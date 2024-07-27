unit ulist;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  generic TList<T> = class
    private
    type
      PNode = ^TNode;
      TNode = record
        Data : T;
        Previous : PNode;
        Next : PNode;
      end;
    private
      _head : PNode;
      _tail : PNode;
      _count : integer;
    public
      procedure Add(const value : T);
      procedure Clear();
      constructor Create;
      destructor Destroy; override;
      function Get(index : integer) : T;
      procedure Insert(const value : T; const index : integer);
      procedure Remove(const index : integer);
    private
      function GetNode(index : integer) : PNode;
      function GetNodeFromHead(index : integer) : PNode;
      function GetNodeFromTail(index : integer) : PNode;
    public
      property Count : integer read _count;
  end;

implementation

{$REGION 'constructors/destructors'}

constructor TList.Create();
begin
  _head := nil;
  _tail := nil;
  _count := 0;
end;

destructor TList.Destroy();
begin
  Clear();
  inherited;
end;

{$ENDREGION}

{$REGION 'Public Methods'}

procedure TList.Add(const value : T);
var
  newNode : PNode;
begin
  New(newNode);
  newNode^.Data := value;
  newNode^.Next := nil;
  newNode^.Previous := nil;

  if _head = nil then begin
    _head := newNode;
    _tail := newNode;
  end
  else begin
    newNode^.Previous := _tail;
    _tail^.Next := newNode;
    _tail := newNode;
  end;

  Inc(_count);
end;

procedure TList.Insert(const value : T; const index : integer);
var
  node : PNode;
  newNode : PNode;
begin
  if (index < 0) or (index >= _count) then begin
    raise Exception.Create('Index out of bounds');
  end;

  New(newNode);
  newNode^.Data := value;
  newNode^.Next := nil;
  newNode^.Previous := nil;

  if index = 0 then begin
    newNode^.Next := _head;
    _head^.Previous := newNode;
    _head := newNode;
  end
  else if index = _count - 1 then begin
    newNode^.Next := _tail;
    newNode^.Previous := _tail^.Previous;
    _tail^.Previous^.Next := newNode;
    _tail^.Previous := newNode;
  end
  else begin
    node := GetNode(index);
    newNode^.Previous := node^.Previous;
    newNode^.Previous^.Next := newNode;
    newNode^.Next := node;
    node^.Previous := newNode;
  end;

  Inc(_count);
end;

procedure TList.Clear();
var
  i : integer;
  node : PNode;
begin
  for i := 0 to _count - 1 do begin
    node := _head^.Next;
    Dispose(_head);
    _head := node;
  end;
  _count := 0;
end;

function TList.Get(index : integer) : T;
var
  node : PNode;
begin
  node := GetNode(index);
  Result := node^.Data;
end;

procedure TList.Remove(const index : integer);
var
  node : PNode;
begin
  if (index < 0) or (index >= _count) then begin
    raise Exception.Create('Index out of bounds');
  end;

  if (index = 0) and (_count = 1) then begin
    Dispose(_head);
  end
  else if (index = 0) and (_count > 1) then begin
    node := _head;
    _head := _head^.Next;
    _head^.Next^.Previous := _head;
    _head^.Previous := nil;
    Dispose(node);
  end
  else if (index = _count - 1) then begin
    node := _tail^.Previous;
    node^.Next := nil;
    Dispose(_tail);
    _tail := node;
  end
  else begin
    node := GetNode(index);
    node^.Previous^.Next := node^.Next;
    node^.Next^.Previous := node^.Previous;
    Dispose(node);
  end;

  Dec(_count);
end;

{$ENDREGION}

{$REGION 'Private Methods'}

function TList.GetNode(index : integer) : PNode;
begin
  if (index < 0) or (index >= _count) then begin
    raise Exception.Create('Index out of bounds');
  end;

  if index = 0 then begin
    Result := _head;
  end
  else if index = _count - 1 then begin
    Result := _tail;
  end
  else if index < _count div 2 then begin
    Result := GetNodeFromHead(index);
  end
  else begin
    Result := GetNodeFromTail(index);
  end;
end;

function TList.GetNodeFromHead(index : integer) : PNode;
var
  i : integer;
  currentNode : PNode;
begin
  currentNode := _head;
  for i := 0 to index - 1 do begin
    currentNode := currentNode^.Next;
  end;

  Result := currentNode;
end;

function TList.GetNodeFromTail(index : integer) : PNode;
var
  i : integer;
  target : integer;
  currentNode : PNode;
begin
  target := (_count - 1) - index;
  currentNode := _tail;
  for i := 0 to target - 1 do begin
      currentNode := currentNode^.Previous;
  end;

  Result := currentNode;
end;

{$ENDREGION}

end.

