unit Unit18;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Themes, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel;

type
  TMileShow = class(TForm)
    Src: TImage;
    FIO: TLabeledEdit;
    balance: TLabeledEdit;
    Stop: TEdit;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SrcClick(Sender: TObject);
    procedure ballClick(Sender: TObject);
    procedure FIO2Click(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure balanceKeyPress(Sender: TObject; var Key: Char);
    procedure FIOKeyPress(Sender: TObject; var Key: Char);
    procedure StopKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MileShow: TMileShow;

implementation

{$R *.dfm}

procedure TMileShow.balanceKeyPress(Sender: TObject; var Key: Char);
begin
  Close;
end;

procedure TMileShow.ballClick(Sender: TObject);
begin
  Close;
end;

procedure TMileShow.FormClick(Sender: TObject);
begin
  Close;
end;

procedure TMileShow.FormKeyPress(Sender: TObject; var Key: Char);
begin
  Close;
end;

procedure TMileShow.FormShow(Sender: TObject);
begin
  Stop.SetFocus;
end;

procedure TMileShow.FIO2Click(Sender: TObject);
begin
  Close;
end;

procedure TMileShow.FIOKeyPress(Sender: TObject; var Key: Char);
begin
  Close;
end;

procedure TMileShow.SrcClick(Sender: TObject);
begin
  Close;
end;

procedure TMileShow.StopKeyPress(Sender: TObject; var Key: Char);
begin
  Close;
end;

end.
