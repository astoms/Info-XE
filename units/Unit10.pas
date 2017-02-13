unit Unit10;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Data.DB, Data.Win.ADODB;

type
  TAddZPC = class(TForm)
    BitBtn1: TBitBtn;
    ZPCNum: TLabeledEdit;
    ORA_QUERY: TADOQuery;
    Mysql_Query: TADOQuery;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddZPC: TAddZPC;

implementation

uses unit1, unit2;

{$R *.dfm}

procedure TAddZPC.BitBtn1Click(Sender: TObject);
var id, froms, tos: string;
begin
  if ZPCNum.Text<>'' then
  begin
    if length(ZPCNum.Text)=12 then
    begin
      ZPCNum.Text:=copy(ZPCNum.Text, 5, 7);
    end;
  end;
  try
    ORA_QUERY.Active:=false;
    ORA_QUERY.SQL.Clear;
    ORA_QUERY.SQL.Add('select d.id, c.name as froms, l.name as tos');
    ORA_QUERY.SQL.Add('from smdocuments d, smclientinfo c, smstorelocations l');
    ORA_QUERY.SQL.Add('where d.id = ''���'+ZPCNum.Text+'''');
    ORA_QUERY.SQL.Add('and d.clientindex = c.id');
    ORA_QUERY.SQL.Add('and d.location = l.id');
    ORA_QUERY.Active:=true;
  except
    ShowMessage('������ ���������� � �������. ���������� �������� ������!');
    Exit;
  end;
  ORA_Query.First;
  if ORA_Query.FieldByName('id').AsString='���'+ZPCNum.Text then
  begin
    id:=ORA_Query.FieldByName('id').AsString;
    froms:=ORA_Query.FieldByName('froms').AsString;
    tos:=ORA_Query.FieldByName('tos').AsString;
  end;
  try
    Mysql_Query.Active:=false;
    MySQL_Query.SQL.Clear;
    MySQL_Query.SQL.Add('insert into zpc_table(`zpc`, `from`, `to`, `data`, `timed`, `whois`, `count_e`, `state`) values('''+id+''', '''+froms+''', '''+tos+''', CURDATE(), CURTIME(), '''+Auth.LoginDB.Text+''', ''-'', ''� �������'')');
    MySQL_Query.ExecSQL;
  except
    ShowMessage('��������� ������: ���������� �������� �� ���� ���������� ��������������!');
  end;
  MainForm.Changer.Click;
  Close;
end;

procedure TAddZPC.FormShow(Sender: TObject);
begin
  ZPCNUm.Text:='';
end;

end.
