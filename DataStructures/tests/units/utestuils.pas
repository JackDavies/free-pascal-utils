unit utestuils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TTestObjA = class
    private
      _id : integer;
      _created : TDateTime;
    public
      function Double() : integer;
    public
      constructor Create(id : integer);
    public
      property Id : integer read _id write _id;
  end;

implementation

constructor TTestObjA.Create(id : integer);
begin
  _id := id;
  _created := Now();
end;

function TTestObjA.Double() : integer;
begin
  Result := Id * 2;
end;

end.

