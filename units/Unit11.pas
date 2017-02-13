unit Unit11;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Data.Win.ADODB;

type
  TChooseGoods = class(TForm)
    PlaceTable: TADOTable;
    PlaceSource: TDataSource;
    DBGrid1: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ChooseGoods: TChooseGoods;

implementation

{$R *.dfm}

uses unit1, unit5;

procedure TChooseGoods.DBGrid1DblClick(Sender: TObject);
begin
  if PlaceTable.FieldByName('name').AsString<>'' then
  begin
    AD.Edit3.Text:='';
    AD.Edit3.Text:=PlaceTable.FieldByName('name').AsString;
    AD.Edit5.Text:='';
    AD.Edit5.Text:=PlaceTable.FieldByName('value').AsString;
    ChooseGoods.Close;
  end;
end;

procedure TChooseGoods.FormShow(Sender: TObject);
begin
  PlaceTable.Active:=false;
  PlaceTable.Active:=true;
end;

end.
