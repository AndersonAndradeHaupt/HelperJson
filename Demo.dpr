program Demo;

uses
  Vcl.Forms,
  UTeste in 'UTeste.pas' {Form1},
  JsonHelper in 'JsonHelper.pas',
  JsonHelper.interfaces in 'JsonHelper.interfaces.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
