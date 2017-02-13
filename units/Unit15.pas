unit Unit15;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.CheckLst;

type
  TValueList = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    List: TCheckListBox;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  private
    { Private declarations }
    MyList:TStringList;
  public
    { Public declarations }
    procedure ShowList(section:string);
  end;

var
  ValueList: TValueList;

implementation

{$R *.dfm}

uses Unit1, Unit2;

{ TValueList }

procedure TValueList.BitBtn1Click(Sender: TObject);
var i:integer;
begin
  try
    MainForm.TreeView.OnChange(nil,MainForm.TreeView.Items.GetFirstNode);
    MainForm.FindEdit.Text:='';
    i:=0;
    while i<>MyList.Count do
    begin
      if List.Checked[i]=true then
      begin
        MainForm.FindEdit.Text:=MainForm.FindEdit.Text+MyList.Strings[i]+' ';
      end;
      inc(i);
    end;
    MainForm.Search.Caption:='�����';
    MainForm.Search.Click;
    MainForm.GridSelectAll(MainForm.DBGrid1);
    i:=0;
    try
      MainForm.TaskBar.OverlayIcon:=MainForm.UpdImg.Picture.Icon;
      MainForm.Icon:=MainForm.UpdImg.Picture.Icon;
    except
    end;
    while i<=MainForm.DBGrid1.SelectedRows.Count do
    begin
      MainForm.DBGrid1.DataSource.DataSet.GotoBookmark(Pointer(MainForm.DBGrid1.SelectedRows.Items[i]));
      MainForm.DBGrid1.OnDblClick(nil);
      inc(i);
    end;
  except
  end;
  ValueList.Close;
end;

procedure TValueList.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TValueList.BitBtn3Click(Sender: TObject);
var i:integer;
begin
  i:=0;
  while i<>List.Items.Count do
  begin
    List.Checked[i]:=true;
    inc(i);
  end;
end;


procedure TValueList.BitBtn4Click(Sender: TObject);
var i:integer;
begin
  i:=0;
  while i<>List.Items.Count do
  begin
    List.Checked[i]:=false;
    inc(i);
  end;
end;

procedure TValueList.ShowList(section: string);
var id:string;
begin
  try
    Auth.SGO_Query.Active:=false;
    Auth.SGO_Query.SQL.Clear;
    Auth.SGO_Query.SQL.Add('select * from t_zd where `group` = '''+section+''' and `ext`=''false0''');
    Auth.SGO_Query.Active:=true;
  except
    on E:Exception do
    begin
      ShowMessage('�� ����� ������������ ��������� ������.'+#13+'���������� �������� �� ���� ���������� ��������������.'+#13+'���������: '+E.Message+'.');
      Exit;
    end;
  end;
  if Auth.SGO_Query.RecordCount>0 then
  begin
    id:='';
    Auth.SGO_Query.First;
    while not Auth.SGO_Query.Eof do
    begin
      id:=id+Auth.SGO_Query.FieldByName('id').AsString+', ';
      Auth.SGO_Query.Next;
    end;
    id:=copy(id, 1, length(id)-2);
    try
      Auth.SGO_Query.Active:=false;
      Auth.SGO_Query.SQL.Clear;
      Auth.SGO_Query.SQL.Add('select * from t_zd2 where `docid` in ('+id+') and `ext`=''false''');
      Auth.SGO_Query.Active:=true;
    except
      on E:Exception do
      begin
        ShowMessage('�� ����� ������������ ��������� ������.'+#13+'���������� �������� �� ���� ���������� ��������������.'+#13+'���������: '+E.Message+'.');
        Exit;
      end;
    end;
    if Auth.SGO_Query.RecordCount>0 then
    begin
      if MyList<>nil then MyList.Free;
      MyList:=TStringList.Create;
      MyList.Clear;
      List.Items.Clear;
      Auth.SGO_Query.First;
      while not Auth.SGO_Query.Eof do
      begin
        MyList.Add(Auth.SGO_Query.FieldByName('article').AsString);
        List.Items.Add(Auth.SGO_Query.FieldByName('article').AsString+' | '+Auth.SGO_Query.FieldByName('name').AsString+' | ��������: '+Auth.SGO_Query.FieldByName('docid').AsString);
        Auth.SGO_Query.Next;
      end;
      ValueList.ShowModal;
    end
    else
    begin
      ShowMessage('� ����� ��������� ���������� ��� ������� ������� ����� ���� �� ��������������!');
      Exit;
    end;
  end
  else
  begin
    ShowMessage('� ����� ��������� ���������� ��� ������� ������� ����� ���� �� ��������������!');
  end;
end;

end.
