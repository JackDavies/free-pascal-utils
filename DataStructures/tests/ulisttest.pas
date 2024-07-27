unit ulisttest;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry, ulist, utestuils;

type

  TIntList = specialize TList<integer>;
  TObjAList = specialize TList<TTestObjA>;

  TListTests = class(TTestCase)
  published
    procedure IntListTests;
    procedure ObjListTests;
    procedure LargeIntListTest;
    procedure InsertTest;
    procedure RemoveTest;
  end;

implementation

procedure TListTests.ObjListTests;
var
  list : TObjAList;
  obj : TTestObjA;
  i : integer;
begin
  list := TObjAList.Create();

  obj := TTestObjA.Create(1);

  list.Add(obj);

  AssertEquals(1, list.Get(0).Id);
  list.Clear();

  for i := 0 to 10000 do begin
    obj := TTestObjA.Create(i);
    list.Add(obj);
  end;

  obj := list.Get(0);
  obj := list.Get(1);
  obj := list.Get(list.Count - 1);

  for i := 0 to 10000 do begin
    AssertEquals(list.Get(i).Id, i);
  end;

  list.Clear();
end;

procedure TListTests.IntListTests;
var
  list : TIntList;
  i : integer;
begin
  list := TIntList.Create();
  AssertEquals(list.Count, 0);

  list.Add(10);
  AssertEquals(list.Count, 1);
  i := list.Get(0);
  AssertEquals(i, 10);

  list.Add(20);
  AssertEquals(list.Count, 2);
  i := list.Get(1);
  AssertEquals(i, 20);

  list.Add(30);
  AssertEquals(list.Count, 3);
  i := list.Get(2);
  AssertEquals(i, 30);

  list.Add(40);
  AssertEquals(list.Count, 4);
  i := list.Get(3);
  AssertEquals(i, 40);

  list.Add(50);
  AssertEquals(list.Count, 5);
  i := list.Get(4);
  AssertEquals(i, 50);

  list.Add(60);
  AssertEquals(list.Count, 6);
  i := list.Get(5);
  AssertEquals(i, 60);

  list.Add(70);
  AssertEquals(list.Count, 7);
  i := list.Get(6);
  AssertEquals(i, 70);

  list.Add(80);
  AssertEquals(list.Count, 8);
  i := list.Get(7);
  AssertEquals(i, 80);

  list.Add(90);
  AssertEquals(list.Count, 9);
  i := list.Get(8);
  AssertEquals(i, 90);

  list.Add(100);
  AssertEquals(list.Count, 10);
  i := list.Get(9);
  AssertEquals(i, 100);

  i := list.Get(0);
  AssertEquals(i, 10);

  i := list.Get(1);
  AssertEquals(i, 20);

  i := list.Get(2);
  AssertEquals(i, 30);

  i := list.Get(3);
  AssertEquals(i, 40);

  i := list.Get(4);
  AssertEquals(i, 50);

  i := list.Get(5);
  AssertEquals(i, 60);

  i := list.Get(6);
  AssertEquals(i, 70);

  i := list.Get(7);
  AssertEquals(i, 80);

  i := list.Get(8);
  AssertEquals(i, 90);

  i := list.Get(9);
  AssertEquals(i, 100);

  list.Clear();
end;

procedure TListTests.LargeIntListTest;
var
  list : TIntList;
  i : integer;
begin
  list := TIntList.Create;

  for i := 0 to 10000 do begin
    list.Add(i);
  end;

  for i := 0 to 10000 do begin
    AssertEquals(list.Get(i), i);
  end;

  list.Clear();
end;

procedure TListTests.InsertTest;
var
  list : TIntList;
begin
  list := TIntList.Create;

  list.Add(0);
  list.Add(1);
  list.Add(2);
  list.Add(3);

  AssertEquals(list.Count, 4);
  AssertEquals(list.Get(1), 1);

  list.Insert(100, 1);
  AssertEquals(list.Count, 5);
  AssertEquals(list.Get(0), 0);
  AssertEquals(list.Get(1), 100);
  AssertEquals(list.Get(2), 1);
  AssertEquals(list.Get(3), 2);
  AssertEquals(list.Get(4), 3);

  list.Insert(200, 0);
  AssertEquals(list.Count, 6);
  AssertEquals(list.Get(0), 200);
  AssertEquals(list.Get(1), 0);
  AssertEquals(list.Get(2), 100);
  AssertEquals(list.Get(3), 1);
  AssertEquals(list.Get(4), 2);
  AssertEquals(list.Get(5), 3);

  list.Insert(300, list.Count - 1);
  AssertEquals(list.Count, 7);
  AssertEquals(list.Get(0), 200);
  AssertEquals(list.Get(1), 0);
  AssertEquals(list.Get(2), 100);
  AssertEquals(list.Get(3), 1);
  AssertEquals(list.Get(4), 2);
  AssertEquals(list.Get(5), 300);
  AssertEquals(list.Get(6), 3);
end;

procedure TListTests.RemoveTest;
var
  list : TIntList;
begin
  list := TIntList.Create;

  list.Add(0);
  list.Remove(0);
  AssertEquals(list.Count, 0);

  list.Add(0);
  list.Add(1);
  list.Add(2);
  list.Add(3);

  list.Remove(0);
  AssertEquals(list.Count, 3);
  AssertEquals(list.Get(0), 1);
  AssertEquals(list.Get(1), 2);
  AssertEquals(list.Get(2), 3);

  list.Clear();
  list.Add(0);
  list.Add(1);
  list.Add(2);
  list.Add(3);

  list.Remove(1);
  AssertEquals(list.Count, 3);
  AssertEquals(list.Get(0), 0);
  AssertEquals(list.Get(1), 2);
  AssertEquals(list.Get(2), 3);

  list.Clear();
  list.Add(0);
  list.Add(1);
  list.Add(2);
  list.Add(3);

  list.Remove(2);
  AssertEquals(list.Count, 3);
  AssertEquals(list.Get(0), 0);
  AssertEquals(list.Get(1), 1);
  AssertEquals(list.Get(2), 3);

  list.Clear();
  list.Add(0);
  list.Add(1);
  list.Add(2);
  list.Add(3);

  list.Remove(3);
  AssertEquals(list.Count, 3);
  AssertEquals(list.Get(0), 0);
  AssertEquals(list.Get(1), 1);
  AssertEquals(list.Get(2), 2);
end;

initialization

  RegisterTest(TListTests);
end.

