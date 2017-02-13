unit Unit17;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TZvChange = class(TForm)
    BitBtn1: TBitBtn;
    Edit1: TEdit;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    id:string;
    article:string;
    { Public declarations }
  end;

var
  ZvChange: TZvChange;

implementation

{$R *.dfm}

uses Unit2, Unit1;

procedure TZvChange.BitBtn1Click(Sender: TObject);
begin
  try
    if Edit1.Text<>'' then
    begin
      MainForm.ZV_TD_Query.Active:=false;
      MainForm.ZV_TD_Query.SQL.Clear;
      MainForm.ZV_TD_Query.SQL.Add('update zv_td2 set count='''+Edit1.Text+''' where id = '''+id+''' ');
      MainForm.ZV_TD_Query.ExecSQL;
      MainForm.Zv_Read2.Active:=false;
      MainForm.Zv_Read2.Active:=true;
      MainForm.Zv_Read2.Filtered:=false;
      MainForm.Zv_Read2.Filter:='docid = '''+MainForm.doc_num+'''';
      MainForm.Zv_Read2.Filtered:=true;
      MainForm.DBGrid8.DataSource.DataSet.Last;
      Close;
    end
    else Close;
  except
  end;
end;

procedure TZvChange.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
  begin
    BitBtn1.Click;
    Exit;
  end;
  if not (key in ['0'..'9', #8, '.', ',']) then
  begin
    key:=#0;
  end;
end;

end.
