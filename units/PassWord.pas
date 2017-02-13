unit PASSWORD;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Dialogs;

type
  TPasswordDlg = class(TForm)
    Label1: TLabel;
    Password: TEdit;
    OKBtn: TButton;
    CancelBtn: TButton;
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PasswordDlg: TPasswordDlg;

implementation

{$R *.dfm}

uses Unit1, Unit5;

procedure TPasswordDlg.CancelBtnClick(Sender: TObject);
begin
  PasswordDlg.Close;
end;

procedure TPasswordDlg.OKBtnClick(Sender: TObject);
begin
  if PassWord.Text<>'' then
  begin
    if PassWord.Text=Auth.pass then
    begin
      AD.Show;
      PassWord.Text:='';
      PasswordDlg.Hide;
    end
    else
    begin
      PassWord.Text:='';
    end;
  end;
end;

end.
 
