unit Unit16;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TZvAdd = class(TForm)
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ZvAdd: TZvAdd;

implementation

{$R *.dfm}

uses Unit2, Unit1;

procedure TZvAdd.BitBtn1Click(Sender: TObject);
var i:integer; place:string;
begin
  try
    if Edit1.Text<>'' then
    begin
      MainForm.ZV_TD_Query.Active:=false;
      MainForm.ZV_TD_Query.SQL.Clear;
      i:=0;
      place:='';
      while i<>MainForm.clPlace.Items.Count do
      begin
        place:=place+MainForm.clPlace.Items.Strings[i]+'; ';
        inc(i);
      end;
      if place<>'' then place:=copy(place, 1, length(place)-2);
      MainForm.ZV_TD_Query.SQL.Add('insert into zv_td2(article, barcode, name, count, count_n, place, sender, docid) values('''+MainForm.DBGrid1.DataSource.DataSet.FieldByName('article').AsString+''', '''+MainForm.DBGrid2.DataSource.DataSet.FieldByName('barcode').AsString+''', '''+MainForm.DBGrid1.DataSource.DataSet.FieldByName('name').AsString+''', '''+Edit1.Text+''', '''', '''+place+''', '''+Auth.groupname+''', '''+MainForm.doc_num+''')');
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

procedure TZvAdd.Edit1KeyPress(Sender: TObject; var Key: Char);
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

procedure TZvAdd.FormShow(Sender: TObject);
begin
  Edit1.Text:='1';
end;

end.
