unit Unit8;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Math;

type
  TChForm = class(TForm)
    BitBtn1: TBitBtn;
    CField: TLabeledEdit;
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
  ChForm: TChForm;

implementation

{$R *.dfm}

uses Unit2, Unit1;

procedure TChForm.BitBtn1Click(Sender: TObject);
var amount_summ, amount_summ_d: Currency; mycount:double; vip_sum:string;
begin
  if ((CField.Text<>'') or (CField.Text<>'0')) then
  begin
    count:=CField.Text;
    try
      StrToFloat(count);
      mycount:=StrToFloat(count);
    except
      ChForm.Close;
    end;
    System.SysUtils.FormatSettings.ThousandSeparator:='.';
    System.SysUtils.FormatSettings.DecimalSeparator:='.';
    try
      if MainForm.DBGrid5.DataSource.DataSet.FieldByName('article').AsString<>'' then
      begin

        try
          MainForm.PriceSet.Active:=false;
          MainForm.PriceSet.CommandText:='select * from smprices where storeloc='+Auth.storeloc+' and pricetype='+Auth.pricetype+' and article='''+MainForm.DBGrid5.DataSource.DataSet.FieldByName('article').AsString+'''';
          MainForm.PriceSet.Active:=true;
          MainForm.PriceSet.First;
        except
        end;

        try
          if MainForm.PriceSet.FieldByName('price').AsString<>'' then
          begin
            try
              amount_summ:=RoundTo((StrToFloat(MainForm.PriceSet.FieldByName('price').AsString)*10000)*mycount,0);
            except
              On E:Exception do
              begin
                ShowMessage('Ошибка: '+E.Message+'.');
                amount_summ:=0;
              end;
            end;
            try
              amount_summ_d:=RoundTo(StrToFloat(MainForm.PriceSet.FieldByName('price').AsString)*mycount,-2);
            except
              On E:Exception do
              begin
                ShowMessage('Ошибка: '+E.Message+'.');
                amount_summ_d:=0;
              end;
            end;
          end;
        except
        end;
        MainForm.VipQuery.Active:=false;
        MainForm.VipQuery.SQL.Clear;
        MainForm.VipQuery.SQL.Add('update info_vip set count='''+count+''', summ='''+FloatToStr(amount_summ)+''', summ_d='''+FloatToStr(amount_summ_d)+''' where id='''+MainForm.DBGrid5.DataSource.DataSet.FieldByName('id').AsString+''' ');
        MainForm.VipQuery.ExecSQL;
        MainForm.VipTable.Active:=false;
        MainForm.VipTable.Active:=true;

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
      end;
    except
    end;
    ChForm.Close;
  end;
end;

procedure TChForm.CFieldKeyPress(Sender: TObject; var Key: Char);
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

function TChForm.ChangeChar(value: string): string;
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

procedure TChForm.FormShow(Sender: TObject);
begin
  count:=MainForm.DBGrid5.DataSource.DataSet.FieldByName('count').AsString;
  CField.SetFocus;
  CField.Text:=MainForm.DBGrid5.DataSource.DataSet.FieldByName('count').AsString;
end;

end.
