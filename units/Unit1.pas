unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Registry,
  Data.DB, Data.Win.ADODB, Vcl.Menus, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, ShellAPI, IdCoder, IdCoder3to4,
  IdCoder00E, IdCoderXXE, System.Win.TaskbarCore, Vcl.Taskbar, Vcl.ExtCtrls;

type
  TConnAccess = class(TThread)
  private
  protected
    procedure Execute; override;
  end;

  TGList = record
    num:string;
    name:string;
  end;

  TStylePrice = record
    name:string;
    path:string;
  end;

  TFormatPrice = record
    id:string;
    name:string;
    style:array of TStylePrice;
  end;

  TAuth = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Remember: TCheckBox;
    Label3: TLabel;
    LoginDB: TEdit;
    PasswordDB: TEdit;
    ServerDB: TComboBox;
    BitBtn1: TBitBtn;
    OraSes: TADOConnection;
    MySQLSes: TADOConnection;
    LoadSet: TADOQuery;
    Menu: TMainMenu;
    APanel: TMenuItem;
    http: TIdHTTP;
    DeCode: TIdDecoderXXE;
    Taskbar: TTaskbar;
    AuthImg: TImage;
    SGO: TADOConnection;
    SGO_Query: TADOQuery;
    StartMain: TTimer;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ServerDBKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure APanelClick(Sender: TObject);
    procedure StartMainTimer(Sender: TObject);
  private
    procedure SaveReg();
    procedure ClearReg();
    procedure OpenReg();
    procedure GoToServer(Base:string);
    { Private declarations }
  public
    pass:string;
    pricetype:string;
    storeloc:string;
    storeloc2:string;
    groupname:string;
    groupid:string;
    tz_moder:boolean;
    sklad:boolean;
    magazin:string;
    title:string;
    (*                    *)
    FormatP:array of TFormatPrice;
    GList:array of TGList;
    (*                    *)
    (*                    *)
    ip:string;
    port:string;
    ML:string;
    MP:string;
    { Public declarations }
    procedure Restore(Sender:TObject);
  end;

var
  Auth: TAuth;

const ver='2.0.4.4';

implementation

{$R *.dfm}

uses Unit2, Unit5, PassWord;

procedure TAuth.Restore(Sender: TObject);
begin
  //MainForm.FormStyle:=fsStayOnTop;
  MainForm.Show;
  //Application.BringToFront;
  SetForegroundWindow(MainForm.Handle);
  ShowWindow(MainForm.Handle, SW_MAXIMIZE);
  {
  if MainForm.Report.PreviewForm.Visible=true then
  begin
    ShowWindow(MainForm.Report.PreviewForm.Handle, SW_RESTORE);
  end
  else
  begin
    ShowWindow(MainForm.Handle, SW_RESTORE);
  end;
  }

  //Report.PreviewForm.Handle
  //SendMessage(MainForm.Handle, WM_SYSCOMMAND, SC_RESTORE, 0);
  //ShowWindow(Application.Handle, SW_HIDE);
  //ShowWindow(Application.Handle, SW_RESTORE);
  //ShowWindow(Application.Handle, SW_MAXIMIZE);
end;

procedure TAuth.APanelClick(Sender: TObject);
begin
  PasswordDlg.ShowModal;
end;

procedure TAuth.BitBtn1Click(Sender: TObject);
var Token:THANDLE;
    L,P:pWideChar;
    i,k:integer;
    mythread:TConnAccess;
