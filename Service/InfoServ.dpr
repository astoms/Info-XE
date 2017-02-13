program InfoServ;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils, ShellAPI, Tlhelp32, Windows;

function KillTask(ExeFileName: string): integer;
const
 PROCESS_TERMINATE=$0001;
var
 ContinueLoop: BOOL;
 FSnapshotHandle: THandle;
 FProcessEntry32: TProcessEntry32;
begin
 result := 0;

 FSnapshotHandle := CreateToolhelp32Snapshot
                    (TH32CS_SNAPPROCESS, 0);
 FProcessEntry32.dwSize := Sizeof(FProcessEntry32);
 ContinueLoop := Process32First(FSnapshotHandle,
                                FProcessEntry32);

 while integer(ContinueLoop) <> 0 do
 begin
   if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
        UpperCase(ExeFileName))
    or (UpperCase(FProcessEntry32.szExeFile) =
        UpperCase(ExeFileName))) then
     Result := Integer(TerminateProcess(OpenProcess(
                       PROCESS_TERMINATE, BOOL(0),
                       FProcessEntry32.th32ProcessID), 0));
   ContinueLoop := Process32Next(FSnapshotHandle,
                                 FProcessEntry32);
 end;

 CloseHandle(FSnapshotHandle);
end;

function FullDirectoryCopy(SourceDir, TargetDir: string; StopIfNotAllCopied,
  OverWriteFiles: Boolean): Boolean;
var
  SR: TSearchRec;
  I: Integer;
begin
  Result := False;
  SourceDir := IncludeTrailingBackslash(SourceDir);
  TargetDir := IncludeTrailingBackslash(TargetDir);
  if not DirectoryExists(SourceDir) then
    Exit;
  if not ForceDirectories(TargetDir) then
    Exit;

  I := FindFirst(SourceDir + '*', faAnyFile, SR);
  try
    while I = 0 do
    begin
      if (SR.Name <> '') and (SR.Name <> '.') and (SR.Name <> '..') then
      begin
        if SR.Attr = faDirectory then
          Result := FullDirectoryCopy(SourceDir + SR.Name, TargetDir + SR.NAME,
            StopIfNotAllCopied, OverWriteFiles)
        else if not (not OverWriteFiles and FileExists(TargetDir + SR.Name))
          then
          Result := CopyFile(Pchar(SourceDir + SR.Name), Pchar(TargetDir +
            SR.Name), False)
        else
          Result := True;
        if not Result and StopIfNotAllCopied then
          exit;
      end;
      I := FindNext(SR);
    end;
  finally
    System.SysUtils.FindClose(SR);
  end;
end;


begin
  try
    writeln('*********************************************');
    writeln;
  except
  end;
  try
    writeln(' * Завершаем работу Info-справочник товаров');
    KillTask('Info_XE.exe');
  except
  end;
  try
    writeln(' * Загружаем данные на компьютер');
    if FullDirectoryCopy('s:\IT-отдел\production\Info XE', GetCurrentDir, false, true) then
    begin
      writeln(' * Обновляем системные файлы');
    end
    else
    begin
      writeln;
      writeln(' Ошибка обновления! Пожалуйста сообщите об этом системному администратору.');
      readln;
    end;
  except
  end;
  try
    writeln(' * Запускаем Info-справочник товаров');
    WinExec('info_xe.exe', SW_SHOW);
  except
  end;
  try
    writeln;
    writeln('*********************************************');
  except
  end;
end.
