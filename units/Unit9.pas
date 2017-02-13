unit Unit9;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TScaner = class(TForm)
    Label1: TLabel;
    Memo1: TMemo;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Finder: TEdit;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    article:string;
    { Private declarations }
  public
    procedure Find(barcode:string);
    { Public declarations }
  end;

var
  Scaner: TScaner;

implementation

{$R *.dfm}

uses Unit2, Unit1;

procedure TScaner.BitBtn1Click(Sender: TObject);
begin
  Scaner.Close;
end;

procedure TScaner.BitBtn2Click(Sender: TObject);
begin
  if article<>'' then
  begin
    try
    MainForm.TreeSet.Active:=false;
    MainForm.TreeSet.CommandText:='select d.article, d.name, d.mesname, d.country, DECODE(accepted, ''1'', ''�������'', ''2'', ''���������'', ''�����'') as accepted, ';
    MainForm.TreeSet.CommandText:=MainForm.TreeSet.CommandText+'DECODE(datatype, ''0'', ''�����'', ''1'', ''������'', ''2'', ''������'', ''3'', ''����'', ''4'', ''���������'', ''5'', ''�����'', ''#�/�'') as datatype, s.tree, s.name as gname from supermag.smcard d, supermag.sacardclass s WHERE s.id = d.idclass and d.article='''+article+'''';
    MainForm.TreeSet.Active:=true;

    MainForm.DBGrid1.DataSource.DataSet.First;
    except
    end;

    MainForm.BitBtn4.Click;

    MainForm.TreeSet.Active:=false;
  end;
end;

procedure TScaner.Find(barcode: string);
var amount:Currency; goods:string; k:integer;
    DataSetGood:string;
begin

  try
    k:=0;
    goods:='';
    while k<>length(Auth.GList) do
    begin
      goods:=goods+Auth.GList[k].num+' ,';
      inc(k);
    end;
    goods:=copy(goods, 1, length(goods)-2);
  except
  end;

  barcode:=copy(barcode, 1, 13);
  article:='';
  Memo1.Lines.Clear;
  LabeledEdit1.Text:='';
  LabeledEdit2.Text:='';
  Label2.Caption:='';
  try
    MainForm.BarcodeSet.Active:=false;
    MainForm.BarcodeSet.CommandText:='select s.article, s.barcode from supermag.smstoreunits s, supermag.smcard d where d.article = s.article and s.barcode='''+barcode+'''';
    MainForm.BarcodeSet.Active:=true;

    MainForm.BarcodeSet.First;
    article:=MainForm.BarcodeSet.FieldByName('article').AsString;
    LabeledEdit1.Text:=article;
    LabeledEdit2.Text:=barcode;

    if article<>'' then
    begin
      MainForm.BarcodeSet.Filtered:=false;
      MainForm.TreeModel.Active:=false;
      MainForm.TreeModel.CommandText:='select d.article, d.name, d.mesname, d.country, DECODE(accepted, ''1'', ''�������'', ''2'', ''���������'', ''�����'') as accepted, ';
      MainForm.TreeModel.CommandText:=MainForm.TreeModel.CommandText+'DECODE(datatype, ''0'', ''�����'', ''1'', ''������'', ''2'', ''������'', ''3'', ''����'', ''4'', ''���������'', ''5'', ''�����'', ''#�/�'') as datatype, s.tree, s.name as gname from supermag.smcard d, supermag.sacardclass s WHERE s.id = d.idclass and accepted=1 and d.article='''+article+'''';
      MainForm.TreeModel.Active:=true;
      MainForm.TreeModel.First;

      Memo1.Lines.Add(MainForm.TreeModel.FieldByName('name').AsString);
      System.SysUtils.FormatSettings.ThousandSeparator:='.';
      System.SysUtils.FormatSettings.DecimalSeparator:='.';
      MainForm.TreeModel.Active:=false;
      MainForm.TreeModel.CommandText:='select * from smprices where storeloc='''+Auth.storeloc+''' and pricetype='''+Auth.pricetype+''' and article='''+article+'''';
      MainForm.TreeModel.Active:=true;
      amount:=MainForm.TreeModel.FieldByName('price').AsFloat;
      MainForm.TreeModel.Active:=false;
      try
        MainForm.TreeModel.Active:=false;
        DataSetGood:= ' SELECT *'
              + ' FROM Supermag.SMGoods d, Supermag.SMStorelocations c, Supermag.SMOperGoods s'
              + ' where (d.article= '+ article + ') and (c.ID = d.STORELOC) and (d.article=s.article(+)) and (s.LOCID(+) = d.STORELOC) and (d.storeloc in ('+Auth.storeloc2+'))';

        MainForm.TreeModel.CommandText:=' SELECT name,QUANTITY,RESERVEDQUANTITY,INCOMINGQUANTITY,AWAITEDQUANTITY,FOUNDQUANTITY,CAST(sum(SALEQUANTITY - RETURNQUANTITY) as FLOAT) as opersale, CAST((max(quantity)-sum(SALEQUANTITY - RETURNQUANTITY)-reservedquantity) as FLOAT) as operquant'
              + ' FROM (' + DataSetGood + ')'
              + ' GROUP BY name,QUANTITY,RESERVEDQUANTITY,INCOMINGQUANTITY,AWAITEDQUANTITY,FOUNDQUANTITY';
        MainForm.TreeModel.Active:=true;
      except
      end;
      DBGrid1.DataSource:=DataSource1;
      Label2.Caption:=FloatToStrF(amount, ffNumber, 10, 2);
    end
    else
    Memo1.Lines.Add('��� ���������� �� ��������� �����-����!');
  except
    on E:Exception do ShowMessage('������: '+E.Message+'.');
  end;
end;

procedure TScaner.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_F12 then
  begin
    Finder.Text:='';
    Finder.SetFocus;
  end;
  if key=VK_RETURN then
  begin
    Find(Finder.Text);
  end;
end;

procedure TScaner.FormResize(Sender: TObject);
begin
  DBGrid1.Columns[1].Width:=60;
  DBGrid1.Columns[2].Width:=60;
  DBGrid1.Columns[3].Width:=60;
  DBGrid1.Columns[4].Width:=60;
  DBGrid1.Columns[5].Width:=60;
  DBGrid1.Columns[6].Width:=60;
  DBGrid1.Columns[7].Width:=60;
  DBGrid1.Columns[8].Width:=260;
end;

end.
