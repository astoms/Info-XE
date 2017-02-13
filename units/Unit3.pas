unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Math;

type
  TEnterForm = class(TForm)
    CField: TLabeledEdit;
    BitBtn1: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure CFieldKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    count:string;
    function ChangeChar(value:string):string;
    { Public declarations }
  end;

var
  EnterForm: TEnterForm;

implementation

{$R *.dfm}

uses unit1, unit2;

procedure TEnterForm.BitBtn1Click(Sender: TObject);
var amount, amount_d, amount_summ, amount_summ_d: Currency;
    mycount:double; vip_sum:string;
begin
  if ((CField.Text<>'') or (CField.Text<>'0')) then
  begin
    count:=CField.Text;
    try
      StrToFloat(count);
      mycount:=StrToFloat(count);
    except
      EnterForm.Close;
    end;
    System.SysUtils.FormatSettings.ThousandSeparator:='.';
    System.SysUtils.FormatSettings.DecimalSeparator:='.';
    try
      if MainForm.DBGrid1.DataSource.DataSet.FieldByName('article').AsString<>'' then
      begin
        try
          MainForm.BarcodeSet.Active:=false;
          MainForm.BarcodeSet.CommandText:='select d.article, s.barcode from supermag.smstoreunits s, supermag.smcard d where d.article = s.article and d.article='''+MainForm.DBGrid1.DataSource.DataSet.FieldByName('article').AsString+'''';
          MainForm.BarcodeSet.Active:=true;
        except
        end;
        try
          MainForm.PriceSet.Active:=false;
          MainForm.PriceSet.CommandText:='select * from smprices where storeloc='+Auth.storeloc+' and pricetype='+Auth.pricetype+' and article='''+MainForm.DBGrid1.DataSource.DataSet.FieldByName('article').AsString+'''';
          MainForm.PriceSet.Active:=true;
        except
          //on E:Exception do ShowMessage('������ 0cv2324x354342: '+E.Message);
        end;

        try
          if MainForm.PriceSet.FieldByName('price').AsString<>'' then
          begin
            try
              amount:=RoundTo(MainForm.PriceSet.FieldByName('price').AsFloat*10000,0);
            except
              amount:=0;
            end;
            try
              amount_d:=RoundTo(MainForm.PriceSet.FieldByName('price').AsFloat,-2);
            except
              amount_d:=0;
            end;
            try
              amount_summ:=RoundTo((StrToFloat(MainForm.PriceSet.FieldByName('price').AsString)*10000)*mycount,0);
            except
              amount_summ:=0;
            end;
            try
              amount_summ_d:=RoundTo(StrToFloat(MainForm.PriceSet.FieldByName('price').AsString)*mycount,-2);
            except
              amount_summ_d:=0;
            end;
            MainForm.VipQuery.Active:=false;
            MainForm.VipQuery.SQL.Clear;
            MainForm.VipQuery.SQL.Add('insert into info_vip(groupid, article, name, barcode, count, em, price, price_d, summ, summ_d) values('''+Auth.groupid+''', '''+MainForm.DBGrid1.DataSource.DataSet.FieldByName('article').AsString+''', '''+MainForm.noBadChar(MainForm.DBGrid1.DataSource.DataSet.FieldByName('name').AsString)+''', '''+MainForm.DBGrid2.DataSource.DataSet.FieldByName('barcode').AsString+''', '''+count+''', '''+MainForm.DBGrid1.DataSource.DataSet.FieldByName('mesname').AsString+''', '''+FloatToStr(amount)+''', '''+FloatToStr(amount_d)+''', '''+FloatToStr(amount_summ)+''', '''+FloatToStr(amount_summ_d)+''')');
            MainForm.VipQuery.ExecSQL;
            MainForm.VipTable.Active:=false;
            MainForm.VipTable.Active:=true;
          end
          else
          begin
            amount:=0;
            amount_d:=0;
            amount_summ:=0;
            amount_summ_d:=0;
            MainForm.VipQuery.Active:=false;
            MainForm.VipQuery.SQL.Clear;
            MainForm.VipQuery.SQL.Add('insert into info_vip(groupid, article, name, barcode, count, em, price, price_d, summ, summ_d) values('''+Auth.groupid+''', '''+MainForm.DBGrid1.DataSource.DataSet.FieldByName('article').AsString+''', '''+MainForm.noBadChar(MainForm.DBGrid1.DataSource.DataSet.FieldByName('name').AsString)+''', '''+MainForm.DBGrid2.DataSource.DataSet.FieldByName('barcode').AsString+''', '''+count+''', '''+MainForm.DBGrid1.DataSource.DataSet.FieldByName('mesname').AsString+''', '''+FloatToStr(amount)+''', '''+FloatToStr(amount_d)+''', '''+FloatToStr(amount_summ)+''', '''+FloatToStr(amount_summ_d)+''')');
            MainForm.VipQuery.ExecSQL;
            MainForm.VipTable.Active:=false;
            MainForm.VipTable.Active:=true;
          end;
        except
        end;

        try
          MainForm.VipQuery.Active:=false;
          MainForm.VipQuery.SQL.Clear;
          MainForm.VipQuery.SQL.Add('select * from info_vip where groupid='''+Auth.groupid+'''');
          MainForm.VipQuery.Active:=true;
          MainForm.VipQuery.First;
          vip_sum:='0';
          while not MainForm.VipQuery.Eof do
          begin
            try
              vip_sum:=FloatToStr(StrToFloat(vip_sum)+StrToFloat(MainForm.VipQuery.FieldByName('summ_d').AsString));
            except
            end;
            MainForm.VipQuery.Next;
          end;
        except
        end;

        try
          MainForm.VipQuery.Active:=false;
          MainForm.VipQuery.SQL.Clear;
          MainForm.VipQuery.SQL.Add('update info_vip set vip_sum='''+vip_sum+''' where groupid='''+Auth.groupid+'''');
          MainForm.VipQuery.ExecSQL;
        except
        end;

        try
          MainForm.VipTable.Active:=false;
          MainForm.VipTable.Active:=true;
          MainForm.VipTable.Filtered:=false;
          MainForm.VipTable.Filter:='groupid='''+Auth.groupid+'''';
          MainForm.VipTable.Filtered:=true;
        except
        end;
        MainForm.DBGrid5.DataSource.DataSet.Last;
      end;
    except
    end;
    EnterForm.Close;
  end;
end;

procedure TEnterForm.CFieldKeyPress(Sender: TObject; var Key: Char);
var i:integer; ext:boolean;
begin
  ext:=false;
  if key in ['0'..'9', #13, #8, '.', ','] then
  begin
    if ((key='.') or (key=',')) then
    begin
      i:=0;
      while i<=length(CField.Text) do
      begin
        if copy(CField.Text, i, 1)='.' then
        begin
          ext:=true;
        end;
        inc(i);
      end;
      if ext=false then key:='.' else
      begin
        key:=#0;
      end;
    end;

    if key=#13 then
    begin
      BitBtn1.Click;
    end;
  end
  else key:=#0;
end;

function TEnterForm.ChangeChar(value: string): string;
var temp:string; i:integer;
begin
  i:=1;
  temp:='';
  while i<>length(value) do
  begin
    if copy(value, i, 1)=',' then
    begin
      temp:=temp+'.';
    end
    else
    begin
      temp:=temp+copy(value, i, 1);
    end;
    inc(i);
  end;
  result:=temp;
end;

procedure TEnterForm.FormShow(Sender: TObject);
begin
  count:='';
  CField.SetFocus;
  CField.Text:='1';
end;

end.
