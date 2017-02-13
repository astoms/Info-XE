unit uUtilsFr;

interface
uses
  frxClass, frxPreview;

type
   TFastReportDesignReportButtonOnClickStubClass = class(TObject)
  public
    procedure OnClick(Sender: TObject);
  end;


procedure FastReportAddDesignButtonToPreviewForm(AReport: TfrxReport);

implementation
uses
  Buttons;

var
  lfxDesignReportButtonOnClickStub: TFastReportDesignReportButtonOnClickStubClass;

{ TFastReportDesignReportButtonOnClickStubClass }

procedure FastReportAddDesignButtonToPreviewForm(AReport: TfrxReport);
var
  lfrxPreviewForm: TfrxPreviewForm;
  lbtnDesign: TSpeedButton;
begin
  lfrxPreviewForm := TfrxPreviewForm(AReport.PreviewForm);

  lbtnDesign := TSpeedButton.Create(lfrxPreviewForm);
  lbtnDesign.OnClick := lfxDesignReportButtonOnClickStub.OnClick;
  lbtnDesign.Caption := 'Дизайнер';
  lbtnDesign.Width:= 66;

  lfrxPreviewForm.ToolBar.InsertControl(lbtnDesign);
end;

procedure TFastReportDesignReportButtonOnClickStubClass.OnClick(
  Sender: TObject);
begin
  TfrxPreviewForm(TSpeedButton(Sender).Owner).Report.DesignReport;
end;

initialization
  lfxDesignReportButtonOnClickStub := TFastReportDesignReportButtonOnClickStubClass.Create;

finalization
  lfxDesignReportButtonOnClickStub.Free;
end.
