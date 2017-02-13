unit Unit20;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TAddPlace = class(TForm)
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    add:boolean;
    { Public declarations }
  end;

var
  AddPlace: TAddPlace;

implementation

{$R *.dfm}

uses Unit2;

procedure TAddPlace.BitBtn1Click(Sender: TObject);
begin
  add:=true;
  Close;
end;

procedure TAddPlace.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then bitbtn1.Click;
end;

procedure TAddPlace.FormShow(Sender: TObject);
begin
  Edit1.Text:='';
  add:=false;
end;

end.
