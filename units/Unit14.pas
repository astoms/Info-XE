unit Unit14;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TTovSave = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TovSave: TTovSave;

implementation

uses unit1, Unit2;

{$R *.dfm}

procedure TTovSave.BitBtn1Click(Sender: TObject);
var i:integer;
begin
  try
    if MainForm.DBGrid7.Cells[0, MainForm.DBGrid7.RowCount-1]<>'' then
    begin
      try
        Auth.SGO_Query.Active:=false;
        Auth.SGO_Query.SQL.Clear;
        Auth.SGO_Query.SQL.Add('delete from t_zd2 where docid='''+MainForm.docid+'''');
        Auth.SGO_Query.ExecSQL;
      except
      end;
      i:=1;
      while i<=MainForm.DBGrid7.RowCount-1 do
      begin
        Auth.SGO_Query.Active:=false;
        Auth.SGO_Query.SQL.Clear;
        Auth.SGO_Query.SQL.Add('insert into t_zd2(tree, article, barcode, name, production, goods, sr, days, date, comment, prim, docid) values('''+MainForm.DBGrid7.Cells[0,i]+''', '''+MainForm.DBGrid7.Cells[1,i]+''', '''+MainForm.DBGrid7.Cells[2,i]+''', '''+MainForm.DBGrid7.Cells[3,i]+''', '''+MainForm.DBGrid7.Cells[4,i]+''', '''+MainForm.DBGrid7.Cells[5,i]+''', '''+MainForm.DBGrid7.Cells[6,i]+''', '''+MainForm.DBGrid7.Cells[7,i]+''', '''+MainForm.DBGrid7.Cells[8,i]+''', '''+MainForm.DBGrid7.Cells[9,i]+''', '''+MainForm.DBGrid7.Cells[10,i]+''', '''+MainForm.docid+''')');
        Auth.SGO_Query.ExecSQL;
        inc(i);
      end;
    end;
  except
    //on e:exception do ShowMessage(e.Message);
  end;
  TovSave.Close;
end;

procedure TTovSave.BitBtn2Click(Sender: TObject);
var i:integer; ext:boolean;
begin
  ext:=false;
  try
    if Auth.tz_moder=false then
    begin
      if MainForm.DBGrid7.Cells[0, MainForm.DBGrid7.RowCount-1]<>'' then
      begin
        try
          Auth.SGO_Query.Active:=false;
          Auth.SGO_Query.SQL.Clear;
          Auth.SGO_Query.SQL.Add('delete from t_zd2 where docid='''+MainForm.docid+'''');
          Auth.SGO_Query.ExecSQL;
        except
        end;
        i:=1;
        while i<=MainForm.DBGrid7.RowCount-1 do
        begin
          Auth.SGO_Query.Active:=false;
          Auth.SGO_Query.SQL.Clear;
          Auth.SGO_Query.SQL.Add('insert into t_zd2(tree, article, barcode, name, production, goods, sr, days, date, comment, prim, docid) values('''+MainForm.DBGrid7.Cells[0,i]+''', '''+MainForm.DBGrid7.Cells[1,i]+''', '''+MainForm.DBGrid7.Cells[2,i]+''', '''+MainForm.DBGrid7.Cells[3,i]+''', '''+MainForm.DBGrid7.Cells[4,i]+''', '''+MainForm.DBGrid7.Cells[5,i]+''', '''+MainForm.DBGrid7.Cells[6,i]+''', '''+MainForm.DBGrid7.Cells[7,i]+''', '''+MainForm.DBGrid7.Cells[8,i]+''', '''+MainForm.DBGrid7.Cells[9,i]+''', '''+MainForm.DBGrid7.Cells[10,i]+''', '''+MainForm.docid+''')');
          Auth.SGO_Query.ExecSQL;
          inc(i);
        end;
      end;
    end
    else
    begin
      //ShowMessage('��������� ��������...');
      if MainForm.DBGrid7.Cells[0, MainForm.DBGrid7.RowCount-1]<>'' then
      begin
        ext:=false;
        i:=1;
        while i<=MainForm.DBGrid7.RowCount-1 do
        begin
          if ((MainForm.DBGrid7.Cells[8,i]='-') or (MainForm.DBGrid7.Cells[8,i]=' ') or (MainForm.DBGrid7.Cells[8,i]='')) then
          begin
            ext:=true;
            break;
          end;
          inc(i);
        end;
        if ext then
        begin
          ShowMessage('��������! ���������� ��������� �� ���������.'+#13+'���������: '+'���������� ���������� ���� �������� ������!');
          Exit;
        end;
        try
          Auth.SGO_Query.Active:=false;
          Auth.SGO_Query.SQL.Clear;
          Auth.SGO_Query.SQL.Add('delete from t_zd2 where docid='''+MainForm.docid+'''');
          Auth.SGO_Query.ExecSQL;
        except
        end;
        i:=1;
        while i<=MainForm.DBGrid7.RowCount-1 do
        begin
          Auth.SGO_Query.Active:=false;
          Auth.SGO_Query.SQL.Clear;
          Auth.SGO_Query.SQL.Add('insert into t_zd2(tree, article, barcode, name, production, goods, sr, days, date, comment, prim, docid) values('''+MainForm.DBGrid7.Cells[0,i]+''', '''+MainForm.DBGrid7.Cells[1,i]+''', '''+MainForm.DBGrid7.Cells[2,i]+''', '''+MainForm.DBGrid7.Cells[3,i]+''', '''+MainForm.DBGrid7.Cells[4,i]+''', '''+MainForm.DBGrid7.Cells[5,i]+''', '''+MainForm.DBGrid7.Cells[6,i]+''', '''+MainForm.DBGrid7.Cells[7,i]+''', '''+MainForm.DBGrid7.Cells[8,i]+''', '''+MainForm.DBGrid7.Cells[9,i]+''', '''+MainForm.DBGrid7.Cells[10,i]+''', '''+MainForm.docid+''')');
          Auth.SGO_Query.ExecSQL;
          inc(i);
        end;
      end;
    end;
  except
    //on e:exception do ShowMessage(e.Message);
  end;
  try
    if BitBtn2.Caption='��������� (������:���������� � �������� �����)' then
    begin
      Auth.SGO_Query.Active:=false;
      Auth.SGO_Query.SQL.Clear;
      Auth.SGO_Query.SQL.Add('update t_zd set status=''���������� � �������� �����'' where id='''+MainForm.docid+'''');
      Auth.SGO_Query.ExecSQL;
    end
    else
    begin
      Auth.SGO_Query.Active:=false;
      Auth.SGO_Query.SQL.Clear;
      Auth.SGO_Query.SQL.Add('update t_zd set status=''�������� ����������'' where id='''+MainForm.docid+'''');
      Auth.SGO_Query.ExecSQL;
    end;
  except
    //on e:exception do ShowMessage(e.Message);
  end;
  TovSave.Close;
end;

procedure TTovSave.BitBtn3Click(Sender: TObject);
begin
  TovSave.Close;
end;

end.