begin
  if (Remember.Checked) then
  begin
    SaveReg();
  end
  else
  begin
    ClearReg();
  end;
  if ((LoginDB.Text<>'') and (PasswordDB.Text<>'') and (ServerDB.Text<>'')) then
  begin
    try
      L:=pChar(LoginDB.Text);
      P:=pChar(PasswordDB.Text);
      if LogonUser(L, pChar('ASTOMS'), P, LOGON32_LOGON_NETWORK, LOGON32_PROVIDER_DEFAULT, Token) then
      begin
        try
          LoadSet.Active:=false;
          LoadSet.SQL.Clear;
          LoadSet.SQL.Add('SELECT * FROM info_db where `database` = '''+ServerDB.Text+'''');
          //ShowMessage(LoadSet.SQL.CommaText);
          LoadSet.Active:=true;
          LoadSet.First;
          storeloc2:='';
          while not LoadSet.Eof do
          begin
            storeloc2:=storeloc2+#39+LoadSet.FieldByName('num').AsString+#39+', ';
            LoadSet.Next;
          end;
          storeloc2:=copy(storeloc2, 1, length(storeloc2)-2);
        except
        end;
        try
          LoadSet.Filtered:=false;
          LoadSet.Active:=false;
          LoadSet.SQL.Clear;
          LoadSet.SQL.Add('SELECT * FROM info_group');
          LoadSet.Active:=true;
          //MainForm.Room.Items.Clear;
          //MainForm.Room.Items.Add('�����');
          LoadSet.First;
          while not LoadSet.Eof do
          begin
            //MainForm.Room.Items.Add(LoadSet.FieldByName('name').AsString);
            LoadSet.Next;
          end;

          LoadSet.Filtered:=false;
          LoadSet.Active:=false;
          LoadSet.SQL.Clear;
          LoadSet.SQL.Add('SELECT * FROM info_users where user='''+LoginDB.Text+'''');
          LoadSet.Active:=true;

          LoadSet.First;
          if VarToStr(LoadSet.FieldValues['groupid'])<>'' then
          begin
            groupid:=VarToStr(LoadSet.FieldValues['groupid']);
            LoadSet.Active:=false;
            LoadSet.SQL.Clear;
            LoadSet.SQL.Add('select * from info_db');
            LoadSet.Active:=true;
            LoadSet.Filtered:=false;
            LoadSet.Filter:='database='''+ServerDB.Text+'''';
            LoadSet.Filtered:=true;
            SetLength(GList,0);
            SetLength(GList, LoadSet.RecordCount);
            LoadSet.First;
            k:=0;
            while not LoadSet.Eof do
            begin
              GList[k].num:=LoadSet.FieldByName('num').AsString;
              GList[k].name:=LoadSet.FieldByName('name').AsString;
              inc(k);
              LoadSet.Next;
            end;
            LoadSet.Filtered:=false;
            LoadSet.Active:=false;
            LoadSet.SQL.Clear;
            LoadSet.SQL.Add('select * from info_group where id='+#39+groupid+#39);
            LoadSet.Active:=true;
            LoadSet.First;
            groupname:=LoadSet.FieldByName('name').AsString;
            try
              if LoadSet.FieldByName('moder').AsString='true' then
              begin
                tz_moder:=true;
              end
              else tz_moder:=false;
            except
            end;
            try
              if LoadSet.FieldByName('sklad_k').AsString='true' then
              begin
                sklad:=true;
                MainForm.PageControl1.Pages[15].TabVisible:=true;
              end
              else
              begin
                sklad:=false;
                MainForm.PageControl1.Pages[15].TabVisible:=false;
              end;
            except
            end;
            MainForm.Otd.Items.Clear;
            MainForm.Otd.Items.Add('��� ������');
            MainForm.ComboBox1.Items.Clear;
            MainForm.ComboBox1.Items.Add('��� ������');
            LoadSet.Filtered:=false;
            LoadSet.Active:=false;
            LoadSet.SQL.Clear;
            LoadSet.SQL.Add('select * from info_group');
            LoadSet.Active:=true;
            LoadSet.First;
            while not LoadSet.EOF do
            begin
              MainForm.Otd.Items.Add(LoadSet.FieldByName('name').AsString);
              MainForm.ComboBox1.Items.Add(LoadSet.FieldByName('name').AsString);
              LoadSet.Next;
            end;
            LoadSet.Active:=false;
            LoadSet.SQL.Clear;
            LoadSet.SQL.Add('select * from info_trade');
            LoadSet.Active:=true;
            LoadSet.First;
            MainForm.ComboBox3.Items.Clear;
            MainForm.ComboBox3.Items.Add('���');
            while not LoadSet.Eof do
            begin
              MainForm.ComboBox3.Items.Add(LoadSet.FieldByName('name').AsString);
              LoadSet.Next;
            end;
            MainForm.ComboBox3.ItemIndex:=0;
          end
          else
          begin
            ShowMessage('������ ������� ������ �� �������������.'+#13+'���������� �������� �� ���� ���������� ��������������!');
            Exit;
          end;
        except
          on E:Exception do ShowMessage(E.Message);
        end;
        //MainForm.Access.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=G:\InfoDataBase.mdb;Persist Security Info=True';
        //MainForm.Access.Connected:=true;
        {try

      if (ServerDB.Text='ASTOMS5') then
      begin
        try
          MainForm.Access.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=S:\Mile_brest\Priemka\db\InfoDataBase.mdb;Persist Security Info=True';
          MainForm.Access.Connected:=true;
        except
        end;
      end;
      if (ServerDB.Text='MILE_CO') then
      begin
        try
          if Sklad then
          begin
            MainForm.Access.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=S:\Mile_Sklad\db\InfoDataBase.mdb;Persist Security Info=True';
            MainForm.Access.Connected:=true;
          end
          else
          begin
            if FileExists('\\MILE-VM1\info\InfoDataBase.mdb') then
            begin
              MainForm.Access.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=\\MILE-VM1\info\InfoDataBase.mdb;Persist Security Info=True';
              MainForm.Access.Connected:=true;
            end
            else
            begin
              MainForm.Access.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=S:\Mile_minsk\server_ImportXml\InfoDataBase.mdb;Persist Security Info=True';
              MainForm.Access.Connected:=true;
            end;
          end;
        except
        end;
      end;
      if (ServerDB.Text='MILE_MINSK') then
      begin
        try
          if Sklad then
          begin
            MainForm.Access.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=S:\Mile_Sklad\db\InfoDataBase.mdb;Persist Security Info=True';
            MainForm.Access.Connected:=true;
          end
          else
          begin
            if FileExists('\\MILE-VM1\info\InfoDataBase.mdb') then
            begin
              MainForm.Access.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=\\MILE-VM1\info\InfoDataBase.mdb;Persist Security Info=True';
              MainForm.Access.Connected:=true;
            end
            else
            begin
              MainForm.Access.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=S:\Mile_minsk\server_ImportXml\InfoDataBase.mdb;Persist Security Info=True';
              MainForm.Access.Connected:=true;
            end;
          end;
        except
        end;
      end;
      if (ServerDB.Text='Mogilev') then
      begin
        try
          MainForm.Access.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=S:\Mile_mogilev\priemka\DB\InfoDataBase.mdb;Persist Security Info=True';
          MainForm.Access.Connected:=true;
        except
        end;
      end;
      if (ServerDB.Text='MILE_MOG') then
      begin
        try
          MainForm.Access.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=S:\Mile_mogilev\priemka\DB\InfoDataBase.mdb;Persist Security Info=True';
          MainForm.Access.Connected:=true;
        except
        end;
      end;
      if (ServerDB.Text='MILE_MOMO') then
      begin
        try
          MainForm.Access.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=S:\Mile_momo\priemka\DB\InfoDataBase.mdb;Persist Security Info=True';
          MainForm.Access.Connected:=true;
        except
        end;
      end;
      if (ServerDB.Text='NOVOSEL') then
      begin
        try
          MainForm.Access.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=S:\Novoselkin\server_ImportXml\InfoDataBase.mdb;Persist Security Info=True';
          MainForm.Access.Connected:=true;
        except
        end;
      end;
    except
    end;  }
        GoToServer(ServerDB.Text);
        MainForm.Caption:=Auth.title+' '+ver+' | '+Auth.groupname;
        //MainForm.Caption:='�������������-�������� ������� Info xe';
        MainForm.TreeView.Items.Item[0].Expanded:=true;
        //MainForm.GetGroup();
        TaskBar.OverlayIcon:=nil;
        Screen.Cursor := crAppStart;
        MainForm.ModelTree.GetDataForTree();
        MainForm.ModelTree.GetSortedNodeList();
        MainForm.ModelTree.DrawTree();
        MainForm.TreeView.Items[0].Expanded:=true;
        (* *)
        MainForm.PageControl1.ActivePageIndex:=0;
        try
          MainForm.Panel13.height:=Trunc(MainForm.Panel5.Height*0.6);
          MainForm.Panel12.height:=Trunc(MainForm.Panel5.Height*0.4);
        except
        end;
        MainForm.LoadReg();
        try
          MainForm.ChatTable.Active:=false;
          MainForm.ChatTable.Active:=true;
        except
        end;
        Application.ProcessMessages;
        MainForm.Visible:=true;
        Auth.Visible:=false;
        MainForm.TreeView.OnChange(nil,MainForm.TreeView.Items.GetFirstNode);
        MainForm.TreeView.Items.GetFirstNode.Expanded:=true;
        Screen.Cursor := crDefault;
        Application.ProcessMessages;
        MainForm.FindEdit.SetFocus;
        MainForm.Obrab.Enabled:=true;
        MyThread:=TConnAccess.Create(False);
        MyThread.Priority:=tpNormal;
      end
      else
      begin
        //ShowMessage('������� ������ ����� ��� ������.');
        //Exit;
      end;
    except
      on E:Exception do ShowMessage('������: '+E.Message+'.');
    end;
  end
  else
  begin
    ShowMessage('������: ���������� ������ ����. ���������� ������� ��� ������.');
  end;
end;

procedure TAuth.ClearReg;
var
   Registry: TRegistry;
begin
   Registry := TRegistry.Create;
   Registry.RootKey := hkey_current_user;
   Registry.OpenKey('software\Info',true);
   Registry.WriteString('Login','');
   Registry.WriteString('Password','');
   Registry.WriteString('ServerBD', '');
   Registry.CloseKey;
   Registry.Free;
end;

procedure TAuth.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  OraSes.Connected:=false;
  MySQLSes.Connected:=false;
  try
    MainForm.Client.Close;
  except
  end;
  ExitProcess(1);
end;

procedure TAuth.FormCreate(Sender: TObject);
var i,j:integer;
    temp:Word;
    F:TextFile; S, dir:string;
    nip:string; nport:string; nml:string; nmp:string;
begin
  tz_moder:=false;
  try
    if FileExists('MySQL.Net') then
    begin
      AssignFile(F, 'MySQL.Net');
      ReSet(F);
      ReadLn(F, S);
      ip:=DeCode.DecodeString(S);
      ReadLn(F, S);
      port:=DeCode.DecodeString(S);
      ReadLn(F, S);
      ML:=DeCode.DecodeString(S);
      ReadLn(F, S);
      MP:=DeCode.DecodeString(S);
      CloseFile(F);
    end
    else
    begin
      ShowMessage('��������! ��������� ������������ ����.'+#13+'���������� �������� �� ���� ���������� ��������������.');
      ExitProcess(0);
    end;
  except
  end;
  try
    MySQLSes.Connected:=false;
    MySQLSes.ConnectionString:='Provider=MSDASQL.1;Password='+MP+';Persist Security Info=True;User ID=root;Extended Properties="Driver=MySQL ODBC 5.3 Unicode Driver;SERVER='+ip+';UID='+ML+';PWD='+MP+';DATABASE=info;PORT='+port+';COLUMN_SIZE_S32=1"';
    MySQLSes.Connected:=true;
  except
    on E:Exception do
    begin
      ShowMessage('���������� � ����� ������ "MySQL.Net" �� ������� ����������.'+#13+'���������� �������� �� ���� ���������� ��������������.'+#13+'�������: '+E.Message+'.');
      //ExitProcess(1);
    end;
  end;

  try
    if FileExists('Central.Net') then
    begin
      AssignFile(F, 'Central.Net');
      ReSet(F);
      ReadLn(F, S);
      nip:=DeCode.DecodeString(S);
      ReadLn(F, S);
      nport:=DeCode.DecodeString(S);
      ReadLn(F, S);
      nML:=DeCode.DecodeString(S);
      ReadLn(F, S);
      nMP:=DeCode.DecodeString(S);
      CloseFile(F);
    end
    else
    begin
      ShowMessage('��������! ��������� ������������ ����.'+#13+'���������� �������� �� ���� ���������� ��������������.');
      ExitProcess(0);
    end;
  except
  end;
  try
    SGO.Connected:=false;
    SGO.ConnectionString:='Provider=MSDASQL.1;Password='+nMP+';Persist Security Info=True;User ID=root;Extended Properties="Driver=MySQL ODBC 5.3 Unicode Driver;SERVER='+nip+';UID='+nML+';PWD='+nMP+';DATABASE=info;PORT='+nport+';COLUMN_SIZE_S32=1"';
    SGO.Connected:=true;
  except
    on E:Exception do
    begin
      ShowMessage('���������� � ����� ������ "Central.Net" �� ������� ����������.'+#13+'���������� �������� �� ���� ���������� ��������������.'+#13+'�������: '+E.Message+'.');
      //ExitProcess(1);
    end;
  end;

  dir:=ExtractFilePath(ParamStr(0));
  TaskBar.OverlayIcon:=AuthImg.Picture.Icon;

  try
    ServerDB.Items.Clear;
    LoadSet.Active:=false;
    LoadSet.SQL.Clear;
    LoadSet.SQL.Add('SELECT * FROM settings');
    LoadSet.Active:=true;
    LoadSet.First;
    while not LoadSet.Eof do
    begin
      if VarToStr(LoadSet.FieldValues['name'])='version' then
      begin
        if ver<>VarToStr(LoadSet.FieldValues['value']) then
        begin
          ShowMessage('��������! ��������� "Info - ���������� �������" ��������.'+#13+'����� ������� "�K" ����� �������� ����������!');
          WinExec('InfoServ.exe', SW_SHOW);
        end;
      end;
      if VarToStr(LoadSet.FieldValues['name'])='pass' then
      begin
        pass:=VarToStr(LoadSet.FieldValues['value']);
      end;
      if VarToStr(LoadSet.FieldValues['name'])='database' then
      begin
        ServerDB.Items.Add(VarToStr(LoadSet.FieldValues['value']));
      end;
      if VarToStr(LoadSet.FieldValues['name'])='title' then
      begin
        Application.Title:=VarToStr(LoadSet.FieldValues['value']);
        Auth.title:=VarToStr(LoadSet.FieldValues['value']);
      end;
      if VarToStr(LoadSet.FieldValues['name'])='pricetype' then
      begin
        pricetype:=VarToStr(LoadSet.FieldValues['value']);
      end;
      if VarToStr(LoadSet.FieldValues['name'])='storeloc' then
      begin
        storeloc:=VarToStr(LoadSet.FieldValues['value']);
      end;
      if VarToStr(LoadSet.FieldValues['name'])='trade' then
      begin
        magazin:=VarToStr(LoadSet.FieldValues['value']);
      end;
      LoadSet.Next;
    end;
    ServerDB.ItemIndex:=0;
  except
  end;
  try
    LoadSet.Active:=false;
    LoadSet.SQL.Clear;
    LoadSet.SQL.Add('SELECT * FROM info_format');
    LoadSet.Active:=true;
    LoadSet.First;
    SetLength(FormatP, 0);
    SetLength(FormatP, LoadSet.RecordCount);
    i:=0;
    while not LoadSet.Eof do
    begin
      FormatP[i].id:=LoadSet.FieldByName('id').AsString;
      FormatP[i].name:=LoadSet.FieldByName('name').AsString;
      LoadSet.Next;
      inc(i);
    end;
    LoadSet.Active:=false;
    LoadSet.SQL.Clear;
    LoadSet.SQL.Add('SELECT * FROM info_style');
    LoadSet.Active:=true;
    try
      i:=0;
      while i<>length(FormatP) do
      begin
        LoadSet.Filtered:=false;
        LoadSet.Filter:='format='+FormatP[i].id;
        LoadSet.Filtered:=true;
        LoadSet.First;
        SetLength(FormatP[i].style, 0);
        SetLength(FormatP[i].style, LoadSet.RecordCount);
        j:=0;
        while not LoadSet.Eof do
        begin
          FormatP[i].style[j].name:=LoadSet.FieldByName('name').AsString;
          FormatP[i].style[j].path:=LoadSet.FieldByName('file').AsString;
          LoadSet.Next;
          inc(j);
        end;
        inc(i);
      end;
    except
    end;
    LoadSet.Filtered:=false;
  except
  end;
  OpenReg();
  StartMain.Enabled:=true;
end;

procedure TAuth.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if KEY=VK_RETURN then
  begin
    BitBtn1.Click;
  end;
end;

procedure TAuth.GoToServer(Base: string);
begin
  OraSes.Connected:=false;
  (* *)
  if ServerDB.Text<>'' then
  begin
    try
      OraSes.ConnectionString:='Provider=MSDASQL.1;Password=qqq;Persist Security Info=True;User ID=supermag;Extended Properties="DRIVER={Microsoft ODBC for Oracle};UID=supermag;PWD=qqq;SERVER='+ServerDB.Text+';"';
      OraSes.Connected:=true;
    except
      on E:Exception do
      begin
        ShowMessage('���������� � ����� ������ "'+ServerDB.Text+'" �� ������� ����������.'+#13+'�������: '+E.Message+'.');
        ExitProcess(1);
      end;
    end;
  end;
  (* *)
end;

procedure TAuth.OpenReg;
var
   Registry: TRegistry;
begin
  Registry := TRegistry.Create;
  Registry.RootKey := hkey_current_user;
  Registry.OpenKey('software\Info',true);
  LoginDB.Text:=Registry.ReadString('Login');
  PasswordDB.Text:=Registry.ReadString('Password');
  ServerDB.Text:=Registry.ReadString('ServerBD');
  if LoginDB.Text<>'' then Remember.Checked:=true else Remember.Checked:=false;
  Registry.CloseKey;
  Registry.Free;
end;

procedure TAuth.SaveReg;
var
   Registry: TRegistry;
begin
   Registry := TRegistry.Create;
   Registry.RootKey := hkey_current_user;
   Registry.OpenKey('software\Info',true);
   Registry.WriteString('Login',LoginDB.Text);
   Registry.WriteString('Password',PasswordDB.Text);
   Registry.WriteString('ServerBD', ServerDB.Text);
   Registry.CloseKey;
   Registry.Free;
end;

procedure TAuth.ServerDBKeyPress(Sender: TObject; var Key: Char);
begin
  key:=#0;
end;
procedure TAuth.StartMainTimer(Sender: TObject);
begin
  StartMain.Enabled:=false;
  BitBtn1.Click;
end;

{ TConnAccess }

procedure TConnAccess.Execute;
begin
  inherited;

  try
    {
    if (Auth.ServerDB.Text='ASTOMS5') then
    begin
      try
        MainForm.Access.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=S:\Mile_brest\Priemka\db\InfoDataBase.mdb;Persist Security Info=True';
        MainForm.Access.Connected:=true;
      except
      end;
    end;
    }

    (*
    if (Auth.ServerDB.Text='MILE_CO') then
    begin
      try
        if Auth.Sklad then
        begin
          MainForm.Access.ConnectionString:='Provider=Microsoft.ACE.OLEDB.15.0;Data Source=S:\Mile_Sklad\db\InfoDataBase.mdb;Persist Security Info=True';
          MainForm.Access.Connected:=true;
        end
        else
        begin
          if FileExists('\\dt-vm-1\info\InfoDataBase.mdb') then
          begin
            MainForm.Access.ConnectionString:='Provider=Microsoft.ACE.OLEDB.15.0;Data Source=\\dt-vm-1\info\InfoDataBase.mdb;Persist Security Info=True';
            //MainForm.Access.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=\\dt-vm-1\info\InfoDataBase.mdb;Persist Security Info=True';
            MainForm.Access.Connected:=true;
          end
          else ShowMessage('���������� � ����� ������ ������� �� ���� �����������!'+#13+'���������� �������� �� ���� ���������� ��������������!');
        end;
      except
      end;
    end;
    *)

    if (Auth.ServerDB.Text='MILE_CO') then
    begin
      try
        if Auth.Sklad then
        begin
          MainForm.Access.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source=\\log-sklad\obmen\db\InfoDataBase.mdb;Persist Security Info=True';
          MainForm.Access.Connected:=true;
        end
        else
        begin

        end;
      except
      end;
    end;

    {
    if (Auth.ServerDB.Text='MILE_MINSK') then
    begin
      try
        if FileExists('\\dt-sh\obmen\info\InfoDataBase.mdb') then
        begin
          MainForm.Access.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source=\\dt-sh\obmen\info\InfoDataBase.mdb;Persist Security Info=True';
          //MainForm.Access.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=\\dt-vm-1\info\InfoDataBase.mdb;Persist Security Info=True';
          MainForm.Access.Connected:=true;
        end
        else ShowMessage('���������� � ����� ������ ������� �� ���� �����������!'+#13+'���������� �������� �� ���� ���������� ��������������!');
      except
      end;
    end;
    }

    (*
    if ((Auth.ServerDB.Text='ASTOMS7') or (Auth.ServerDB.Text='astoms7')) then
    begin
      try
        MainForm.Access.ConnectionString:='Provider=Microsoft.ACE.OLEDB.15.0;Data Source=s:\mile_����������\Priemka\DB\InfoDataBase.mdb;Persist Security Info=True';
        //MainForm.Access.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=s:\mile_����������\Priemka\DB\InfoDataBase.mdb;Persist Security Info=True';
        MainForm.Access.Connected:=true;
      except
      end;
    end;
    *)

    {
    if (Auth.ServerDB.Text='MILE_MOG') then
    begin
      try
        MainForm.Access.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=S:\Mile_mogilev\priemka\DB\InfoDataBase.mdb;Persist Security Info=True';
        MainForm.Access.Connected:=true;
      except
      end;
    end;
    }
    {
    if (Auth.ServerDB.Text='MILE_MOMO') then
    begin
      try
        MainForm.Access.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=S:\Mile_momo\priemka\DB\InfoDataBase.mdb;Persist Security Info=True';
        MainForm.Access.Connected:=true;
      except
      end;
    end;
    }
    {
    if (Auth.ServerDB.Text='NOVOSEL') then
    begin
      try
        MainForm.Access.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=S:\Novoselkin\server_ImportXml\InfoDataBase.mdb;Persist Security Info=True';
        MainForm.Access.Connected:=true;
      except
      end;
    end;
    }
  except
  end;

  terminate;
end;

end.
