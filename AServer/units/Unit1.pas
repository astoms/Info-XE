unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons,
  Data.DB, Data.Win.ADODB;

type
  TMainForm = class(TForm)
    BitBtn1: TBitBtn;
    DateTimePicker1: TDateTimePicker;
    Button1: TButton;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label2: TLabel;
    OraQuery: TADOQuery;
    OraSes: TADOConnection;
    MS_Conn: TADOConnection;
    MS_Query: TADOQuery;
    MS_Query2: TADOQuery;
    Button2: TButton;
    MS_Query3: TADOQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.Button1Click(Sender: TObject);
var article, article2:string;  num_r, num_w:integer; pers, sum:integer;
begin
  try
    MS_Query.Active:=false;
    MS_Query.SQL.Clear;
    MS_Query.SQL.Add('select * from t_zd where `status`=''�������� ����������'' ');
    //MS_Query.Parameters.ParamByName('DT').Value:=Now;
    //MS_Query.Parameters.ParamByName('DT').DataType:=ftDate;
    MS_Query.Active:=true;
  except
    on E:Exception do ShowMessage('������ #1: '+E.Message+'.');
  end;
  if MS_Query.RecordCount>0 then
  begin
    MS_Query.First;
    while not MS_Query.Eof do
    begin
      //ShowMessage('DOCID: '+MS_Query.FieldByName('id').AsString);
      try
        MS_Query2.Active:=false;
        MS_Query2.SQL.Clear;
        MS_Query2.SQL.Add('select * from t_zd2 where `docid` = '''+MS_Query.FieldByName('id').AsString+'''');
        MS_Query2.Active:=true;
      except
        on E:Exception do ShowMessage('������ #2: '+E.Message+'.');
      end;
      if MS_Query2.RecordCount>0 then
      begin
        article:='';
        MS_Query2.First;
        while not MS_Query2.Eof do
        begin
          article:=article+#39+MS_Query2.FieldByName('article').AsString+#39+', ';
          MS_Query2.Next;
        end;
        article:=copy(article, 1, length(article)-2);
        //ShowMessage('�������� ��������: '+article);
        try
          OraQuery.Active:=false;
          OraQuery.SQL.Clear;
          OraQuery.SQL.Add('select d.id, d.createdat, s.article from smdocuments d, smspec s ');
          OraQuery.SQL.Add('where d.doctype = ''WI'' ');
          OraQuery.SQL.Add('and d.id = s.docid ');
          OraQuery.SQL.Add('and d.doctype = s.doctype ');
          OraQuery.SQL.Add('and s.article in ('+article+') and d.createdat = :DaT');
          OraQuery.Parameters.ParamByName('DaT').Value:=Now;
          OraQuery.Parameters.ParamByName('DaT').DataType:=ftDate;
          OraQuery.Active:=true;
          article2:='';
          if OraQuery.RecordCount>=0 then
          begin
            OraQuery.First;
            while not OraQuery.Eof do
            begin
              article2:=article2+#39+OraQuery.FieldByName('article').AsString+#39+', ';
              OraQuery.Next;
            end;
            article2:=copy(article2, 1, length(article2)-2);
            //ShowMessage('�� ��� �������� ���� ��: '+article2);
            if article2='' then
            begin
              try
                MS_Query2.Active:=false;
                MS_Query2.SQL.Clear;
                MS_Query2.SQL.Add('update t_zd2 set ext=''false'' where `docid` = '''+MS_Query.FieldByName('id').AsString+'''');
                MS_Query2.ExecSQL;
              except
                on E:Exception do ShowMessage('������ #3: '+E.Message+'.');
              end;
            end
            else
            begin
              try
                MS_Query2.Active:=false;
                MS_Query2.SQL.Clear;
                MS_Query2.SQL.Add('update t_zd2 set ext=''false'' where `docid` = '''+MS_Query.FieldByName('id').AsString+''' and `article` not in ('+article2+')');
                MS_Query2.ExecSQL;
              except
                on E:Exception do ShowMessage('������ #3: '+E.Message+'.');
              end;
            end;
            num_w:=0;
            num_r:=0;
            sum:=0;
            pers:=0;
            try
              MS_Query2.Active:=false;
              MS_Query2.SQL.Clear;
              MS_Query2.SQL.Add('select * from t_zd2 where `docid` = '''+MS_Query.FieldByName('id').AsString+''' and ext=''true''');
              MS_Query.Active:=true;
              try
                num_w:=MS_Query.RecordCount;
              except
                num_w:=0;
              end;
            except
              on E:Exception do ShowMessage('������ #4: '+E.Message+'.');
            end;
            try
              MS_Query2.Active:=false;
              MS_Query2.SQL.Clear;
              MS_Query2.SQL.Add('select * from t_zd2 where `docid` = '''+MS_Query.FieldByName('id').AsString+''' and ext=''false''');
              MS_Query2.Active:=true;
              try
                num_r:=MS_Query.RecordCount;
              except
                num_r:=0;
              end;
            except
              on E:Exception do ShowMessage('������ #5: '+E.Message+'.');
            end;
            sum:=num_w+num_r;
            pers:=(num_w*100) div sum;
            if pers>60 then
            begin
              try
                MS_Query2.Active:=false;
                MS_Query2.SQL.Clear;
                MS_Query2.SQL.Add('update t_zd set ext=''false1'' where `id` = '''+MS_Query.FieldByName('id').AsString+'''');
                MS_Query2.ExecSQL;
              except
                on E:Exception do ShowMessage('������ #6: '+E.Message+'.');
              end;
            end
            else
            begin
              try
                MS_Query2.Active:=false;
                MS_Query2.SQL.Clear;
                MS_Query2.SQL.Add('update t_zd set ext=''false0'' where `id` = '''+MS_Query.FieldByName('id').AsString+'''');
                MS_Query2.ExecSQL;
              except
                on E:Exception do ShowMessage('������ #7: '+E.Message+'.');
              end;
            end;
          end;
        except
          on E:Exception do ShowMessage('������ #4: '+E.Message+'.');
        end;
      end;
      MS_Query.Next;
    end;
    //
  end;
  Exit;
end;

procedure TMainForm.Button2Click(Sender: TObject);
var norm, hard, good: integer;
begin
  try
    MS_Query.Active:=false;
    MS_Query.SQL.Clear();
    MS_Query.SQL.Add('select `id`, `mag` from t_zd where `status` = ''�������� ����������'' and `ext` <> ''th'' order by `date`');
    MS_Query.Active:=true; //`date` > CURDATE()-25 and
    MS_Query.First;
    while not MS_Query.Eof do
    begin
      try
        MS_Query2.Active:=false;
        MS_Query2.SQL.Clear;
        MS_Query2.SQL.Add('select `id`, `article`, `date` from t_zd2 where `docid` = '''+MS_Query.FieldByName('id').AsString+''' order by `id`');
        MS_Query2.Active:=true;
        MS_Query2.First;

        while not MS_Query2.Eof do
        begin
          if MS_Query.FieldByName('mag').ASString='������� "Mile", �.�����, ������������ �����,188 ��� "����������"' then  //Mile
          begin
            try
              OraQuery.Active:=false;
              OraQuery.SQL.Clear;
              OraQuery.SQL.Add('select d.id, d.createdat, s.article from smdocuments d, smspec s where d.doctype = ''WI'' and d.id = s.docid and d.doctype = s.doctype and d.createdat BETWEEN to_date('''+MS_Query2.FieldByName('date').AsString+''', ''dd.mm.yyyy'')-3 AND to_date('''+MS_Query2.FieldByName('date').AsString+''', ''dd.mm.yyyy'')+14 and s.article = '''+MS_Query2.FieldByName('article').AsString+''' and d.locationto in (''8'', ''10'') order by d.createdat');
              OraQuery.Active:=true;
              if OraQuery.RecordCount>0 then
              begin
                try
                  MS_Query3.Active:=false;
                  MS_Query3.SQL.Clear;
                  MS_Query3.SQL.Add('update t_zd2 set ext = ''th'' where `id` = '''+MS_Query2.FieldByName('id').AsString+'''');
                  MS_Query3.ExecSQL;
                except

                end;
              end
              else
              begin
                try
                  MS_Query3.Active:=false;
                  MS_Query3.SQL.Clear;
                  MS_Query3.SQL.Add('update t_zd2 set ext = ''false'' where `id` = '''+MS_Query2.FieldByName('id').AsString+'''');
                  MS_Query3.ExecSQL;
                except

                end;
              end;
            except
            end;
          end;
          if MS_Query.FieldByName('mag').ASString='�������  "Mile", �.�����, ��. ���������, 9� ��� "����������"' then //Brest
          begin
            try

                try
                OraQuery.Active:=false;
                OraQuery.SQL.Clear;
                OraQuery.SQL.Add('select d.id, d.createdat, s.article from smdocuments d, smspec s where d.doctype = ''WI'' and d.id = s.docid and d.doctype = s.doctype and d.createdat BETWEEN to_date('''+MS_Query2.FieldByName('date').AsString+''', ''dd.mm.yyyy'')-3 AND to_date('''+MS_Query2.FieldByName('date').AsString+''', ''dd.mm.yyyy'')+20 and s.article = '''+MS_Query2.FieldByName('article').AsString+''' and d.locationto in (''11'') order by d.createdat');
                OraQuery.Active:=true;
                if OraQuery.RecordCount>0 then
                begin
                  try
                    MS_Query3.Active:=false;
                    MS_Query3.SQL.Clear;
                    MS_Query3.SQL.Add('update t_zd2 set ext = ''th'' where `id` = '''+MS_Query2.FieldByName('id').AsString+'''');
                    MS_Query3.ExecSQL;
                  except

                  end;
                end
                else
                begin
                  try
                    MS_Query3.Active:=false;
                    MS_Query3.SQL.Clear;
                    MS_Query3.SQL.Add('update t_zd2 set ext = ''false'' where `id` = '''+MS_Query2.FieldByName('id').AsString+'''');
                    MS_Query3.ExecSQL;
                  except

                  end;
                end;
                except

                end;

            except
            end;
          end;
          if MS_Query.FieldByName('mag').ASString='������� "����������", ������� �-�, ���. �������,1 ��� "����������"' then //Novoselk
          begin
            try

                try
                OraQuery.Active:=false;
                OraQuery.SQL.Clear;
                OraQuery.SQL.Add('select d.id, d.createdat, s.article from smdocuments d, smspec s where d.doctype = ''WI'' and d.id = s.docid and d.doctype = s.doctype and d.createdat BETWEEN to_date('''+MS_Query2.FieldByName('date').AsString+''', ''dd.mm.yyyy'')-3 AND to_date('''+MS_Query2.FieldByName('date').AsString+''', ''dd.mm.yyyy'')+14 and s.article = '''+MS_Query2.FieldByName('article').AsString+''' and d.locationto in (''2'') order by d.createdat');
                OraQuery.Active:=true;
                if OraQuery.RecordCount>0 then
                begin
                  try
                    MS_Query3.Active:=false;
                    MS_Query3.SQL.Clear;
                    MS_Query3.SQL.Add('update t_zd2 set ext = ''th'' where `id` = '''+MS_Query2.FieldByName('id').AsString+'''');
                    MS_Query3.ExecSQL;
                  except

                  end;
                end
                else
                begin
                  try
                    MS_Query3.Active:=false;
                    MS_Query3.SQL.Clear;
                    MS_Query3.SQL.Add('update t_zd2 set ext = ''false'' where `id` = '''+MS_Query2.FieldByName('id').AsString+'''');
                    MS_Query3.ExecSQL;
                  except

                  end;
                end;
                except

                end;

            except
            end;
          end;
          if MS_Query.FieldByName('mag').ASString='������� "Mile", �.�����, ��-� ������������, 150� ��� "����������"' then //Momo
          begin
            try

                try
                OraQuery.Active:=false;
                OraQuery.SQL.Clear;
                OraQuery.SQL.Add('select d.id, d.createdat, s.article from smdocuments d, smspec s where d.doctype = ''WI'' and d.id = s.docid and d.doctype = s.doctype and d.createdat BETWEEN to_date('''+MS_Query2.FieldByName('date').AsString+''', ''dd.mm.yyyy'')-3 AND to_date('''+MS_Query2.FieldByName('date').AsString+''', ''dd.mm.yyyy'')+14 and s.article = '''+MS_Query2.FieldByName('article').AsString+''' and d.locationto in (''18'') order by d.createdat');
                OraQuery.Active:=true;
                if OraQuery.RecordCount>0 then
                begin
                  try
                    MS_Query3.Active:=false;
                    MS_Query3.SQL.Clear;
                    MS_Query3.SQL.Add('update t_zd2 set ext = ''th'' where `id` = '''+MS_Query2.FieldByName('id').AsString+'''');
                    MS_Query3.ExecSQL;
                  except

                  end;
                end
                else
                begin
                  try
                    MS_Query3.Active:=false;
                    MS_Query3.SQL.Clear;
                    MS_Query3.SQL.Add('update t_zd2 set ext = ''false'' where `id` = '''+MS_Query2.FieldByName('id').AsString+'''');
                    MS_Query3.ExecSQL;
                  except

                  end;
                end;
                except

                end;

            except
            end;
          end;
          if MS_Query.FieldByName('mag').ASString='������� "������������ ����������� "Mile", �.�����, ����������, 127' then //Jdani
          begin
            try

                try
                OraQuery.Active:=false;
                OraQuery.SQL.Clear;
                OraQuery.SQL.Add('select d.id, d.createdat, s.article from smdocuments d, smspec s where d.doctype = ''WI'' and d.id = s.docid and d.doctype = s.doctype and d.createdat BETWEEN to_date('''+MS_Query2.FieldByName('date').AsString+''', ''dd.mm.yyyy'')-2 AND to_date('''+MS_Query2.FieldByName('date').AsString+''', ''dd.mm.yyyy'')+14 and s.article = '''+MS_Query2.FieldByName('article').AsString+''' and d.locationto in (''21'') order by d.createdat');
                OraQuery.Active:=true;
                if OraQuery.RecordCount>0 then
                begin
                  try
                    MS_Query3.Active:=false;
                    MS_Query3.SQL.Clear;
                    MS_Query3.SQL.Add('update t_zd2 set ext = ''th'' where `id` = '''+MS_Query2.FieldByName('id').AsString+'''');
                    MS_Query3.ExecSQL;
                  except

                  end;
                end
                else
                begin
                  try
                    MS_Query3.Active:=false;
                    MS_Query3.SQL.Clear;
                    MS_Query3.SQL.Add('update t_zd2 set ext = ''false'' where `id` = '''+MS_Query2.FieldByName('id').AsString+'''');
                    MS_Query3.ExecSQL;
                  except

                  end;
                end;
                except

                end;

            except
            end;
          end;
          MS_Query2.Next();
        end;
        try
          MS_Query2.Active:=false;
          MS_Query2.SQL.Clear;
          MS_Query2.SQL.Add('select `ext` from t_zd2 where `docid` = '''+MS_Query.FieldByName('id').AsString+'''');
          MS_Query2.Active:=true;
          norm:=0;
          hard:=0;
          good:=0;
          if MS_Query2.RecordCount>0 then
          begin
            MS_Query2.First;
            while not MS_Query2.Eof do
            begin
              if MS_Query2.FieldByName('ext').AsString = 'true' then norm:=norm+1;
              if MS_Query2.FieldByName('ext').AsString = 'th' then good:=good+1;
              if MS_Query2.FieldByName('ext').AsString = 'false' then hard:=hard+1;
              MS_Query2.Next;
            end;
            try
              if ((hard=0) and (good>0)) then
              begin
                MS_Query3.Active:=false;
                MS_Query3.SQL.Clear;
                MS_Query3.SQL.Add('update t_zd set `ext`=''th'' where `id` = '''+MS_Query.FieldByName('id').AsString+'''');
                MS_Query3.ExecSQL;
              end;
              if ((hard>0) and (good=0)) then
              begin
                MS_Query3.Active:=false;
                MS_Query3.SQL.Clear;
                MS_Query3.SQL.Add('update t_zd set `ext`=''false0'' where `id` = '''+MS_Query.FieldByName('id').AsString+'''');
                MS_Query3.ExecSQL;
              end;
              if ((hard>0) and (good>0)) then
              begin
                MS_Query3.Active:=false;
                MS_Query3.SQL.Clear;
                MS_Query3.SQL.Add('update t_zd set `ext`=''false1'' where `id` = '''+MS_Query.FieldByName('id').AsString+'''');
                MS_Query3.ExecSQL;
              end;
            except
            end;
          end;
        except

        end;
      except

      end;
      MS_Query.Next;
    end;
  except

  end;
end;

end.
