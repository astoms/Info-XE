unit Unit5;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, IdCoder,
  IdCoder3to4, IdCoder00E, IdCoderXXE, IdBaseComponent, Vcl.Mask, Vcl.DBCtrls;

type
  TAD = class(TForm)
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    GroupBox1: TGroupBox;
    Panel4: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Edit1: TEdit;
    Panel5: TPanel;
    DBGrid1: TDBGrid;
    GroupBox2: TGroupBox;
    Panel6: TPanel;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Edit2: TEdit;
    Panel7: TPanel;
    DBGrid2: TDBGrid;
    GroupTable: TADOTable;
    GroupSource: TDataSource;
    GroupQuery: TADOQuery;
    UserTable: TADOTable;
    UserSource: TDataSource;
    UserQuery: TADOQuery;
    TNSTable: TADOTable;
    TNSSource: TDataSource;
    TNSQuery: TADOQuery;
    TabSheet2: TTabSheet;
    GroupBox4: TGroupBox;
    Panel8: TPanel;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    Edit3: TEdit;
    Panel9: TPanel;
    DBGrid3: TDBGrid;
    TabSheet3: TTabSheet;
    GroupBox3: TGroupBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit1: TLabeledEdit;
    GroupBox5: TGroupBox;
    LabeledEdit3: TLabeledEdit;
    Label1: TLabel;
    SpeedButton3: TSpeedButton;
    Label2: TLabel;
    TabSheet4: TTabSheet;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    DBGrid4: TDBGrid;
    DBGrid5: TDBGrid;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    BitBtn10: TBitBtn;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    BitBtn11: TBitBtn;
    FormatTable: TADOTable;
    StyleTable: TADOTable;
    StyleQuery: TADOQuery;
    FormatQuery: TADOQuery;
    StyleSource: TDataSource;
    FormatSource: TDataSource;
    TabSheet5: TTabSheet;
    DeCode: TIdDecoderXXE;
    EnCode: TIdEncoderXXE;
    LabeledEdit7: TLabeledEdit;
    LabeledEdit8: TLabeledEdit;
    LabeledEdit9: TLabeledEdit;
    LabeledEdit10: TLabeledEdit;
    BitBtn12: TBitBtn;
    CheckBox1: TCheckBox;
    GroupBox8: TGroupBox;
    Panel14: TPanel;
    BitBtn13: TBitBtn;
    BitBtn14: TBitBtn;
    Edit4: TEdit;
    Panel15: TPanel;
    DBGrid6: TDBGrid;
    DBTable: TADOTable;
    DBQuery: TADOQuery;
    DBSource: TDataSource;
    BitBtn15: TBitBtn;
    Edit5: TEdit;
    CheckBox2: TCheckBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure DBGrid4CellClick(Column: TColumn);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure LabeledEdit7KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn12Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure DBGrid6CellClick(Column: TColumn);
    procedure BitBtn15Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AD: TAD;

implementation

{$R *.dfm}

uses unit1, Unit6, Unit7, Unit4, Unit11;

procedure TAD.BitBtn10Click(Sender: TObject);
var
 temp:Word;
