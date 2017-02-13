unit Unit6;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Data.Win.ADODB;

type
  TChPrice = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    DBGrid1: TDBGrid;
    PriceTable: TADOTable;
    PriceQuery: TADOQuery;
    PriceSource: TDataSource;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    BitBtn2: TBitBtn;
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
  ChPrice: TChPrice;

implementation

{$R *.dfm}

uses Unit1, Unit5;

procedure TChPrice.BitBtn1Click(Sender: TObject);
var
 temp:Word;
begin
  if ((LabeledEdit1.Text<>'') and (LabeledEdit2.Text<>'')) then
  begin
    temp:=MessageBox(handle, PChar('�� ������������� ������ �������� ����� ��� ���� � ������ "'+LabeledEdit1.Text+'" � ��������� "'+LabeledEdit2.Text+'" � ���� ������ ?'), PChar('���������� � "���� ���":'), MB_YESNO+MB_ICONQUESTION);
    case temp of
      idyes:
      begin
        PriceQuery.Active:=false;
        PriceQuery.SQL.Clear;
        PriceQuery.SQL.Add('insert into info_price(name,value) values('''+LabeledEdit1.Text+''','''+LabeledEdit2.Text+''')');
        PriceQuery.ExecSQL;
        LabeledEdit1.Text:='';
        LabeledEdit2.Text:='';
        PriceTable.Active:=false;
        PriceTable.Active:=true;
      end;
    end;
  end;
end;

procedure TChPrice.BitBtn2Click(Sender: TObject);
var
 temp:Word;
begin
  temp:=MessageBox(handle, PChar('�� ������������� ������ ������� ��� ���� "'+DBGrid1.DataSource.DataSet.FieldByName('name').AsString+'" �� ���� ������ ?'), PChar('�������� �������� �� "���� ���":'), MB_YESNO+MB_ICONQUESTION);
  case temp of
    idyes:
      begin
        PriceQuery.Active:=false;
        PriceQuery.SQL.Clear;
        PriceQuery.SQL.Add('delete from info_price where id='''+DBGrid1.DataSource.DataSet.FieldByName('id').AsString+'''');
        PriceQuery.ExecSQL;
        PriceTable.Active:=false;
        PriceTable.Active:=true;
      end;
  end;
end;

procedure TChPrice.DBGrid1DblClick(Sender: TObject);
begin
  if DBGrid1.DataSource.DataSet.FieldByName('name').AsString<>'' then
  begin
    Ad.LabeledEdit1.Text:=DBGrid1.DataSource.DataSet.FieldByName('name').AsString;
    try
      PriceQuery.Active:=false;
      PriceQuery.SQL.Clear;
      PriceQuery.SQL.Add('update settings set value='''+DBGrid1.DataSource.DataSet.FieldByName('value').AsString+''' where name=''pricetype''');
      PriceQuery.ExecSQL;
      Auth.pricetype:=DBGrid1.DataSource.DataSet.FieldByName('value').AsString;
    except
    end;
    ChPrice.Close;
  end;
end;

procedure TChPrice.FormShow(Sender: TObject);
begin
  PriceTable.Active:=false;
  PriceTable.Active:=true;
end;

end.
