program Info_XE;





{$R *.dres}

uses
  Vcl.Forms,
  Unit1 in 'units\Unit1.pas' {Auth},
  Vcl.Themes,
  Vcl.Styles,
  Unit2 in 'units\Unit2.pas' {MainForm},
  Unit3 in 'units\Unit3.pas' {EnterForm},
  PassWord in 'units\PassWord.pas' {PasswordDlg},
  Unit5 in 'units\Unit5.pas' {AD},
  Unit6 in 'units\Unit6.pas' {ChPrice},
  Unit7 in 'units\Unit7.pas' {ChPlace},
  Unit4 in 'units\Unit4.pas' {ChTrade},
  Unit8 in 'units\Unit8.pas' {ChForm},
  Unit9 in 'units\Unit9.pas' {Scaner},
  uUtilsFr in 'units\uUtilsFr.pas',
  Unit11 in 'units\Unit11.pas' {ChooseGoods},
  Unit12 in 'units\Unit12.pas' {LoadData},
  UModelTree in 'units\UModelTree.pas',
  Unit13 in 'units\Unit13.pas' {TovJam},
  Unit14 in 'units\Unit14.pas' {TovSave},
  Unit15 in 'units\Unit15.pas' {ValueList},
  Unit16 in 'units\Unit16.pas' {ZvAdd},
  Unit17 in 'units\Unit17.pas' {ZvChange},
  Unit18 in 'units\Unit18.pas' {MileShow},
  Unit10 in 'units\Unit10.pas' {AddZPC},
  Unit19 in 'units\Unit19.pas' {ChangeZPC},
  Unit20 in 'units\Unit20.pas' {AddPlace},
  Unit21 in 'units\Unit21.pas' {ZvMessage},
  Unit22 in 'units\Unit22.pas' {PrintForm};

{$R *.res}

begin
  Application.Initialize;
  //Application.MainFormOnTaskbar := False;
  TStyleManager.TrySetStyle('Emerald Light Slate');
  Application.Title := 'Info - справочник товаров';
  Application.CreateForm(TAuth, Auth);
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TEnterForm, EnterForm);
  Application.CreateForm(TPasswordDlg, PasswordDlg);
  Application.CreateForm(TAD, AD);
  Application.CreateForm(TChPrice, ChPrice);
  Application.CreateForm(TChPrice, ChPrice);
  Application.CreateForm(TChPlace, ChPlace);
  Application.CreateForm(TChTrade, ChTrade);
  Application.CreateForm(TChForm, ChForm);
  Application.CreateForm(TScaner, Scaner);
  Application.CreateForm(TChooseGoods, ChooseGoods);
  Application.CreateForm(TLoadData, LoadData);
  Application.CreateForm(TTovJam, TovJam);
  Application.CreateForm(TTovSave, TovSave);
  Application.CreateForm(TValueList, ValueList);
  Application.CreateForm(TZvAdd, ZvAdd);
  Application.CreateForm(TZvChange, ZvChange);
  Application.CreateForm(TMileShow, MileShow);
  Application.CreateForm(TAddZPC, AddZPC);
  Application.CreateForm(TChangeZPC, ChangeZPC);
  Application.CreateForm(TAddPlace, AddPlace);
  Application.CreateForm(TZvMessage, ZvMessage);
  Application.CreateForm(TPrintForm, PrintForm);
  MileShow.TransparentColorValue:=MileShow.Color;
  //Application.OnMinimize:=Auth.Restore;
  Application.OnRestore:=Auth.Restore;
  Application.Run;
end.
