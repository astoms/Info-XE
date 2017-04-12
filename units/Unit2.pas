unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls, Vcl.Buttons, Vcl.ImgList, Data.DB, Data.Win.ADODB,
  System.Win.TaskbarCore, Vcl.Taskbar, FireDAC.UI.Intf, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Intf, FireDAC.Comp.UI, System.Sensors, System.Sensors.Components, Math,
  Vcl.Menus, Vcl.Imaging.pngimage, frxClass, frxDBSet, frxBarcode, frxGradient, frxBarcod,
  Vcl.JumpList, System.ImageList, Vcl.WinXCtrls, Vcl.Mask, Vcl.DBCtrls, Registry,
  CPortCtl, CPort, UModelTree, Vcl.OleCtrls, SHDocVw, Vcl.AppEvnts, ComObj,
  frxPreview, ActiveX, frxDock, System.Win.ScktComp, CommCtrl;

type
  TDBGridCover = class(TDBGrid);

  TMyGrid = class(TStringGrid);

  TNewThread = class(TThread)
  private
    _PriceSet:TADODataSet;
    _BarcodeSet:TADODataSet;
    _TreeSet:TADODataSet;
    _GoodSet:TADODataSet;
    _Cartoons:TLabel;
  protected
    procedure Execute; override;
  end;

  TMainForm = class(TForm)
    TreeImg: TImageList;
    TreeSQL: TADOQuery;
    TreeSet: TADODataSet;
    DBSource: TDataSource;
    BarcodeSet: TADODataSet;
    BarCodeSource: TDataSource;
    PropSet: TADODataSet;
    PropSource: TDataSource;
    Menu: TMainMenu;
    APanel1: TMenuItem;
    PriceSet: TADODataSet;
    CheckTable: TADOTable;
    CheckQuery: TADOQuery;
    CheckSource: TDataSource;
    Report: TfrxReport;
    RepSet: TfrxDBDataset;
    VipTable: TADOTable;
    VipQuery: TADOQuery;
    VipSource: TDataSource;
    Report_Vip: TfrxReport;
    VipSet: TfrxDBDataset;
    MainSet: TfrxDBDataset;
    Report_Main: TfrxReport;
    EtiketTable: TADOTable;
    EtiketQuery: TADOQuery;
    Taskbar: TTaskbar;
    F121: TMenuItem;
    Splitter1: TSplitter;
    Panel1: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    GroupBox3: TGroupBox;
    Cartoons: TLabel;
    Loader: TImage;
    LText: TLabel;
    Search: TBitBtn;
    GroupBox4: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    Filter: TBitBtn;
    GroupBox5: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    FindEdit: TSearchBox;
    Panel5: TPanel;
    Splitter2: TSplitter;
    Panel12: TPanel;
    DBGrid1: TDBGrid;
    Panel13: TPanel;
    TabSheet1: TTabSheet;
    BitBtn1: TBitBtn;
    TabSheet2: TTabSheet;
    DBGrid3: TDBGrid;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    DBGrid2: TDBGrid;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    Panel14: TPanel;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    Panel15: TPanel;
    DBGrid5: TDBGrid;
    TabSheet8: TTabSheet;
    TabSheet10: TTabSheet;
    Panel18: TPanel;
    Image1: TImage;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    BitBtn12: TBitBtn;
    CombFormat: TComboBox;
    CombStyle: TComboBox;
    Panel19: TPanel;
    DBGrid4: TDBGrid;
    TabSheet9: TTabSheet;
    TabSheet11: TTabSheet;
    TabSheet12: TTabSheet;
    Panel20: TPanel;
    ToggleAct: TToggleSwitch;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit5: TDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    Label8: TLabel;
    DBEdit9: TDBEdit;
    Label9: TLabel;
    GroupBox6: TGroupBox;
    LPrice: TLabel;
    EPrice: TDBEdit;
    PriceSource: TDataSource;
    GoodsTable: TADOTable;
    GoodsQuery: TADOQuery;
    GoodsSource: TDataSource;
    Timer: TTimer;
    BitBtn6: TBitBtn;
    IconClear: TImage;
    RefreshImg: TImage;
    UpdImg: TImage;
    FormIcon: TImage;
    zdSource: TDataSource;
    zdTable: TADOTable;
    zdQuery: TADOQuery;
    GoodSet: TADODataSet;
    GoodSource: TDataSource;
    ChatTable: TADOTable;
    ChatQuery: TADOQuery;
    ZV_Table: TADOTable;
    ZV_Query: TADOQuery;
    ZV_Source: TDataSource;
    ComPort: TComPort;
    TabSheet13: TTabSheet;
    PageControl1: TPageControl;
    ComTerminal: TComTerminal;
    ComComboBox1: TComComboBox;
    TreeModel: TADODataSet;
    TabSheet14: TTabSheet;
    ChatTimer: TTimer;
    CheckImg: TImage;
    CheckImg_e: TImage;
    Panel16: TPanel;
    Panel17: TPanel;
    ZvGrid: TDBGrid;
    Panel22: TPanel;
    Panel24: TPanel;
    createzv: TBitBtn;
    BitBtn14: TBitBtn;
    GroupBox7: TGroupBox;
    StaticText1: TStaticText;
    FromD: TDateTimePicker;
    StaticText2: TStaticText;
    ToD: TDateTimePicker;
    Otd: TComboBox;
    Zv: TComboBox;
    Label12: TLabel;
    DocD: TDateTimePicker;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    ComboBox3: TComboBox;
    BitBtn15: TBitBtn;
    BitBtn16: TBitBtn;
    CheckDoc: TCheckBox;
    Panel25: TPanel;
    Panel26: TPanel;
    Shape1: TShape;
    Label17: TLabel;
    Label18: TLabel;
    BitBtn17: TBitBtn;
    BitBtn18: TBitBtn;
    BitBtn19: TBitBtn;
    BitBtn20: TBitBtn;
    DBGrid7: TStringGrid;
    Tov_Query: TADOQuery;
    BitBtn21: TBitBtn;
    BitBtn22: TBitBtn;
    BitBtn23: TBitBtn;
    BitBtn24: TBitBtn;
    Block: TPopupMenu;
    BitBtn5: TBitBtn;
    BitBtn4: TBitBtn;
    DBGrid6: TDBGrid;
    DT: TDateTimePicker;
    GroupBox8: TGroupBox;
    DatePost: TDateTimePicker;
    BitBtn25: TBitBtn;
    BitBtn26: TBitBtn;
    TextPost: TEdit;
    BitBtn27: TBitBtn;
    CheckBox3: TCheckBox;
    ChatConn: TADOConnection;
    BalloonHint: TBalloonHint;
    MileCard: TADOConnection;
    CardQuery: TADOQuery;
    ZV_ReadS: TDataSource;
    ZV_Read: TADOTable;
    Panel21: TPanel;
    Panel23: TPanel;
    Panel29: TPanel;
    Lab1: TLabel;
    Label11: TLabel;
    BitBtn13: TBitBtn;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    RGrid: TDBGrid;
    Panel27: TPanel;
    Panel28: TPanel;
    Shape2: TShape;
    Label10: TLabel;
    Label19: TLabel;
    BitBtn28: TBitBtn;
    BitBtn35: TBitBtn;
    BitBtn29: TBitBtn;
    BitBtn30: TBitBtn;
    BitBtn31: TBitBtn;
    BitBtn32: TBitBtn;
    BitBtn33: TBitBtn;
    BitBtn34: TBitBtn;
    DBGrid8: TDBGrid;
    ZV_TD_Query: TADOQuery;
    ZV_TD_SOURCE: TDataSource;
    Client: TClientSocket;
    Zv_Read2: TADOTable;
    Zv_DB: TfrxDBDataset;
    ZV_Report: TfrxReport;
    Image2: TImage;
    Image3: TImage;
    FastPrint: TMenuItem;
    CheckBox4: TCheckBox;
    OraZPC: TADOQuery;
    ZPCSet: TfrxDBDataset;
    ZPCReport: TfrxReport;
    ���: TTabSheet;
    Panel30: TPanel;
    Panel31: TPanel;
    DBGrid9: TDBGrid;
    BitBtn36: TBitBtn;
    BitBtn37: TBitBtn;
    ToggleSwitch1: TToggleSwitch;
    DateTimePicker3: TDateTimePicker;
    DateTimePicker4: TDateTimePicker;
    Label20: TLabel;
    Label21: TLabel;
    ZPC_TABLE: TADOTable;
    ZPC_Source: TDataSource;
    Changer: TButton;
    TabSheet15: TTabSheet;
    Panel32: TPanel;
    Panel33: TPanel;
    BitBtn38: TBitBtn;
    Sklad_Query: TADOQuery;
    Access: TADOConnection;
    Place_Query: TADOQuery;
    clPlace: TListBox;
    Label22: TLabel;
    RadioButton4: TRadioButton;
    BitBtn39: TBitBtn;
    BitBtn40: TBitBtn;
    GroupBox9: TGroupBox;
    Edit1: TEdit;
    BitBtn41: TBitBtn;
    Place_Query2: TADOQuery;
    Obrab: TTimer;
    Place_Query3: TADOQuery;
    Otloj: TTimer;
    Panel2: TPanel;
    Splitter3: TSplitter;
    GroupBox1: TGroupBox;
    TreeView: TTreeView;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Image4: TImage;
    ZPC_Sklad: TfrxDBDataset;
    ZPC_Query: TADOQuery;
    BitBtn7: TBitBtn;
    Label23: TLabel;
    ListBox1: TListBox;
    OraPos: TADOQuery;
    RadioButton5: TRadioButton;
    Label24: TLabel;
    BitBtn42: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure FilterClick(Sender: TObject);
    procedure SearchClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure TreeViewMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TreeViewMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure APanel1Click(Sender: TObject);
    procedure TabSheet10Show(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure DBGrid4DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure DBGrid4DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn12Click(Sender: TObject);
    procedure CombFormatChange(Sender: TObject);
    procedure CombFormatKeyPress(Sender: TObject; var Key: Char);
    procedure CombStyleKeyPress(Sender: TObject; var Key: Char);
    procedure ReportBeforePrint(Sender: TfrxReportComponent);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
    procedure TabSheet7Show(Sender: TObject);
    procedure DBGrid5DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure DBGrid5DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure Report_VipBeforePrint(Sender: TfrxReportComponent);
    procedure BitBtn4Click(Sender: TObject);
    procedure F121Click(Sender: TObject);
    procedure FindEditKeyPress(Sender: TObject; var Key: Char);
    procedure FindEditInvokeSearch(Sender: TObject);
    procedure DBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ToggleActClick(Sender: TObject);
    procedure EPriceChange(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure DBGrid5DblClick(Sender: TObject);
    procedure TreeViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MsgBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SendEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RoomKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FindEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ChatGridDrawDataCell(Sender: TObject; const [Ref] Rect: TRect;
      Field: TField; State: TGridDrawState);
    procedure RoomKeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit1Change(Sender: TObject);
    procedure createzvClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure ZvGridDblClick(Sender: TObject);
    procedure ComTerminalStrRecieved(Sender: TObject; var Str: string);
    procedure DBGrid5KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid4KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GridChatDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure RoomChange(Sender: TObject);
    procedure Panel6CanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
    procedure ComboBox3Change(Sender: TObject);
    procedure ComboBox3KeyPress(Sender: TObject; var Key: Char);
    procedure OtdKeyPress(Sender: TObject; var Key: Char);
    procedure ZvKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn16Click(Sender: TObject);
    procedure BitBtn15Click(Sender: TObject);
    procedure BitBtn18Click(Sender: TObject);
    procedure BitBtn20Click(Sender: TObject);
    procedure Panel25CanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure BitBtn14Click(Sender: TObject);
    procedure BitBtn17Click(Sender: TObject);
    procedure DBGrid7KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn21Click(Sender: TObject);
    procedure BitBtn22Click(Sender: TObject);
    procedure DBGrid7DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure DBGrid7DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ZvGridTitleClick(Column: TColumn);
    procedure DBGrid7DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure DBGrid7KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn23Click(Sender: TObject);
    procedure BitBtn19Click(Sender: TObject);
    procedure DBGrid7SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FindEditChange(Sender: TObject);
    procedure TabSheet3Resize(Sender: TObject);
    function noBadChar(value:string):string;
    procedure ZvGridDrawColumnCell(Sender: TObject; const [Ref] Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DTExit(Sender: TObject);
    procedure DBGrid7MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure BitBtn25Click(Sender: TObject);
    procedure BitBtn26Click(Sender: TObject);
    procedure BitBtn27Click(Sender: TObject);
    procedure CheckBox3MouseEnter(Sender: TObject);
    procedure CheckBox2MouseEnter(Sender: TObject);
    procedure CheckBox1MouseEnter(Sender: TObject);
    procedure ReportPreview(Sender: TObject);
    procedure DTKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DTChange(Sender: TObject);
    procedure DTCloseUp(Sender: TObject);
    procedure BitBtn13Click(Sender: TObject);
    procedure DateTimePicker1Change(Sender: TObject);
    procedure DateTimePicker2Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure BitBtn32Click(Sender: TObject);
    procedure RGridDblClick(Sender: TObject);
    procedure ClientRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure CheckBox3Enter(Sender: TObject);
    procedure CheckBox2Enter(Sender: TObject);
    procedure CheckBox1Enter(Sender: TObject);
    procedure BitBtn29Click(Sender: TObject);
    procedure BitBtn30Click(Sender: TObject);
    procedure DBGrid8DblClick(Sender: TObject);
    procedure BitBtn31Click(Sender: TObject);
    procedure DBGrid8DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure DBGrid8DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure FastPrintClick(Sender: TObject);
    procedure ZV_ReportPreview(Sender: TObject);
    procedure Report_VipPreview(Sender: TObject);
    procedure Report_MainPreview(Sender: TObject);
    procedure CheckBox4Enter(Sender: TObject);
    procedure CheckBox4MouseEnter(Sender: TObject);
    procedure BitBtn36Click(Sender: TObject);
    procedure ChangerClick(Sender: TObject);
    procedure DateTimePicker3Change(Sender: TObject);
    procedure DateTimePicker4Change(Sender: TObject);
    procedure ToggleSwitch1Click(Sender: TObject);
    procedure DBGrid9TitleClick(Column: TColumn);
    procedure BitBtn37Click(Sender: TObject);
    procedure DBGrid9DblClick(Sender: TObject);
    procedure TreeViewCompare(Sender: TObject; Node1, Node2: TTreeNode;
      Data: Integer; var Compare: Integer);
    procedure BitBtn38Click(Sender: TObject);
    procedure BitBtn33Click(Sender: TObject);
    procedure RadioButton4Click(Sender: TObject);
    procedure BitBtn40Click(Sender: TObject);
    procedure BitBtn39Click(Sender: TObject);
    procedure BitBtn41Click(Sender: TObject);
    procedure TreeViewCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure BitBtn34Click(Sender: TObject);
    procedure ObrabTimer(Sender: TObject);
    procedure OtlojTimer(Sender: TObject);
    procedure TreeViewClick(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure FindEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure RadioButton5Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure BitBtn42Click(Sender: TObject);
  private
    group:string;
    Half:byte;
    Half_S:AnsiString;
    anim:integer;
    FImportList: TStringList;
    FOnImportList: TNotifyEvent;
    { Private declarations }
    procedure PreResize;
    function SetPoint(value:string):string;
    procedure SaveReg();
  public

    aPlace:string;
    doc_num:string;
    Imager:array of TImage;
    saved:boolean;
    docid:string;
    section:string;
    SNode:TTreeNode;
    ModelTree: TModelTree;
    TvGrid:array of boolean;
    TvExt:boolean;
    procedure HideMes();
    function GetCop(value:string):string;
    function GetRub(value:string):string;
    procedure ChSearch();
    function ClearField(value:string):string;
    function ClearSQL(value:string):string;
    function DelPers(value:string):string;
    function GridSelectAll(Grid: TDBGrid): Longint;
    procedure WB_LoadHTML(WebBrowser: TWebBrowser; HTMLCode: string);
    procedure LoadReg();
    function SQLString(value:string):string;
    procedure ShowG();
    procedure GetGroup();
    procedure ReadDoc(id:string);
    procedure Wheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure GSort(Sender:TObject);
    function strik(val:string):string;
    { Public declarations }
  end;

var
  MainForm: TMainForm;  f12, f12_ext:boolean;

implementation

{$R *.dfm}

uses Unit1, Unit3, PassWord, Unit8, Unit9, Unit12, Unit13, Unit14, Unit15,
  Unit16, Unit17, Unit18, Unit10, Unit19, Unit20, Unit21, Unit22;

var AForm:array of TZvMessage;

{ TMainForm }

procedure TMainForm.APanel1Click(Sender: TObject);
begin
  PasswordDlg.Show;
end;

procedure TMainForm.BitBtn10Click(Sender: TObject);
begin
  try
    if DBGrid4.DataSource.DataSet.FieldByName('article').AsString<>'' then
    begin
      CheckQuery.Active:=false;
      CheckQuery.SQL.Clear;
      CheckQuery.SQL.Add('delete from info_check where id='''+DBGrid4.DataSource.DataSet.FieldByName('id').AsString+'''');
      CheckQuery.ExecSQL;
    end;
  except
  end;
  try
    CheckTable.Active:=false;
    CheckTable.Active:=true;
    CheckTable.Filtered:=false;
    CheckTable.Filter:='groupid='''+Auth.groupid+'''';
    CheckTable.Filtered:=true;
  except
  end;
end;

procedure TMainForm.BitBtn11Click(Sender: TObject);
var buttonSelected:integer;
begin
  try
    if DBGrid4.DataSource.DataSet.FieldByName('article').AsString<>'' then
    begin
      buttonSelected := MessageDlg('��������� ������� ������ � ������� ?', mtCustom, [mbYes,mbCancel], 0);
      if buttonSelected = mrYes then
      begin
        CheckQuery.Active:=false;
        CheckQuery.SQL.Clear;
        CheckQuery.SQL.Add('delete from info_check where groupid='''+Auth.groupid+'''');
        CheckQuery.ExecSQL;
      end;
    end;
  except
  end;
  try
    CheckTable.Active:=false;
    CheckTable.Active:=true;
    CheckTable.Filtered:=false;
    CheckTable.Filter:='groupid='''+Auth.groupid+'''';
    CheckTable.Filtered:=true;
  except
  end;
end;

procedure TMainForm.BitBtn12Click(Sender: TObject);
var i,j:integer;
    dir:string;
begin
  dir:=ExtractFilePath(ParamStr(0));
  if ((CombFormat.Text<>'') and (CombStyle.Text<>'')) then
  begin
    i:=0;
    while i<>length(Auth.FormatP) do
    begin
      if Auth.FormatP[i].name=CombFormat.Text then
      begin
        j:=0;
        while j<>length(Auth.FormatP[i].style) do
        begin
          if Auth.FormatP[i].style[j].name=CombStyle.Text then
          begin
            Report.LoadFromFile(dir+'FR\'+Auth.FormatP[i].style[j].path);
            Report.PrintOptions.ShowDialog:=true;
            Report.PrepareReport(true);
            Report.ShowPreparedReport;
            Report.Clear;
            break;
          end;
          inc(j);
        end;
        break;
      end;
      inc(i);
    end;
  end;
end;

procedure TMainForm.BitBtn13Click(Sender: TObject);
begin
  try
    Auth.LoadSet.Active:=false;
    Auth.LoadSet.SQL.Clear;
    Auth.LoadSet.SQL.Add('insert into zv_td(`date`, `group`, `status`, `comment`) values (:TD, '''+auth.groupname+''', ''��������'', '''')');
    Auth.LoadSet.Parameters.ParamByName('TD').Value:=Now;
    Auth.LoadSet.Parameters.ParamByName('TD').DataType:=ftDate;
    Auth.LoadSet.ExecSQL;
  except
    ShowMessage('������: �������� ������ ������ ����������.'+#13+'� ������ ���� ��� ������ ���������� ��������, ���������� �������� �� ���� ���������� ��������������.');
    Exit;
  end;
  try
    ZV_Read.Active:=false;
    ZV_Read.Active:=true;
    ShowMessage('������ ������� �������!');
  except
    ShowMessage('������: �������� ������ ������ ����������.'+#13+'� ������ ���� ��� ������ ���������� ��������, ���������� �������� �� ���� ���������� ��������������.');
    Exit;
  end;
end;

procedure TMainForm.BitBtn14Click(Sender: TObject);
begin
  try
    if ZvGrid.DataSource.DataSet.FieldByName('id').AsString<>'' then
    begin
      docid:=ZvGrid.DataSource.DataSet.FieldByName('id').AsString;
      section:=ZvGrid.DataSource.DataSet.FieldByName('group').AsString;
      ReadDoc(docid);
      Label17.Caption:='��������: '+docid;
      Label18.Caption:='�������� ���-��';
      //DBGrid7.Enabled:=false;
      panel25.Align:=alClient;
      panel25.Visible:=true;
      panel16.Visible:=false;
      BitBtn18.SetFocus;
      BitBtn21.Enabled:=false;
      BitBtn22.Enabled:=false;
    end;
  except
  end;
end;

procedure TMainForm.BitBtn15Click(Sender: TObject);
begin
  try
    if CheckDoc.Checked=true then
    begin
      {�� ����}
      if Zv.Text='��� ���������' then
      begin
        {������: ��� ���������}
        if ((Otd.Text='��� ������') or (Otd.Text='��� ������')) then
        begin
          {�����: ��� ������}
          ZV_Table.Active:=false;
          ZV_Table.Active:=true;
          ZV_Table.Filtered:=false;
          if ComboBox3.Text='���' then
          begin
            ZV_Table.Filter:='date='''+DateToStr(DocD.Date)+'''';
          end
          else
          begin
            ZV_Table.Filter:='date='''+DateToStr(DocD.Date)+''' and mag='''+ComboBox3.Text+'''';
          end;
          ZV_Table.Filtered:=true;
        end
        else
        begin
          {������: �� ������}
          ZV_Table.Active:=false;
          ZV_Table.Active:=true;
          ZV_Table.Filtered:=false;
          if ComboBox3.Text='���' then
          begin
            ZV_Table.Filter:='date='''+DateToStr(DocD.Date)+''' and group='''+Otd.Text+'''';
          end
          else
          begin
            ZV_Table.Filter:='date='''+DateToStr(DocD.Date)+''' and group='''+Otd.Text+''' and mag='''+ComboBox3.Text+'''';
          end;
          ZV_Table.Filtered:=true;
        end;
      end
      else
      begin
        {������: �� �������}
        if ((Otd.Text='��� ������') or (Otd.Text='��� ������')) then
        begin
          {�����: ��� ������}
          ZV_Table.Active:=false;
          ZV_Table.Active:=true;
          ZV_Table.Filtered:=false;
          if ComboBox3.Text='���' then
          begin
            ZV_Table.Filter:='date='''+DateToStr(DocD.Date)+''' and status='''+Zv.Text+'''';
          end
          else
          begin
            ZV_Table.Filter:='date='''+DateToStr(DocD.Date)+''' and status='''+Zv.Text+''' and mag='''+ComboBox3.Text+'''';
          end;
          ZV_Table.Filtered:=true;
        end
        else
        begin
          {������: �� ������}
          ZV_Table.Active:=false;
          ZV_Table.Active:=true;
          ZV_Table.Filtered:=false;
          if ComboBox3.Text='���' then
          begin
            ZV_Table.Filter:='date='''+DateToStr(DocD.Date)+''' and status='''+Zv.Text+''' and group='''+Otd.Text+'''';
          end
          else
          begin
            ZV_Table.Filter:='date='''+DateToStr(DocD.Date)+''' and status='''+Zv.Text+''' and group='''+Otd.Text+''' and mag='''+ComboBox3.Text+'''';
          end;
          ZV_Table.Filtered:=true;
        end;
      end;
    end
    else
    begin
      {� ���������}
      if Zv.Text='��� ���������' then
      begin
        {������: ��� ���������}
        if ((Otd.Text='��� ������') or (Otd.Text='��� ������')) then
        begin
          {�����: ��� ������}
          ZV_Table.Active:=false;
          ZV_Table.Active:=true;
          ZV_Table.Filtered:=false;
          if ComboBox3.Text='���' then
          begin
            ZV_Table.Filter:='(date>='''+DateToStr(FromD.Date)+''' and date<='''+DateToStr(ToD.Date)+''')';
          end
          else
          begin
            ZV_Table.Filter:='(date>='''+DateToStr(FromD.Date)+''' and date<='''+DateToStr(ToD.Date)+''') and mag='''+ComboBox3.Text+'''';
          end;
          ZV_Table.Filtered:=true;
        end
        else
        begin
          {������: �� ������}
          ZV_Table.Active:=false;
          ZV_Table.Active:=true;
          ZV_Table.Filtered:=false;
          if ComboBox3.Text='���' then
          begin
            ZV_Table.Filter:='(date>='''+DateToStr(FromD.Date)+''' and date<='''+DateToStr(ToD.Date)+''') and group='''+Otd.Text+'''';
          end
          else
          begin
            ZV_Table.Filter:='(date>='''+DateToStr(FromD.Date)+''' and date<='''+DateToStr(ToD.Date)+''') and group='''+Otd.Text+''' and mag='''+ComboBox3.Text+'''';
          end;
          ZV_Table.Filtered:=true;
        end;
      end
      else
      begin
        {������: �� �������}
        if ((Otd.Text='��� ������') or (Otd.Text='��� ������')) then
        begin
          {�����: ��� ������}
          ZV_Table.Active:=false;
          ZV_Table.Active:=true;
          ZV_Table.Filtered:=false;
          if ComboBox3.Text='���' then
          begin
            ZV_Table.Filter:='(date>='''+DateToStr(FromD.Date)+''' and date<='''+DateToStr(ToD.Date)+''') and status='''+Zv.Text+'''';
          end
          else
          begin
            ZV_Table.Filter:='(date>='''+DateToStr(FromD.Date)+''' and date<='''+DateToStr(ToD.Date)+''') and status='''+Zv.Text+''' and mag='''+ComboBox3.Text+'''';
          end;
          ZV_Table.Filtered:=true;
        end
        else
        begin
          {������: �� ������}
          ZV_Table.Active:=false;
          ZV_Table.Active:=true;
          ZV_Table.Filtered:=false;
          if ComboBox3.Text='���' then
          begin
            ZV_Table.Filter:='(date>='''+DateToStr(FromD.Date)+''' and date<='''+DateToStr(ToD.Date)+''') and status='''+Zv.Text+''' and group='''+Otd.Text+'''';
          end
          else
          begin
            ZV_Table.Filter:='(date>='''+DateToStr(FromD.Date)+''' and date<='''+DateToStr(ToD.Date)+''') and status='''+Zv.Text+''' and group='''+Otd.Text+''' and mag='''+ComboBox3.Text+'''';
          end;
          ZV_Table.Filtered:=true;
        end;
      end;
    end;
    //ShowMessage(ZV_Table.Filter);
  except
  end;
end;

procedure TMainForm.BitBtn16Click(Sender: TObject);
begin
  ZV_Table.Filtered:=false;
  ZV_Table.Active:=false;
  ZV_Table.Active:=true;
end;

procedure TMainForm.BitBtn17Click(Sender: TObject);
begin
  ReadDoc(docid);
end;

procedure TMainForm.BitBtn18Click(Sender: TObject);
begin
  if BitBtn18.Caption='�������������' then
  begin
    if ((section=auth.groupname) or (Auth.tz_moder=true)) then
    begin
      Auth.SGO_Query.Active:=false;
      Auth.SGO_Query.SQL.Clear;
      Auth.SGO_Query.SQL.Add('select * from t_zd where id='''+docid+'''');
      Auth.SGO_Query.Active:=true;
      Auth.SGO_Query.First;
      if ((Auth.SGO_Query.FieldByName('status').AsString='��������') and (Auth.tz_moder=false)) then
      begin
        //DBGrid7.Enabled:=true;
        //BitBtn7.Enabled:=false;
        try
          Label18.Caption:=Auth.SGO_Query.FieldByName('status').AsString;
        except
        end;
        BitBtn18.Caption:='���������';

        BitBtn21.Enabled:=true;
        BitBtn22.Enabled:=true;
        BitBtn23.Enabled:=true;
        if (Auth.tz_moder=false) then
        begin
          BitBtn27.Enabled:=true;
        end;
        saved:=false;
      end
      else
      begin
        if ((Auth.SGO_Query.FieldByName('status').AsString='���������� � �������� �����') and (Auth.tz_moder=true)) then
        begin
          //DBGrid7.Enabled:=true;
          //BitBtn7.Enabled:=false;
          try
            Label18.Caption:=Auth.SGO_Query.FieldByName('status').AsString;
          except
          end;
          BitBtn18.Caption:='���������';

          BitBtn21.Enabled:=true;
          BitBtn22.Enabled:=true;
          BitBtn23.Enabled:=true;
          saved:=false;
        end
        else
        begin
          ShowMessage('�������������� ��������� ���������!'+#13+'���������: �� �� ������ ������� ������� ����� ����.');
        end;
      end;
    end
    else ShowMessage('�������������� ��������� ���������!'+#13+'���������: �� �� ��������� ���������� ���������.');
  end
  else
  begin
    //DBGrid7.Enabled:=false;
    saved:=true;
    //BitBtn7.Enabled:=true;
    if Auth.tz_moder=true then
    begin
      TovSave.BitBtn2.Caption:='��������� (������: �������� ����������)';
    end
    else
    begin
      TovSave.BitBtn2.Caption:='��������� (������:���������� � �������� �����)';
    end;
    TovSave.ShowModal;
    Label18.Caption:='�������� ���-��';
    BitBtn18.Caption:='�������������';

    BitBtn21.Enabled:=false;
    BitBtn22.Enabled:=false;
    BitBtn23.Enabled:=false;
  end;
end;

procedure TMainForm.BitBtn19Click(Sender: TObject);
var Excel:variant; i,j:integer;
begin
  Excel:=CreateOleObject('Excel.Application');
  Excel.DisplayAlerts := false;
  Excel.Visible:=false;
  Excel.WorkBooks.Add;
  Excel.WorkBooks[1].WorkSheets[1].Name := '�����> �������� ���';
  Excel.Columns[1].ColumnWidth := 12;
  Excel.Columns[2].ColumnWidth := 18.57;
  Excel.Columns[3].ColumnWidth := 58.29;
  Excel.Columns[4].ColumnWidth := 14.29;
  Excel.Columns[5].ColumnWidth := 14.71;
  Excel.Columns[6].ColumnWidth := 13;
  Excel.Columns[7].ColumnWidth := 14.42;
  Excel.Columns[8].ColumnWidth := 19.29;
  Excel.Columns[9].ColumnWidth := 38.14;
  Excel.Columns[10].ColumnWidth := 32.57;

  Excel.Columns[1].NumberFormat := '@';
  Excel.Columns[2].NumberFormat := '@';
  Excel.Columns[3].NumberFormat := '@';
  Excel.Columns[4].NumberFormat := '@';
  Excel.Columns[5].NumberFormat := '@';
  Excel.Columns[6].NumberFormat := '@';
  Excel.Columns[7].NumberFormat := '@';
  Excel.Columns[8].NumberFormat := '@';
  Excel.Columns[9].NumberFormat := '@';
  Excel.Columns[10].NumberFormat := '@';

  Excel.Rows[1].Font.Bold := True;
  i:=0;
  while i<>DBGrid7.RowCount do
  begin



    for j := 0 to DBGrid7.ColCount do
    begin
      Excel.Cells[i+1, j+1].Value := DBGrid7.Cells[j,i];
    end;
    inc(i);
  end;

  Excel.WorkBooks[1].WorkSheets[1].Range['A1:J'+IntToStr(i)].Borders.LineStyle := 1;
  Excel.Visible:=true;
end;

procedure TMainForm.BitBtn1Click(Sender: TObject);
var i,k:integer;   finder:boolean;
begin
  if DBEdit1.Text<>'' then
  begin
    finder:=false;
    i:=1;
    while i<>TreeView.Items.Count do
    begin
      k:=1;
      while k<>length(TreeView.Items.Item[i].Text) do
      begin
        if copy(TreeView.Items.Item[i].Text, k, 1)=' ' then break;
        inc(k);
      end;
      if DBEdit8.Text=copy(TreeView.Items.Item[i].Text, 1, k-1) then
      begin
        DBGrid1.DataSource.DataSet.Locate('article',DBEdit1.Text,[loCaseInsensitive]);
        TreeView.SetFocus;
        TreeView.Items.Item[i].Selected:=true;
        finder:=true;
        break;
      end;
      inc(i);
    end;
    if finder=false then ShowMessage('������ �� �������.');
  end;
end;

procedure TMainForm.BitBtn20Click(Sender: TObject);
begin
  if saved=false then
  begin
    BitBtn18.Click;
    saved:=true;
  end;
  Label18.Caption:='�������� ���-��';
  BitBtn18.Caption:='�������������';

  BitBtn21.Enabled:=false;
  BitBtn22.Enabled:=false;
  BitBtn23.Enabled:=false;
  Panel25.Visible:=false;
  Panel16.Visible:=true;
end;

procedure TMainForm.BitBtn21Click(Sender: TObject);
var i, buttonSelected:integer;
begin
  if Label18.Caption='��������' then
  begin
    buttonSelected := MessageDlg('��������� ������� ������ � ������� ?', mtCustom, [mbYes,mbCancel], 0);
    if buttonSelected = mrYes then
    begin
      i:=0;
      while i<>DBGrid7.RowCount do
      begin
        DBGrid7.Rows[i].Clear;
        inc(i);
      end;

      DBGrid7.RowCount:=2;
      DBGrid7.ColCount:=10;

      DBGrid7.FixedCols:=0;
      DBGrid7.FixedRows:=1;

      DBGrid7.Cells[0,0]:='�������';
      DBGrid7.Cells[1,0]:='�����-���';
      DBGrid7.Cells[2,0]:='������������';
      DBGrid7.Cells[3,0]:='���������';
      DBGrid7.Cells[4,0]:='�������';
      DBGrid7.Cells[5,0]:='��. ���. ����.';
      DBGrid7.Cells[6,0]:='����� ����';
      DBGrid7.Cells[7,0]:='���� ��������';
      DBGrid7.Cells[8,0]:='����������� ������������';
      DBGrid7.Cells[9,0]:='����������';
    end;
  end;
end;

procedure TMainForm.BitBtn22Click(Sender: TObject);
begin
  if Label18.Caption='��������' then
  begin
    if ((DBGrid7.Row<>0) and (DBGrid7.Cells[0, DBGrid7.Row]<>'')) then
    begin
      TMyGrid(DBGrid7).DeleteRow(DBGrid7.Row);
    end;
  end;
end;

procedure TMainForm.BitBtn23Click(Sender: TObject);
begin
  if Auth.tz_moder=false then
  begin
    BitBtn6.Click;  {}
  end;
end;

procedure TMainForm.BitBtn25Click(Sender: TObject);
var i:integer;
begin
  if Auth.tz_moder=true then
  begin
    i:=0;
    while i<>length(TvGrid) do
    begin
      if TvGrid[i]=true then
      begin
        DBGrid7.Cells[8, i]:=DateToStr(DatePost.Date);
      end;
      inc(i);
    end;
  end;
end;

procedure TMainForm.BitBtn26Click(Sender: TObject);
var i:integer;
begin
  if Auth.tz_moder=true then
  begin
    i:=0;
    while i<>length(TvGrid) do
    begin
      if TvGrid[i]=true then
      begin
        DBGrid7.Cells[4, i]:=TextPost.Text;
      end;
      inc(i);
    end;
    TextPost.Text:='';
  end;
end;

procedure TMainForm.BitBtn27Click(Sender: TObject);
begin
  ValueList.ShowList(section);
end;

procedure TMainForm.BitBtn29Click(Sender: TObject);
var
  buttonSelected : Integer;
begin
  buttonSelected := MessageDlg('������� �� ��������� ['+DBGrid8.DataSource.DataSet.FieldByName('name').AsString+'] ',mtConfirmation, mbOKCancel, 0);
  if buttonSelected = mrOK     then
  begin
    ZV_TD_Query.Active:=false;
    ZV_TD_Query.SQL.Clear;
    ZV_TD_Query.SQL.Add('delete from zv_td2 where id='''+DBGrid8.DataSource.DataSet.FieldByName('id').AsString+'''');
    ZV_TD_Query.ExecSQL;
    Zv_Read2.Active:=false;
    Zv_Read2.Active:=true;
    Zv_Read2.Filtered:=false;
    Zv_Read2.Filter:='docid = '''+MainForm.doc_num+'''';
    Zv_Read2.Filtered:=true;
    Exit;
  end;
end;

procedure TMainForm.BitBtn2Click(Sender: TObject);
var vip_sum:string;
begin
  try
    if DBGrid5.DataSource.DataSet.FieldByName('article').AsString<>'' then
    begin
      VipQuery.Active:=false;
      VipQuery.SQL.Clear;
      VipQuery.SQL.Add('delete from info_vip where id='''+DBGrid5.DataSource.DataSet.FieldByName('id').AsString+'''');
      VipQuery.ExecSQL;
    end;
  except
  end;

  try
    MainForm.VipQuery.Active:=false;
    MainForm.VipQuery.SQL.Clear;
    MainForm.VipQuery.SQL.Add('select * from info_vip where groupid='''+Auth.groupid+'''');
    MainForm.VipQuery.Active:=true;
    MainForm.VipQuery.First;
    vip_sum:='0';
    while not MainForm.VipQuery.Eof do
    begin
      try
        vip_sum:=FloatToStr(StrToFloat(vip_sum)+StrToFloat(MainForm.VipQuery.FieldByName('summ_d').AsString));
      except
      end;
      MainForm.VipQuery.Next;
    end;
  except
  end;

  try
    MainForm.VipQuery.Active:=false;
    MainForm.VipQuery.SQL.Clear;
    MainForm.VipQuery.SQL.Add('update info_vip set vip_sum='''+vip_sum+''' where groupid='''+Auth.groupid+'''');
    MainForm.VipQuery.ExecSQL;
  except
  end;

  try
    VipTable.Active:=false;
    VipTable.Active:=true;
    VipTable.Filtered:=false;
    VipTable.Filter:='groupid='''+Auth.groupid+'''';
    VipTable.Filtered:=true;
  except
  end;
end;

procedure TMainForm.BitBtn30Click(Sender: TObject);
var
  buttonSelected : Integer;
begin
  buttonSelected := MessageDlg('�������� ������� �'+doc_num+' ?',mtConfirmation, mbOKCancel, 0);
  if buttonSelected = mrOK     then
  begin
    ZV_TD_Query.Active:=false;
    ZV_TD_Query.SQL.Clear;
    ZV_TD_Query.SQL.Add('delete from zv_td2 where docid='''+doc_num+'''');
    ZV_TD_Query.ExecSQL;
    Zv_Read2.Active:=false;
    Zv_Read2.Active:=true;
    Zv_Read2.Filtered:=false;
    Zv_Read2.Filter:='docid = '''+MainForm.doc_num+'''';
    Zv_Read2.Filtered:=true;
    Exit;
  end;
end;

procedure TMainForm.BitBtn31Click(Sender: TObject);
var dir:string;
begin
  dir:=ExtractFilePath(ParamStr(0));
  Zv_Report.LoadFromFile(dir+'FR\zv_td.fr3');
  Zv_Report.PrintOptions.ShowDialog:=true;
  Zv_Report.PrepareReport(true);
  Zv_Report.ShowPreparedReport;
end;

procedure TMainForm.BitBtn32Click(Sender: TObject);
begin
  ChSearch;
  Panel27.Visible:=false;
end;

procedure TMainForm.BitBtn33Click(Sender: TObject);
var
  buttonSelected : Integer;
begin
  buttonSelected := MessageDlg('������������ ������ �['+MainForm.doc_num+'] ',mtConfirmation, mbOKCancel, 0);
  if buttonSelected = mrOK     then
  begin
    ZV_TD_Query.Active:=false;
    ZV_TD_Query.SQL.Clear;
    ZV_TD_Query.SQL.Add('update zv_td set status=''�����������'' where id='''+MainForm.doc_num+'''');
    ZV_TD_Query.ExecSQL;
    Exit;
  end;
end;

procedure TMainForm.BitBtn34Click(Sender: TObject);
var
  buttonSelected : Integer;
begin
  if Auth.sklad then
  begin
    buttonSelected := MessageDlg('������ �['+MainForm.doc_num+'] ������ ?',mtConfirmation, mbOKCancel, 0);
    if buttonSelected = mrOK     then
    begin
      ZV_TD_Query.Active:=false;
      ZV_TD_Query.SQL.Clear;
      ZV_TD_Query.SQL.Add('update zv_td set status=''�������'' where id='''+MainForm.doc_num+'''');
      ZV_TD_Query.ExecSQL;
      Exit;
    end;
  end;
end;

procedure TMainForm.BitBtn36Click(Sender: TObject);
begin
  if Auth.tz_moder then
  begin
    AddZPC.ShowModal;
  end;
end;

procedure TMainForm.BitBtn37Click(Sender: TObject);
begin
  if Auth.sklad then
  begin
    ChangeZPC.id_doc:=DBGrid9.DataSource.DataSet.FieldByName('id').AsString;
    ChangeZPC.Caption:='�������������: '+DBGrid9.DataSource.DataSet.FieldByName('zpc').AsString;
    ChangeZPC.ShowModal;
  end;
end;

procedure TMainForm.BitBtn38Click(Sender: TObject);
var Exceles:variant; OpenD:TOpenDialog; i,k:integer; temp:string; List:TStringList; PList:TStringList;
begin
  OpenD:=TOpenDialog.Create(self);
  OpenD.Title:='������� Excel:';
  if OpenD.Execute then
  begin
    Screen.Cursor := crAppStart;
    Exceles:=CreateOleObject('Excel.Application');
    Exceles.Workbooks.Open(OpenD.FileName);
    Exceles.DisplayAlerts:=False;
    Exceles.Visible := False;
    i:=2;
    while Exceles.Cells[i,2].Text<>'' do
    begin
      temp:='';
      try
        BarcodeSet.Active:=false;
        BarcodeSet.CommandText:='select d.article, s.barcode from supermag.smstoreunits s, supermag.smcard d where d.article = s.article and d.article='''+Exceles.Cells[i,2].Text+'''';
        BarcodeSet.Active:=true;
      except
      end;

      try
        BarcodeSet.First;
        while not BarcodeSet.Eof do
        begin
          if Access.Connected then
          begin
            try
              Place_Query.Active:=false;
              Place_Query.SQL.Clear;
              Place_Query.SQL.Add('select clArticle, clPlace from tblNaserver where clStrihkod='''+BarcodeSet.FieldByName('barcode').AsString+'''');
              Place_Query.Active:=true;
            except
            end;
          end
          else
          begin
            try
              Access.Connected:=true;
              Place_Query.Active:=false;
              Place_Query.SQL.Clear;
              Place_Query.SQL.Add('select clArticle, clPlace from tblNaserver where clStrihkod='''+BarcodeSet.FieldByName('barcode').AsString+'''');
              Place_Query.Active:=true;
            except
            end;
          end;
          try
            Place_Query.First;
            while not Place_Query.Eof do
            begin
              temp:=temp+';'+Place_Query.FieldByName('clPlace').AsString;
              Place_Query.Next;
            end;
          except
          end;
          BarcodeSet.Next;
        end;

        List:=TStringList.Create;
        List.Duplicates:=dupIgnore;
        List.Delimiter:=';';
        List.DelimitedText:=temp;

        PList:=TStringList.Create;
        PList.Duplicates:=dupIgnore;
        k:=0;
        while k<>List.Count do
        begin
          if PList.IndexOf(List.Strings[k])=-1 then PList.Add(List.Strings[k]);
          inc(k);
        end;

      except
      end;

      k:=0;
      while k<>PList.Count do
      begin
        Exceles.Cells[i,7].Value:=Exceles.Cells[i,7].Text+PList.Strings[k]+' | ';
        inc(k);
      end;
      //
      try
        Sklad_Query.Active:=false;
        Sklad_Query.SQL.Clear;
        Sklad_Query.SQL.Add('select g.article, g.quantity from smgoods g where g.article='''+Exceles.Cells[i,2].Text+''' and g.storeloc=''19''');
        Sklad_Query.Active:=true;
      except
      end;
      try
        if ((Sklad_Query.FieldByName('article').AsString=Exceles.Cells[i,2].Text) and (Sklad_Query.FieldByName('quantity').AsString<>'')) then Exceles.Cells[i,6].Value:=Sklad_Query.FieldByName('quantity').AsString;
      except
      end;
      //
      inc(i);
    end;
    Exceles.Visible := True;
    Screen.Cursor := crDefault;
    ShowMessage('���������� ������ ���������!');
  end
  else
  begin
    OpenD.Free;
    Exit;
  end;
end;

procedure TMainForm.BitBtn39Click(Sender: TObject);
var temp:Word; delword:string; newstring:string; k:integer;
begin
  if Auth.sklad then
  begin
    try
    AddPlace.ShowModal;
    if AddPlace.add=false then
    begin
      Exit;
    end;
    if (AddPlace.add) then
    begin
      temp:=MessageBox(handle, PChar('������� YES ��� ���������� ����� ��������!'), PChar('�������� ['+AddPlace.Edit1.Text+'] � '+DBEdit1.Text), MB_YESNO+MB_ICONQUESTION);
      case temp of
        idyes:
        begin
          delword:=AddPlace.Edit1.Text;
          newstring:='';
          k:=0;
          while k<>clPlace.Count do
          begin
            newstring:=newstring+clPlace.Items.Strings[k]+';';
            inc(k);
          end;
          newstring:=newstring+delword;
          BarcodeSet.First;
          while not BarcodeSet.Eof do
          begin
            Place_Query.Active:=false;
            Place_Query.SQL.Clear;
            Place_Query.SQL.Add('update tblNaserver set clPlace='''+newstring+''' where clStrihkod='''+BarcodeSet.FieldByName('barcode').AsString+'''');
            Place_Query.ExecSQL;
            BarcodeSet.Next;
          end;
        end;
      end;
    end;
    clPlace.Items.Add(delword);
    except
    end;
  end;
end;


procedure TMainForm.BitBtn3Click(Sender: TObject);
var buttonSelected : Integer;
begin
  try
    if DBGrid5.DataSource.DataSet.FieldByName('article').AsString<>'' then
    begin
      buttonSelected := MessageDlg('��������� ������� ������ � ������� ?', mtCustom, [mbYes,mbCancel], 0);
      if buttonSelected = mrYes then
      begin
        VipQuery.Active:=false;
        VipQuery.SQL.Clear;
        VipQuery.SQL.Add('delete from info_vip where groupid='''+Auth.groupid+'''');
        VipQuery.ExecSQL;
      end;
    end;
  except
  end;
  try
    VipTable.Active:=false;
    VipTable.Active:=true;
    VipTable.Filtered:=false;
    VipTable.Filter:='groupid='''+Auth.groupid+'''';
    VipTable.Filtered:=true;
  except
  end;
end;

procedure TMainForm.BitBtn40Click(Sender: TObject);
var temp:Word; delword:string; newstring:string; k:integer;
begin
  if Auth.sklad then
  begin
    try
    if (clPlace.ItemIndex<>-1) then
    begin
      temp:=MessageBox(handle, PChar('������� YES ��� �������� ����� ��������!'), PChar('������� ['+clPlace.Items.Strings[clPlace.ItemIndex]+'] �� '+DBEdit1.Text), MB_YESNO+MB_ICONQUESTION);
      case temp of
        idyes:
        begin
          delword:=clPlace.Items.Strings[clPlace.ItemIndex];
          newstring:='';
          k:=0;
          while k<>clPlace.Count do
          begin
            if clPlace.Items.Strings[k]<>delword then
            begin
              newstring:=newstring+clPlace.Items.Strings[k]+';';
            end;
            inc(k);
          end;
          BarcodeSet.First;
          while not BarcodeSet.Eof do
          begin
            Place_Query.Active:=false;
            Place_Query.SQL.Clear;
            Place_Query.SQL.Add('update tblNaserver set clPlace='''+newstring+''' where clStrihkod='''+BarcodeSet.FieldByName('barcode').AsString+'''');
            Place_Query.ExecSQL;
            BarcodeSet.Next;
          end;
        end;
      end;
    end;
    clPlace.Items.Delete(clPlace.ItemIndex);
    except
    end;
  end;
end;

procedure TMainForm.BitBtn41Click(Sender: TObject);
var temp:Word; clPlace:string; tmp:array of string; List:TStringList;  i:integer;
begin
  Screen.Cursor := crAppStart;
  //ShowMessage(Access.ConnectionString);
  if Edit1.Text<>'' then
  begin
    List:=TStringList.Create;
    List.Delimiter:=',';
    List.Duplicates:=dupIgnore;
    List.DelimitedText:=Edit1.Text;
    i:=0;
    while i<>List.Count do
    begin
      try
        if (Access.Connected=false) then Access.Connected:=true;
        Place_Query.Active:=false;
        Place_Query.SQL.Clear;
        Place_Query.SQL.Add('select * from tblnaserver where clPlace like ''%'+List.Strings[i]+'%''');
        Place_Query.Active:=true;
        Place_Query.First;
        while not Place_Query.Eof do
        begin
          try
            clPlace:=Place_Query.FieldByName('clPlace').AsString;
            clPlace:=StringReplace(clPlace, List.Strings[i], '', [rfReplaceAll, rfIgnoreCase]);
            Place_Query2.Active:=false;
            Place_Query2.SQL.Clear;
            Place_Query2.SQL.Add('update tblnaserver set clPlace = '''+clPlace+'''  where clStrihkod='''+Place_Query.FieldByName('clStrihkod').AsString+''' and clName='''+Place_Query.FieldByName('clName').AsString+''' and clOperator='''+Place_Query.FieldByName('clOperator').AsString+'''');
            Place_Query2.ExecSQL;
          except
          end;
          Place_Query.Next;
        end;

      except
        //on E:Exception do ShowMessage(E.Message);
      end;
      inc(i);
    end;
    Screen.Cursor := crDefault;
    ShowMessage('������ ['+Edit1.Text+'] ���� �������!');
    Edit1.Text:='';
  end;
  Screen.Cursor := crDefault;
end;

procedure TMainForm.BitBtn42Click(Sender: TObject);
var temp:string; List, List2:TStringList; i:integer;
begin

  try
    Place_Query3.Active:=false;
    Place_Query3.SQL.Clear;
    Place_Query3.SQL.Add('select article, place, count from place_sklad');
    Place_Query3.Active:=true;
    Place_Query3.First;
    while not Place_Query3.Eof do
    begin
      try
        BarcodeSet.Active:=false;
        BarcodeSet.CommandText:='select d.article, s.barcode from supermag.smstoreunits s, supermag.smcard d where d.article = s.article and d.article='''+Place_Query3.FieldByName('article').AsString+'''';
        BarcodeSet.Active:=true;
      except
      end;
      Application.ProcessMessages;

      if (Access.Connected=false) then
      begin
        Access.Connected:=true;
      end;

      if (Access.Connected) then
      begin
        clPlace.Items.Clear;
        temp:='';
        DBGrid2.DataSource.DataSet.First;
        while not DBGrid2.DataSource.DataSet.Eof do
        begin
          Place_Query.Active:=false;
          Place_Query.SQL.Clear;
          Place_Query.SQL.Add('select clPlace from tblNaserver where clStrihkod='''+DBGrid2.DataSource.DataSet.FieldByName('barcode').AsString+'''');
          Place_Query.Active:=true;
          Place_Query.First;
          while not Place_Query.Eof do
          begin
            temp:=temp+Place_Query.FieldByName('clPlace').AsString+';';
            Place_Query.Next;
          end;
          DBGrid2.DataSource.DataSet.Next;
        end;

        List:=TStringList.Create;
        List.Duplicates:=dupIgnore;
        List.Delimiter:=';';
        List.DelimitedText:=temp;

        i:=0;
        while i<>List.Count do
        begin
          if List.Strings[i]<>'' then
          begin
            if (clPlace.Items.IndexOf(List.Strings[i])=-1) then clPlace.Items.Add(List.Strings[i]);
          end;
          inc(i);
        end;

        List2:=TStringList.Create;
        List.Duplicates:=dupIgnore;
        List.Delimiter:=';';
        List.DelimitedText:=Place_Query3.FieldByName('place').AsString;

        i:=0;
        while i<>List2.Count do
        begin
          if List2.Strings[i]<>'' then
          begin
            if (clPlace.Items.IndexOf(List2.Strings[i])=-1) then clPlace.Items.Add(List2.Strings[i]);
          end;
          inc(i);
        end;

        temp:='';
        i:=0;
        while i<>clPlace.Count do
        begin
          if clPlace.Items.Strings[i]<>'' then
          begin
            temp:=clPlace.Items.Strings[i]+';';
          end;
        end;

        try
          DBGrid2.DataSource.DataSet.First;
          while not DBGrid2.DataSource.DataSet.Eof do
          begin
            try
              Place_Query.Active:=false;
              Place_Query.SQL.Clear;
              Place_Query.SQL.Add('insert into tblNaserver set clPlace = '''+temp+'''  where clStrihkod='''+DBGrid2.DataSource.DataSet.FieldByName('barcode').AsString+'''');
              Place_Query.Active:=true;
            except
            end;
            DBGrid2.DataSource.DataSet.Next;
          end;
        except
        end;
      end;
      Place_Query3.Next;
    end;
  except
  end;

end;

procedure TMainForm.BitBtn4Click(Sender: TObject);
begin
  if PageControl1.ActivePage.Tag=0 then PageControl1.ActivePageIndex:=6;
  if PageControl1.ActivePageIndex=6 then
  begin
    DBGrid5.OnDragDrop(Self, DBGrid1, 0, 0);
  end;
  if PageControl1.ActivePageIndex=9 then
  begin
    DBGrid4.OnDragDrop(Self, DBGrid1, 0, 0);
  end;
  if PageControl1.ActivePageIndex=8 then
  begin
    if Panel27.Visible then
    begin
      DBGrid8.OnDragDrop(Self, DBGrid1, 0, 0);
    end;
  end;
end;

procedure TMainForm.BitBtn5Click(Sender: TObject);
var dir:string;  i:integer;
begin
  try
    EtiketQuery.Active:=false;
    EtiketQuery.SQL.Clear;
    EtiketQuery.SQL.Add('delete from info_etiket where groupid='''+Auth.groupid+'''');
    EtiketQuery.ExecSQL;
  except
  end;
  try
    if DBGrid1.SelectedRows.Count<=1 then
    begin
      EtiketQuery.Active:=false;
      EtiketQuery.SQL.Clear;
      EtiketQuery.SQL.Add('insert into info_etiket(name, barcode, groupid) values('''+DBGrid1.DataSource.DataSet.FieldByName('name').AsString+''','''+DBGrid2.DataSource.DataSet.FieldByName('barcode').AsString+''', '''+Auth.groupid+''')');
      EtiketQuery.ExecSQL;
    end
    else
    begin
      i:=0;
      while i<>DBGrid1.SelectedRows.Count do
      begin
        DBGrid1.DataSource.DataSet.GotoBookmark(Pointer(DBGrid1.SelectedRows.Items[i]));
        try
          BarcodeSet.Active:=false;
          BarcodeSet.CommandText:='select d.article, s.barcode from supermag.smstoreunits s, supermag.smcard d where d.article = s.article and d.article='''+DBGrid1.DataSource.DataSet.FieldByName('article').AsString+'''';
          BarcodeSet.Active:=true;
        except
        end;
        EtiketQuery.Active:=false;
        EtiketQuery.SQL.Clear;
        EtiketQuery.SQL.Add('insert into info_etiket(name, barcode, groupid) values('''+DBGrid1.DataSource.DataSet.FieldByName('name').AsString+''','''+DBGrid2.DataSource.DataSet.FieldByName('barcode').AsString+''', '''+Auth.groupid+''')');
        EtiketQuery.ExecSQL;
        inc(i);
      end;
    end;
  except
  end;
  try
    EtiketTable.Active:=false;
    EtiketTable.Active:=true;
    EtiketTable.Filtered:=false;
    EtiketTable.Filter:='groupid='''+Auth.groupid+'''';
    EtiketTable.Filtered:=true;
  except
  end;
  dir:=ExtractFilePath(ParamStr(0));
  Report_Main.LoadFromFile(dir+'FR\etiket.fr3');
  Report_Main.PrintOptions.ShowDialog:=true;
  Report_Main.PrepareReport(true);
  Report_Main.print;
end;

procedure TMainForm.BitBtn6Click(Sender: TObject);
var OpenDialogImport:TOpenDialog;
    F:TextFile; txt:string;
    i:integer;  article:AnsiString;
begin
  try
    OpenDialogImport:=TOpenDialog.Create(self);
    OpenDialogImport.Title:='������ �����: ';
    OpenDialogImport.Filter:='Dat File| *.dat';
    if OpenDialogImport.Execute then
    begin
      Screen.Cursor := crAppStart;
      LoadData.ProgressBar1.Position:=0;
      LoadData.ProgressBar1.Min:=0;
      AssignFile(F, OpenDialogImport.FileName);
      Reset(F);
      while not EOF(F) do
      begin
        readln(f, txt);
        if copy(txt, 1, 7)<>'' then
        begin
          article:=article+#39+copy(txt, 1, 7)+#39+', ';
        end;
      end;
      if article='' then
      begin
        ShowMessage('������: ���� ����, ���������� ��������� ������ ����!');
        Exit;
      end;
      article:='article in ('+copy(article, 1, length(article)-2)+')';
      try
        TreeSet.Active:=false;
        TreeSet.CommandText:='select d.article, d.name, d.mesabbrev as mesname, d.country, DECODE(accepted, ''1'', ''�������'', ''2'', ''���������'', ''�����'') as accepted, ';
        TreeSet.CommandText:=TreeSet.CommandText+'DECODE(datatype, ''0'', ''�����'', ''1'', ''������'', ''2'', ''������'', ''3'', ''����'', ''4'', ''���������'', ''5'', ''�����'', ''#�/�'') as datatype, s.tree, s.name as gname from supermag.smcard d, supermag.sacardclass s WHERE s.id = d.idclass and accepted=1 and '+article;
        TreeSet.Active:=true;
      except
        //on E:Exception do ShowMessage(E.Message);
      end;
      DBGrid1.Enabled:=true;
      GridSelectAll(DBGrid1);
      i:=0;
      try
        while i<=DBGrid1.SelectedRows.Count do
        begin
          DBGrid1.DataSource.DataSet.GotoBookmark(Pointer(DBGrid1.SelectedRows.Items[i]));
          try
            BarcodeSet.Active:=false;
            BarcodeSet.CommandText:='select d.article, s.barcode from supermag.smstoreunits s, supermag.smcard d where d.article = s.article and d.article='''+DBGrid1.DataSource.DataSet.FieldByName('article').AsString+'''';
            BarcodeSet.Active:=true;
          except
          end;
          DBGrid1.OnDblClick(nil);
          inc(i);
        end;
      except
      end;
      Screen.Cursor := crDefault;
      CloseFile(F);
      TreeView.OnChange(nil,MainForm.TreeView.Items.GetFirstNode);
    end
    else
    begin
      OpenDialogImport.Free;
      Exit;
    end;
  except
    on E:Exception do ShowMessage('������ ������ �� ��� ��������!'+#13+'������: '+E.Message+'.');
  end;
end;

procedure TMainForm.BitBtn7Click(Sender: TObject);
var OpenD:TOpenDialog; Excel:Variant; i,j,k:integer; article:AnsiString; action_price, action_def:string;
    action_def_r, action_def_k:string; FormatList: TStringList; CatCheck:TStringList;
    mj, mk:boolean; name:string; price_dr, price_dk: string;
begin
  OpenD:=TOpenDialog.Create(nil);
  OpenD.Title:='�������� Excel �����:';
  OpenD.Filter:='Excel 2007-2017|*.xlsx|Excel 2003|*.xls';
  if OpenD.Execute then
  begin
    Excel:=CreateOleObject('Excel.Application');
    Excel.Application.WorkBooks.Add(OpenD.FileName);
    Excel.Visible:=False;
    Excel.DisplayAlerts:=False;
    FormatList:=TStringList.Create;
    FormatList.Sorted:=True;
    FormatList.Duplicates:=dupIgnore;
    CatCheck:=TStringList.Create;
    CatCheck.Sorted:=True;
    CatCheck.Duplicates:=dupIgnore;
    i:=14;
    while ((Excel.Cells[i,14].Text<>'') or (Excel.Cells[i,15].Text<>'') or (Excel.Cells[i,16].Text<>'') or (Excel.Cells[i,1].Text<>''))  do
    begin
      if Pos('�1', Excel.Cells[i,11].Text)>0 then
      begin
        FormatList.Add('�1');
      end;
      if Pos('�2', Excel.Cells[i,11].Text)>0 then
      begin
        FormatList.Add('�2');
      end;
      if Pos('�3', Excel.Cells[i,11].Text)>0 then
      begin
        FormatList.Add('�3');
      end;
      if Pos('�4', Excel.Cells[i,11].Text)>0 then
      begin
        FormatList.Add('�4');
      end;
      if Pos('�5', Excel.Cells[i,11].Text)>0 then
      begin
        FormatList.Add('�5');
      end;
      if Pos('�6', Excel.Cells[i,11].Text)>0 then
      begin
        FormatList.Add('�6');
      end;
      if ((Excel.Cells[i,1].Text<>'') and (Excel.Cells[i,1].Text<>'�����:') and (Excel.Cells[i,1].Text<>'�����:')) then
      begin
        CatCheck.Add(Excel.Cells[i,1].Text);
      end;
      inc(i);
    end;
    PrintForm.DTP.Date:=Now();
    PrintForm.Format.Items.Clear;
    i:=0;
    while i<FormatList.Count do
    begin
      PrintForm.Format.Items.Add(FormatList.Strings[i]);
      inc(i);
    end;
    PrintForm.Cat.Items.Clear;
    i:=0;
    while i<CatCheck.Count do
    begin
      PrintForm.Cat.Items.Add(CatCheck.Strings[i]);
      inc(i);
    end;
    PrintForm.ShowModal;
    Screen.Cursor := crAppStart;
    i:=14;
    while ((Excel.Cells[i,14].Text<>'') or (Excel.Cells[i,15].Text<>'') or (Excel.Cells[i,16].Text<>'') or (Excel.Cells[i,1].Text<>''))  do
    begin
      j:=0;
      mj:=false;
      while j<PrintForm.Cat.Items.Count do
      begin
        if PrintForm.Cat.Checked[j] then
        begin
          if Pos(PrintForm.Cat.Items.Strings[j], Excel.Cells[i,1].Text)>0 then
          begin
            mj:=true;
            break;
          end;
        end;
        inc(j);
      end;
      mk:=false;
      if (mj) then
      begin
        k:=0;
        while k<PrintForm.Format.Items.Count do
        begin
          if PrintForm.Format.Checked[k] then
          begin
            if Pos(PrintForm.Format.Items.Strings[k], Excel.Cells[i,11].Text)>0 then
            begin
              mk:=true;
              break;
            end;
          end;
          inc(k);
        end;
      end;
      if (mk) then
      begin
        if (PrintForm.Action.Checked) then
        begin
          article:='';
          name:='';
          action_price:='';
          action_def:='';
          action_def_r:='';
          action_def_k:='';
          //

          try
            //StrToFloat(Excel.Cells[i,14].Text);
            article:='article = '+#39+Excel.Cells[i,14].Text+#39;
            name:=Excel.Cells[i,22].Text;
            action_price:=DelPers(Excel.Cells[i,21].Text);
            action_def:=Excel.Cells[i,17].Text;
            try
              action_def_r:=GetRub(SetPoint(action_def));
            except
            end;
            try
              action_def_k:=GetCop(SetPoint(action_def));
              //FloatToStr(Trunc(Frac(StrToFloat(SetPoint(action_def)))*100));
            except
            end;
            if length(action_def_k)=1 then action_def_k:=action_def_k+'0';
            try
              TreeSet.Active:=false;
              TreeSet.CommandText:='select d.article, d.name, d.mesabbrev as mesname, d.country, DECODE(accepted, ''1'', ''�������'', ''2'', ''���������'', ''�����'') as accepted, ';
              TreeSet.CommandText:=TreeSet.CommandText+'DECODE(datatype, ''0'', ''�����'', ''1'', ''������'', ''2'', ''������'', ''3'', ''����'', ''4'', ''���������'', ''5'', ''�����'', ''#�/�'') as datatype, s.tree, s.name as gname from supermag.smcard d, supermag.sacardclass s WHERE s.id = d.idclass and accepted=1 and '+article;
              TreeSet.Active:=true;
            except
              //on E:Exception do ShowMessage(E.Message);
            end;
            try
              BarcodeSet.Active:=false;
              BarcodeSet.CommandText:='select d.article, s.barcode from supermag.smstoreunits s, supermag.smcard d where d.article = s.article and d.article='''+Excel.Cells[i,14].Text+'''';
              BarcodeSet.Active:=true;
            except
            end;
            DBGrid1.Enabled:=true;
            DBGrid1.OnDblClick(nil);
            try
              CheckQuery.Active:=false;
              CheckQuery.SQL.Clear;
              CheckQuery.SQL.Add('select price_dr, price_dk from `info_check` where article='''+Excel.Cells[i,14].Text+'''');
              CheckQuery.Active:=true;
              price_dr:=CheckQuery.FieldByName('price_dr').AsString;
              price_dk:=CheckQuery.FieldByName('price_dk').AsString;
            except
            end;
            try
              CheckQuery.Active:=false;
              CheckQuery.SQL.Clear;
              CheckQuery.SQL.Add('update `info_check` set memo='''+DateToStr(PrintForm.DTP.Date)+''', name='''+name+''', price_dr='''+action_def_r+''', price_dk='''+action_def_k+''', action_price_r='''+action_price+''', action_def_k='''+price_dk+''', action_def_r='''+price_dr+''' where article='''+Excel.Cells[i,14].Text+'''');
              CheckQuery.ExecSQL;
            except
            end;
          except

          end;
        end
        else
        begin
          article:='';
          name:='';
          action_price:='';
          action_def:='';
          action_def_r:='';
          action_def_k:='';
          //

          try
            //StrToFloat(Excel.Cells[i,14].Text);
            article:='article = '+#39+Excel.Cells[i,14].Text+#39;
            name:=Excel.Cells[i,22].Text;
            action_price:=DelPers(Excel.Cells[i,21].Text);
            action_def:=Excel.Cells[i,17].Text;
            try
              action_def_r:=GetRub(SetPoint(action_def));
            except
            end;
            try
              action_def_k:=GetCop(SetPoint(action_def));
            except
            end;
            action_def:=Excel.Cells[i,18].Text;
            try
              price_dr:=GetRub(SetPoint(action_def));
            except
            end;
            try
              price_dk:=GetCop(SetPoint(action_def));
            except
            end;
            if length(action_def_k)=1 then action_def_k:=action_def_k+'0';
            if length(price_dk)=1 then price_dk:=price_dk+'0';
            try
              TreeSet.Active:=false;
              TreeSet.CommandText:='select d.article, d.name, d.mesabbrev as mesname, d.country, DECODE(accepted, ''1'', ''�������'', ''2'', ''���������'', ''�����'') as accepted, ';
              TreeSet.CommandText:=TreeSet.CommandText+'DECODE(datatype, ''0'', ''�����'', ''1'', ''������'', ''2'', ''������'', ''3'', ''����'', ''4'', ''���������'', ''5'', ''�����'', ''#�/�'') as datatype, s.tree, s.name as gname from supermag.smcard d, supermag.sacardclass s WHERE s.id = d.idclass and accepted=1 and '+article;
              TreeSet.Active:=true;
            except
              //on E:Exception do ShowMessage(E.Message);
            end;
            try
              BarcodeSet.Active:=false;
              BarcodeSet.CommandText:='select d.article, s.barcode from supermag.smstoreunits s, supermag.smcard d where d.article = s.article and d.article='''+Excel.Cells[i,14].Text+'''';
              BarcodeSet.Active:=true;
            except
            end;
            DBGrid1.Enabled:=true;
            DBGrid1.OnDblClick(nil);
            try
              CheckQuery.Active:=false;
              CheckQuery.SQL.Clear;
              CheckQuery.SQL.Add('update `info_check` set memo='''+DateToStr(PrintForm.DTP.Date)+''', name='''+name+''', price_dr='''+action_def_r+''', price_dk='''+action_def_k+''', action_price_r='''+action_price+''', action_def_k='''+price_dk+''', action_def_r='''+price_dr+''' where article='''+Excel.Cells[i,14].Text+'''');
              CheckQuery.ExecSQL;
            except
            end;
          except

          end;
        end;
      end;
      CheckTable.Active:=false;
      CheckTable.Active:=true;
      CheckTable.Filtered:=false;
      CheckTable.Filter:='groupid='''+Auth.groupid+'''';
      CheckTable.Filtered:=true;
      inc(i);
    end;
    {
    Screen.Cursor := crAppStart;
    Excel:=CreateOleObject('Excel.Application');
    Excel.Application.WorkBooks.Add(OpenD.FileName);
    Excel.Visible:=False;
    Excel.DisplayAlerts:=False;
    article:='';
    i:=14;
    while (Excel.Cells[i,1].Text<>'') or (Excel.Cells[i,2].Text<>'') or (Excel.Cells[i,3].Text<>'')  do
    begin
      if Excel.Cells[i,3].Text<>'' then
      begin
        article:=article+#39+Excel.Cells[i,14].Text+#39+', ';
      end;
      inc(i);
    end;
    article:='article in ('+copy(article, 1, length(article)-2)+')';
    try
      TreeSet.Active:=false;
      TreeSet.CommandText:='select d.article, d.name, d.mesabbrev as mesname, d.country, DECODE(accepted, ''1'', ''�������'', ''2'', ''���������'', ''�����'') as accepted, ';
      TreeSet.CommandText:=TreeSet.CommandText+'DECODE(datatype, ''0'', ''�����'', ''1'', ''������'', ''2'', ''������'', ''3'', ''����'', ''4'', ''���������'', ''5'', ''�����'', ''#�/�'') as datatype, s.tree, s.name as gname from supermag.smcard d, supermag.sacardclass s WHERE s.id = d.idclass and accepted=1 and '+article;
      TreeSet.Active:=true;
    except
      //on E:Exception do ShowMessage(E.Message);
    end;
    DBGrid1.Enabled:=true;
    GridSelectAll(DBGrid1);
    i:=0;
    try
      while i<=DBGrid1.SelectedRows.Count do
      begin
        DBGrid1.DataSource.DataSet.GotoBookmark(Pointer(DBGrid1.SelectedRows.Items[i]));
        try
          BarcodeSet.Active:=false;
          BarcodeSet.CommandText:='select d.article, s.barcode from supermag.smstoreunits s, supermag.smcard d where d.article = s.article and d.article='''+DBGrid1.DataSource.DataSet.FieldByName('article').AsString+'''';
          BarcodeSet.Active:=true;
        except
        end;
        DBGrid1.OnDblClick(nil);
        inc(i);
      end;
    except
    end;
    i:=14;
    while (Excel.Cells[i,14].Text<>'') or (Excel.Cells[i,17].Text<>'') or (Excel.Cells[i,18].Text<>'')  do
    begin
      article:='';
      action_price:='';
      action_def:='';
      action_price_r:='';
      action_price_k:='';
      action_def_r:='';
      action_def_k:='';
      if Excel.Cells[i,14].Text<>'' then
      begin

        try
          article:=Excel.Cells[i,14].Text;
          action_price:=Excel.Cells[i,17].Text;
          action_def:=Excel.Cells[i,18].Text;
          action_price_r:=FloatToStr(Trunc(StrToFloat(SetPoint(action_price))));
          action_price_k:=FloatToStr(Trunc(Frac(StrToFloat(SetPoint(action_price)))*100));
          action_def_r:=FloatToStr(Trunc(StrToFloat(SetPoint(action_def))));
          action_def_k:=FloatToStr(Trunc(Frac(StrToFloat(SetPoint(action_def)))*100));
          if length(action_price_k)=1 then action_price_k:=action_price_k+'0';
          if length(action_def_k)=1 then action_def_k:=action_def_k+'0';
        except
          On e:Exception do begin
            ShowMessage('������: '+E.Message+'.');
          end;
        end;
        try
          CheckQuery.Active:=false;
          CheckQuery.SQL.Clear;
          CheckQuery.SQL.Add('update `info_check` set action_price_r='''+action_price_r+''', action_price_k='''+action_price_k+''', action_def_k='''+action_def_k+''', action_def_r='''+action_def_r+''' where article='''+article+'''');
          CheckQuery.ExecSQL;
        except
        end;
      end;
      inc(i);
    end;
    CheckTable.Active:=false;
    CheckTable.Active:=true;
    CheckTable.Filtered:=false;
    CheckTable.Filter:='groupid='''+Auth.groupid+'''';
    CheckTable.Filtered:=true;
    FlashWindow(Application.Handle, True);
    Screen.Cursor := crDefault;
    }
    FlashWindow(Application.Handle, True);
    Screen.Cursor := crDefault;
    Excel.Quit;
    Excel:=Unassigned;
  end
  else
  begin
    Exit;
  end;
end;

procedure TMainForm.BitBtn8Click(Sender: TObject);
var dir:string;
begin
  dir:=ExtractFilePath(ParamStr(0));
  Report.LoadFromFile(dir+'FR\list.fr3');
  Report.PrintOptions.ShowDialog:=true;
  Report.PrepareReport(true);
  Report.ShowPreparedReport;
end;

procedure TMainForm.BitBtn9Click(Sender: TObject);
begin
  if DBGrid5.DataSource.DataSet.FieldByName('article').AsString<>'' then
  begin
    ChForm.Caption:='�������: '+DBGrid5.DataSource.DataSet.FieldByName('article').AsString;
    ChForm.ShowModal;
  end;
end;

procedure TMainForm.ChangerClick(Sender: TObject);
begin
  if ToggleSwitch1.State=tssOff then
  begin
    ZPC_TABLE.Active:=false;
    ZPC_TABLE.Active:=true;
    ZPC_TABLE.Filtered:=false;
    ZPC_TABLE.Filter:='data>='''+DateToStr(DateTimePicker3.Date)+''' and data<='''+DateToStr(DateTimePicker4.Date)+''' and state<>''���������''';
    ZPC_TABLE.Filtered:=true;
  end
  else
  begin
    ZPC_TABLE.Active:=false;
    ZPC_TABLE.Active:=true;
    ZPC_TABLE.Filtered:=false;
    ZPC_TABLE.Filter:='data>='''+DateToStr(DateTimePicker3.Date)+''' and data<='''+DateToStr(DateTimePicker4.Date)+''' and state=''���������''';
    ZPC_TABLE.Filtered:=true;
  end;
end;

procedure TMainForm.ChatGridDrawDataCell(Sender: TObject;
  const [Ref] Rect: TRect; Field: TField; State: TGridDrawState);
begin
{}
end;

procedure TMainForm.CheckBox1Enter(Sender: TObject);
begin
  CheckBox2.Checked:=false;
  CheckBox3.Checked:=false;
  CheckBox4.Checked:=false;
  //CheckBox1.Checked:=true;
  Search.Caption:='�����';
end;

procedure TMainForm.CheckBox1MouseEnter(Sender: TObject);
var point:TPoint;
begin
  point.X := CheckBox1.Width div 2;
  point.Y := CheckBox1.Height;
  BalloonHint.Title:='�����: �������';
  BalloonHint.Description:='������������ �����-���� ������';
  BalloonHint.ShowHint(CheckBox1.ClientToScreen(point));
end;

procedure TMainForm.CheckBox2Enter(Sender: TObject);
begin
  CheckBox1.Checked:=false;
  CheckBox3.Checked:=false;
  CheckBox4.Checked:=false;
  //CheckBox2.Checked:=true;
  Search.Caption:='�����';
end;

procedure TMainForm.CheckBox2MouseEnter(Sender: TObject);
var point:TPoint;
begin
  point.X := CheckBox2.Width div 2;
  point.Y := CheckBox2.Height;
  BalloonHint.Title:='�����: ������������';
  BalloonHint.Description:='������������ ������ �������';
  BalloonHint.ShowHint(CheckBox2.ClientToScreen(point));
end;

procedure TMainForm.CheckBox3Enter(Sender: TObject);
begin
  CheckBox1.Checked:=false;
  CheckBox2.Checked:=false;
  CheckBox4.Checked:=false;
  //CheckBox3.Checked:=true;
  Search.Caption:='�����';
end;

procedure TMainForm.CheckBox3MouseEnter(Sender: TObject);
var point:TPoint;
begin
  point.X := CheckBox3.Width div 2;
  point.Y := CheckBox3.Height;
  BalloonHint.Title:='�����: ���������';
  BalloonHint.Description:='������ ����� �������';
  BalloonHint.ShowHint(CheckBox3.ClientToScreen(point));
end;

procedure TMainForm.CheckBox4Enter(Sender: TObject);
begin
  CheckBox1.Checked:=false;
  CheckBox2.Checked:=false;
  CheckBox3.Checked:=false;
  //CheckBox3.Checked:=true;
  Search.Caption:='�����';
end;

procedure TMainForm.CheckBox4MouseEnter(Sender: TObject);
var point:TPoint;
begin
  point.X := CheckBox4.Width div 2;
  point.Y := CheckBox4.Height;
  BalloonHint.Title:='�����: ���';
  BalloonHint.Description:='����� ��� � ����';
  BalloonHint.ShowHint(CheckBox4.ClientToScreen(point));
end;

procedure TMainForm.ChSearch;
begin
  try
    if ComboBox2.Text='��� ������' then
    begin
      if ComboBox1.Text='��� ������' then
      begin
        ZV_Read.Active:=false;
        ZV_Read.Active:=true;
        ZV_READ.Filtered:=false;
        ZV_READ.Filter:='date >= ' + DateToStr(DateTimePicker1.Date) + ' and date <= ' + DateToStr(DateTimePicker2.Date);

        ZV_READ.Filtered:=true;
      end
      else
      begin
        ZV_Read.Active:=false;
        ZV_Read.Active:=true;
        ZV_READ.Filtered:=false;
        ZV_READ.Filter:='group = '''+ComboBox1.Text+''' and date >= ' + DateToStr(DateTimePicker1.Date) + ' and date <= ' + DateToStr(DateTimePicker2.Date);
        ZV_READ.Filtered:=true;
      end;
    end
    else
    begin
      if ComboBox1.Text='��� ������' then
      begin
        ZV_Read.Active:=false;
        ZV_Read.Active:=true;
        ZV_READ.Filtered:=false;
        ZV_READ.Filter:='status='''+ComboBox2.Text+''' and date >= ' + DateToStr(DateTimePicker1.Date) + ' and date <= ' + DateToStr(DateTimePicker2.Date);
        ZV_READ.Filtered:=true;
      end
      else
      begin
        ZV_Read.Active:=false;
        ZV_Read.Active:=true;
        ZV_READ.Filtered:=false;
        ZV_READ.Filter:='group='''+ComboBox1.Text+''' and status='''+ComboBox2.Text+''' and date >= ' + DateToStr(DateTimePicker1.Date) + ' and date <= ' + DateToStr(DateTimePicker2.Date);
        ZV_READ.Filtered:=true;
      end;
    end;
    ZV_READ.First;
  except
  end;
end;

function TMainForm.ClearField(value: string): string;
var i:integer; temp:string;
begin
  temp:='';
  i:=1;
  while i<=length(value) do
  begin
    if ((copy(value, i, 1)<>' ') and (copy(value, i, 1)<>'�') and (copy(value, i, 1)<>'�') and (copy(value, i, 1)<>'�'))  then
    begin
      temp:=temp+copy(value, i, 1);
    end;
    inc(i);
  end;
  result:=temp;
end;

function TMainForm.ClearSQL(value: string): string;
var i:integer; temp:string;
begin
  temp:='';
  i:=1;
  while i<=length(value) do
  begin
    if ((copy(value, i, 1)<>''''))  then
    begin
      temp:=temp+copy(value, i, 1);
    end;
    inc(i);
  end;
  result:=temp;
end;

procedure TMainForm.ClientError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  ErrorCode:=0;
end;

procedure TMainForm.ClientRead(Sender: TObject; Socket: TCustomWinSocket);
var recieve:AnsiString;
    i:integer; fam, mil:string;
begin
  recieve:=Socket.ReceiveText;
  if copy(recieve, 1, 4)='chat' then
  begin
    //ChatWin.Lines.Add(copy(recieve, 6, length(recieve)));
    //ChatWin.Perform(EM_LINESCROLL, 0, ChatWin.Lines.Count - 1);
    Exit;
  end;
  if recieve='esc' then
  begin
    ShowMessage('��������, ��� ������ �� ��� ��������.'+#13+#13+'��������� ������� ����: '+#13+'1) ������ �������� ����������, ���������� ��������� ������ ����� 2-3 ������.'+
    #13+'2) ���������� �������� ��������� �����.'+#13+'3) ������ ����� �� ����������.'+#13+#13+'� ������ ������� ������ ������, ���������� �������� �� ���� ���������� ��������������.');
    Exit;
  end;
  if copy(recieve, 1, 2)='rc' then
  begin
    i:=4;
    while i<>length(recieve) do
    begin
      if copy(recieve, i, 1)='&' then
      begin
        break;
      end;
      inc(i);
    end;
    MileShow.FIO.Text:=copy(recieve, 4, i-4);
    MileShow.balance.Text:=copy(recieve, i+1, length(recieve));
    MileShow.ShowModal;
  end;
end;

procedure TMainForm.CombFormatChange(Sender: TObject);
var i,j:integer;
begin
  try
    CombStyle.Items.Clear;
    i:=0;
    while i<>length(Auth.FormatP) do
    begin
      if Auth.FormatP[i].name=CombFormat.Text then
      begin
        j:=0;
        while j<>length(Auth.FormatP[i].style) do
        begin
          CombStyle.Items.Add(Auth.FormatP[i].style[j].name);
          inc(j);
        end;
        break;
      end;
      inc(i);
    end;
    CombStyle.ItemIndex:=0;
  except
  end;
end;

procedure TMainForm.CombFormatKeyPress(Sender: TObject; var Key: Char);
begin
  key:=#0;
end;

procedure TMainForm.ComboBox1Change(Sender: TObject);
begin
  ChSearch;
end;

procedure TMainForm.ComboBox2Change(Sender: TObject);
begin
  ChSearch;
end;

procedure TMainForm.ComboBox3Change(Sender: TObject);
begin
  try
    Auth.SGO_Query.Active:=false;
    Auth.SGO_Query.SQL.Clear;
    Auth.SGO_Query.SQL.Add('select t.group from t_zd t where t.mag='''+ComboBox3.Text+''' group by t.group');
    Auth.SGO_Query.Active:=true;
    Auth.SGO_Query.First;
    Otd.Items.Clear;
    Otd.Items.Add('��� ������');
    while not Auth.SGO_Query.Eof do
    begin
      Otd.Items.Add(Auth.SGO_Query.FieldByName('group').AsString);
      Auth.SGO_Query.Next;
    end;
  except
    //on E:Exception do ShowMessage('������: '+E.Message+'.');
  end;
end;

procedure TMainForm.ComboBox3KeyPress(Sender: TObject; var Key: Char);
begin
  key:=#0;
end;

procedure TMainForm.CombStyleKeyPress(Sender: TObject; var Key: Char);
begin
  key:=#0;
end;

procedure TMainForm.ComTerminalStrRecieved(Sender: TObject; var Str: string);
var s:string;
begin
  if half=0 then Half_S:='';
  inc(half);
  Half_S:=Half_S+Str;
  if CheckBox2.Checked=false then
  begin
    CheckBox1.Checked:=true;
    if half=2 then
    begin
      FindEdit.Enabled:=true;
      FindEdit.Text:=copy(Half_S, 1, 13);
      f12:=true;
      Search.Click;
    end;
  end
  else
  begin
    if half=2 then
    begin
      FindEdit.Enabled:=true;
      FindEdit.Text:=FindEdit.Text+' '+copy(Half_S, 1, 13);
      FindEdit.SelStart:=Length(FindEdit.Text);
    end;
  end;
  if half=2 then half:=0;
end;

procedure TMainForm.createzvClick(Sender: TObject);
var _date:TDateTimePicker;
begin
  if Auth.tz_moder=false then
  begin
    _date:=TDateTimePicker.Create(self);
    _date.Date:=Now;
    ZV_Query.Active:=false;
    ZV_Query.SQL.Clear;
    ZV_Query.SQL.Add('insert into t_zd(`date`, `group`, `status`, `mag`) values(:SD, '''+Auth.groupname+''', ''��������'', '''+Auth.magazin+''')');
    ZV_Query.Parameters.ParamByName('SD').Value:=FormatDateTime('YYYY-MM-DD', _date.Date);
    ZV_Query.ExecSQL;
    ZV_Table.Active:=false;
    ZV_Table.Active:=true;
    ZV_Query.Active:=false;
    ZV_Query.Sql.Clear;
    ZV_Query.SQL.Add('select * from t_zd');
    ZV_Query.Active:=true;
    ZV_Query.Last;
    docid:=ZV_Query.FieldByName('id').AsString;
    section:=ZV_Query.FieldByName('group').AsString;
    ReadDoc(docid);
    Label17.Caption:='��������: '+docid;
    Label18.Caption:='�������� ���-��';
    //DBGrid7.Enabled:=false;
    panel25.Align:=alClient;
    panel25.Visible:=true;
    panel16.Visible:=false;
    BitBtn18.SetFocus;
    BitBtn21.Enabled:=false;
    BitBtn22.Enabled:=false;
  end;
end;

procedure TMainForm.DateTimePicker1Change(Sender: TObject);
begin
  ChSearch;
end;

procedure TMainForm.DateTimePicker2Change(Sender: TObject);
begin
  ChSearch;
end;

procedure TMainForm.DateTimePicker3Change(Sender: TObject);
begin
  Changer.Click;
end;

procedure TMainForm.DateTimePicker4Change(Sender: TObject);
begin
  Changer.Click;
end;

procedure TMainForm.DBEdit1Change(Sender: TObject);
var goods:string; i,k,e:integer; DataSetGood:string; temp:string;  List:TStringList;
begin
  if TreeSet.FieldByName('article').AsString<>'' then
  begin
    try
      BarcodeSet.Active:=false;
      BarcodeSet.CommandText:='select d.article, s.barcode from supermag.smstoreunits s, supermag.smcard d where d.article = s.article and d.article='''+DBGrid1.DataSource.DataSet.FieldByName('article').AsString+'''';
      BarcodeSet.Active:=true;
    except
      //on E:Exception do ShowMessage('������ 0cv2324x354343: '+E.Message);
    end;
    Application.ProcessMessages;


    try
      Place_Query3.Active:=false;
      Place_Query3.SQL.Clear;
      Place_Query3.SQL.Add('select place, count from place_sklad where article = '''+DBGrid1.DataSource.DataSet.FieldByName('article').AsString+'''');
      Place_Query3.Active:=true;

      clPlace.Items.Clear;
      Label24.Caption:='���������� �� ������: ';
      temp:=Place_Query3.FieldByName('place').AsString;
      List:=TStringList.Create;
      List.Duplicates:=dupIgnore;
      List.Delimiter:=';';
      List.DelimitedText:=temp;

      i:=0;
      while i<>List.Count do
      begin
        if List.Strings[i]<>'' then
        begin
          if (clPlace.Items.IndexOf(List.Strings[i])=-1) then clPlace.Items.Add(List.Strings[i]);
        end;
        inc(i);
      end;

      Label24.Caption:='���������� �� ������: '+Place_Query3.FieldByName('count').AsString;

    except

    end;

    {

    try
      if (Access.Connected=false) then
      begin
        Access.Connected:=true;
      end;
      if (Access.Connected) then
      begin
        clPlace.Items.Clear;
        temp:='';
        DBGrid2.DataSource.DataSet.First;
        while not DBGrid2.DataSource.DataSet.Eof do
        begin
          Place_Query.Active:=false;
          Place_Query.SQL.Clear;
          Place_Query.SQL.Add('select clPlace from tblNaserver where clStrihkod='''+DBGrid2.DataSource.DataSet.FieldByName('barcode').AsString+'''');
          Place_Query.Active:=true;
          Place_Query.First;
          while not Place_Query.Eof do
          begin
            temp:=temp+Place_Query.FieldByName('clPlace').AsString+';';
            Place_Query.Next;
          end;
          DBGrid2.DataSource.DataSet.Next;
        end;

        List:=TStringList.Create;
        List.Duplicates:=dupIgnore;
        List.Delimiter:=';';
        List.DelimitedText:=temp;

        i:=0;
        while i<>List.Count do
        begin
          if List.Strings[i]<>'' then
          begin
            if (clPlace.Items.IndexOf(List.Strings[i])=-1) then clPlace.Items.Add(List.Strings[i]);
          end;
          inc(i);
        end;
      end;
    except
    end;

    try
      PriceSet.Active:=false;
      PriceSet.CommandText:='select * from smprices where storeloc='+Auth.storeloc+' and pricetype='+Auth.pricetype+' and article='''+DBGrid1.DataSource.DataSet.FieldByName('article').AsString+'''';
      PriceSet.Active:=true;
    except
      //on E:Exception do ShowMessage('������ 0cv2324x354342: '+E.Message);
    end;

    }

    try
      OraPos.Active:=false;
      OraPos.SQL.Clear;
      OraPos.SQL.Add('select u.name from smspec d, smdocuments p, supermag.smclientinfo u where d.article = '''+DBGrid1.DataSource.DataSet.FieldByName('article').AsString+''' and p.id = d.docid(+) and u.id = p.clientindex and d.doctype = ''WI'' and u.name not in (''���������� ��� '', ''����������'') group by u.name');
      OraPos.Active:=true;
      OraPos.First;
      ListBox1.Items.Clear;
      while not OraPos.Eof do
      begin
        ListBox1.Items.Add(OraPos.FieldByName('name').AsString);
        OraPos.Next;
      end;
    except
    end;

    try
      k:=0;
      goods:='';
      while k<>length(Auth.GList) do
      begin
        goods:=goods+Auth.GList[k].num+' ,';
        inc(k);
      end;
      goods:=copy(goods, 1, length(goods)-2);
    except
    end;




    try

      GoodSet.Active:=false;
      GoodSet.CommandText:='select g.article, ';
      GoodSet.CommandText:=GoodSet.CommandText+'decode(g.storeloc, ''2'', ''���. "����������", ������� �-�, ���. �������,1, 223053'', ''8'', ''���. "Mile", �.�����, ������������ �����,188, 220053'', ''11'', ''���. "Mile", �.�����, ��. ���������, 9�, 224022'',';
      GoodSet.CommandText:=GoodSet.CommandText+' ''16'', ''���. "Mile", �.�������, ������� �����,31, 212039'', ''18'', ''���. "Mile", �.�����, ��-� ������������, 150�'',';
      GoodSet.CommandText:=GoodSet.CommandText+' ''10'', ''����� "Mile" ������������, 220053 �.�����, ������������ �����, 188'', ''14'',';
      GoodSet.CommandText:=GoodSet.CommandText+' ''������������� ����� "Mile", 220113 �.�����, ��. �����������, 10'', ''15'', ''���������� ��'', ''17'', ''����� �������� � ����� "������������� �����", ��. �����������, 10'', ''-'') as storeloc';
      GoodSet.CommandText:=GoodSet.CommandText+' , g.quantity, g.RESERVEDQUANTITY, g.INCOMINGQUANTITY, g.AWAITEDQUANTITY, g.FOUNDQUANTITY, sog.opersale from smgoods g, ';
      GoodSet.CommandText:=GoodSet.CommandText+' (select decode(sum(og.salequantity - og.returnquantity), '''', ''0'', ''0'') as opersale, og.locid, og.article from smopergoods og where og.article='''+DBGrid1.DataSource.DataSet.FieldByName('article').AsString+''' and og.locid in ('+goods+') group by og.locid, og.article) sog where g.storeloc in ('+goods+') and g.article='''+DBGrid1.DataSource.DataSet.FieldByName('article').AsString+''' and g.article=sog.article(+) and g.storeloc=sog.locid(+)';
      GoodSet.Active:=true;

        GoodSet.Active:=false;
        //ShowMessage(Auth.storeloc2);
        DataSetGood:= ' SELECT *'
              + ' FROM Supermag.SMGoods d, Supermag.SMStorelocations c, Supermag.SMOperGoods s'
              + ' where (d.article= '+ DBGrid1.DataSource.DataSet.FieldByName('article').AsString + ') and (c.ID = d.STORELOC) and (d.article=s.article(+)) and (s.LOCID(+) = d.STORELOC) and d.STORELOC in ('+Auth.storeloc2+')';

        GoodSet.CommandText:=' SELECT name,QUANTITY,RESERVEDQUANTITY,INCOMINGQUANTITY,AWAITEDQUANTITY,FOUNDQUANTITY,CAST(sum(SALEQUANTITY - RETURNQUANTITY) as FLOAT) as opersale, CAST((max(quantity)-sum(SALEQUANTITY - RETURNQUANTITY)-reservedquantity) as FLOAT) as operquant'
              + ' FROM (' + DataSetGood + ')'
              + ' GROUP BY name,QUANTITY,RESERVEDQUANTITY,INCOMINGQUANTITY,AWAITEDQUANTITY,FOUNDQUANTITY';
        GoodSet.Active:=true;

        //ShowMessage(GoodSet.CommandText);
    except
      //on E:Exception do Showmessage(e.Message);
    end;

    try
      PropSet.Active:=false;
      PropSet.CommandText:='select s.article, decode(s.propid, ''52'', ''������������ ����������� Mile'', ''48'', ''����� Mile ������������'', ''51'', ''����� ���������� �������'', ';
      PropSet.CommandText:=PropSet.CommandText+'''49'', ''����� �����'', ''50'', ''����� �������'', ''39'',''����������� ������'', ''32'', ''����������'', ''Sys.Annotation'', ''���������'', ''1'', ''��� ������ (��)'', ''0'', ''��� ����� (��)'', ';
      PropSet.CommandText:=PropSet.CommandText+'''3'',''��� ����'', ''User.Gosreg'', ''����������������'', ''37'', ''A. ���������/���������'', ''26'',''�����'', ''13'', ''�������������'', ''25'', ''�������'', ''18'',''����������'',''27'',''�����'', ''4'', ''���-�� � ����'', ';
      PropSet.CommandText:=PropSet.CommandText+'''34'', ''������������'', ''28'', ''�����'', ''21'', ''��������'', ''16'',''��������'', ''17'',''��������'', ''15'',''����������'', ''33'',''�����'', ''2'',''����� (�3)'', ''8'',''�����'', ''31'', ''�������'',''6'',''������'', ''12'', ''������������'', ';
      PropSet.CommandText:=PropSet.CommandText+'''9'',''����������'', ''20'',''���������'', ''14'', ''������'', ''10'', ''������'', ''Sys.RegionProducer'',''������ ������������'', ''24'', ''����'', ''7'', ''�����������'', ''19'', ''�������'', ''Sys.Composition'', ''������'', ''User.IsSpecialGood'', ''���������'', ';
      PropSet.CommandText:=PropSet.CommandText+'''38'',''������ ����'', ''22'', ''���'', ''36'', ''�������'', ''Sys.BrandName'', ''�������� �����'', ''40'' ,''�������� ������� ������������'', ''11'', ''�����'', ''23'', ''������'', ''35'', ''���'', ''30'', ''�����������������'', ''User.Import_Article'', ''������: ������� � ������ ����'', ';
      PropSet.CommandText:=PropSet.CommandText+'''User.Import_Group'', ''������: ������ � ������ ����'', ''User.Width'', ''��������: ������, ��'', ''User.Height'', ''��������: ������, ��'', ''User.Deep'', ''��������: �������, ��'', ''55'', ''�������, �2'', ''56'', ''���������� � ��������, ��'', ';
      PropSet.CommandText:=PropSet.CommandText+'''57'', ''��������� ��������'', ''58'', ''�����'', ''59'', ''������� ��������� ����'',''60'', ''���� ������'', ';
      PropSet.CommandText:=PropSet.CommandText+'''#�/�'') as propid, s.propval from supermag.smcardproperties s where s.article='''+TreeSet.FieldByName('article').AsString+''' and s.propval is not null';
      PropSet.Active:=true;
    except
    end;

  end;
end;

procedure TMainForm.DBGrid1CellClick(Column: TColumn);
begin
  {
  try
    //DBGrid1.Refresh;
    //DBGrid1.Repaint;
  except

  end;
  }
end;

procedure TMainForm.DBGrid1DblClick(Sender: TObject);
var amount, amount_d, amount_color, price_dr, price_dk: Currency;
    size, size_2, color, plosh, count_upak, _class, trademark:string;
    amount_string, price_sh, price_mk, price_up, dop_info:string;
    price_sh_r, price_sh_k, price_mk_r, price_mk_k, price_up_r, price_up_k:string;
    srok, p_width, pr_width:string;
    tmp:string;
    goodkop:string;
    i:integer; ost_tov, ost_temp:string;
    SQL_TOV:string;
begin
  try
    if PageControl1.ActivePageIndex=8 then
    begin
      if Panel27.Visible=true then
      begin
        try
          ZV_TD_Query.Active:=false;
          ZV_TD_Query.SQL.Clear;
          ZV_TD_Query.SQL.Add('select * from zv_td where id='''+MainForm.doc_num+'''');
          ZV_TD_Query.Active:=true;
        except
        end;
        try
          if (ZV_TD_Query.FieldByName('status').AsString='��������') then
          begin
            ZvAdd.Caption:='������� ���������� ['+DBGrid1.DataSource.DataSet.FieldByName('article').AsString+']:';
            ZvAdd.ShowModal;
          end
          else ShowMessage('������ ��� ������������ ��� �������.'+#13+'���������� �������� � ������ ����������!');
        except
        end;
      end;
      Exit;
    end;
    if PageControl1.ActivePageIndex=11 then
    begin
      if ((Panel25.Visible=true) and (BitBtn18.Caption='���������') and (Auth.tz_moder=false)) then
      begin
        if DBGrid1.DataSource.DataSet.FieldByName('article').AsString<>'' then
        begin
          try
            //ShowMessage(Auth.storeloc2);
            Tov_Query.Active:=false;
            Tov_Query.SQL.Clear;
            SQL_TOV:='select g.article, g.quantity, t.salerate, t.storeloc ';
            SQL_TOV:=SQL_TOV+'from smgoods g, (select y.article as article, y.salerate as salerate, y.storeloc as storeloc from smstocklevels y) t ';
            SQL_TOV:=SQL_TOV+'where g.article = t.article(+)';
            SQL_TOV:=SQL_TOV+'and g.storeloc = t.storeloc(+)';
            SQL_TOV:=SQL_TOV+'and g.article = '''+DBGrid1.DataSource.DataSet.FieldByName('article').AsString+''' ';
            SQL_TOV:=SQL_TOV+'and g.storeloc in ('+auth.storeloc2+') ';
            SQL_TOV:=SQL_TOV+'and g.quantity > 0 ';
            SQL_TOV:=SQL_TOV+'order by t.storeloc ';
            Tov_Query.SQL.Add(SQL_TOV);
            Tov_Query.Active:=true;
            Tov_Query.First;
            //ShowMessage(Tov_Query.SQL.CommaText);
            //if Tov_Query.RecordCount=0 then showmessage('���� ���');

            //ShowMessage(Tov_Query.SQL.CommaText);
          except
            //on E:Exception do ShowMessage('������: '+E.Message);
          end;
          try
            if DBGrid7.Cells[1,DBGrid7.RowCount-1]='' then
            begin
              ost_tov:='0';
              ost_temp:='0';
              while not Tov_Query.Eof do
              begin

                //ShowMessage(Tov_Query.FieldByName('article').AsString);
                try
                  ost_temp:=ost_tov;
                  ost_temp:=FloatToStr(StrToFloat(ost_temp)+(Tov_Query.FieldByName('quantity').AsFloat));
                  ost_tov:=ost_temp;
                except
                end;
                Tov_Query.Next;
              end;
              Tov_Query.First;
              DBGrid7.Cells[0, DBGrid7.RowCount-1]:=DBGrid1.DataSource.DataSet.FieldByName('tree').AsString;
              DBGrid7.Cells[1, DBGrid7.RowCount-1]:=DBGrid1.DataSource.DataSet.FieldByName('article').AsString;
              DBGrid7.Cells[2, DBGrid7.RowCount-1]:=DBGrid2.DataSource.DataSet.FieldByName('barcode').AsString;
              DBGrid7.Cells[3, DBGrid7.RowCount-1]:=DBGrid1.DataSource.DataSet.FieldByName('name').AsString;
              DBGrid7.Cells[5, DBGrid7.RowCount-1]:=ost_tov;
              if ((Tov_Query.FieldByName('salerate').AsString<>'') and (Tov_Query.FieldByName('salerate').AsString<>'INF') and (Tov_Query.FieldByName('salerate').AsString<>'')) then DBGrid7.Cells[6, DBGrid7.RowCount-1]:=Tov_Query.FieldByName('salerate').AsString else DBGrid7.Cells[6, DBGrid7.RowCount-1]:='0';

              try
                DBGrid7.Cells[7, DBGrid7.RowCount-1]:=FloatToStr(RoundTo(StrToFloat(DBGrid7.Cells[5, DBGrid7.RowCount-1])/StrToFloat(DBGrid7.Cells[6, DBGrid7.RowCount-1]),0));
              except
                DBGrid7.Cells[7, DBGrid7.RowCount-1]:='0';
              end;

              if ((DBGrid7.Cells[7, DBGrid7.RowCount-1]='NAN') or (DBGrid7.Cells[7, DBGrid7.RowCount-1]='INF')) then
              begin
                DBGrid7.Cells[7, DBGrid7.RowCount-1]:='0';
              end;


              Tov_Query.Active:=false;
              Tov_Query.SQL.Clear;
              Tov_Query.SQL.Add('select u.name from smspec d, smdocuments p, supermag.smclientinfo u ');
              Tov_Query.SQL.Add('where d.article = '''+DBGrid1.DataSource.DataSet.FieldByName('article').AsString+''' ');
              Tov_Query.SQL.Add('and p.id = d.docid(+) ');
              Tov_Query.SQL.Add('and u.id = p.clientindex ');
              Tov_Query.SQL.Add('and u.name <> ''���������� ��� '' ');
              Tov_Query.SQL.Add('and d.doctype = ''WI'' ');
              Tov_Query.SQL.Add('order by p.createdat desc');
              Tov_Query.Active:=true;
              Tov_Query.First;

              DBGrid7.Cells[4, DBGrid7.RowCount-1]:=Tov_Query.FieldByName('name').AsString;

              DBGrid7.Cells[8, DBGrid7.RowCount-1]:='';
              DBGrid7.Cells[9, DBGrid7.RowCount-1]:='';
              DBGrid7.Cells[10, DBGrid7.RowCount-1]:='';
            end
            else
            begin
              ost_tov:='0';
              ost_temp:='0';
              while not Tov_Query.Eof do
              begin

                //ShowMessage(Tov_Query.FieldByName('quantity').AsString);
                try
                  ost_temp:=ost_tov;
                  ost_temp:=FloatToStr(StrToFloat(ost_temp)+(Tov_Query.FieldByName('quantity').AsFloat));
                  ost_tov:=ost_temp;
                except
                end;
                Tov_Query.Next;
              end;
              Tov_Query.First;
              DBGrid7.RowCount:=DBGrid7.RowCount+1;
              DBGrid7.Cells[0, DBGrid7.RowCount-1]:=DBGrid1.DataSource.DataSet.FieldByName('tree').AsString;
              DBGrid7.Cells[1, DBGrid7.RowCount-1]:=DBGrid1.DataSource.DataSet.FieldByName('article').AsString;
              DBGrid7.Cells[2, DBGrid7.RowCount-1]:=DBGrid2.DataSource.DataSet.FieldByName('barcode').AsString;
              DBGrid7.Cells[3, DBGrid7.RowCount-1]:=DBGrid1.DataSource.DataSet.FieldByName('name').AsString;
              DBGrid7.Cells[5, DBGrid7.RowCount-1]:=ost_tov;
              if ((Tov_Query.FieldByName('salerate').AsString<>'') and (Tov_Query.FieldByName('salerate').AsString<>'INF') and (Tov_Query.FieldByName('salerate').AsString<>'')) then DBGrid7.Cells[6, DBGrid7.RowCount-1]:=Tov_Query.FieldByName('salerate').AsString else DBGrid7.Cells[6, DBGrid7.RowCount-1]:='0';

              try
                DBGrid7.Cells[7, DBGrid7.RowCount-1]:=FloatToStr(RoundTo(StrToFloat(DBGrid7.Cells[5, DBGrid7.RowCount-1])/StrToFloat(DBGrid7.Cells[6, DBGrid7.RowCount-1]),0));
              except
                DBGrid7.Cells[7, DBGrid7.RowCount-1]:='0';
              end;

              if ((DBGrid7.Cells[7, DBGrid7.RowCount-1]='NAN') or (DBGrid7.Cells[7, DBGrid7.RowCount-1]='INF')) then
              begin
                DBGrid7.Cells[7, DBGrid7.RowCount-1]:='0';
              end;

              Tov_Query.Active:=false;
              Tov_Query.SQL.Clear;
              Tov_Query.SQL.Add('select u.name from smspec d, smdocuments p, supermag.smclientinfo u ');
              Tov_Query.SQL.Add('where d.article = '''+DBGrid1.DataSource.DataSet.FieldByName('article').AsString+''' ');
              Tov_Query.SQL.Add('and p.id = d.docid(+) ');
              Tov_Query.SQL.Add('and u.id = p.clientindex ');
              Tov_Query.SQL.Add('and u.name <> ''���������� ��� '' ');
              Tov_Query.SQL.Add('and d.doctype = ''WI'' ');
              Tov_Query.SQL.Add('order by p.createdat desc');
              Tov_Query.Active:=true;
              Tov_Query.First;

              DBGrid7.Cells[4, DBGrid7.RowCount-1]:=Tov_Query.FieldByName('name').AsString;

              DBGrid7.Cells[8, DBGrid7.RowCount-1]:='';
              DBGrid7.Cells[9, DBGrid7.RowCount-1]:='';
              DBGrid7.Cells[10, DBGrid7.RowCount-1]:='';
            end;
          except
          end;
        end;
      end;
      Exit;
    end;
    try
      if PageControl1.ActivePage.Tag=0 then PageControl1.ActivePageIndex:=6;
    except
    end;
    if PageControl1.ActivePageIndex=6 then
    begin
      try
        if DBGrid1.DataSource.DataSet.FieldByName('article').AsString<>'' then
        begin
          EnterForm.Caption:='�������: '+DBGrid1.DataSource.DataSet.FieldByName('article').AsString;
          EnterForm.ShowModal;
        end;
      except
      end;
      exit;
    end;
    if PageControl1.ActivePageIndex=9 then
    begin
      try
        PropSet.Active:=false;
        PropSet.CommandText:='select s.article, decode(s.propid, ''52'', ''������������ ����������� Mile'', ''48'', ''����� Mile ������������'', ''51'', ''����� ���������� �������'', ';
        PropSet.CommandText:=PropSet.CommandText+'''49'', ''����� �����'', ''50'', ''����� �������'', ''39'',''����������� ������'', ''32'', ''����������'', ''Sys.Annotation'', ''���������'', ''1'', ''��� ������ (��)'', ''0'', ''��� ����� (��)'', ';
        PropSet.CommandText:=PropSet.CommandText+'''3'',''��� ����'', ''User.Gosreg'', ''����������������'', ''37'', ''A. ���������/���������'', ''26'',''�����'', ''13'', ''�������������'', ''25'', ''�������'', ''18'',''����������'',''27'',''�����'', ''4'', ''���-�� � ����'', ';
        PropSet.CommandText:=PropSet.CommandText+'''34'', ''������������'', ''28'', ''�����'', ''21'', ''��������'', ''16'',''��������'', ''17'',''��������'', ''15'',''����������'', ''33'',''�����'', ''2'',''����� (�3)'', ''8'',''�����'', ''31'', ''�������'',''6'',''������'', ''12'', ''������������'', ';
        PropSet.CommandText:=PropSet.CommandText+'''9'',''����������'', ''20'',''���������'', ''14'', ''������'', ''10'', ''������'', ''Sys.RegionProducer'',''������ ������������'', ''24'', ''����'', ''7'', ''�����������'', ''19'', ''�������'', ''Sys.Composition'', ''������'', ''User.IsSpecialGood'', ''���������'', ';
        PropSet.CommandText:=PropSet.CommandText+'''38'',''������ ����'', ''22'', ''���'', ''36'', ''�������'', ''Sys.BrandName'', ''�������� �����'', ''40'' ,''�������� ������� ������������'', ''11'', ''�����'', ''23'', ''������'', ''35'', ''���'', ''30'', ''�����������������'', ''User.Import_Article'', ''������: ������� � ������ ����'', ';
        PropSet.CommandText:=PropSet.CommandText+'''User.Import_Group'', ''������: ������ � ������ ����'', ''User.Width'', ''��������: ������, ��'', ''User.Height'', ''��������: ������, ��'', ''User.Deep'', ''��������: �������, ��'', ''55'', ''�������, �2'', ''56'', ''���������� � ��������, ��'', ';
        PropSet.CommandText:=PropSet.CommandText+'''57'', ''��������� ��������'', ''58'', ''�����'', ''59'', ''������� ��������� ����'',''60'', ''���� ������'', ';
        PropSet.CommandText:=PropSet.CommandText+'''#�/�'') as propid, s.propval from supermag.smcardproperties s where s.article='''+DBGrid1.DataSource.DataSet.FieldByName('article').AsString+''' and s.propval is not null';
        PropSet.Active:=true;

        PropSet.First;

        size:='';
        size_2:='';
        color:='';
        plosh:='';
        count_upak:='';
        _class:='';
        trademark:='';
        price_sh:='';
        price_mk:='';
        price_up:='';
        dop_info:='';
        srok:='';
        p_width:='';
        pr_width:='';

        while not PropSet.Eof do
        begin
          if PropSet.FieldByName('propid').AsString='���� ������' then
          begin
            srok:=noBadChar(PropSet.FieldByName('propval').AsString);
          end;
          if PropSet.FieldByName('propid').AsString='������� ��������' then
          begin
            p_width:=noBadChar(PropSet.FieldByName('propval').AsString);
          end;
          if PropSet.FieldByName('propid').AsString='������� ��������� ����' then
          begin
            pr_width:=noBadChar(PropSet.FieldByName('propval').AsString);
          end;
          if PropSet.FieldByName('propid').AsString='������' then
          begin
            size:=noBadChar(PropSet.FieldByName('propval').AsString);
          end;
          if PropSet.FieldByName('propid').AsString='��������: ������, ��' then
          begin
            size_2:=size_2+noBadChar(PropSet.FieldByName('propval').AsString)+'x';
          end;
          if PropSet.FieldByName('propid').AsString='��������: ������, ��' then
          begin
            size_2:=size_2+noBadChar(PropSet.FieldByName('propval').AsString)+'x';
          end;
          if PropSet.FieldByName('propid').AsString='��������: �������, ��' then
          begin
            size_2:=size_2+noBadChar(PropSet.FieldByName('propval').AsString)+'x';
          end;
          if PropSet.FieldByName('propid').AsString='�����' then
          begin
            color:=noBadChar(PropSet.FieldByName('propval').AsString);
          end;
          if PropSet.FieldByName('propid').AsString='�������, �2' then
          begin
            plosh:=noBadChar(PropSet.FieldByName('propval').AsString);
          end;
          if PropSet.FieldByName('propid').AsString='���������� � ��������, ��' then
          begin
            count_upak:=noBadChar(PropSet.FieldByName('propval').AsString);
          end;
          if PropSet.FieldByName('propid').AsString='�����' then
          begin
            _class:=noBadChar(PropSet.FieldByName('propval').AsString);
          end;
          if PropSet.FieldByName('propid').AsString='�������� �����' then
          begin
            trademark:=noBadChar(PropSet.FieldByName('propval').AsString);
          end;
          if PropSet.FieldByName('propid').AsString='�������������' then
          begin
            dop_info:=noBadChar(PropSet.FieldByName('propval').AsString);
          end;
          PropSet.Next;
        end;
        if size_2<>'' then size_2:=copy(size_2, 1, length(size_2)-1);
        if size='' then size:=size_2;
      except
      end;

      //PropSet.Filtered:=false;

      System.SysUtils.FormatSettings.ThousandSeparator:='.';
      System.SysUtils.FormatSettings.DecimalSeparator:='.';

      try
        if DBGrid1.DataSource.DataSet.FieldByName('article').AsString<>'' then
        begin

          try
            BarcodeSet.Active:=false;
            BarcodeSet.CommandText:='select d.article, s.barcode from supermag.smstoreunits s, supermag.smcard d where d.article = s.article and d.article='''+DBGrid1.DataSource.DataSet.FieldByName('article').AsString+'''';
            BarcodeSet.Active:=true;
          except
          end;
          try
            PriceSet.Active:=false;
            PriceSet.CommandText:='select * from smprices where storeloc='+Auth.storeloc+' and pricetype='+Auth.pricetype+' and article='''+DBGrid1.DataSource.DataSet.FieldByName('article').AsString+'''';
            PriceSet.Active:=true;
          except
          end;



          amount:=0;
          amount_d:=0;
          amount_color:=0;
          price_mk:='';
          price_up:='';
          price_dr:=0;
          price_dk:=0;
          try

            if PriceSet.FieldByName('price').AsString<>'' then
            begin
              try
                amount:=PriceSet.FieldByName('price').AsFloat*10000;
              except
                amount:=0;
              end;
                      try
                        amount_d:=PriceSet.FieldByName('price').AsFloat;
                      except
                        amount_d:=0;
                      end;
                      try
                        price_dr:=Trunc(PriceSet.FieldByName('price').AsFloat);
                      except
                        price_dr:=0;
                      end;
                      try
                        price_dk:=Frac(PriceSet.FieldByName('price').AsFloat)*100;
                      except
                        price_dk:=0;
                      end;
              try
                amount_color:=RoundTo(amount/StrToFloat(StringReplace(count_upak, ',', '.',[rfReplaceAll, rfIgnoreCase])),2);
                price_sh:=FloatToStrF(amount_color, ffNumber, 10, 0);
              except
                price_sh:='0';
              end;
              try
                amount_color:=RoundTo(amount/StrToFloat(StringReplace(plosh, ',', '.',[rfReplaceAll, rfIgnoreCase])),2);
                price_mk:=FloatToStrF(amount_color, ffNumber, 10, 0);
              except
                price_mk:='0';
              end;
              try
                amount_color:=RoundTo(amount,2);
                price_up:=FloatToStrF(amount_color, ffNumber, 10, 0);
              except
                price_up:='0';
              end;



              try
                amount_color:=RoundTo(amount/StrToFloat(StringReplace(count_upak, ',', '.',[rfReplaceAll, rfIgnoreCase])),-2);
                amount_color:=RoundTo(amount_color/10000,-2);
                price_sh_r:=FloatToStrF(Trunc(amount_color), ffNumber, 10, 0);
                goodkop:='';
                  try
                    goodkop:=FloatToStrF(Frac(amount_color)*100, ffNumber, 10, 0);
                    if length(goodkop)=1 then
                    begin
                      goodkop:='0'+goodkop;
                    end;
                  except
                    goodkop:='0';
                  end;
                price_sh_k:=goodkop;
              except
                price_sh_r:='0';
                price_sh_k:='0';
              end;
              try
                amount_color:=RoundTo(amount/StrToFloat(StringReplace(plosh, ',', '.',[rfReplaceAll, rfIgnoreCase])),-2);
                amount_color:=RoundTo(amount_color/10000,-2);
                price_mk_r:=FloatToStrF(Trunc(amount_color), ffNumber, 10, 0);

                goodkop:='';
                  try
                    goodkop:=FloatToStrF(Frac(amount_color)*100, ffNumber, 10, 0);
                    if length(goodkop)=1 then
                    begin
                      goodkop:='0'+goodkop;
                    end;
                  except
                    goodkop:='0';
                  end;
                price_mk_k:=goodkop;
              except
                price_mk_r:='0';
                price_mk_k:='0';
              end;
              try
                price_up_r:=VarToStr(price_dr);
                price_up_k:=VarToStr(price_dk);
              except
                price_up_r:='0';
                price_up_k:='0';
              end;

              goodkop:='';
              try
                goodkop:=FloatToStrF(price_dk, ffNumber, 10, 0);
                if length(goodkop)=1 then
                begin
                  goodkop:='0'+goodkop;
                end;
              except
                goodkop:='0';
              end;

              CheckQuery.Active:=false;
              CheckQuery.SQL.Clear;
              CheckQuery.SQL.Add('insert into info_check(`groupid`, `article`, `barcode`, `name`, `price`, `price_d`, `em`,');
              CheckQuery.SQL.Add(' `country`, `memo`, `old_price`, `action_name`, `magazin`, `size`, `color`, `plosh`, `count_upak`, `class`, `trademark`, `price_mk`, `price_sh`, `price_up`, ');
              CheckQuery.SQL.Add(' `dop_info`, `price_dr`, `price_dk`,`srok`,`p_width`,`pr_width`, `price_sh_r`, `price_sh_k`, `price_mk_r`, `price_mk_k`, `price_up_r`, `price_up_k`) ');
              CheckQuery.SQL.Add('values('''+Auth.groupid+''', '''+DBGrid1.DataSource.DataSet.FieldByName('article').AsString+''', '''+DBGrid2.DataSource.DataSet.FieldByName('barcode').AsString+''', '''+noBadChar(SQLString(DBGrid1.DataSource.DataSet.FieldByName('name').AsString))+''', '''+FloatToStrF(amount, ffNumber, 10, 0)+''', '''+strik(FloatToStrF(amount_d, ffNumber, 10, 2))+''', '''+DBGrid1.DataSource.DataSet.FieldByName('mesname').AsString+''', '''+DBGrid1.DataSource.DataSet.FieldByName('country').AsString+''', '''', '''', '''', '''+Auth.magazin+''', '''+size+''', '''+color+''', '''+plosh+''', '''+count_upak+''', '''+_class+''', '''+trademark+''', '''+price_mk+''', '''+price_sh+''', '''+price_up+''', '''+dop_info+''', '''+strik(FloatToStrF(price_dr, ffNumber, 10, 0))+''', '''+goodkop+''','''+srok+''','''+p_width+''','''+pr_width+''', '''+price_sh_r+''', '''+price_sh_k+''', '''+price_mk_r+''', '''+price_mk_k+''', '''+price_up_r+''', '''+price_up_k+''')');
              CheckQuery.ExecSQL;
              CheckTable.Active:=false;
              CheckTable.Active:=true;
            end
            else
            begin
              amount:=0;
              amount_d:=0;
              try
                price_sh:='0';
              except
              end;
              try
                price_mk:='0';
              except
              end;
              try
                price_up:='0';
              except
              end;
              price_sh_r:='0';
              price_sh_k:='0';
              price_mk_r:='0';
              price_mk_k:='0';
              price_up_r:='0';
              price_up_k:='0';

              goodkop:='';
              try
                goodkop:=FloatToStrF(price_dk, ffNumber, 10, 0);
                if length(goodkop)=1 then
                begin
                  goodkop:='0'+goodkop;
                end;
              except
                goodkop:='0';
              end;

              CheckQuery.Active:=false;
              CheckQuery.SQL.Clear;
              CheckQuery.SQL.Add('insert into info_check(`groupid`, `article`, `barcode`, `name`, `price`, `price_d`, `em`,');
              CheckQuery.SQL.Add(' `country`, `memo`, `old_price`, `action_name`, `magazin`, `size`, `color`, `plosh`, `count_upak`, ');
              CheckQuery.SQL.Add(' `class`, `trademark`, `price_mk`, `price_sh`, `price_up`, `dop_info`, `price_dr`, `price_dk`,`srok`,`p_width`,`pr_width`, `price_sh_r`, `price_sh_k`, `price_mk_r`, `price_mk_k`, `price_up_r`, `price_up_k`)');
              CheckQuery.SQL.Add(' values('''+Auth.groupid+''', '''+DBGrid1.DataSource.DataSet.FieldByName('article').AsString+''', '''+DBGrid2.DataSource.DataSet.FieldByName('barcode').AsString+''', '''+noBadChar(SQLString(DBGrid1.DataSource.DataSet.FieldByName('name').AsString))+''', '''+FloatToStrF(amount, ffNumber, 10, 0)+''', '''+strik(FloatToStrF(amount_d, ffNumber, 10, 2))+''', '''+DBGrid1.DataSource.DataSet.FieldByName('mesname').AsString+''', '''+DBGrid1.DataSource.DataSet.FieldByName('country').AsString+''', '''', '''', '''', '''+Auth.magazin+''', '''+size+''', '''+color+''', '''+plosh+''', '''+count_upak+''', '''+_class+''', '''+trademark+''', '''+price_mk+''', '''+price_sh+''', '''+price_up+''', '''+dop_info+''', '''+strik(FloatToStrF(price_dr, ffNumber, 10, 0))+''', '''+goodkop+''','''+srok+''','''+p_width+''','''+pr_width+''', '''+price_sh_r+''', '''+price_sh_k+''', '''+price_mk_r+''', '''+price_mk_k+''', '''+price_up_r+''', '''+price_up_k+''')');
              CheckQuery.ExecSQL;
              CheckTable.Active:=false;
              CheckTable.Active:=true;
            end;
          except
            //On E:Exception do ShowMessage('������ ���������� ��������: '+E.Message+'.');
          end;
          try
            CheckTable.Active:=false;
            CheckTable.Active:=true;
            CheckTable.Filtered:=false;
            CheckTable.Filter:='groupid='''+Auth.groupid+'''';
            CheckTable.Filtered:=true;
          except
          end;
          //ShowMessage('Price_dr: '+FloatToStr(price_dr));
          DBGrid4.DataSource.DataSet.Last;
        end;
      except
      end;
      exit;
    end;
  except
  end;
end;

procedure TMainForm.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  try
    if key=VK_F12 then
    begin
      f121.Click;
    end;
  except
  end;
end;

procedure TMainForm.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  try
    if Key = ^A then
    begin
      GridSelectAll(DBGrid1);
      Key := #0;
    end;
  except
  end;
end;

procedure TMainForm.DBGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  recTmp: TGridCoord;
begin
  try
    if ((Shift = [ssLeft]) or (Shift = [ssRight]) or (Shift = [ssMiddle]) or (Shift = [ssCtrl]+[ssLeft]) or (Shift = [ssCtrl]+[ssRight]) or (Shift = [ssMiddle]+[ssCtrl])) then
    begin
      recTmp := DBGrid1.MouseCoord(X, Y);
      if recTmp.Y = 0 then exit;
      DBGrid1.BeginDrag(true, 0);
    end;
  except
  end;
end;

procedure TMainForm.DBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  try
    if Button=mbLeft then
    begin
      if (Shift <> [ssCtrl]) then
      begin
        DBGrid1.SelectedRows.CurrentRowSelected:=false;
      end;
    end
    else
    begin
      if (Shift <> [ssCtrl]) then
      begin
        DBGrid1.OnCellClick(nil);
        DBGrid1.SelectedRows.CurrentRowSelected:=false;
      end
      else
      begin
        if DBGrid1.SelectedRows.CurrentRowSelected=true then DBGrid1.SelectedRows.CurrentRowSelected:=false else DBGrid1.SelectedRows.CurrentRowSelected:=true;
      end;
    end;
  except
  end;
end;

procedure TMainForm.DBGrid1TitleClick(Column: TColumn);
begin
  try
    if (TreeSet.Sort = Column.FieldName + ' ASC') then
    begin
      TreeSet.Sort:=Column.FieldName + ' DESC';
    end
    else
    begin
      TreeSet.Sort:=Column.FieldName + ' ASC';
    end;
  except
  end;
end;

procedure TMainForm.DBGrid4DragDrop(Sender, Source: TObject; X, Y: Integer);
var i:integer; dir:string;
begin
  dir:=ExtractFilePath(ParamStr(0));
  if (Source is TDBGrid) then
  begin
    if DBGrid1.SelectedRows.Count<=1 then
    begin
      DBGrid1.OnDblClick(nil);
    end
    else
    begin
      i:=0;
      try
        TaskBar.OverlayIcon:=UpdImg.Picture.Icon;
        MainForm.Icon:=UpdImg.Picture.Icon;
      except
      end;
      BarcodeSet.Filtered:=false;
      PriceSet.Filtered:=false;
      PropSet.Filtered:=false;
      while i<=DBGrid1.SelectedRows.Count do
      begin
        DBGrid1.DataSource.DataSet.GotoBookmark(Pointer(DBGrid1.SelectedRows.Items[i]));
        try
          BarcodeSet.Active:=false;
          BarcodeSet.CommandText:='select d.article, s.barcode from supermag.smstoreunits s, supermag.smcard d where d.article = s.article and d.article='''+DBGrid1.DataSource.DataSet.FieldByName('article').AsString+'''';
          BarcodeSet.Active:=true;
        except
        end;
        DBGrid1.OnDblClick(nil);
        inc(i);
      end;
      BarcodeSet.Filtered:=false;
      PriceSet.Filtered:=false;
      PropSet.Filtered:=false;
      TaskBar.OverlayIcon:=IconClear.Picture.Icon;
      MainForm.Icon:=FormIcon.Picture.Icon;
    end;
  end;
end;

procedure TMainForm.DBGrid4DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  if ((Source is TDBGrid) or (Source is TTreeView)) then Accept:=true else Accept:=false;
end;

procedure TMainForm.DBGrid4KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_DELETE then
  begin
    BitBtn10.Click;
  end;
end;

procedure TMainForm.DBGrid5DblClick(Sender: TObject);
begin
  bitbtn9.Click;
end;

procedure TMainForm.DBGrid5DragDrop(Sender, Source: TObject; X, Y: Integer);
var i:integer; dir:string;
begin
  dir:=ExtractFilePath(ParamStr(0));
  if (Source is TDBGrid) then
  begin
    if DBGrid1.SelectedRows.Count<=1 then
    begin
      DBGrid1.OnDblClick(nil);
    end
    else
    begin
      i:=0;
      try
        TaskBar.OverlayIcon:=UpdImg.Picture.Icon;
        MainForm.Icon:=UpdImg.Picture.Icon;
      except
      end;
      while i<=DBGrid1.SelectedRows.Count do
      begin
        DBGrid1.DataSource.DataSet.GotoBookmark(Pointer(DBGrid1.SelectedRows.Items[i]));
        try
          BarcodeSet.Active:=false;
          BarcodeSet.CommandText:='select d.article, s.barcode from supermag.smstoreunits s, supermag.smcard d where d.article = s.article and d.article='''+DBGrid1.DataSource.DataSet.FieldByName('article').AsString+'''';
          BarcodeSet.Active:=true;
        except
        end;
        DBGrid1.OnDblClick(nil);
        inc(i);
      end;
      TaskBar.OverlayIcon:=IconClear.Picture.Icon;
      MainForm.Icon:=FormIcon.Picture.Icon;
    end;
  end;
end;

procedure TMainForm.DBGrid5DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  if ((Source is TDBGrid) or (Source is TTreeView)) then Accept:=true else Accept:=false;
end;

procedure TMainForm.DBGrid5KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_DELETE then
  begin
    BitBtn2.Click;
  end;
end;

procedure TMainForm.DBGrid7DragDrop(Sender, Source: TObject; X, Y: Integer);
var i:integer; dir:string;
begin
  if Auth.tz_moder=false then
  begin
    dir:=ExtractFilePath(ParamStr(0));
    if (Source is TDBGrid) then
    begin
      if DBGrid1.SelectedRows.Count<=1 then
      begin
        DBGrid1.OnDblClick(nil);
      end
      else
      begin
        i:=0;
        try
          TaskBar.OverlayIcon:=UpdImg.Picture.Icon;
          MainForm.Icon:=UpdImg.Picture.Icon;
        except
        end;
        BarcodeSet.Filtered:=false;
        PriceSet.Filtered:=false;
        PropSet.Filtered:=false;
        while i<DBGrid1.SelectedRows.Count do
        begin
          DBGrid1.DataSource.DataSet.GotoBookmark(Pointer(DBGrid1.SelectedRows.Items[i]));
          try
            BarcodeSet.Active:=false;
            BarcodeSet.CommandText:='select d.article, s.barcode from supermag.smstoreunits s, supermag.smcard d where d.article = s.article and d.article='''+DBGrid1.DataSource.DataSet.FieldByName('article').AsString+'''';
            BarcodeSet.Active:=true;
          except
          end;
          DBGrid1.OnDblClick(nil);
          inc(i);
        end;
        BarcodeSet.Filtered:=false;
        PriceSet.Filtered:=false;
        PropSet.Filtered:=false;
        TaskBar.OverlayIcon:=IconClear.Picture.Icon;
        MainForm.Icon:=FormIcon.Picture.Icon;
      end;
    end;

    if (Source is TTreeView) then
    begin
      TreeView.OnChange(nil,MainForm.TreeView.Selected);
      GridSelectAll(DBGrid1);
      if DBGrid1.SelectedRows.Count<=1 then
      begin
        DBGrid1.OnDblClick(nil);
      end
      else
      begin
        i:=0;
        try
          TaskBar.OverlayIcon:=UpdImg.Picture.Icon;
          MainForm.Icon:=UpdImg.Picture.Icon;
        except
        end;
        BarcodeSet.Filtered:=false;
        PriceSet.Filtered:=false;
        PropSet.Filtered:=false;
        while i<DBGrid1.SelectedRows.Count do
        begin
          DBGrid1.DataSource.DataSet.GotoBookmark(Pointer(DBGrid1.SelectedRows.Items[i]));
          try
            BarcodeSet.Active:=false;
            BarcodeSet.CommandText:='select d.article, s.barcode from supermag.smstoreunits s, supermag.smcard d where d.article = s.article and d.article='''+DBGrid1.DataSource.DataSet.FieldByName('article').AsString+'''';
            BarcodeSet.Active:=true;
          except
          end;
          DBGrid1.OnDblClick(nil);
          inc(i);
        end;
        BarcodeSet.Filtered:=false;
        PriceSet.Filtered:=false;
        PropSet.Filtered:=false;
        TaskBar.OverlayIcon:=IconClear.Picture.Icon;
        MainForm.Icon:=FormIcon.Picture.Icon;
      end;
    end;
  end;
end;

procedure TMainForm.DBGrid7DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  if ((Source is TDBGrid) or (Source is TTreeView)) then Accept:=true else Accept:=false;
end;

procedure TMainForm.DBGrid7DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var s:string;
    Flag: Cardinal;
    H: integer;
    var i,j:integer;
begin
  if (DBGrid7.Cells[11, ARow]='false') then
  begin
    //DBGrid7.Canvas.Brush.Color:=clRed;
    DBGrid7.Canvas.Brush.Color:=$3C14DC;
    DBGrid7.Canvas.FillRect(Rect);
  end;
  if (DBGrid7.Cells[11, ARow]='th') then
  begin
    //DBGrid7.Canvas.Brush.Color:=clRed;
    DBGrid7.Canvas.Brush.Color:=clGreen;
    DBGrid7.Canvas.FillRect(Rect);
  end;
  i:=0;
  while i<>length(TvGrid) do
  begin
    if (TvGrid[i]=true) then
    begin
      if (ARow=i) then
      begin
        DBGrid7.Canvas.Brush.Color:=$AACD66;
        DBGrid7.Canvas.FillRect(Rect);
      end;
    end;
    inc(i);
  end;


  if ARow<>0 then
  begin
    DBGrid7.Canvas.FillRect(Rect);
    s := DBGrid7.Cells[ACol,ARow];
    Flag := DT_LEFT or DT_WORDBREAK;
    Inc(Rect.Left,3);
    Dec(Rect.Right,3);
    H := DrawText(DBGrid7.Canvas.Handle,PChar(s),length(s),Rect,Flag);
    if H > DBGrid7.RowHeights[ARow] then DBGrid7.RowHeights[ARow] := H; //�����������
  end;

end;

procedure TMainForm.DBGrid7KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var i:integer; R:TRect;
begin
  if Auth.tz_moder = false then
  begin
    if Label18.Caption='��������' then
    begin
      if key=VK_DELETE then
      begin
        BitBtn22.Click;
        key:=0;
      end;
    end;
  end
  else
  begin
    key:=0;
  end;
end;

procedure TMainForm.DBGrid7KeyPress(Sender: TObject; var Key: Char);
begin

  if Label18.Caption='��������' then
  begin
    if ((DBGrid7.Col=4) or (DBGrid7.Col=10)) then
    begin
    end
    else
    begin
      key:=#0;
    end;
  end;
  if Label18.Caption='���������� � �������� �����' then
  begin
    if ((DBGrid7.Col=9) or (DBGrid7.Col=8) or (DBGrid7.Col=4)) then
    begin
    end
    else
    begin
      key:=#0;
    end;
  end;
  if ((Label18.Caption='�������� ����������') or (Label18.Caption='�������� ���-��')) then
  begin
    key:=#0;
  end;
end;

procedure TMainForm.DBGrid7MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var i:integer;
begin
  if BitBtn18.Caption='���������' then
  begin
    if Auth.tz_moder=true then
    begin
      if (Shift=[ssCtrl]+[ssLeft]) then
      begin
        if TvGrid[DBGrid7.Row]=false then
        begin
          TvGrid[DBGrid7.Row]:=true;
          DBGrid7.Refresh;
        end
        else
        begin
          TvGrid[DBGrid7.Row]:=false;
          DBGrid7.Refresh;
        end;
      end
      else
      begin
        if (Shift=[ssLeft]) then
        begin
          i:=0;
          while i<>length(TvGrid) do
          begin
            TvGrid[i]:=false;
            inc(i);
          end;
          DBGrid7.Refresh;
        end;
      end;
    end;
  end;
end;

procedure TMainForm.DBGrid7SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var R : TRect;
begin
  if (BitBtn18.Caption='���������') then
  begin
    R := DBGrid7.CellRect(ACol, ARow);
    R.Left  := R.Left + DBGrid7.Left;
    R.Right := R.Right + DBGrid7.Left;
    R.Top := R.Top + DBGrid7.Top;
    R.Bottom := R.Bottom + DBGrid7.Top;
    DT.Visible:=false;
    if Auth.tz_moder=true then
    begin
      if ((ACol=8) and (ARow>0)) then
      begin
        DT.Top := R.Top + 1;
        DT.Left := R.Left + 1;
        DT.Width := (R.Right + 1) - R.Left;
        DT.Height := (R.Bottom + 1) - R.Top;
        try
          if DBGrid7.Cells[ACol, ARow]=' - ' then
          begin
            DT.Format:=' - ';
          end
          else
          begin
            DT.Format:='';
            DT.Date:=StrToDate(DBGrid7.Cells[ACol, ARow]);
          end;
        except
          DT.Date:=Now;
        end;
        DT.Visible:=true;
        DT.SetFocus;
      end;
    end;
  end;
end;

procedure TMainForm.DBGrid8DblClick(Sender: TObject);
begin
  if DBGrid8.DataSource.DataSet.FieldByName('article').AsString<>'' then
  begin
    ZvChange.Caption:='������� ���������� ['+DBGrid8.DataSource.DataSet.FieldByName('article').AsString+']:';
    ZvChange.id:=DBGrid8.DataSource.DataSet.FieldByName('id').AsString;
    ZvChange.Edit1.Text:=DBGrid8.DataSource.DataSet.FieldByName('count').AsString;
    ZvChange.ShowModal;
  end;
end;

procedure TMainForm.DBGrid8DragDrop(Sender, Source: TObject; X, Y: Integer);
var i:integer; dir:string;
begin
  dir:=ExtractFilePath(ParamStr(0));
  if (Source is TDBGrid) then
  begin
    if DBGrid1.SelectedRows.Count<=1 then
    begin
      DBGrid1.OnDblClick(nil);
    end
    else
    begin
      i:=0;
      try
        TaskBar.OverlayIcon:=UpdImg.Picture.Icon;
        MainForm.Icon:=UpdImg.Picture.Icon;
      except
      end;
      while i<=DBGrid1.SelectedRows.Count do
      begin
        DBGrid1.DataSource.DataSet.GotoBookmark(Pointer(DBGrid1.SelectedRows.Items[i]));
        try
          BarcodeSet.Active:=false;
          BarcodeSet.CommandText:='select d.article, s.barcode from supermag.smstoreunits s, supermag.smcard d where d.article = s.article and d.article='''+DBGrid1.DataSource.DataSet.FieldByName('article').AsString+'''';
          BarcodeSet.Active:=true;
        except
        end;
        DBGrid1.OnDblClick(nil);
        inc(i);
      end;
      TaskBar.OverlayIcon:=IconClear.Picture.Icon;
      MainForm.Icon:=FormIcon.Picture.Icon;
    end;
  end;
end;

procedure TMainForm.DBGrid8DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  if ((Source is TDBGrid) or (Source is TTreeView)) then Accept:=true else Accept:=false;
end;

procedure TMainForm.DBGrid9DblClick(Sender: TObject);
begin
  BitBtn37.Click;
end;

procedure TMainForm.DBGrid9TitleClick(Column: TColumn);
begin
  try
    ZPC_TABLE.Sort:=Column.FieldName;
  except
  end;
end;

function TMainForm.DelPers(value: string): string;
var i:integer; temp:string;
begin
  temp:='';
  i:=1;
  while i<=length(value) do
  begin
    if copy(value, i, 1)<>'%' then
    begin
      temp:=temp+copy(value, i, 1);
    end;
    inc(i);
  end;
  result:=temp;
end;

procedure TMainForm.DTChange(Sender: TObject);
begin
  DT.Format:='';
end;

procedure TMainForm.DTCloseUp(Sender: TObject);
begin
  DT.Format:='';
end;

procedure TMainForm.DTExit(Sender: TObject);
begin
  if DT.Format=' - ' then DBGrid7.Cells[DBGrid7.Col, DBGrid7.Row]:=' - ' else DBGrid7.Cells[DBGrid7.Col, DBGrid7.Row]:=DateToStr(DT.Date);
  DT.Visible:=false;
end;

procedure TMainForm.DTKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((key=VK_BACK) or (key=VK_DELETE)) then
  begin
    DT.Format:=' - ';
  end;
end;

procedure TMainForm.EPriceChange(Sender: TObject);
var amount:Currency;
begin
  try
    System.SysUtils.FormatSettings.ThousandSeparator:='.';
    System.SysUtils.FormatSettings.DecimalSeparator:='.';
    amount:=PriceSet.FieldByName('price').AsFloat;
    LPrice.Caption:=FloatToStrF(amount, ffNumber, 10, 2);
  except
  end;
end;

procedure TMainForm.F121Click(Sender: TObject);
begin
  if CheckBox3.Checked then
  begin
    FindEdit.Enabled:=true;
    FindEdit.Clear;
    FindEdit.SetFocus;
    Exit;
  end;
  if CheckBox2.Checked=false then
  begin
    CheckBox1.Checked:=true;
    f12:=true;
    FindEdit.Enabled:=true;
    FindEdit.Clear;
    FindEdit.SetFocus;
  end
  else
  begin
    f12_ext:=true;
    FindEdit.Enabled:=true;
    FindEdit.SetFocus;
  end;
end;

procedure TMainForm.FastPrintClick(Sender: TObject);
var dir:string;
begin
  if PageControl1.ActivePageIndex=6 then
  begin
    dir:=ExtractFilePath(ParamStr(0));
    Report.LoadFromFile(dir+'FR\list.fr3');
    Report.PrepareReport(true);
    Report.PrintOptions.ShowDialog:=false;
    Report.Print;
  end;
  if PageControl1.ActivePageIndex=8 then
  begin
    if Panel27.Visible=true then
    begin
      dir:=ExtractFilePath(ParamStr(0));
      Zv_Report.LoadFromFile(dir+'FR\zv_td.fr3');
      Zv_Report.PrepareReport(true);
      Zv_Report.PrintOptions.ShowDialog:=false;
      Zv_Report.Print;
    end;
  end;
end;

procedure TMainForm.FilterClick(Sender: TObject);
begin
  if Filter.Caption='������' then
  begin
    Search.Click;
  end
  else
  begin
    try
      TreeSet.Filtered:=false;
      if group<>'' then
      begin
        if ToggleAct.State=TToggleSwitchState.tssOff then
        begin
          TreeSet.Filter:='tree like '''+group+'%'' and accepted=''�������''';
        end
        else
        begin
          TreeSet.Filter:='tree like '''+group+'%''';
        end;
      end
      else
      begin
        TreeSet.Filter:='';
      end;
      TreeSet.Filtered:=true;
    except
    end;
    Filter.Caption:='������';
  end;
end;

procedure TMainForm.FindEditChange(Sender: TObject);
begin
  Search.Caption:='�����';
end;

procedure TMainForm.FindEditInvokeSearch(Sender: TObject);
begin
  if f12_ext=true then
  begin
    FindEdit.Text:=FindEdit.Text+' ';
    FindEdit.SelStart:=Length(FindEdit.Text);
    f12_ext:=false;
    Exit;
  end
  else Search.Click;
end;

procedure TMainForm.FindEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_F12 then
  begin
    f121.Click;
  end;
end;

procedure TMainForm.FindEditKeyPress(Sender: TObject; var Key: Char);
begin
  {
  if ((key=#8) and (radiobutton1.Checked) and (Checkbox1.Checked) and (length(FindEdit.Text)>=7))then
  begin
    FindEdit.Text:='';
  end;
  }
end;

procedure TMainForm.FindEditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((radiobutton1.Checked) and (Checkbox1.Checked) and (key<>VK_BACK)) then
  begin
    if length(FindEdit.Text)=7 then
    begin
      try
        StrToFloat(FindEdit.Text);
        Search.Click;
        FindEdit.SetFocus;
        FindEdit.SelLength:=0;
        FindEdit.SelStart:=Length(FindEdit.Text);
      except
      end;
    end;
  end;
end;

procedure TMainForm.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  PreResize;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveReg();
  try
    Client.Close;
  except
  end;
  ExitProcess(2);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var i:integer;
begin
  TreeView.Color := clRed;
  TreeView.BorderStyle := bsNone;
  //chatbit.Click;
  saved:=true;
  DocD.Date:=Now;
  FromD.Date:=Now;
  DateTimePicker1.Date:=Now;
  DateTimePicker2.Date:=Now;
  DateTimePicker3.Date:=Now;
  DateTimePicker4.Date:=Now;
  ToD.Date:=Now;
  f12:=false;
  f12_ext:=false;
  anim:=0;
  group:='';
  TDBGridCover(DBGrid1).OnMouseWheel:= Wheel;
  BitBtn3.Click;
  try
    CombFormat.Items.Clear;
    CombFormat.Text:='';
    CombStyle.Items.Clear;
    CombStyle.Text:='';
    i:=0;
    while i<>length(Auth.FormatP) do
    begin
      CombFormat.Items.Add(Auth.FormatP[i].name);
      inc(i);
    end;
    CombFormat.ItemIndex:=0;
    CombFormat.OnChange(self);
    FImportList:= TStringList.Create;
  except
  end;
  ModelTree:= TModelTree.Create(Self);
  ModelTree.SetModelData(TreeView);
  try
    ComPort.Connected:=true;
  except
    ComPort.Connected:=false;
  end;
  try
    DBGrid1.DoubleBuffered:=true;
  except

  end;
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  PreResize;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  Auth.Hide;
  //FindEdit.SetFocus;
  TreeView.HideSelection:=false;
end;

function TMainForm.GetCop(value: string): string;
var temp:string; ext:boolean; i:integer;
begin
  temp:='';
  i:=1;
  ext:=false;
  while i<=length(value) do
  begin
    if (ext) then
    begin
      temp:=temp+copy(value, i, 1);
    end;
    if ((copy(value, i, 1) = ',') or (copy(value, i, 1) = '.')) then
    begin
      ext:=true;
    end;
    inc(i);
  end;
  Result:=temp;
end;

procedure TMainForm.GetGroup;
//var Group:TNewThread;
begin
  {
  Group:=TNewThread.Create(true);
  Group.FreeOnTerminate:=true;
  Group.Priority:=tpNormal;
  Group.Resume;
  }
end;

function TMainForm.GetRub(value: string): string;
var temp:string; ext:boolean; i:integer;
begin
  temp:='';
  i:=1;
  ext:=false;
  while i<=length(value) do
  begin
    if ((copy(value, i, 1) = ',') or (copy(value, i, 1) = '.')) then
    begin
      ext:=true;
    end;
    if (ext=false) then
    begin
      temp:=temp+copy(value, i, 1);
    end;
    inc(i);
  end;
  Result:=temp;
end;

function TMainForm.GridSelectAll(Grid: TDBGrid): Longint;
begin
  Result := 0;
  Grid.SelectedRows.Clear;
  with Grid.Datasource.DataSet do
  begin
    First;
    DisableControls;
    try
      while not EOF do
      begin
        Grid.SelectedRows.CurrentRowSelected := True;
        inc(Result);
        Next;
      end;
    finally
      EnableControls;
    end;
  end;
end;

procedure TMainForm.GSort(Sender: TObject);
var Grid:TStringGrid; i, j, p, column:Integer; List:TStringList;
begin
  if (Sender is TImage) then
  begin

    column:=(Sender as TImage).Tag;
    List:=TStringList.Create;
    List.Sorted:=True;
    List.Duplicates:=dupAccept;
    i:=1;
    while (i<DBGrid7.RowCount) do
    begin
      List.Add(DBGrid7.Cells[column, i]);
      inc(i);
    end;

    Grid:=TStringGrid.Create(self);

    i:=0;
    while i<>Grid.RowCount do
    begin
      Grid.Rows[i].Clear;
      inc(i);
    end;

    Grid.RowCount:=2;
    Grid.ColCount:=13;

    Grid.FixedCols:=0;
    Grid.FixedRows:=1;

    Grid.Cells[0,0]:='������';
    Grid.Cells[1,0]:='�������';
    Grid.Cells[2,0]:='�����-���';
    Grid.Cells[3,0]:='������������';
    Grid.Cells[4,0]:='���������';
    Grid.Cells[5,0]:='�������';
    Grid.Cells[6,0]:='��. ���. ����.';
    Grid.Cells[7,0]:='����� ����';
    Grid.Cells[8,0]:='���� ��������';
    Grid.Cells[9,0]:='����������� ������������';
    Grid.Cells[10,0]:='����������';
    Grid.Cells[11,0]:='Ext';

    i:=0;
    while i<DBGrid7.RowCount do
    begin
      j:=0;
      while j<DBGrid7.ColCount do
      begin
        Grid.Cells[j,i]:=DBGrid7.Cells[j,i];
        Grid.RowCount:=Grid.RowCount+1;
        inc(j);
      end;
      Grid.Cells[Grid.ColCount-1, i]:='false';
      inc(i);
    end;


    i:=0;
    while i<DBGrid7.RowCount do
    begin
      DBGrid7.Rows[i].Clear;
      inc(i);
    end;

    DBGrid7.RowCount:=2;
    DBGrid7.ColCount:=12;

    DBGrid7.FixedCols:=0;
    DBGrid7.FixedRows:=1;

    DBGrid7.Cells[0,0]:='������';
    DBGrid7.Cells[1,0]:='�������';
    DBGrid7.Cells[2,0]:='�����-���';
    DBGrid7.Cells[3,0]:='������������';
    DBGrid7.Cells[4,0]:='���������';
    DBGrid7.Cells[5,0]:='�������';
    DBGrid7.Cells[6,0]:='��. ���. ����.';
    DBGrid7.Cells[7,0]:='����� ����';
    DBGrid7.Cells[8,0]:='���� ��������';
    DBGrid7.Cells[9,0]:='����������� ������������';
    DBGrid7.Cells[10,0]:='����������';
    DBGrid7.Cells[11,0]:='Ext';
    DBGrid7.ColWidths[11]:=-1;

    i:=0;
    while i<List.Count do
    begin
      j:=1;
      while j<Grid.RowCount do
      begin
        if ((Grid.Cells[column, j]=List.Strings[i]) and (Grid.Cells[Grid.ColCount-1, j]='false')) then
        begin
          if (DBGrid7.Cells[1, DBGrid7.RowCount-1]='') then
          begin
            p:=0;
            while (p<Grid.ColCount) do
            begin
              DBGrid7.Cells[p, DBGrid7.RowCount-1]:=Grid.Cells[p, j];
              Grid.Cells[Grid.ColCount-1, j]:='true';
              inc(p);
            end;
          end
          else
          begin
            DBGrid7.RowCount:=DBGrid7.RowCount+1;
            p:=0;
            while (p<Grid.ColCount) do
            begin
              DBGrid7.Cells[p, DBGrid7.RowCount-1]:=Grid.Cells[p, j];
              Grid.Cells[Grid.ColCount-1, j]:='true';
              inc(p);
            end;
          end;
          break;
        end;
        inc(j);
      end;
      inc(i);
    end;

    Grid.Destroy;
    List.Destroy;
  end;
end;

procedure TMainForm.HideMes;
var i:integer;
begin
  i:=0;
  while i<>length(AForm) do
  begin
    AForm[i].Hide;
    inc(i);
  end;
end;

procedure TMainForm.Image1Click(Sender: TObject);
var i,j:integer;
    dir:string;
begin
  try
    CheckQuery.Active:=false;
    CheckQuery.SQL.Clear;
    CheckQuery.SQL.Add('select fr from info_group where id='''+Auth.groupid+'''');
    CheckQuery.Active:=true;
    CheckQuery.First;
    if CheckQuery.FieldByName('fr').AsString='true' then
    begin
      dir:=ExtractFilePath(ParamStr(0));
      if ((CombFormat.Text<>'') and (CombStyle.Text<>'')) then
      begin
        i:=0;
        while i<>length(Auth.FormatP) do
        begin
          if Auth.FormatP[i].name=CombFormat.Text then
          begin
            j:=0;
            while j<>length(Auth.FormatP[i].style) do
            begin
              if Auth.FormatP[i].style[j].name=CombStyle.Text then
              begin
                Report.LoadFromFile(dir+'FR\'+Auth.FormatP[i].style[j].path);
                Report.DesignReport();
                break;
              end;
              inc(j);
            end;
            break;
          end;
          inc(i);
        end;
      end;
    end;
  except
  end;
end;

procedure TMainForm.Image4Click(Sender: TObject);
begin
  Auth.Show;
  MainForm.Hide;
end;

procedure TMainForm.LoadReg;
var
  Registry: TRegistry;
begin
  try
    Registry := TRegistry.Create;
    Registry.RootKey := hkey_current_user;
    Registry.OpenKey('software\Info',true);
    try
      if Registry.ReadString('LeftPanel')<>'' then
      begin
        Panel2.width:=StrToInt(Registry.ReadString('LeftPanel'));
      end;
      if Registry.ReadString('ButtomPanel')<>'' then
      begin
        Panel12.height:=StrToInt(Registry.ReadString('ButtomPanel'));
      end;
    except
    end;
    Registry.CloseKey;
    Registry.Free;
  except
  end;
end;

procedure TMainForm.MsgBoxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_F12 then
  begin
    f121.Click;
  end;
end;

function TMainForm.noBadChar(value: string): string;
var temp:string; i:integer;
begin
  temp:=StringReplace(value, #92, #92+#92, [rfReplaceAll, rfIgnoreCase]);
  temp:=StringReplace(value, #34, #92+#34, [rfReplaceAll, rfIgnoreCase]);
  temp:=StringReplace(value, #39, #92+#39, [rfReplaceAll, rfIgnoreCase]);
  temp:=StringReplace(value, #47, #92+#47, [rfReplaceAll, rfIgnoreCase]);
  result:=temp;
end;

procedure TMainForm.ObrabTimer(Sender: TObject);
var i:integer; top:integer; post:integer;
begin
  Place_Query3.Active:=false;
  Place_Query3.SQL.Clear;
  Place_Query3.SQL.Add('select * from `zv_td` where `status`=''�������'' and `statmes`=''false'' and `group`='''+Auth.groupname+'''');
  Place_Query3.Active:=true;
  if Place_Query3.RecordCount<>0 then
  begin
    i:=0;
    while i<>length(AForm) do
    begin
      AForm[i].Destroy;
      inc(i);
    end;
    SetLength(AForm, 0);
    SetLength(AForm, Place_Query3.RecordCount + 1);
    i:=0;
    while i<>length(AForm) do
    begin
      AForm[i]:=TZvMessage.Create(nil);
      inc(i);
    end;
    i:=0;
    top:=0;
    post:=Screen.Height - 55;
    Place_Query3.First;
    while not Place_Query3.Eof do
    begin
      top:=top+AForm[i].Height + 5;
      AForm[i].Left:=Screen.Width - AForm[i].Width - 20;
      AForm[i].Top:= post - top;
      AForm[i].Caption:='�����:';
      AForm[i].num:=Place_Query3.FieldByName('id').AsString;
      AForm[i].name:=Place_Query3.FieldByName('status').AsString;
      AForm[i].Label1.Caption:='���� ������ �'+Place_Query3.FieldByName('id').AsString+' ����������.';
      AForm[i].Show;
      Place_Query3.Next;
      inc(i);
    end;
  end;
end;

procedure TMainForm.OtdKeyPress(Sender: TObject; var Key: Char);
begin
  key:=#0;
end;

procedure TMainForm.OtlojTimer(Sender: TObject);
begin
  Obrab.Enabled:=true;
end;

procedure TMainForm.PageControl1Change(Sender: TObject);
begin
  TreeView.DragMode:=dmManual;
  if PageControl1.ActivePageIndex=11 then
  begin
    //TreeView.DragMode:=dmAutomatic;
    combobox3.Text:=Auth.magazin;
    bitbtn15.Click;
  end;
  if PageControl1.ActivePageIndex=8 then
  begin
    try
      ZV_READ.Active:=false;
      ZV_Read.Active:=true;
      ZV_READ.Filtered:=false;
      ZV_Read.Filter:='date='''+DateToStr(Now)+'''';
      ZV_READ.Filtered:=true;
      ZV_ReadS.DataSet.First;
    except
    end;
  end;
  if PageControl1.ActivePageIndex=14 then
  begin
    try
      Changer.Click;
    except
    end;
  end;
end;

procedure TMainForm.Panel25CanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
var i:integer; l:integer;
begin
  SetLength(Imager, 0);
  SetLength(Imager, DBGrid7.ColCount);
  DBGrid7.ColWidths[0]:=Trunc(DBGrid7.Width * 0.08);
  DBGrid7.ColWidths[1]:=Trunc(DBGrid7.Width * 0.08);
  DBGrid7.ColWidths[2]:=Trunc(DBGrid7.Width * 0.08);
  DBGrid7.ColWidths[3]:=Trunc(DBGrid7.Width * 0.12);
  DBGrid7.ColWidths[4]:=Trunc(DBGrid7.Width * 0.08);
  DBGrid7.ColWidths[5]:=Trunc(DBGrid7.Width * 0.08);
  DBGrid7.ColWidths[6]:=Trunc(DBGrid7.Width * 0.08);
  DBGrid7.ColWidths[7]:=Trunc(DBGrid7.Width * 0.08);
  DBGrid7.ColWidths[8]:=Trunc(DBGrid7.Width * 0.08);
  DBGrid7.ColWidths[9]:=Trunc(DBGrid7.Width * 0.1);
  DBGrid7.ColWidths[10]:=Trunc(DBGrid7.Width * 0.1);
  l:=0;
  i:=0;
  while (i < DBGrid7.ColCount) do
  begin
    Imager[i]:=TImage.Create(self);
    Imager[i].Parent:=DBGrid7;
    Imager[i].Left:=l;
    Imager[i].Top:=0;
    Imager[i].Width:=DBGrid7.ColWidths[i];
    Imager[i].Height:=DBGrid7.RowHeights[0];
    Imager[i].Tag:=i;
    Imager[i].OnClick:=GSort;

    Imager[i].Visible:=true;
    l:=l+Imager[i].Width;
    inc(i);
  end;
end;

procedure TMainForm.Panel6CanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  //SendEdit.Left:=5;
  //SendEdit.Width:=Panel6.Width-15-BitBtn7.Width;
  //BitBtn7.Left:=SendEdit.Left+SendEdit.Width+3;
  //Label10.Left:=5;
  //Room.Left:=Label10.Left+Label10.Width+5;
  //Room.Width:=Panel6.Width-10-Label10.Left-Label10.Width-2;
end;

procedure TMainForm.PreResize;
begin
  try
    DBGrid1.Columns[0].Width:=Trunc(DBGrid1.Width * 0.1);
    DBGrid1.Columns[1].Width:=Trunc(DBGrid1.Width * 0.67);
    DBGrid1.Columns[2].Width:=Trunc(DBGrid1.Width * 0.1);
    DBGrid1.Columns[3].Width:=Trunc(DBGrid1.Width * 0.1);
  except
  end;
  try
    DBGrid4.Columns[1].Width:=Trunc(DBgrid4.Width * 0.08);
    DBGrid4.Columns[2].Width:=Trunc(DBgrid4.Width * 0.12);
    DBGrid4.Columns[3].Width:=Trunc(DBgrid4.Width * 0.2);
    DBGrid4.Columns[4].Width:=Trunc(DBgrid4.Width * 0.08);
    DBGrid4.Columns[5].Width:=Trunc(DBgrid4.Width * 0.08);
    DBGrid4.Columns[6].Width:=Trunc(DBgrid4.Width * 0.08);
    DBGrid4.Columns[7].Width:=Trunc(DBgrid4.Width * 0.08);
    DBGrid4.Columns[8].Width:=Trunc(DBgrid4.Width * 0.08);
    DBGrid4.Columns[9].Width:=Trunc(DBgrid4.Width * 0.18);
    DBGrid4.Columns[10].Width:=Trunc(DBgrid4.Width * 0.18);
    DBGrid4.Columns[11].Width:=Trunc(DBgrid4.Width * 0.18);
  except
  end;
  try
    DBGrid5.Columns[1].Width:=Trunc(DBgrid5.Width * 0.1);
    DBGrid5.Columns[2].Width:=Trunc(DBgrid5.Width * 0.2);
    DBGrid5.Columns[3].Width:=Trunc(DBgrid5.Width * 0.1);
    DBGrid5.Columns[4].Width:=Trunc(DBgrid5.Width * 0.1);
    DBGrid5.Columns[5].Width:=Trunc(DBgrid5.Width * 0.05);
    DBGrid5.Columns[6].Width:=Trunc(DBgrid5.Width * 0.1);
    DBGrid5.Columns[7].Width:=Trunc(DBgrid5.Width * 0.1);
    DBGrid5.Columns[8].Width:=Trunc(DBgrid5.Width * 0.1);
    DBGrid5.Columns[9].Width:=Trunc(DBgrid5.Width * 0.1);
  except
  end;
  try
    ZvGrid.Columns[0].Width:=Trunc(ZvGrid.Width * 0.1);
    ZvGrid.Columns[1].Width:=Trunc(ZvGrid.Width * 0.1);
    ZvGrid.Columns[2].Width:=Trunc(ZvGrid.Width * 0.15);
    ZvGrid.Columns[3].Width:=Trunc(ZvGrid.Width * 0.15);
    ZvGrid.Columns[4].Width:=Trunc(ZvGrid.Width * 0.45);
  except
  end;
  try
    RGrid.Columns[0].Width:=Trunc(RGrid.Width * 0.1);
    RGrid.Columns[1].Width:=Trunc(RGrid.Width * 0.1);
    RGrid.Columns[2].Width:=Trunc(RGrid.Width * 0.2);
    RGrid.Columns[3].Width:=Trunc(RGrid.Width * 0.2);
    RGrid.Columns[4].Width:=Trunc(RGrid.Width * 0.2);
  except
  end;
  try
    DBGrid8.Columns[1].Width:=Trunc(DBGrid8.Width * 0.1);
    DBGrid8.Columns[2].Width:=Trunc(DBGrid8.Width * 0.1);
    DBGrid8.Columns[3].Width:=Trunc(DBGrid8.Width * 0.3);
    DBGrid8.Columns[4].Width:=Trunc(DBGrid8.Width * 0.1);
    DBGrid8.Columns[5].Width:=Trunc(DBGrid8.Width * 0.1);
    DBGrid8.Columns[6].Width:=Trunc(DBGrid8.Width * 0.1);
    DBGrid8.Columns[7].Width:=Trunc(DBGrid8.Width * 0.1);
    DBGrid8.Columns[8].Width:=Trunc(DBGrid8.Width * 0.1);
  except

  end;
end;

procedure TMainForm.RadioButton1Click(Sender: TObject);
begin
  Search.Caption:='�����';
  Search.Click;
end;

procedure TMainForm.RadioButton2Click(Sender: TObject);
begin
  Search.Caption:='�����';
  Search.Click;
end;

procedure TMainForm.RadioButton3Click(Sender: TObject);
begin
  Search.Caption:='�����';
  Search.Click;
end;

procedure TMainForm.RadioButton4Click(Sender: TObject);
begin
  Search.Caption:='�����';
  Search.Click;
end;

procedure TMainForm.RadioButton5Click(Sender: TObject);
begin
  Search.Caption:='�����';
  Search.Click;
end;

procedure TMainForm.ReadDoc(id:string);
var i:integer;
begin
  saved:=true;
  i:=0;
  while i<>DBGrid7.RowCount do
  begin
    DBGrid7.Rows[i].Clear;
    inc(i);
  end;


  DBGrid7.RowCount:=2;
  DBGrid7.ColCount:=12;

  DBGrid7.FixedCols:=0;
  DBGrid7.FixedRows:=1;

  DBGrid7.Cells[0,0]:='������';
  DBGrid7.Cells[1,0]:='�������';
  DBGrid7.Cells[2,0]:='�����-���';
  DBGrid7.Cells[3,0]:='������������';
  DBGrid7.Cells[4,0]:='���������';
  DBGrid7.Cells[5,0]:='�������';
  DBGrid7.Cells[6,0]:='��. ���. ����.';
  DBGrid7.Cells[7,0]:='����� ����';
  DBGrid7.Cells[8,0]:='���� ��������';
  DBGrid7.Cells[9,0]:='����������� ������������';
  DBGrid7.Cells[10,0]:='����������';
  DBGrid7.Cells[11,0]:='ext';
  DBGrid7.ColWidths[11]:=-1;

  Auth.SGO_Query.Active:=false;
  Auth.SGO_Query.SQL.Clear;
  Auth.SGO_Query.SQL.Add('select * from t_zd2 where docid='''+id+'''');
  Auth.SGO_Query.Active:=true;

  Auth.SGO_Query.First;
  while not Auth.SGO_Query.Eof do
  begin
    if DBGrid7.Cells[0, DBGrid7.RowCount-1]<>'' then DBGrid7.RowCount:=DBGrid7.RowCount+1;
    DBGrid7.Cells[0,DBGrid7.RowCount-1]:=Auth.SGO_Query.FieldByName('tree').AsString;
    DBGrid7.Cells[1,DBGrid7.RowCount-1]:=Auth.SGO_Query.FieldByName('article').AsString;
    DBGrid7.Cells[2,DBGrid7.RowCount-1]:=Auth.SGO_Query.FieldByName('barcode').AsString;
    DBGrid7.Cells[3,DBGrid7.RowCount-1]:=Auth.SGO_Query.FieldByName('name').AsString;
    DBGrid7.Cells[4,DBGrid7.RowCount-1]:=Auth.SGO_Query.FieldByName('production').AsString;
    DBGrid7.Cells[5,DBGrid7.RowCount-1]:=Auth.SGO_Query.FieldByName('goods').AsString;
    DBGrid7.Cells[6,DBGrid7.RowCount-1]:=Auth.SGO_Query.FieldByName('sr').AsString;
    DBGrid7.Cells[7,DBGrid7.RowCount-1]:=Auth.SGO_Query.FieldByName('days').AsString;
    DBGrid7.Cells[8,DBGrid7.RowCount-1]:=Auth.SGO_Query.FieldByName('date').AsString;
    DBGrid7.Cells[9,DBGrid7.RowCount-1]:=Auth.SGO_Query.FieldByName('comment').AsString;
    DBGrid7.Cells[10,DBGrid7.RowCount-1]:=Auth.SGO_Query.FieldByName('prim').AsString;
    DBGrid7.Cells[11,DBGrid7.RowCount-1]:=Auth.SGO_Query.FieldByName('ext').AsString;
    Auth.SGO_Query.Next;
  end;

  SetLength(TvGrid, 0);
  SetLength(TvGrid, DBGrid7.RowCount);
  i:=0;
  while i<>length(TVGrid) do
  begin
    TvGrid[i]:=false;
    inc(i);
  end;

  if Auth.tz_moder=true then
  begin
    DatePost.Date:=Now;
    TextPost.Text:='';
    GroupBox8.Enabled:=true;
  end
  else
  begin
    GroupBox8.Enabled:=false;
  end;
end;

procedure TMainForm.ReportBeforePrint(Sender: TfrxReportComponent);
var dir:string;
begin
  try
    if TfrxPictureView(Sender).Name='Napol_Img' then
    begin
      dir:=ExtractFileDir(ParamStr(0));
      TfrxPictureView(Sender).Picture.LoadFromFile(dir+'\FR\company\'+RepSet.DataSet.FieldByName('trademark').AsString+'.bmp');
    end;
  except
  end;
  try
    if TfrxBarCodeView(Sender).Name='BarCode1' then
    begin
      if length(RepSet.DataSet.FieldByName('barcode').AsString)=8 then TfrxBarCodeView(Sender).BarType:=bcCodeEAN8;
      if length(RepSet.DataSet.FieldByName('barcode').AsString)=13 then TfrxBarCodeView(Sender).BarType:=bcCodeEAN13;
      if length(RepSet.DataSet.FieldByName('barcode').AsString)>13 then TfrxBarCodeView(Sender).BarType:=bcCodeEAN128B;
    end;
  except
  end;
end;

procedure TMainForm.ReportPreview(Sender: TObject);
var frmPreview: TfrxPreviewForm;
begin
  frmPreview:=TfrxPreviewForm(Report.PreviewForm);
  frmPreview.Caption:='��������������� ��������: ';
  frmPreview.BorderIcons:=frmPreview.BorderIcons-[biMinimize]-[biMaximize];
end;

procedure TMainForm.Report_MainPreview(Sender: TObject);
var frmPreview: TfrxPreviewForm;
begin
  frmPreview:=TfrxPreviewForm(Report_Main.PreviewForm);
  frmPreview.Caption:='��������������� ��������: ';
  frmPreview.BorderIcons:=frmPreview.BorderIcons-[biMinimize]-[biMaximize];
end;

procedure TMainForm.Report_VipBeforePrint(Sender: TfrxReportComponent);
begin
  try
    if TfrxBarCodeView(Sender).Name='BarCode1' then
    begin
      if length(VipSet.DataSet.FieldByName('barcode').AsString)=8 then TfrxBarCodeView(Sender).BarType:=bcCodeEAN8;
      if length(VipSet.DataSet.FieldByName('barcode').AsString)=13 then TfrxBarCodeView(Sender).BarType:=bcCodeEAN13;
      if length(VipSet.DataSet.FieldByName('barcode').AsString)>13 then TfrxBarCodeView(Sender).BarType:=bcCodeEAN128B;
    end;
  except
  end;
end;

procedure TMainForm.Report_VipPreview(Sender: TObject);
var frmPreview: TfrxPreviewForm;
begin
  frmPreview:=TfrxPreviewForm(Report_Vip.PreviewForm);
  frmPreview.Caption:='��������������� ��������: ';
  frmPreview.BorderIcons:=frmPreview.BorderIcons-[biMinimize]-[biMaximize];
end;

procedure TMainForm.RGridDblClick(Sender: TObject);
begin
  try
    Label10.Caption:='�������� '+RGrid.DataSource.DataSet.FieldByName('id').AsString+':';
    Label19.Caption:=RGrid.DataSource.DataSet.FieldByName('status').AsString;
    doc_num:=RGrid.DataSource.DataSet.FieldByName('id').AsString;
    ZV_Read2.Active:=false;
    ZV_Read2.Active:=true;
    ZV_Read2.Filtered:=false;
    ZV_Read2.Filter:='docid='''+RGrid.DataSource.DataSet.FieldByName('id').AsString+'''';
    ZV_Read2.Filtered:=true;
    Panel27.Align:=alClient;
    Panel27.Visible:=true;
    try
      ZV_TD_Query.Active:=false;
      ZV_TD_Query.SQL.Clear;
      ZV_TD_Query.SQL.Add('select * from zv_td where id='''+MainForm.doc_num+'''');
      ZV_TD_Query.Active:=true;
    except
    end;
    if ZV_TD_Query.FieldByName('status').AsString='��������' then
    begin
      MainForm.BitBtn29.Enabled:=true;
      MainForm.BitBtn30.Enabled:=true;
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
  except
  end;
end;

procedure TMainForm.RoomChange(Sender: TObject);
begin
  //ChatBit.Click;
end;

procedure TMainForm.RoomKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_F12 then
  begin
    f121.Click;
  end;
  if key=VK_RETURN then
  begin
    //BitBtn7.Click;
  end;
end;

procedure TMainForm.RoomKeyPress(Sender: TObject; var Key: Char);
begin
  if key<>#13 then key:=#0;
end;

procedure TMainForm.SaveReg;
var
   Registry: TRegistry;
begin
   Registry := TRegistry.Create;
   Registry.RootKey := hkey_current_user;
   Registry.OpenKey('software\Info',true);
   Registry.WriteString('LeftPanel',IntToStr(Panel2.Width));
   Registry.WriteString('ButtomPanel',IntToStr(Panel12.Height));
   Registry.CloseKey;
   Registry.Free;
end;

procedure TMainForm.SearchClick(Sender: TObject);
var i,k,e, count:integer; tmp,temp:array of string; filtered:string;
    getid, cardid, clientid, sur_name, name, patronymic:string; dir:string; tmpf:string; zpcart:string; zpc_place:string; List:TStringList;
begin
  if checkbox3.Checked=true then
  begin
    if FindEdit.Text<>'' then
    begin
      if length(FindEdit.Text)=6 then
      begin
        FindEdit.Text:='4000000'+FindEdit.Text;
      end;
      if Client.Active=true then
      begin
        try
          Client.Socket.SendText('card='+FindEdit.Text);
        except
        end;
      end
      else
      begin
        try
          Client.Active:=true;
          Client.Open;
          Client.Socket.SendText('card='+FindEdit.Text);
        except
        end;
      end;
    end;
    FindEdit.SetFocus;
    FindEdit.SelLength:=0;
    FindEdit.SelStart:=Length(FindEdit.Text);
    Exit;
  end;
  if ((checkbox1.Checked=true) or (checkbox2.Checked=true)) then
  begin
    if f12=true then
    begin
      Scaner.Caption:='Price Checker: ';
      Scaner.Find(FindEdit.Text);
      Application.ProcessMessages;
      Scaner.Show;
      Scaner.Finder.SetFocus;
      f12:=false;
      //FindEdit.Text:='';
      //FindEdit.SetFocus;
      //FindEdit.SelLength:=0;
      //FindEdit.SelStart:=Length(FindEdit.Text);
      Exit;
      {
      else
      begin
        FindEdit.Text:=FindEdit.Text+' ';
        FindEdit.SelStart:=Length(FindEdit.Text);
        Exit;
      end;
      }
    end;
    if f12_ext=true then
    begin
      FindEdit.SelStart:=Length(FindEdit.Text);
      Exit;
    end;
    if FindEdit.Text='' then
    begin
      FindEdit.SetFocus;
      FindEdit.SelLength:=0;
      FindEdit.SelStart:=Length(FindEdit.Text);
      Exit;
    end
    else
    begin
      filtered:=FindEdit.Text;
      for i := length(filtered) downto 2 do
      begin
        if (filtered[i]=' ') and (filtered[i-1]=' ') then
          delete(filtered,i,1);
      end;
      if filtered[length(filtered)]<>#32 then filtered:=filtered+#32;
    end;
    FindEdit.Text:=filtered;
    if Search.Caption='[ ������ ]' then
    begin
      if (group='') then SNode:=TreeView.Items[0];
      TreeView.OnChange(self, SNode);
      TreeView.SetFocus;
      FindEdit.SetFocus;
      FindEdit.SelLength:=0;
      FindEdit.SelStart:=Length(FindEdit.Text);
      Exit;
    end;

    i:=1;
    k:=0;
    while i<>length(FindEdit.Text)+1 do
    begin
      if copy(FindEdit.Text, i, 1)=' ' then
      begin
        inc(k);
      end;
      inc(i);
    end;
    SetLength(tmp, k);

    i:=1;
    k:=0;
    while i<>length(FindEdit.Text)+1 do
    begin
      if copy(FindEdit.Text, i ,1)<>#32 then
      begin
        tmp[k]:=tmp[k]+copy(FindEdit.Text, i, 1);
      end
      else inc(k);
      inc(i);
    end;

    k:=0;
    e:=0;
    while k<>length(tmp) do
    begin
      if tmp[k]<>'' then
      begin
        inc(e);
      end;
      inc(k);
    end;

    if RadioButton5.Checked=true then
    begin
      try
        TreeSet.Active:=false;
        TreeSet.CommandText:='select DISTINCT d.article, c.name, c.mesabbrev as mesname, c.country, DECODE(c.accepted, ''1'', ''�������'', ''2'', ''���������'', ''�����'') as accepted, ';
        TreeSet.CommandText:=TreeSet.CommandText + 'DECODE(c.datatype, ''0'', ''�����'', ''1'', ''������'', ''2'', ''������'', ''3'', ''����'', ''4'', ''���������'', ''5'', ''�����'', ''#�/�'') as datatype, s.tree, s.name as gname ';
        TreeSet.CommandText:=TreeSet.CommandText + 'from smspec d, smdocuments p, supermag.smclientinfo u, smcard c, sacardclass s ';
        TreeSet.CommandText:=TreeSet.CommandText + 'where p.id = d.docid(+) ';
        TreeSet.CommandText:=TreeSet.CommandText + 'and u.id = p.clientindex ';
        TreeSet.CommandText:=TreeSet.CommandText + 'and d.article = c.article ';
        TreeSet.CommandText:=TreeSet.CommandText + 'and s.id = c.idclass ';
        TreeSet.CommandText:=TreeSet.CommandText + 'and d.doctype = ''WI'' ';
        TreeSet.CommandText:=TreeSet.CommandText + 'and upper(u.name) like upper(''%'+copy(FindEdit.Text, 1, length(FindEdit.Text)-1)+'%'') ';
        TreeSet.Active:=true;
        DBGrid1.Enabled:=true;
      except
        //on E:Exception do ShowMessage(E.Message);
      end;
      Cartoons.Caption:='�������� ��������: '+IntToStr(TreeSet.RecordCount);
      //Exit;
    end;

    if RadioButton4.Checked=true then
    begin
      try
        if (Access.Connected = false) then Access.Connected:=true;
      except
        FindEdit.SetFocus;
        FindEdit.SelLength:=0;
        FindEdit.SelStart:=Length(FindEdit.Text);
        Exit;
      end;
      try
        if (FindEdit.Text='') then exit;

        filtered:='';
        i:=0;
        while i<>length(tmp) do
        begin
          filtered:=filtered+'clPlace like '+#39+'%'+tmp[i]+'%'+#39+' or ';
          inc(i);
        end;
        filtered:=copy(filtered, 1, length(filtered)-3);
      except
      end;

      if filtered<>'' then
      begin
        try
          Place_Query.Active:=false;
          Place_Query.SQL.Clear;
          Place_Query.SQL.Add('select clStrihkod from tblNaserver where '+filtered);
          //ShowMessage(Place_Query.SQL.CommaText);
          Place_Query.Active:=true;
        except
        end;
        tmpf:='';
        try
          if Place_Query.RecordCount>0 then
          begin
            try
              Place_Query.First;
              while not Place_Query.Eof do
              begin
                tmpf:=tmpf+#39+Place_Query.FieldByName('clStrihkod').AsString+#39+', ';
                Place_Query.Next;
              end;
              tmpf:=copy(tmpf, 1, length(tmpf)-2);
            except
            end;
            try
              MainForm.TreeView.OnChange(nil,MainForm.TreeView.Items.GetFirstNode);
              try
                BarcodeSet.Active:=false;
                BarcodeSet.CommandText:='select s.article, s.barcode from supermag.smstoreunits s where barcode in ('+tmpf+')';
                BarcodeSet.Active:=true;
              except
                //On E:Exception do ShowMessage('������ x'+IntToStr(E.HelpContext)+': '+E.Message+'.');
              end;
              filtered:='';
              BarcodeSet.First;
              while not BarcodeSet.Eof do
              begin
                filtered:=filtered+#39+BarcodeSet.FieldByName('article').AsString+#39+', ';
                BarcodeSet.Next;
              end;
              try
                filtered:=copy(filtered, 1, length(filtered)-2);
              except
              end;
              //ShowMessage(filtered);
              if filtered='' then
              begin
                //ShowMessage('��� ������ �� ����� ������� �����������!'+#13+'���������� ��������� ����� ������� ����� ������� ��� ������ �������.');
                FindEdit.SetFocus;
                FindEdit.SelLength:=0;
                FindEdit.SelStart:=Length(FindEdit.Text);
                Exit;
              end;
              try
                TreeSet.Active:=false;
                TreeSet.CommandText:='select d.article, d.name, d.mesabbrev as mesname, d.country, DECODE(accepted, ''1'', ''�������'', ''2'', ''���������'', ''�����'') as accepted, ';
                TreeSet.CommandText:=TreeSet.CommandText+'DECODE(datatype, ''0'', ''�����'', ''1'', ''������'', ''2'', ''������'', ''3'', ''����'', ''4'', ''���������'', ''5'', ''�����'', ''#�/�'') as datatype, s.tree, s.name as gname from supermag.smcard d, supermag.sacardclass s WHERE s.id = d.idclass and accepted=1 and d.article in ('+filtered+')';
                //ShowMessage('#1: '+TreeSet.CommandText);
                TreeSet.Active:=true;
              except
              end;
              Cartoons.Caption:='�������� ��������: '+IntToStr(TreeSet.RecordCount);
              if TreeSet.RecordCount=0 then
              begin
                DBGrid1.Enabled:=false;
                //ShowMessage('��� ������ �� ����� ������� �����������!'+#13+'���������� ��������� ����� ������� ����� ������� ��� ������ �������.');
              end
              else
              begin
                DBGrid1.Enabled:=true;
              end;
              //Filter.Caption:='[������]';
              Search.Caption:='[ ������ ]';
            except
            end;
          end;
        except
        end;
      end;
    end;

    //�� �������
    if RadioButton1.Checked=true then
    begin
      count:=e;
      SetLength(temp, e);
      k:=0;
      e:=0;
      while k<>length(tmp) do
      begin
        if tmp[k]<>'' then
        begin
          temp[e]:=#39+tmp[k]+#39+', ';
          i:=e;
          inc(e);
        end;
        inc(k);
      end;
      temp[i]:=copy(temp[i], 1,length(temp[i])-2);
      if length(temp)>1 then
      begin
        k:=0;
        filtered:='';
        while k<>length(temp) do
        begin
          filtered:=filtered+temp[k];
          inc(k);
        end;
        try
          if ToggleAct.State=TToggleSwitchState.tssOff then
          begin
            if group='' then
            begin
              try
                TreeSet.Active:=false;
                TreeSet.CommandText:='select d.article, d.name, d.mesabbrev as mesname, d.country, DECODE(accepted, ''1'', ''�������'', ''2'', ''���������'', ''�����'') as accepted, ';
                TreeSet.CommandText:=TreeSet.CommandText+'DECODE(datatype, ''0'', ''�����'', ''1'', ''������'', ''2'', ''������'', ''3'', ''����'', ''4'', ''���������'', ''5'', ''�����'', ''#�/�'') as datatype, s.tree, s.name as gname from supermag.smcard d, supermag.sacardclass s WHERE s.id = d.idclass and accepted=1 and d.article in ('+filtered+')';
                TreeSet.Active:=true;
              except
              end;
            end
            else
            begin
              try
                TreeSet.Active:=false;
                TreeSet.CommandText:='select d.article, d.name, d.mesabbrev as mesname, d.country, DECODE(accepted, ''1'', ''�������'', ''2'', ''���������'', ''�����'') as accepted, ';
                TreeSet.CommandText:=TreeSet.CommandText+'DECODE(datatype, ''0'', ''�����'', ''1'', ''������'', ''2'', ''������'', ''3'', ''����'', ''4'', ''���������'', ''5'', ''�����'', ''#�/�'') as datatype, s.tree, s.name as gname from supermag.smcard d, supermag.sacardclass s WHERE s.id = d.idclass and accepted=1 and d.article in ('+filtered+') and s.tree like '+#39+group+'%'+#39;
                TreeSet.Active:=true;
              except
              end;
            end;
          end
          else
          begin
            if group='' then
            begin
              try
                TreeSet.Active:=false;
                TreeSet.CommandText:='select d.article, d.name, d.mesabbrev as mesname, d.country, DECODE(accepted, ''1'', ''�������'', ''2'', ''���������'', ''�����'') as accepted, ';
                TreeSet.CommandText:=TreeSet.CommandText+'DECODE(datatype, ''0'', ''�����'', ''1'', ''������'', ''2'', ''������'', ''3'', ''����'', ''4'', ''���������'', ''5'', ''�����'', ''#�/�'') as datatype, s.tree, s.name as gname from supermag.smcard d, supermag.sacardclass s WHERE s.id = d.idclass and d.article in ('+filtered+')';
                TreeSet.Active:=true;
              except
              end;
            end
            else
            begin
              try
                TreeSet.Active:=false;
                TreeSet.CommandText:='select d.article, d.name, d.mesabbrev as mesname, d.country, DECODE(accepted, ''1'', ''�������'', ''2'', ''���������'', ''�����'') as accepted, ';
                TreeSet.CommandText:=TreeSet.CommandText+'DECODE(datatype, ''0'', ''�����'', ''1'', ''������'', ''2'', ''������'', ''3'', ''����'', ''4'', ''���������'', ''5'', ''�����'', ''#�/�'') as datatype, s.tree, s.name as gname from supermag.smcard d, supermag.sacardclass s WHERE s.id = d.idclass and d.article in ('+filtered+') and s.tree like '+#39+group+'%'+#39;
                TreeSet.Active:=true;
              except
              end;
            end;
          end;
        except
        end;
      end
      else
      begin
        SetLength(temp, 0);
        SetLength(temp, count);
        k:=0;
        e:=0;
        while k<>length(tmp) do
        begin
          if tmp[k]<>'' then
          begin
            temp[e]:='%'+tmp[k];
            i:=e;
            inc(e);
          end;
          inc(k);
        end;
        //temp[i]:=copy(temp[i], 1,length(temp[i])-2);
        k:=0;
        filtered:='';
        while k<>length(temp) do
        begin
          filtered:=filtered+temp[k];
          inc(k);
        end;
        try
          if ToggleAct.State=TToggleSwitchState.tssOff then
          begin
            if group='' then
            begin
              try
                TreeSet.Active:=false;
                TreeSet.CommandText:='select d.article, d.name, d.mesabbrev as mesname, d.country, DECODE(accepted, ''1'', ''�������'', ''2'', ''���������'', ''�����'') as accepted, ';
                TreeSet.CommandText:=TreeSet.CommandText+'DECODE(datatype, ''0'', ''�����'', ''1'', ''������'', ''2'', ''������'', ''3'', ''����'', ''4'', ''���������'', ''5'', ''�����'', ''#�/�'') as datatype, s.tree, s.name as gname ';
                TreeSet.CommandText:=TreeSet.CommandText+'from supermag.smcard d, supermag.sacardclass s WHERE s.id = d.idclass and accepted=1 and d.article like '''+filtered+'''';
                TreeSet.Active:=true;
              except
              end;
            end
            else
            begin
              try
                TreeSet.Active:=false;
                TreeSet.CommandText:='select d.article, d.name, d.mesabbrev as mesname, d.country, DECODE(accepted, ''1'', ''�������'', ''2'', ''���������'', ''�����'') as accepted, ';
                TreeSet.CommandText:=TreeSet.CommandText+'DECODE(datatype, ''0'', ''�����'', ''1'', ''������'', ''2'', ''������'', ''3'', ''����'', ''4'', ''���������'', ''5'', ''�����'', ''#�/�'') as datatype, s.tree, s.name as gname ';
                TreeSet.CommandText:=TreeSet.CommandText+'from supermag.smcard d, supermag.sacardclass s WHERE s.id = d.idclass and accepted=1 and d.article like '''+filtered+''' and s.tree like '+#39+group+'%'+#39;
                TreeSet.Active:=true;
              except
              end;
            end;
          end
          else
          begin
            if group='' then
            begin
              try
                TreeSet.Active:=false;
                TreeSet.CommandText:='select d.article, d.name, d.mesabbrev as mesname, d.country, DECODE(accepted, ''1'', ''�������'', ''2'', ''���������'', ''�����'') as accepted, ';
                TreeSet.CommandText:=TreeSet.CommandText+'DECODE(datatype, ''0'', ''�����'', ''1'', ''������'', ''2'', ''������'', ''3'', ''����'', ''4'', ''���������'', ''5'', ''�����'', ''#�/�'') as datatype, s.tree, s.name as gname from supermag.smcard d, supermag.sacardclass s WHERE s.id = d.idclass and d.article like '''+filtered+'''';
                TreeSet.Active:=true;
              except
              end;
            end
            else
            begin
              try
                TreeSet.Active:=false;
                TreeSet.CommandText:='select d.article, d.name, d.mesabbrev as mesname, d.country, DECODE(accepted, ''1'', ''�������'', ''2'', ''���������'', ''�����'') as accepted, ';
                TreeSet.CommandText:=TreeSet.CommandText+'DECODE(datatype, ''0'', ''�����'', ''1'', ''������'', ''2'', ''������'', ''3'', ''����'', ''4'', ''���������'', ''5'', ''�����'', ''#�/�'') as datatype, s.tree, s.name as gname from supermag.smcard d, supermag.sacardclass s WHERE s.id = d.idclass and d.article like '''+filtered+''' and s.tree like '+#39+group+'%'+#39;
                TreeSet.Active:=true;
              except
              end;
            end;
          end;
        except
        end;
      end;
      Cartoons.Caption:='�������� ��������: '+IntToStr(TreeSet.RecordCount);

      if TreeSet.RecordCount=0 then
      begin
        DBGrid1.Enabled:=false;
        //ShowMessage('��� ������ �� ����� ������� �����������!'+#13+'���������� ��������� ����� ������� ����� ������� ��� ������ �������.');
      end
      else
      begin
        DBGrid1.Enabled:=true;
      end;
      //Filter.Caption:='[������]';
      Search.Caption:='[ ������ ]';
    end;

    //�� ���������
    if RadioButton2.Checked=true then
    begin
      filtered:='';
      k:=0;
      if length(tmp)>1 then
      begin
        while k<>length(tmp) do
        begin
          filtered:=filtered+#39+tmp[k]+#39+', ';
          inc(k);
        end;
        try
          filtered:=copy(filtered, 1, length(filtered)-2);
        except
        end;
        try
          BarcodeSet.Active:=false;
          BarcodeSet.CommandText:='select s.article, s.barcode from supermag.smstoreunits s where barcode in ('+filtered+')';
          BarcodeSet.Active:=true;
        except
          //On E:Exception do ShowMessage('������ x'+IntToStr(E.HelpContext)+': '+E.Message+'.');
        end;
        filtered:='';
        BarcodeSet.First;
        while not BarcodeSet.Eof do
        begin
          filtered:=filtered+#39+BarcodeSet.FieldByName('article').AsString+#39+', ';
          BarcodeSet.Next;
        end;
        try
          filtered:=copy(filtered, 1, length(filtered)-2);
        except
        end;
        //ShowMessage(filtered);
        if filtered='' then
        begin
          //ShowMessage('��� ������ �� ����� ������� �����������!'+#13+'���������� ��������� ����� ������� ����� ������� ��� ������ �������.');
          Exit;
        end;

        try
          if ToggleAct.State=TToggleSwitchState.tssOff then
          begin
            if group='' then
            begin
              TreeSet.Active:=false;
              TreeSet.CommandText:='select d.article, d.name, d.mesabbrev as mesname, d.country, DECODE(accepted, ''1'', ''�������'', ''2'', ''���������'', ''�����'') as accepted, ';
              TreeSet.CommandText:=TreeSet.CommandText+'DECODE(datatype, ''0'', ''�����'', ''1'', ''������'', ''2'', ''������'', ''3'', ''����'', ''4'', ''���������'', ''5'', ''�����'', ''#�/�'') as datatype, s.tree, s.name as gname from supermag.smcard d, supermag.sacardclass s WHERE s.id = d.idclass and accepted=1 and d.article in ('+filtered+')';
              //ShowMessage('#1: '+TreeSet.CommandText);
              TreeSet.Active:=true;
            end
            else
            begin
              TreeSet.Active:=false;
              TreeSet.CommandText:='select d.article, d.name, d.mesabbrev as mesname, d.country, DECODE(accepted, ''1'', ''�������'', ''2'', ''���������'', ''�����'') as accepted, ';
              TreeSet.CommandText:=TreeSet.CommandText+'DECODE(datatype, ''0'', ''�����'', ''1'', ''������'', ''2'', ''������'', ''3'', ''����'', ''4'', ''���������'', ''5'', ''�����'', ''#�/�'') as datatype, s.tree, s.name as gname from supermag.smcard d, supermag.sacardclass s WHERE s.id = d.idclass and accepted=1 and d.article in ('+filtered+') and s.tree like '+#39+group+'%'+#39;
              //ShowMessage('#2: '+TreeSet.CommandText);
              TreeSet.Active:=true;
            end;
          end
          else
          begin
            if group='' then
            begin
              TreeSet.Active:=false;
              TreeSet.CommandText:='select d.article, d.name, d.mesabbrev as mesname, d.country, DECODE(accepted, ''1'', ''�������'', ''2'', ''���������'', ''�����'') as accepted, ';
              TreeSet.CommandText:=TreeSet.CommandText+'DECODE(datatype, ''0'', ''�����'', ''1'', ''������'', ''2'', ''������'', ''3'', ''����'', ''4'', ''���������'', ''5'', ''�����'', ''#�/�'') as datatype, s.tree, s.name as gname from supermag.smcard d, supermag.sacardclass s WHERE s.id = d.idclass and d.article in ('+filtered+')';
              //ShowMessage('#3: '+TreeSet.CommandText);
              TreeSet.Active:=true;
            end
            else
            begin
              TreeSet.Active:=false;
              TreeSet.CommandText:='select d.article, d.name, d.mesabbrev as mesname, d.country, DECODE(accepted, ''1'', ''�������'', ''2'', ''���������'', ''�����'') as accepted, ';
              TreeSet.CommandText:=TreeSet.CommandText+'DECODE(datatype, ''0'', ''�����'', ''1'', ''������'', ''2'', ''������'', ''3'', ''����'', ''4'', ''���������'', ''5'', ''�����'', ''#�/�'') as datatype, s.tree, s.name as gname from supermag.smcard d, supermag.sacardclass s WHERE s.id = d.idclass and d.article in ('+filtered+') and s.tree like '+#39+group+'%'+#39;
              //ShowMessage('#4: '+TreeSet.CommandText);
              TreeSet.Active:=true;
            end;
          end;
        except
        end;
      end
      else
      begin
        filtered:='';
        filtered:='%'+tmp[k];
        try
          BarcodeSet.Active:=false;
          BarcodeSet.CommandText:='select s.article, s.barcode from supermag.smstoreunits s where barcode like '''+filtered+'''';
          BarcodeSet.Active:=true;
        except
          //On E:Exception do ShowMessage('������ x'+IntToStr(E.HelpContext)+': '+E.Message+'.');
        end;
        filtered:='';
        BarcodeSet.First;
        while not BarcodeSet.Eof do
        begin
          filtered:=filtered+#39+BarcodeSet.FieldByName('article').AsString+#39+', ';
          BarcodeSet.Next;
        end;
        try
          filtered:=copy(filtered, 1, length(filtered)-2);
        except
        end;
        //ShowMessage(filtered);
        if filtered='' then
        begin
          //ShowMessage('��� ������ �� ����� ������� �����������!'+#13+'���������� ��������� ����� ������� ����� ������� ��� ������ �������.');
          Exit;
        end;

        try
          if ToggleAct.State=TToggleSwitchState.tssOff then
          begin
            if group='' then
            begin
              TreeSet.Active:=false;
              TreeSet.CommandText:='select d.article, d.name, d.mesabbrev as mesname, d.country, DECODE(accepted, ''1'', ''�������'', ''2'', ''���������'', ''�����'') as accepted, ';
              TreeSet.CommandText:=TreeSet.CommandText+'DECODE(datatype, ''0'', ''�����'', ''1'', ''������'', ''2'', ''������'', ''3'', ''����'', ''4'', ''���������'', ''5'', ''�����'', ''#�/�'') as datatype, s.tree, s.name as gname from supermag.smcard d, supermag.sacardclass s WHERE s.id = d.idclass and accepted=1 and d.article in ('+filtered+')';
              //ShowMessage('#1: '+TreeSet.CommandText);
              TreeSet.Active:=true;
            end
            else
            begin
              TreeSet.Active:=false;
              TreeSet.CommandText:='select d.article, d.name, d.mesabbrev as mesname, d.country, DECODE(accepted, ''1'', ''�������'', ''2'', ''���������'', ''�����'') as accepted, ';
              TreeSet.CommandText:=TreeSet.CommandText+'DECODE(datatype, ''0'', ''�����'', ''1'', ''������'', ''2'', ''������'', ''3'', ''����'', ''4'', ''���������'', ''5'', ''�����'', ''#�/�'') as datatype, s.tree, s.name as gname from supermag.smcard d, supermag.sacardclass s WHERE s.id = d.idclass and accepted=1 and d.article in ('+filtered+') and s.tree like '+#39+group+'%'+#39;
              //ShowMessage('#2: '+TreeSet.CommandText);
              TreeSet.Active:=true;
            end;
          end
          else
          begin
            if group='' then
            begin
              TreeSet.Active:=false;
              TreeSet.CommandText:='select d.article, d.name, d.mesabbrev as mesname, d.country, DECODE(accepted, ''1'', ''�������'', ''2'', ''���������'', ''�����'') as accepted, ';
              TreeSet.CommandText:=TreeSet.CommandText+'DECODE(datatype, ''0'', ''�����'', ''1'', ''������'', ''2'', ''������'', ''3'', ''����'', ''4'', ''���������'', ''5'', ''�����'', ''#�/�'') as datatype, s.tree, s.name as gname from supermag.smcard d, supermag.sacardclass s WHERE s.id = d.idclass and d.article in ('+filtered+')';
              //ShowMessage('#3: '+TreeSet.CommandText);
              TreeSet.Active:=true;
            end
            else
            begin
              TreeSet.Active:=false;
              TreeSet.CommandText:='select d.article, d.name, d.mesabbrev as mesname, d.country, DECODE(accepted, ''1'', ''�������'', ''2'', ''���������'', ''�����'') as accepted, ';
              TreeSet.CommandText:=TreeSet.CommandText+'DECODE(datatype, ''0'', ''�����'', ''1'', ''������'', ''2'', ''������'', ''3'', ''����'', ''4'', ''���������'', ''5'', ''�����'', ''#�/�'') as datatype, s.tree, s.name as gname from supermag.smcard d, supermag.sacardclass s WHERE s.id = d.idclass and d.article in ('+filtered+') and s.tree like '+#39+group+'%'+#39;
              //ShowMessage('#4: '+TreeSet.CommandText);
              TreeSet.Active:=true;
            end;
          end;
        except
        end;
      end;
      Cartoons.Caption:='�������� ��������: '+IntToStr(TreeSet.RecordCount);

      if TreeSet.RecordCount=0 then
      begin
        DBGrid1.Enabled:=false;
        //ShowMessage('��� ������ �� ����� ������� �����������!'+#13+'���������� ��������� ����� ������� ����� ������� ��� ������ �������.');
      end
      else
      begin
        DBGrid1.Enabled:=true;
      end;
      Search.Caption:='[ ������ ]';
    end;

    //�� ������������
    if RadioButton3.Checked=true then
    begin
      SetLength(temp, e);
      k:=0;
      e:=0;
      while k<>length(tmp) do
      begin
        if tmp[k]<>'' then
        begin
          temp[e]:='LOWER(d.name) like '+#39+'%'+AnsiLowerCase(tmp[k])+'%'+#39+' and ';
          i:=e;
          inc(e);
        end;
        inc(k);
      end;
      temp[i]:=copy(temp[i], 1,length(temp[i])-5);
      k:=0;
      filtered:='';
      while k<>length(temp) do
      begin
        filtered:=filtered+temp[k];
        inc(k);
      end;
      filtered:=' '+filtered;

      try
        if ToggleAct.State=TToggleSwitchState.tssOff then
        begin
          if group='' then
          begin
            TreeSet.Active:=false;
            TreeSet.CommandText:='select d.article, d.name, d.mesabbrev as mesname, d.country, DECODE(accepted, ''1'', ''�������'', ''2'', ''���������'', ''�����'') as accepted, ';
            TreeSet.CommandText:=TreeSet.CommandText+'DECODE(datatype, ''0'', ''�����'', ''1'', ''������'', ''2'', ''������'', ''3'', ''����'', ''4'', ''���������'', ''5'', ''�����'', ''#�/�'') as datatype, s.tree, s.name as gname from supermag.smcard d, supermag.sacardclass s WHERE s.id = d.idclass and accepted=1 and '+filtered;
            TreeSet.Active:=true;
          end
          else
          begin
            TreeSet.Active:=false;
            TreeSet.CommandText:='select d.article, d.name, d.mesabbrev as mesname, d.country, DECODE(accepted, ''1'', ''�������'', ''2'', ''���������'', ''�����'') as accepted, ';
            TreeSet.CommandText:=TreeSet.CommandText+'DECODE(datatype, ''0'', ''�����'', ''1'', ''������'', ''2'', ''������'', ''3'', ''����'', ''4'', ''���������'', ''5'', ''�����'', ''#�/�'') as datatype, s.tree, s.name as gname from supermag.smcard d, supermag.sacardclass s WHERE s.id = d.idclass and accepted=1 and '+filtered+' and s.tree like '+#39+group+'%'+#39;
            TreeSet.Active:=true;
          end;
        end
        else
        begin
          if group='' then
          begin
            TreeSet.Active:=false;
            TreeSet.CommandText:='select d.article, d.name, d.mesabbrev as mesname, d.country, DECODE(accepted, ''1'', ''�������'', ''2'', ''���������'', ''�����'') as accepted, ';
            TreeSet.CommandText:=TreeSet.CommandText+'DECODE(datatype, ''0'', ''�����'', ''1'', ''������'', ''2'', ''������'', ''3'', ''����'', ''4'', ''���������'', ''5'', ''�����'', ''#�/�'') as datatype, s.tree, s.name as gname from supermag.smcard d, supermag.sacardclass s WHERE s.id = d.idclass and '+filtered;
            TreeSet.Active:=true;
          end
          else
          begin
            TreeSet.Active:=false;
            TreeSet.CommandText:='select d.article, d.name, d.mesabbrev as mesname, d.country, DECODE(accepted, ''1'', ''�������'', ''2'', ''���������'', ''�����'') as accepted, ';
            TreeSet.CommandText:=TreeSet.CommandText+'DECODE(datatype, ''0'', ''�����'', ''1'', ''������'', ''2'', ''������'', ''3'', ''����'', ''4'', ''���������'', ''5'', ''�����'', ''#�/�'') as datatype, s.tree, s.name as gname from supermag.smcard d, supermag.sacardclass s WHERE s.id = d.idclass and '+filtered+' and s.tree like '+#39+group+'%'+#39;
            TreeSet.Active:=true;
          end;
        end;
      except
      end;
      Cartoons.Caption:='�������� ��������: '+IntToStr(TreeSet.RecordCount);

      if TreeSet.RecordCount=0 then
      begin
        DBGrid1.Enabled:=false;
        //ShowMessage('��� ������ �� ����� ������� �����������!'+#13+'���������� ��������� ����� ������� ����� ������� ��� ������ �������.');
      end
      else
      begin
        DBGrid1.Enabled:=true;
      end;
      //Filter.Caption:='[������]';
      Search.Caption:='[ ������ ]';
    end;
  end;
  if checkbox4.Checked=true then
  begin
    if FindEdit.Text<>'' then
    begin
      FindEdit.Text:=ClearField(FindEdit.Text);
      {
      if length(FindEdit.Text)=12 then
      begin
        FindEdit.Text:=copy(FindEdit.Text, 5, 7);
      end;
      }
      try
        OraZPC.Active:=false;
        OraZPC.SQL.Clear;
        OraZPC.SQL.Add('select s.article, d.location, max(d.id) as zpc, max(sb.barcode) as barcode, max(c.name) as getter, max(l.name) as sender, max(ds.shortname) as name, max(s.quantity) as quan, max(ds.mesname) as edism, max(gs.quantity) as ost ');
        OraZPC.SQL.Add('FROM SMDateDocs a, smdocuments d, smclientinfo c, smstorelocations l, smspec s, smcard ds, (select g.article, sum(g.quantity) as quantity, g.storeloc from smgoods g group by g.article, g.storeloc) gs, smstoreunits sb ');
        OraZPC.SQL.Add('where a.id = ''���'+FindEdit.Text+''' ');
        OraZPC.SQL.Add('and d.id = a.id ');
        OraZPC.SQL.Add('and c.id = a.ourselfclient ');
        OraZPC.SQL.Add('and d.location = l.id ');
        OraZPC.SQL.Add('and gs.storeloc = d.location ');
        OraZPC.SQL.Add('and s.docid = d.id ');
        OraZPC.SQL.Add('and ds.article = s.article ');
        OraZPC.SQL.Add('and sb.article = s.article ');
        OraZPC.SQL.Add('and gs.article = s.article ');
        OraZPC.SQL.Add('group by s.article, d.location ');
        OraZPC.Active:=true;
        try
          ZPC_Query.Active:=false;
          ZPC_Query.SQL.Clear;
          ZPC_Query.SQL.Add('delete from zpc where groupid='''+Auth.groupid+'''');
          ZPC_Query.ExecSQL;
        except
          On E:Exception do ShowMessage('������ [1]: '+E.Message);
        end;
        if OraZPC.RecordCount>0 then
        begin
          while not OraZPC.Eof do
          begin

            try
              BarcodeSet.Active:=false;
              BarcodeSet.CommandText:='select d.article, s.barcode from supermag.smstoreunits s, supermag.smcard d where d.article = s.article and d.article='''+OraZPC.FieldByName('article').AsString+'''';
              BarcodeSet.Active:=true;
            except
              //on E:Exception do ShowMessage('������ 0cv2324x354343: '+E.Message);
            end;

            Application.ProcessMessages;
            try
              if (Access.Connected=false) then
              begin
                Access.Connected:=true;
              end;
              if (Access.Connected) then
              begin
                clPlace.Items.Clear;
                zpc_place:='';
                DBGrid2.DataSource.DataSet.First;
                while not DBGrid2.DataSource.DataSet.Eof do
                begin
                  Place_Query.Active:=false;
                  Place_Query.SQL.Clear;
                  Place_Query.SQL.Add('select clPlace from tblNaserver where clStrihkod='''+DBGrid2.DataSource.DataSet.FieldByName('barcode').AsString+'''');
                  Place_Query.Active:=true;
                  Place_Query.First;
                  while not Place_Query.Eof do
                  begin
                    zpc_place:=zpc_place+Place_Query.FieldByName('clPlace').AsString+';';
                    Place_Query.Next;
                  end;
                  DBGrid2.DataSource.DataSet.Next;
                end;

                List:=TStringList.Create;
                List.Duplicates:=dupIgnore;
                List.Delimiter:=';';
                List.DelimitedText:=zpc_place;
                zpc_place:='';
                i:=0;
                while i<>List.Count do
                begin
                  if List.Strings[i]<>'' then
                  begin
                    if (clPlace.Items.IndexOf(List.Strings[i])=-1) then
                    begin
                      clPlace.Items.Add(List.Strings[i]);
                      zpc_place:=zpc_place+List.Strings[i]+';';
                    end;
                  end;
                  inc(i);
                end;

              end;
            except
            end;

            try
              ZPC_Query.Active:=false;
              ZPC_Query.SQL.Clear;
              ZPC_Query.SQL.Add('insert into zpc(zpc_num, barcode, sender, getter, article, name, quan, edism, ost, clPlace, groupid) values('''+OraZPC.FieldByName('zpc').AsString+''', '''+OraZPC.FieldByName('barcode').AsString+''', '''+OraZPC.FieldByName('sender').AsString+''', '''+OraZPC.FieldByName('getter').AsString+''', '''+OraZPC.FieldByName('article').AsString+''', '''+ClearSQL(OraZPC.FieldByName('name').AsString)+''', '''+OraZPC.FieldByName('quan').AsString+''', '''+OraZPC.FieldByName('edism').AsString+''', '''+OraZPC.FieldByName('ost').AsString+''', '''+zpc_place+''', '''+Auth.groupid+''')');
              ZPC_Query.ExecSQL;
            except
              On E:Exception do ShowMessage('������ [3]: '+E.Message);
            end;
            OraZPC.Next;
          end;
          try
            ZPC_Query.Active:=false;
            ZPC_Query.SQL.Clear;
            ZPC_Query.SQL.Add('select * from zpc where groupid='''+Auth.groupid+''' order by name');
            ZPC_Query.Active:=true;
          except
            On E:Exception do ShowMessage('������ [4]: '+E.Message);
          end;
        end;
        FindEdit.SetFocus;
        FindEdit.SelLength:=0;
        FindEdit.SelStart:=Length(FindEdit.Text);
      except
        On E:Exception do
        begin
          ShowMessage('������ [4]: '+E.Message);
          Exit;
        end;
      end;
      try
        dir:=ExtractFilePath(ParamStr(0));
        ZPCReport.LoadFromFile(dir+'FR\ZPC.fr3');
        ZPCReport.PrintOptions.ShowDialog:=true;
        ZPCReport.PrepareReport(true);
        ZPCReport.ShowPreparedReport;
        ZPCReport.Clear;
      except
        ShowMessage('����� ������ �������� � �������.');
        FindEdit.SetFocus;
        FindEdit.SelLength:=0;
        FindEdit.SelStart:=Length(FindEdit.Text);
        Exit;
      end;
    end;
    FindEdit.SetFocus;
    FindEdit.SelLength:=0;
    FindEdit.SelStart:=Length(FindEdit.Text);
    Exit;
  end;
end;

procedure TMainForm.SendEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_F12 then
  begin
    f121.Click;
  end;
  if key=VK_RETURN then
  begin
    //BitBtn7.Click;
  end;
end;

function TMainForm.SetPoint(value: string): string;
var temp:string; i:integer;
begin
  i:=1;
  temp:='';
  while i<=length(value) do
  begin
    if copy(value, i, 1)<>',' then temp:=temp+copy(value, i, 1) else temp:=temp+'.';
    inc(i);
  end;
  if temp<>'' then
  begin
    Result:=temp;
  end
  else Result:='0';
end;

procedure TMainForm.ShowG;
begin
  MainForm.Show;
end;

function TMainForm.SQLString(value: string): string;
var i:integer;   tmp:string; ext:boolean;
begin
  tmp:='';
  i:=1;
  while i<=length(value) do
  begin
    ext:=false;
    if copy(value, i, 1)='''' then
    begin
      tmp:=tmp+'\''';
      ext:=true;
    end;
    if copy(value, i, 1)='''''' then
    begin
      tmp:=tmp+'\''\''';
      ext:=true;
    end;
    if copy(value, i, 1)='"' then
    begin
      tmp:=tmp+'\''\''';
      ext:=true;
    end;
    if ext=false then tmp:=tmp+copy(value, i, 1);
    inc(i);
  end;
  result:=tmp;
end;

function TMainForm.strik(val: string): string;
var i:integer; ext:boolean; tmp:string;
begin
  i:=length(val);
  ext:=true;
  tmp:='';
  while i<>0 do
  begin
    if copy(val, i-1, 1)='.' then
    begin
      if ext=false then
      begin
        val:=copy(val, 1, i-2)+' '+copy(val, i, length(val));
      end;
      if ext=true then ext:=false;
    end;
    dec(i);
  end;
  result:=val;
end;

procedure TMainForm.GridChatDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var s:string;
 Flag: Cardinal;
 H: integer;
 Comp:TComponent;
 i:integer; Image:TImage;
 R:TRect;
begin
  (Sender as TStringGrid).Canvas.FillRect(Rect);
  s := (Sender as TStringGrid).Cells[ACol, ARow];

  if ARow = 0 then Flag := DT_CENTER
  else
  begin
    if (ACol > 0) then Flag := DT_RIGHT else Flag := DT_LEFT;
  end;

  Flag := Flag or DT_WORDBREAK;
  Inc(Rect.Left,3);
  Dec(Rect.Right,3);
  H := DrawText((Sender as TStringGrid).Canvas.Handle, PChar(s), length(s), Rect, Flag);
  if H > (Sender as TStringGrid).RowHeights[ARow] then
    (Sender as TStringGrid).RowHeights[ARow] := H + 3;  //�����������

  if (Sender as TStringGrid).Cells[ACol, ARow]<>'' then
  begin
    i:=1;
    while i<>length((Sender as TStringGrid).Cells[ACol, ARow])  do
    begin
      if copy((Sender as TStringGrid).Cells[ACol, ARow], i, 2)=':)' then
      begin
        (Sender as TStringGrid).Canvas.FillRect(Rect);
        R:=(Sender as TStringGrid).CellRect(ACol, ARow);

        Image:=TImage.Create(self);
        TreeImg.GetBitmap(1, Image.Picture.Bitmap);
        Image.Visible:=false;

        (Sender as TStringGrid).Canvas.TextRect(R, 10, 10, 'Smile: ');
        (Sender as TStringGrid).Canvas.Draw(R.Left, R.Top, Image.Picture.Graphic);
        //(Sender as TStringGrid).Canvas.StretchDraw(R, Image.Picture.Graphic);

        //(Sender as TStringGrid).Canvas.Draw((Sender as TStringGrid).CellRect(ACol,ARow).Left, (Sender as TStringGrid).CellRect(ACol,ARow).Top, Image.Picture.Graphic);
      end;
      inc(i);
    end;
  end;
end;

procedure TMainForm.TabSheet10Show(Sender: TObject);
begin
  try
    CheckTable.Active:=false;
    CheckTable.Active:=true;
    CheckTable.Filtered:=false;
    CheckTable.Filter:='groupid='''+Auth.groupid+'''';
    CheckTable.Filtered:=true;
  except
  end;
end;

procedure TMainForm.TabSheet3Resize(Sender: TObject);
begin
  DBGrid6.Columns[0].Width:=280;
  DBGrid6.Columns[1].Width:=80;
  DBGrid6.Columns[2].Width:=80;
  DBGrid6.Columns[3].Width:=120;
  DBGrid6.Columns[4].Width:=80;
  DBGrid6.Columns[5].Width:=80;
  DBGrid6.Columns[6].Width:=80;
  DBGrid6.Columns[7].Width:=90;
  DBGrid6.Columns[8].Width:=90;
  DBGrid6.Columns[9].Width:=80;
end;

procedure TMainForm.TabSheet7Show(Sender: TObject);
begin
  try
    VipTable.Active:=false;
    VipTable.Active:=true;
    VipTable.Filtered:=false;
    VipTable.Filter:='groupid='''+Auth.groupid+'''';
    VipTable.Filtered:=true;
  except
  end;
end;

procedure TMainForm.TimerTimer(Sender: TObject);
begin
  //MainForm.GetGroup;
end;

procedure TMainForm.ToggleActClick(Sender: TObject);
begin
  try
    if ToggleAct.State=TToggleSwitchState.tssOff then
    begin
      TreeSet.Filtered:=false;
      TreeSet.Filter:='accepted=''�������''';
      TreeSet.Filtered:=true;
      if FindEdit.Text<>'' then
      begin
        Search.Caption:='�����';
        Search.Click;
      end
      else
      begin
        TreeView.OnChange(nil,MainForm.TreeView.Selected);
      end;
      Cartoons.Caption:='�������� ��������: '+IntToStr(TreeSet.RecordCount);
    end
    else
    begin
      TreeSet.Filtered:=false;
      TreeSet.Filter:='';
      TreeSet.Filtered:=true;
      if FindEdit.Text<>'' then
      begin
        Search.Caption:='�����';
        Search.Click;
      end
      else
      begin
        TreeView.OnChange(nil,MainForm.TreeView.Selected);
      end;
      Cartoons.Caption:='�������� ��������: '+IntToStr(TreeSet.RecordCount);
    end;
  except
  end;
end;

procedure TMainForm.ToggleSwitch1Click(Sender: TObject);
begin
  Changer.Click;
end;

procedure TMainForm.TreeViewChange(Sender: TObject; Node: TTreeNode);
var i:integer; tmp:string;  id:string;
begin
  try
    Node.Expanded:=true;
    TreeView.Refresh;
    Application.ProcessMessages;
    //
    TreeSet.Active:=false;
    DBGrid1.Enabled:=false;
    FindEdit.Enabled:=true;
    Search.Enabled:=true;
    Filter.Enabled:=true;
    BitBtn6.Enabled:=true;
    ToggleAct.Enabled:=true;
    Search.Caption:='�����';
    SNode:=Node;
    //
    i:=1;
    while i<>length(Node.Text) do
    begin
      if copy(Node.Text, i, 1)=' ' then break;
      inc(i);
    end;
    tmp:=copy(Node.Text, 1, i-1)+'%';
    group:=copy(Node.Text, 1, i-1);
    if group='��' then group:='';

    if tmp='��%' then
    begin
      Screen.Cursor := crAppStart;
      TreeSet.Active:=false;
      Cartoons.Caption:='�������� ��������: ���';
      Screen.Cursor := crDefault;
      {
      if ToggleAct.State=TToggleSwitchState.tssOff then
      begin
        TreeSet.Active:=false;
        TreeSet.CommandText:='select d.article, d.name, d.mesname, d.country, DECODE(accepted, ''1'', ''�������'', ''2'', ''���������'', ''�����'') as accepted, ';
        TreeSet.CommandText:=TreeSet.CommandText+'DECODE(datatype, ''0'', ''�����'', ''1'', ''������'', ''2'', ''������'', ''3'', ''����'', ''4'', ''���������'', ''5'', ''�����'', ''#�/�'') as datatype, s.tree, s.name as gname from supermag.smcard d, supermag.sacardclass s WHERE s.id = d.idclass and accepted=1';
        TreeSet.Active:=true;
      end
      else
      begin
        TreeSet.Active:=false;
        TreeSet.CommandText:='select d.article, d.name, d.mesname, d.country, DECODE(accepted, ''1'', ''�������'', ''2'', ''���������'', ''�����'') as accepted, ';
        TreeSet.CommandText:=TreeSet.CommandText+'DECODE(datatype, ''0'', ''�����'', ''1'', ''������'', ''2'', ''������'', ''3'', ''����'', ''4'', ''���������'', ''5'', ''�����'', ''#�/�'') as datatype, s.tree, s.name as gname from supermag.smcard d, supermag.sacardclass s WHERE s.id = d.idclass';
        TreeSet.Active:=true;
      end;
      Cartoons.Caption:='�������� ��������: '+IntToStr(TreeSet.RecordCount);
      }
    end
    else
    begin
      try
        Screen.Cursor := crAppStart;
        if ToggleAct.State=TToggleSwitchState.tssOff then
        begin

          TreeSet.Active:=false;
          TreeSet.CommandText:='select d.article, d.name, d.mesabbrev as mesname, d.country, DECODE(accepted, ''1'', ''�������'', ''2'', ''���������'', ''�����'') as accepted, ';
          TreeSet.CommandText:=TreeSet.CommandText+'DECODE(datatype, ''0'', ''�����'', ''1'', ''������'', ''2'', ''������'', ''3'', ''����'', ''4'', ''���������'', ''5'', ''�����'', ''#�/�'') as datatype, s.tree, s.name as gname from supermag.smcard d, supermag.sacardclass s WHERE s.id = d.idclass and s.tree LIKE '''+tmp+'%'' and accepted=1';
          TreeSet.Active:=true;

        end
        else
        begin

          TreeSet.Active:=false;
          TreeSet.CommandText:='select d.article, d.name, d.mesabbrev as mesname, d.country, DECODE(accepted, ''1'', ''�������'', ''2'', ''���������'', ''�����'') as accepted, ';
          TreeSet.CommandText:=TreeSet.CommandText+'DECODE(datatype, ''0'', ''�����'', ''1'', ''������'', ''2'', ''������'', ''3'', ''����'', ''4'', ''���������'', ''5'', ''�����'', ''#�/�'') as datatype, s.tree, s.name as gname from supermag.smcard d, supermag.sacardclass s WHERE s.id = d.idclass and s.tree LIKE '''+tmp+'%''';
          TreeSet.Active:=true;

        end;
        Cartoons.Caption:='�������� ��������: '+IntToStr(TreeSet.RecordCount);
        Screen.Cursor := crDefault;
      except
      end;
    end;
    if (TreeSet.RecordCount > 0) then DBGrid1.Enabled:=true;
  except
  end;
end;

procedure TMainForm.TreeViewClick(Sender: TObject);
begin
  try
    TreeView.Color:= clRed;
    TreeView.BorderStyle:= bsNone;
  except
  end;
end;

procedure TMainForm.TreeViewCompare(Sender: TObject; Node1, Node2: TTreeNode;
  Data: Integer; var Compare: Integer);
var i:integer; tmp1, tmp2:string; tmp3, tmp4:string;
begin
  try
    if Node1.HasChildren and not Node2.HasChildren then compare:=-1 else
    if not Node1.HasChildren and Node2.HasChildren then compare:=1 else
    begin

      i:=0;
      tmp1:='';
      while i<>length(Node1.Text) do
      begin
        if copy(Node1.Text, i, 1)=' ' then break;
        if copy(Node1.Text, i, 1)<>'.' then tmp1:=tmp1+copy(Node1.Text, i, 1);
        inc(i);
      end;

      i:=0;
      tmp2:='';
      while i<>length(Node2.Text) do
      begin
        if copy(Node2.Text, i, 1)=' ' then break;
        if copy(Node2.Text, i, 1)<>'.' then tmp2:=tmp2+copy(Node2.Text, i, 1);
        inc(i);
      end;
      try
        if StrToFloat(tmp1)<StrToFloat(tmp2) then
        begin
          Compare:=-1;
        end;
      except
        Compare:=1;
      end;
    end;
  except
  end;
end;

procedure TMainForm.TreeViewCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  try
    if cdsSelected in State then
    begin
      Sender.Canvas.Font.Color := clNavy;
      Sender.Canvas.Brush.Color := clCream;
    end
    else
    begin
      Sender.Canvas.Font.Color := clWebBlack;
      Sender.Canvas.Brush.Color := $00D6D6D6;
    end;
  except
  end;
end;

procedure TMainForm.TreeViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  try
    if key=VK_F12 then
    begin
      f121.Click;
    end;
  except
  end;
end;

procedure TMainForm.TreeViewMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var Node:TTreeNode;
begin
  {Node:=TreeView.GetNodeAt(X,Y);
  if Node<>nil then
  begin
    if Shift = [ssLeft] then
    begin
      TreeView.BeginDrag(true, 0);
    end;
  end; }
end;

procedure TMainForm.TreeViewMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  {if Shift = [ssLeft] then
  begin
    TreeView.EndDrag(true);
  end;  }
end;

procedure TMainForm.WB_LoadHTML(WebBrowser: TWebBrowser; HTMLCode: string);
var
  sl: TStringList;
  ms: TMemoryStream;
begin
  WebBrowser.Navigate('about:blank');
  while WebBrowser.ReadyState < READYSTATE_INTERACTIVE do
    Application.ProcessMessages;

  if Assigned(WebBrowser.Document) then
  begin
    sl := TStringList.Create;
    try
      ms := TMemoryStream.Create;
      try
        sl.Text := HTMLCode;
        sl.SaveToStream(ms);
        ms.Seek(0, 0);
        (WebBrowser.Document as
          IPersistStreamInit).Load(TStreamAdapter.Create(ms));
      finally
        ms.Free;
      end;
    finally
      sl.Free;
    end;
  end;
end;

procedure TMainForm.Wheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  try
    TDBGrid(Sender).DataSource.DataSet.MoveBy(-1*Sign(WheelDelta));
    Handled := True;
    DBGrid1.OnCellClick(nil);
  except
  end;
end;

procedure TMainForm.ZvGridDblClick(Sender: TObject);
begin
  if ZVGrid.DataSource.DataSet.FieldByName('id').AsString<>'' then
  begin
    BitBtn14.Click;
  end;
end;

procedure TMainForm.ZvGridDrawColumnCell(Sender: TObject;
  const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if (ZvGrid.DataSource.DataSet.FieldValues['ext']='false0') then
  begin
    zvGrid.Canvas.Brush.Color:=clRed;
  end;
  if (ZvGrid.DataSource.DataSet.FieldValues['ext']='false1') then
  begin
    zvGrid.Canvas.Brush.Color:=$00D7FF;
  end;
  if (ZvGrid.DataSource.DataSet.FieldValues['ext']='th') then
  begin
    zvGrid.Canvas.Brush.Color:=clGreen;
  end;
  ZvGrid.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TMainForm.ZvGridTitleClick(Column: TColumn);
begin
  try
    Zv_Table.Sort:=Column.FieldName;
  except
  end;
end;

procedure TMainForm.ZvKeyPress(Sender: TObject; var Key: Char);
begin
  key:=#0;
end;

procedure TMainForm.ZV_ReportPreview(Sender: TObject);
var frmPreview: TfrxPreviewForm;
begin
  frmPreview:=TfrxPreviewForm(ZV_Report.PreviewForm);
  frmPreview.Caption:='��������������� ��������: ';
  frmPreview.BorderIcons:=frmPreview.BorderIcons-[biMinimize]-[biMaximize];
end;

{ TNewThread }

procedure TNewThread.Execute;
var Lab:TLabel;  dir:string;   k:integer; goods:string;
begin
  inherited;

  {

  k:=0;
  goods:='';
  while k<>length(Auth.GList) do
  begin
    goods:=goods+Auth.GList[k].num+' ,';
    inc(k);
  end;
  goods:=copy(goods, 1, length(goods)-2);

  dir:=ExtractFilePath(ParamStr(0));

  MainForm.Loader.Visible:=false;
  MainForm.Loader.Left:=Trunc(MainForm.GroupBox3.Width-MainForm.Loader.Width-5);
  MainForm.Taskbar.OverlayIcon:=MainForm.RefreshImg.Picture.Icon;
  MainForm.Icon:=MainForm.RefreshImg.Picture.Icon;

  _TreeSet:=TADODataSet.Create(nil);
  _BarcodeSet:=TADODataSet.Create(nil);
  _PriceSet:=TADODataSet.Create(nil);
  _GoodSet:=TADODataSet.Create(nil);

  _TreeSet.Connection:=Auth.OraSes;
  _BarcodeSet.Connection:=Auth.OraSes;
  _PriceSet.Connection:=Auth.OraSes;
  _GoodSet.Connection:=Auth.OraSes;


  Block.ProgressBar.Min:=0;
  Block.ProgressBar.Max:=10;
  Block.ProgressBar.Position:=1;

  try
    _TreeSet.Active:=false;
    _TreeSet.CommandText:='select d.article, d.name, d.mesname, d.country, DECODE(accepted, ''1'', ''�������'', ''2'', ''���������'', ''�����'') as accepted, DECODE(datatype, ''0'', ''�����'', ''1'', ''������'', ''2'', ''������'', ''3'', ''����'', ''4'', ''���������'', ''5'', ''�����'', ''#�/�'') ';
    _TreeSet.CommandText:=_TreeSet.CommandText+'as datatype, s.tree, s.name as gname from supermag.smcard d, supermag.sacardclass s WHERE s.id = d.idclass';
    _TreeSet.Active:=true;
    MainForm.Cartoons.Caption:='�������� ��������: '+IntToStr(_TreeSet.RecordCount);
  except
    MainForm.Cartoons.Caption:='�������� ��������: 0';
  end;

  _TreeSet.SaveToFile('TreeSet.xml', pfXML);
  Block.ProgressBar.Position:=2;

  try
    _BarcodeSet.Active:=false;
    _BarcodeSet.CommandText:='select d.article, s.barcode from supermag.smstoreunits s, supermag.smcard d where d.article = s.article';
    _BarcodeSet.Active:=true;
  except
  end;

  _BarcodeSet.SaveToFile('BarcodeSet.xml', pfXML);
  Block.ProgressBar.Position:=3;

  try
    _PriceSet.Active:=false;
    _PriceSet.CommandText:='select * from smprices where storeloc='+Auth.storeloc+' and pricetype='+Auth.pricetype;
    _PriceSet.Active:=true;
  except
  end;

  Block.ProgressBar.Position:=4;

  try
    _GoodSet.Active:=false;
    _GoodSet.CommandText:='select article, ';
    _GoodSet.CommandText:=_GoodSet.CommandText+'decode(storeloc, ''2'', ''���. "����������", ������� �-�, ���. �������,1, 223053'', ''8'', ''���. "Mile", �.�����, ������������ �����,188, 220053'', ''11'', ''���. "Mile", �.�����, ��. ���������, 9�, 224022'',';
    _GoodSet.CommandText:=_GoodSet.CommandText+' ''16'', ''���. "Mile", �.�������, ������� �����,31, 212039'', ''18'', ''���. "Mile", �.�����, ��-� ������������, 150�'',';
    _GoodSet.CommandText:=_GoodSet.CommandText+' ''10'', ''����� "Mile" ������������, 220053 �.�����, ������������ �����, 188'', ''14'',';
    _GoodSet.CommandText:=_GoodSet.CommandText+' ''������������� ����� "Mile", 220113 �.�����, ��. �����������, 10'', ''15'', ''���������� ��'', ''17'', ''����� �������� � ����� "������������� �����", ��. �����������, 10'', ''-'') as storeloc';
    _GoodSet.CommandText:=_GoodSet.CommandText+' , quantity from smgoods where storeloc in ('+goods+')';
    _GoodSet.Active:=true;
  except
  end;

  _GoodSet.SaveToFile('GoodSet.xml', pfXML);
  MainForm.GoodSet.LoadFromFile('GoodSet.xml');
  Block.ProgressBar.Position:=5;

  _PriceSet.SaveToFile('PriceSet.xml', pfXML);
  Block.ProgressBar.Position:=6;

  MainForm.TreeSet.LoadFromFile('TreeSet.xml');
  Block.ProgressBar.Position:=7;

  MainForm.BarcodeSet.LoadFromFile('BarcodeSet.xml');
  Block.ProgressBar.Position:=8;
  MainForm.PriceSet.LoadFromFile('PriceSet.xml');
  Block.ProgressBar.Position:=9;

  MainForm.TreeSet.Filtered:=false;
  MainForm.TreeSet.Filter:='accepted=''�������''';
  MainForm.TreeSet.Filtered:=true;
  MainForm.Cartoons.Caption:='�������� ��������: '+IntToStr(_TreeSet.RecordCount);
  Block.ProgressBar.Position:=10;

  _TreeSet.Free;
  _BarcodeSet.Free;
  _PriceSet.Free;

  MainForm.Timer.Enabled:=true;
  MainForm.Loader.Visible:=true;
  Block.Visible:=false;
  Block.Hide;
  MainForm.Taskbar.OverlayIcon:=MainForm.IconClear.Picture.Icon;
  MainForm.Icon:=MainForm.FormIcon.Picture.Icon;
  }
  Terminate;
  Free;
end;

end.