begin
  temp:=MessageBox(handle, PChar('Вы действительно решили удалить стиль из формата "'+DBGrid4.DataSource.DataSet.FieldByName('name').AsString+'" с именем "'+DBGrid5.DataSource.DataSet.FieldByName('name').AsString+'" ?'), PChar('Удаление стиля:'), MB_YESNO+MB_ICONQUESTION);
  case temp of
    idyes:
      begin
        StyleQuery.Active:=false;
        StyleQuery.SQL.Clear;
        StyleQuery.SQL.Add('delete from info_style where id='''+DBGrid5.DataSource.DataSet.FieldByName('id').AsString+'''');
        StyleQuery.ExecSQL;
        StyleTable.Active:=false;
        StyleTable.Active:=true;
      end;
  end;
end;

procedure TAD.BitBtn11Click(Sender: TObject);
var OpenD:TOpenDialog;
begin
  OpenD:=TOpenDialog.Create(self);
  OpenD.Filter:='FastReport|*.fr3';
  OpenD.Title:='Выбор файла:';
  if OpenD.Execute then
  begin
    LabeledEdit6.Text:=ExtractFileName(OpenD.FileName);
  end
  else
  begin
    OpenD.Free;
    Exit;
  end;
end;

procedure TAD.BitBtn12Click(Sender: TObject);
var F:TextFile;
begin
  AssignFile(F,'MySQL.Net');
  ReWrite(F);
  WriteLn(F,EnCode.EncodeString(LabeledEdit7.Text));
  WriteLn(F,EnCode.EncodeString(LabeledEdit8.Text));
  WriteLn(F,EnCode.EncodeString(LabeledEdit9.Text));
  WriteLn(F,EnCode.EncodeString(LabeledEdit10.Text));
  CloseFile(F);
end;

procedure TAD.BitBtn15Click(Sender: TObject);
var
 temp:Word; tmp:string; i:integer;
begin
  if Edit3.Text<>'' then
  begin
    temp:=MessageBox(handle, PChar('Вы действительно решили добавить место хранения с именем "'+Edit3.Text+'" в базу "'+DBGrid6.DataSource.DataSet.FieldByName('value').AsString+'" ?'), PChar('Добавление места хранения в базу:'), MB_YESNO+MB_ICONQUESTION);
    case temp of
      idyes:
        begin
          tmp:='';
          i:=1;
          while i<>length(Edit3.Text) do
          begin
            if ((copy(Edit3.Text, i, 1)<>'"') and (copy(Edit3.Text, i, 1)<>'''')) then
            begin
              tmp:=tmp+copy(Edit3.Text, i ,1);
            end;
            inc(i);
          end;
          DBQuery.Active:=false;
          DBQuery.SQL.Clear;
          DBQuery.SQL.Add('insert into info_db(`database`, `num`, `name`) values('''+DBGrid6.DataSource.DataSet.FieldByName('value').AsString+''','''+Edit5.Text+''','''+tmp+''')');
          DBQuery.ExecSQL;
          DBTable.Active:=false;
          DBTable.Active:=true;
          DBTable.Filtered:=false;
          DBTable.Filter:='database='''+DBGrid6.DataSource.DataSet.FieldByName('value').AsString+'''';
          DBTable.Filtered:=true;
        end;
    end;
  end;
end;

procedure TAD.BitBtn1Click(Sender: TObject);
var
 temp:Word;
begin
  if Edit1.Text<>'' then
  begin
    temp:=MessageBox(handle, PChar('Вы действительно решили добавить группу "'+Edit1.Text+'" в базу данных ?'), PChar('Добавление группы:'), MB_YESNO+MB_ICONQUESTION);
    case temp of
      idyes:
      begin
        GroupQuery.Active:=false;
        GroupQuery.SQL.Clear;
        GroupQuery.SQL.Add('insert into info_group(name) values('''+Edit1.Text+''')');
        GroupQuery.ExecSQL;
        Edit1.Text:='';
        GroupTable.Active:=false;
        GroupTable.Active:=true;
      end;
    end;
  end;
end;

procedure TAD.BitBtn2Click(Sender: TObject);
var
 temp:Word;
begin
  temp:=MessageBox(handle, PChar('Вы действительно решили удалить группу "'+DBGrid1.DataSource.DataSet.FieldByName('name').AsString+'" из базы данных ?'), PChar('Удаление группы:'), MB_YESNO+MB_ICONQUESTION);
  case temp of
    idyes:
      begin
        GroupQuery.Active:=false;
        GroupQuery.SQL.Clear;
        GroupQuery.SQL.Add('delete from info_group where id='''+DBGrid1.DataSource.DataSet.FieldByName('id').AsString+'''');
        GroupQuery.ExecSQL;
        GroupTable.Active:=false;
        GroupTable.Active:=true;
      end;
  end;
end;

procedure TAD.BitBtn3Click(Sender: TObject);
var
 temp:Word;
begin
  if Edit2.Text<>'' then
  begin
    temp:=MessageBox(handle, PChar('Вы действительно решили добавить в группу "'+DBGrid1.DataSource.DataSet.FieldByName('name').AsString+'" пользователя "'+Edit2.Text+'" ?'), PChar('Добавление пользователя в группу:'), MB_YESNO+MB_ICONQUESTION);
    case temp of
      idyes:
      begin
        UserQuery.Active:=false;
        UserQuery.SQL.Clear;
        UserQuery.SQL.Add('insert into info_users(user, groupid) values('''+Edit2.Text+''', '''+DBGrid1.DataSource.DataSet.FieldByName('id').AsString+''')');
        UserQuery.ExecSQL;
        Edit2.Text:='';
        UserTable.Active:=false;
        UserTable.Active:=true;
      end;
    end;
  end;
end;

procedure TAD.BitBtn4Click(Sender: TObject);
var
 temp:Word;
begin
  temp:=MessageBox(handle, PChar('Вы действительно решили удалить пользователя "'+DBGrid2.DataSource.DataSet.FieldByName('user').AsString+'" из группы "'+DBGrid1.DataSource.DataSet.FieldByName('name').AsString+'" ?'), PChar('Удаление пользователя из группы:'), MB_YESNO+MB_ICONQUESTION);
  case temp of
    idyes:
      begin
        UserQuery.Active:=false;
        UserQuery.SQL.Clear;
        UserQuery.SQL.Add('delete from info_users where id='''+DBGrid2.DataSource.DataSet.FieldByName('id').AsString+'''');
        UserQuery.ExecSQL;
        UserTable.Active:=false;
        UserTable.Active:=true;
      end;
  end;
end;

procedure TAD.BitBtn5Click(Sender: TObject);
begin
  ChooseGoods.ShowModal;
end;

procedure TAD.BitBtn6Click(Sender: TObject);
var
 temp:Word;
begin
  temp:=MessageBox(handle, PChar('Вы действительно решили удалить место хранения с именем "'+DBGrid3.DataSource.DataSet.FieldByName('name').AsString+'" из базы "'+DBGrid6.DataSource.DataSet.FieldByName('value').AsString+'" ?'), PChar('Удаление места хранения из базы:'), MB_YESNO+MB_ICONQUESTION);
  case temp of
    idyes:
      begin
        DBQuery.Active:=false;
        DBQuery.SQL.Clear;
        DBQuery.SQL.Add('delete from info_db where id='''+DBGrid3.DataSource.DataSet.FieldByName('id').AsString+'''');
        DBQuery.ExecSQL;
        DBTable.Active:=false;
        DBTable.Active:=true;
      end;
  end;
end;

procedure TAD.BitBtn7Click(Sender: TObject);
var
 temp:Word;
begin
  temp:=MessageBox(handle, PChar('Вы действительно решили удалить формат "'+DBGrid4.DataSource.DataSet.FieldByName('name').AsString+'" из базы данных ?'), PChar('Удаление формата:'), MB_YESNO+MB_ICONQUESTION);
  case temp of
    idyes:
      begin
        FormatQuery.Active:=false;
        FormatQuery.SQL.Clear;
        FormatQuery.SQL.Add('delete from info_format where id='''+DBGrid4.DataSource.DataSet.FieldByName('id').AsString+'''');
        FormatQuery.ExecSQL;
        FormatTable.Active:=false;
        FormatTable.Active:=true;
      end;
  end;
end;

procedure TAD.BitBtn8Click(Sender: TObject);
var
 temp:Word;
begin
  if LabeledEdit4.Text<>'' then
  begin
    temp:=MessageBox(handle, PChar('Вы действительно решили добавить формат "'+LabeledEdit4.Text+'" в базу данных ?'), PChar('Добавление формата:'), MB_YESNO+MB_ICONQUESTION);
    case temp of
      idyes:
      begin
        FormatQuery.Active:=false;
        FormatQuery.SQL.Clear;
        FormatQuery.SQL.Add('insert into info_format(name) values('''+LabeledEdit4.Text+''')');
        FormatQuery.ExecSQL;
        LabeledEdit4.Text:='';
        FormatTable.Active:=false;
        FormatTable.Active:=true;
      end;
    end;
  end;
end;

procedure TAD.BitBtn9Click(Sender: TObject);
var
 temp:Word;
begin
  if ((LabeledEdit5.Text<>'') and (LabeledEdit6.Text<>'')) then
  begin
    temp:=MessageBox(handle, PChar('Вы действительно решили добавить стиль "'+DBGrid4.DataSource.DataSet.FieldByName('name').AsString+'-'+LabeledEdit5.Text+'" в базу данных ?'), PChar('Добавление стиля:'), MB_YESNO+MB_ICONQUESTION);
    case temp of
      idyes:
      begin
        StyleQuery.Active:=false;
        StyleQuery.SQL.Clear;
        StyleQuery.SQL.Add('insert into info_style(name,file,format) values('''+LabeledEdit5.Text+''', '''+LabeledEdit6.Text+''', '+DBGrid4.DataSource.DataSet.FieldByName('id').AsString+')');
        StyleQuery.ExecSQL;
        LabeledEdit5.Text:='';
        LabeledEdit6.Text:='';
        StyleTable.Active:=false;
        StyleTable.Active:=true;
      end;
    end;
  end;
end;

procedure TAD.CheckBox1Click(Sender: TObject);
var id:string;
begin
  try
    id:=DBGrid1.DataSource.DataSet.FieldByName('id').AsString;
  except
    id:='';
  end;
  if CheckBox1.Checked=true then
  begin
    try
      GroupQuery.Active:=false;
      GroupQuery.SQL.Clear;
      GroupQuery.SQL.Add('update info_group SET fr=''true'' where id='''+id+'''');
      GroupQuery.ExecSQL;
    except
    end;
  end
  else
  begin
    try
      GroupQuery.Active:=false;
      GroupQuery.SQL.Clear;
      GroupQuery.SQL.Add('update info_group SET fr=''false'' where id='''+id+'''');
      GroupQuery.ExecSQL;
    except
    end;
  end;
  GroupTable.Active:=false;
  GroupTable.Active:=true;
  GroupTable.First;
  while not GroupTable.Eof do
  begin
    if GroupTable.FieldByName('id').AsString=id then break;
    GroupTable.Next;
  end;
end;

procedure TAD.CheckBox2Click(Sender: TObject);
var id:string;
begin
  try
    id:=DBGrid1.DataSource.DataSet.FieldByName('id').AsString;
  except
    id:='';
  end;
  if CheckBox1.Checked=true then
  begin
    try
      GroupQuery.Active:=false;
      GroupQuery.SQL.Clear;
      GroupQuery.SQL.Add('update info_group SET moder=''true'' where id='''+id+'''');
      GroupQuery.ExecSQL;
    except
    end;
  end
  else
  begin
    try
      GroupQuery.Active:=false;
      GroupQuery.SQL.Clear;
      GroupQuery.SQL.Add('update info_group SET moder=''false'' where id='''+id+'''');
      GroupQuery.ExecSQL;
    except
    end;
  end;
  GroupTable.Active:=false;
  GroupTable.Active:=true;
  GroupTable.First;
  while not GroupTable.Eof do
  begin
    if GroupTable.FieldByName('id').AsString=id then break;
    GroupTable.Next;
  end;
end;

procedure TAD.DBGrid1CellClick(Column: TColumn);
begin
  try
    UserTable.Active:=false;
    UserTable.Active:=true;
    UserTable.Filtered:=false;
    UserTable.Filter:='groupid='''+DBGrid1.DataSource.DataSet.FieldByName('id').AsString+'''';
    UserTable.Filtered:=true;
  except
  end;
  try
    if GroupTable.FieldByName('fr').AsString='false' then CheckBox1.State:=cbUnChecked else CheckBox1.State:=cbChecked;
  except
  end;
  try
    if GroupTable.FieldByName('moder').AsString='false' then CheckBox2.State:=cbUnChecked else CheckBox1.State:=cbChecked;
  except
  end;
end;

procedure TAD.DBGrid4CellClick(Column: TColumn);
begin
  if DBgrid4.DataSource.DataSet.FieldByName('name').AsString<>'' then
  begin
    StyleTable.Active:=false;
    StyleTable.Active:=true;
    StyleTable.Filtered:=false;
    StyleTable.Filter:='format='+DBgrid4.DataSource.DataSet.FieldByName('id').AsString;
    StyleTable.Filtered:=true;
  end;
end;

procedure TAD.DBGrid6CellClick(Column: TColumn);
begin
  if DBGrid6.DataSource.DataSet.FieldByName('value').AsString<>'' then
  begin
    Edit3.Text:='';
    Edit5.Text:='';
    DBTable.Active:=false;
    DBTable.Active:=true;
    DBTable.Filtered:=false;
    DBTable.Filter:='database='''+DBGrid6.DataSource.DataSet.FieldByName('value').AsString+'''';
    DBTable.Filtered:=true;
  end;
end;

procedure TAD.FormResize(Sender: TObject);
begin
  DBGrid1.Columns[0].Width:=Trunc(DBGrid1.Width * 0.15);
  DBGrid1.Columns[1].Width:=Trunc(DBGrid1.Width * 0.75);
  DBGrid2.Columns[0].Width:=Trunc(DBGrid1.Width * 0.15);
  DBGrid2.Columns[1].Width:=Trunc(DBGrid1.Width * 0.8);
  DBGrid3.Columns[0].Width:=Trunc(DBGrid1.Width * 0.95);
end;

procedure TAD.FormShow(Sender: TObject);
var F:TextFile; S:string;
begin
  if FileExists('MySQL.Net') then
  begin
    AssignFile(F, 'MySQL.Net');
    ReSet(F);
    ReadLn(F, S);
    LabeledEdit7.Text:=DeCode.DecodeString(S);
    ReadLn(F, S);
    LabeledEdit8.Text:=DeCode.DecodeString(S);
    ReadLn(F, S);
    LabeledEdit9.Text:=DeCode.DecodeString(S);
    ReadLn(F, S);
    LabeledEdit10.Text:=DeCode.DecodeString(S);
    CloseFile(F);
  end;
  GroupTable.Active:=true;
  TNSTable.Active:=true;
  TNSTable.Filtered:=false;
  TNSTable.Filter:='name=''database''';
  TNSTable.Filtered:=true;
  try
    GroupQuery.Active:=false;
    GroupQuery.SQL.Clear;
    GroupQuery.SQL.Add('select * from settings');
    GroupQuery.Active:=true;
    GroupQuery.First;
    while not GroupQuery.Eof do
    begin
      if VarToStr(GroupQuery.FieldValues['name'])='pricetype' then
      begin
        Auth.pricetype:=VarToStr(GroupQuery.FieldValues['value']);
        LabeledEdit1.Text:=VarToStr(GroupQuery.FieldValues['value']);
      end;
      if VarToStr(GroupQuery.FieldValues['name'])='storeloc' then
      begin
        Auth.storeloc:=VarToStr(GroupQuery.FieldValues['value']);
        LabeledEdit2.Text:=VarToStr(GroupQuery.FieldValues['value']);
      end;
      GroupQuery.Next;
    end;

    GroupQuery.Active:=false;
    GroupQuery.SQL.Clear;
    GroupQuery.SQL.Add('select * from info_price');
    GroupQuery.Active:=true;
    GroupQuery.First;
    while not GroupQuery.Eof do
    begin
      if VarToStr(GroupQuery.FieldValues['value'])=LabeledEdit1.Text then
      begin
        LabeledEdit1.Text:=VarToStr(GroupQuery.FieldValues['name']);
      end;
      GroupQuery.Next;
    end;

    GroupQuery.Active:=false;
    GroupQuery.SQL.Clear;
    GroupQuery.SQL.Add('select * from info_place');
    GroupQuery.Active:=true;
    GroupQuery.First;
    while not GroupQuery.Eof do
    begin
      if VarToStr(GroupQuery.FieldValues['value'])=LabeledEdit2.Text then
      begin
        LabeledEdit2.Text:=VarToStr(GroupQuery.FieldValues['name']);
      end;
      GroupQuery.Next;
    end;

    GroupQuery.Active:=false;
    GroupQuery.SQL.Clear;
    GroupQuery.SQL.Add('select * from settings where name=''trade''');
    GroupQuery.Active:=true;
    GroupQuery.First;
    LabeledEdit3.Text:=VarToStr(GroupQuery.FieldValues['value']);
    Auth.magazin:=VarToStr(GroupQuery.FieldValues['value']);
    FormatTable.Active:=false;
    FormatTable.Active:=true;
  except
  end;
end;

procedure TAD.LabeledEdit7KeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9', #8, '.']) then key:=#0;
end;

procedure TAD.SpeedButton1Click(Sender: TObject);
begin
    ChPrice.ShowModal;
end;

procedure TAD.SpeedButton2Click(Sender: TObject);
begin
  ChPlace.ShowModal;
end;

procedure TAD.SpeedButton3Click(Sender: TObject);
begin
  ChTrade.ShowModal;
end;

end.
