program FullDebugModeDemo;

uses
  ShareMem,
  Forms,
  DemoForm in 'DemoForm.pas' {Form1},
  FastMMDebugSupport in '..\FastMMDebugSupport.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.