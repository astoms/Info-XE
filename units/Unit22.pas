unit Unit22;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TPrintForm = class(TForm)
    Label1: TLabel;
    DTP: TDateTimePicker;
    Label2: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Cat: TCheckListBox;
    Format: TCheckListBox;
    Action: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrintForm: TPrintForm;

implementation

{$R *.dfm}

end.
