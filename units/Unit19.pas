unit Unit19;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Data.DB, Data.Win.ADODB;

type
  TChangeZPC = class(TForm)
    LabeledEdit1: TLabeledEdit;
    ComboBox1: TComboBox;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    MySQL_Query: TADOQuery;
    procedure FormShow(Sender: TObject);
    procedure ComboBox1KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id_doc:string;
  end;

var
  ChangeZPC: TChangeZPC;

implementation

uses unit1, unit2;

{$R *.dfm}

procedure TChangeZPC.BitBtn1Click(Sender: TObject);
begin
  try
    MySQL_Query.Active:=false;
    MySQL_Query.SQL.Clear;
    MySQL_Query.SQL.Add('update zpc_table set `count_e`='''+LabeledEdit1.Text+''', `state`='''+ComboBox1.Text+''' where id='''+id_doc+'''');
    MySQL_Query.ExecSQL;
  except
    on E:Exception do ShowMessage('Ошибка: '+E.Message+'.')
  end;
  MainForm.Changer.Click;
  Close;
end;

procedure TChangeZPC.ComboBox1KeyPress(Sender: TObject; var Key: Char);
begin
  key:=#0;
end;

procedure TChangeZPC.FormShow(Sender: TObject);
begin
  LabeledEdit1.Text:='0';
  ComboBox1.ItemIndex:=0;
end;

end.
