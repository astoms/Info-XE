unit Unit13;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TTovJam = class(TForm)
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    StaticText1: TStaticText;
    Memo1: TMemo;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    Label1: TLabel;
    Label2: TLabel;
    Memo2: TMemo;
    Label3: TLabel;
    Memo3: TMemo;
    Image1: TImage;
    BitBtn1: TBitBtn;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    DatePost: TDateTimePicker;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Clear();
  end;

var
  TovJam: TTovJam;

implementation

{$R *.dfm}

uses Unit1, Unit2;

{ TTovJam }

procedure TTovJam.BitBtn1Click(Sender: TObject);
begin
  try
    if MainForm.DBGrid7.Cells[0, MainForm.DBGrid7.RowCount-1]='' then
    begin
      MainForm.DBGrid7.Cells[0, MainForm.DBGrid7.RowCount-1]:=LabeledEdit1.Text;
      MainForm.DBGrid7.Cells[1, MainForm.DBGrid7.RowCount-1]:=LabeledEdit2.Text;
      MainForm.DBGrid7.Cells[2, MainForm.DBGrid7.RowCount-1]:=Memo1.Lines.CommaText;
      MainForm.DBGrid7.Cells[3, MainForm.DBGrid7.RowCount-1]:=LabeledEdit3.Text;
      MainForm.DBGrid7.Cells[4, MainForm.DBGrid7.RowCount-1]:=LabeledEdit4.Text;
      MainForm.DBGrid7.Cells[5, MainForm.DBGrid7.RowCount-1]:=LabeledEdit5.Text;
      MainForm.DBGrid7.Cells[6, MainForm.DBGrid7.RowCount-1]:=LabeledEdit6.Text;
      MainForm.DBGrid7.Cells[7, MainForm.DBGrid7.RowCount-1]:='-';
      MainForm.DBGrid7.Cells[8, MainForm.DBGrid7.RowCount-1]:='-';
      MainForm.DBGrid7.Cells[9, MainForm.DBGrid7.RowCount-1]:=Memo3.Text;
    end
    else
    begin
      MainForm.DBGrid7.RowCount:=MainForm.DBGrid7.RowCount+1;
      MainForm.DBGrid7.Cells[0, MainForm.DBGrid7.RowCount-1]:=LabeledEdit1.Text;
      MainForm.DBGrid7.Cells[1, MainForm.DBGrid7.RowCount-1]:=LabeledEdit2.Text;
      MainForm.DBGrid7.Cells[2, MainForm.DBGrid7.RowCount-1]:=Memo1.Lines.CommaText;
      MainForm.DBGrid7.Cells[3, MainForm.DBGrid7.RowCount-1]:=LabeledEdit3.Text;
      MainForm.DBGrid7.Cells[4, MainForm.DBGrid7.RowCount-1]:=LabeledEdit4.Text;
      MainForm.DBGrid7.Cells[5, MainForm.DBGrid7.RowCount-1]:=LabeledEdit5.Text;
      MainForm.DBGrid7.Cells[6, MainForm.DBGrid7.RowCount-1]:=LabeledEdit6.Text;
      MainForm.DBGrid7.Cells[7, MainForm.DBGrid7.RowCount-1]:='-';
      MainForm.DBGrid7.Cells[8, MainForm.DBGrid7.RowCount-1]:='-';
      MainForm.DBGrid7.Cells[9, MainForm.DBGrid7.RowCount-1]:=Memo3.Text;
    end;
  except
  end;
  TovJam.Close;
end;

procedure TTovJam.Clear;
begin
  LabeledEdit1.Text:='';
  LabeledEdit2.Text:='';
  LabeledEdit3.Text:='';
  LabeledEdit4.Text:='';
  LabeledEdit5.Text:='';
  LabeledEdit6.Text:='';
  Memo1.Lines.Clear;
  Memo2.Lines.Clear;
  Memo3.Lines.Clear;
  DatePost.Format:=' ';
end;

end.
