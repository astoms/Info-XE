unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Data.Win.ADODB;

type
  TChPlace = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    DBGrid1: TDBGrid;
    PlaceTable: TADOTable;
    PlaceQuery: TADOQuery;
    PlaceSource: TDataSource;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    BitBtn2: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ChPlace: TChPlace;

implementation

{$R *.dfm}

uses Unit1, Unit5;

procedure TChPlace.BitBtn1Click(Sender: TObject);
var
 temp:Word;
begin
  if ((LabeledEdit1.Text<>'') and (LabeledEdit2.Text<>'')) then
  begin
    temp:=MessageBox(handle, PChar('¬ы действительно решили добавить новое место хранени€ "'+LabeledEdit1.Text+'" и значением "'+LabeledEdit2.Text+'" в базу данных ?'), PChar('ƒобавление места хранени€:'), MB_YESNO+MB_ICONQUESTION);
    case temp of
      idyes:
      begin
        PlaceQuery.Active:=false;
        PlaceQuery.SQL.Clear;
        PlaceQuery.SQL.Add('insert into info_place(name,value) values('''+LabeledEdit1.Text+''','''+LabeledEdit2.Text+''')');
        PlaceQuery.ExecSQL;
        LabeledEdit1.Text:='';
        LabeledEdit2.Text:='';
        PlaceTable.Active:=false;
        PlaceTable.Active:=true;
      end;
    end;
  end;
end;

procedure TChPlace.BitBtn2Click(Sender: TObject);
var
 temp:Word;
begin
  temp:=MessageBox(handle, PChar('¬ы действительно решили удалить место хранени€ "'+DBGrid1.DataSource.DataSet.FieldByName('name').AsString+'" из базы данных ?'), PChar('”даление места хранени€:'), MB_YESNO+MB_ICONQUESTION);
  case temp of
    idyes:
      begin
        PlaceQuery.Active:=false;
        PlaceQuery.SQL.Clear;
        PlaceQuery.SQL.Add('delete from info_place where id='''+DBGrid1.DataSource.DataSet.FieldByName('id').AsString+'''');
        PlaceQuery.ExecSQL;
        PlaceTable.Active:=false;
        PlaceTable.Active:=true;
      end;
  end;
end;

procedure TChPlace.DBGrid1DblClick(Sender: TObject);
begin
  if DBGrid1.DataSource.DataSet.FieldByName('name').AsString<>'' then
  begin
    Ad.LabeledEdit2.Text:=DBGrid1.DataSource.DataSet.FieldByName('name').AsString;
    try
      PlaceQuery.Active:=false;
      PlaceQuery.SQL.Clear;
      PlaceQuery.SQL.Add('update settings set value='''+DBGrid1.DataSource.DataSet.FieldByName('value').AsString+''' where name=''storeloc''');
      PlaceQuery.ExecSQL;
      Auth.storeloc:=DBGrid1.DataSource.DataSet.FieldByName('value').AsString;
    except
    end;
    ChPlace.Close;
  end;
end;

procedure TChPlace.FormShow(Sender: TObject);
begin
  PlaceTable.Active:=false;
  PlaceTable.Active:=true;
end;

end.

