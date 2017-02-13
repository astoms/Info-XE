unit Unit21;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.Buttons;

type
  TZvMessage = class(TForm)
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    num:string;
    name:string;
    { Public declarations }
  end;

var
  ZvMessage: TZvMessage;

implementation

{$R *.dfm}

uses Unit2, Unit1;

procedure TZvMessage.BitBtn1Click(Sender: TObject);
begin
  try
    MainForm.PageControl1.ActivePageIndex:=8;
    MainForm.Label10.Caption:='�������� '+num+':';
    MainForm.Label19.Caption:=name;
    MainForm.doc_num:=num;
    MainForm.ZV_Read2.Active:=false;
    MainForm.ZV_Read2.Active:=true;
    MainForm.ZV_Read2.Filtered:=false;
    MainForm.ZV_Read2.Filter:='docid='''+num+'''';
    MainForm.ZV_Read2.Filtered:=true;
    MainForm.Panel27.Align:=alClient;
    MainForm.Panel27.Visible:=true;
    try
      MainForm.ZV_TD_Query.Active:=false;
      MainForm.ZV_TD_Query.SQL.Clear;
      MainForm.ZV_TD_Query.SQL.Add('select * from zv_td where id='''+num+'''');
      MainForm.ZV_TD_Query.Active:=true;
    except
    end;
    if MainForm.ZV_TD_Query.FieldByName('status').AsString='��������' then
    begin
      MainForm.BitBtn29.Enabled:=true;
      MainForm.BitBtn30.Enabled:=true;
      MainForm.BitBtn33.Enabled:=true;
      if Auth.sklad then
      begin
        MainForm.BitBtn33.Enabled:=false;
      end
      else
      begin
        MainForm.BitBtn33.Enabled:=true;
      end;
      MainForm.BitBtn34.Enabled:=false;
    end
    else
    begin
      MainForm.BitBtn29.Enabled:=false;
      MainForm.BitBtn30.Enabled:=false;
      MainForm.BitBtn33.Enabled:=false;
      MainForm.BitBtn34.Enabled:=true;
      if MainForm.ZV_TD_Query.FieldByName('status').AsString='�������' then
      begin
        MainForm.BitBtn34.Enabled:=false;
      end;
    end;
    try
      MainForm.Place_Query3.Active:=false;
      MainForm.Place_Query3.SQL.Clear;
      MainForm.Place_Query3.SQL.Add('update zv_td set statmes=''true'' where id='''+num+'''');
      MainForm.Place_Query3.ExecSQL;
    except
    end;
  except
  end;
  Close();
end;

procedure TZvMessage.BitBtn2Click(Sender: TObject);
begin
  MainForm.HideMes;
  MainForm.Obrab.Enabled:=false;
  MainForm.Otloj.Enabled:=true;
end;

procedure TZvMessage.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  try
    MainForm.Place_Query3.Active:=false;
    MainForm.Place_Query3.SQL.Clear;
    MainForm.Place_Query3.SQL.Add('update zv_td set statmes=''true'' where id='''+num+'''');
    MainForm.Place_Query3.ExecSQL;
  except
  end;
end;

procedure TZvMessage.FormShow(Sender: TObject);
begin
  //AnimateWindow(Handle,500, SW_SHOWNOACTIVATE);
end;

end.
