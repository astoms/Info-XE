unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Data.Win.ADODB, Data.DB;

type
  TChTrade = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    TradeTable: TADOTable;
    TradeSource: TDataSource;
    TradeQuery: TADOQuery;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ChTrade: TChTrade;

implementation

{$R *.dfm}

uses unit1, unit5;

procedure TChTrade.BitBtn1Click(Sender: TObject);
var
 temp:Word;
begin
  temp:=MessageBox(handle, PChar('�� ������������� ������ ������� �������� ����� "'+DBGrid1.DataSource.DataSet.FieldByName('name').AsString+'" �� ���� ������ ?'), PChar('�������� �������� �� "�������� �����":'), MB_YESNO+MB_ICONQUESTION);
  case temp of
    idyes:
      begin
        TradeQuery.Active:=false;
        TradeQuery.SQL.Clear;
        TradeQuery.SQL.Add('delete from info_trade where id='''+DBGrid1.DataSource.DataSet.FieldByName('id').AsString+'''');
        TradeQuery.ExecSQL;
        TradeTable.Active:=false;
        TradeTable.Active:=true;
      end;
  end;
end;

procedure TChTrade.BitBtn2Click(Sender: TObject);
var
 temp:Word;
begin
  if (Edit1.Text<>'') then
  begin
    temp:=MessageBox(handle, PChar('�� ������������� ������ �������� �������� ����� � ������ "'+Edit1.Text+'" � ���� ������ ?'), PChar('���������� �������� �����:'), MB_YESNO+MB_ICONQUESTION);
    case temp of
      idyes:
      begin
        TradeQuery.Active:=false;
        TradeQuery.SQL.Clear;
        TradeQuery.SQL.Add('insert into info_trade(name) values('''+Edit1.Text+''')');
        TradeQuery.ExecSQL;
        Edit1.Text:='';
        TradeTable.Active:=false;
        TradeTable.Active:=true;
      end;
    end;
  end;
end;

procedure TChTrade.DBGrid1DblClick(Sender: TObject);
begin
  if DBGrid1.DataSource.DataSet.FieldByName('name').AsString<>'' then
  begin
    Ad.LabeledEdit3.Text:=DBGrid1.DataSource.DataSet.FieldByName('name').AsString;
    try
      TradeQuery.Active:=false;
      TradeQuery.SQL.Clear;
      TradeQuery.SQL.Add('update settings set value='''+DBGrid1.DataSource.DataSet.FieldByName('name').AsString+''' where name=''trade''');
      TradeQuery.ExecSQL;
      Auth.magazin:=DBGrid1.DataSource.DataSet.FieldByName('value').AsString;
    except
    end;
    ChTrade.Close;
  end;
end;

procedure TChTrade.FormShow(Sender: TObject);
begin
  TradeTable.Active:=false;
  TradeTable.Active:=true;
end;

end.
