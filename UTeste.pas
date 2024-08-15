unit UTeste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,system.JSON;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses JsonHelper;



procedure TForm1.Button1Click(Sender: TObject);
begin


  Memo2.Lines.add(

     TJSONHelper.New( Memo1.Text)
       .GetArray('qsa')
       .GetValueFromArray(0)
       .GetValueAsString('qual')
       );





end;

end.
