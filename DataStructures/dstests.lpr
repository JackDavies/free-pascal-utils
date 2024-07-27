program dstests;

{$mode objfpc}{$H+}

uses
  Interfaces, Forms, GuiTestRunner, ulisttest, ulist, utestuils;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TGuiTestRunner, TestRunner);
  Application.Run;
end.

