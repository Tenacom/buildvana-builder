// Copyright (C) Tenacom. All rights reserved. THIS IS PROPRIETARY SOFTWARE.
// Reproduction and/or distribution of this file by any means, digital or otherwise,
// is prohibited unless expressly permitted by Tenacom.

[Code]

//============================================================================

function GetUninstallMutexName: string;
begin

  Result := RemoveQuotes('{#emit SetupSetting("AppId")}') + '_uninstalling';

end;

//============================================================================

function IsCommandLineFlagPresent(flag: String): Boolean;
var
  p: String;
  i: Integer;
begin

  p := '+' + flag;
  Result := True;
  for i := 1 to ParamCount do begin
    if SameText(p, ParamStr(i)) then Exit;
  end;

  Result := False;

end;

//============================================================================

function GetCommandLineArgument(name: String): String;
var
  prefix      : String;
  prefixLength: Integer;
  i           : Integer;
  parameter   : String;
begin

  prefix := '+' + name + '=';
  prefixLength := Length(prefix);
  for i := 1 to ParamCount do begin
    parameter := ParamStr(i);
    if (Length(parameter) >= prefixLength) and SameText(prefix, Copy(parameter, 1, prefixLength)) then begin
      Result := Copy(parameter, prefixLength + 1, Length(parameter) - prefixLength);
      Exit;
    end;
  end;

  Result := '';

end;

//============================================================================

procedure WaitForProgramToTerminate;
var
  mutexName: String;
begin

  mutexName := GetCommandLineArgument('APPMUTEX');
  if Length(mutexName) = 0 then Exit;

  while CheckForMutexes(mutexName) do Sleep(100);

end;

//============================================================================

procedure RestartProgram;
var
  exePath   : String;
  appName   : String;
  resultCode: Integer;
begin

  exePath := ExpandConstant('{#APP_MAINEXE}');
  Log('Restarting program: ' + exePath);
  if (not ExecAsOriginalUser(exePath, '/updated', '', SW_SHOW, ewNoWait, resultCode)) then begin
    appName := RemoveQuotes('{#SetupSetting("AppName")}');
    SuppressibleMsgBox(
      'C''è stato un problema riavviando ' + appName + ':' #13#10 #13#10 + SysErrorMessage(resultCode),
      mbError,
      MB_OK,
      IDOK);
  end;

end;

//============================================================================

function GetUninstallString(): String;
var
  rootKey        : Integer;
  appId          : String;
  subKeyName     : String;
  uninstallString: String;
begin

  if Is64BitInstallMode then rootKey := HKEY_AUTO_64 else rootKey := HKEY_AUTO_32;
  appId := RemoveQuotes('{#SetupSetting("AppId")}');
  subKeyName := 'Software\Microsoft\Windows\CurrentVersion\Uninstall\' + appId + '_is1';

  uninstallString := '';
  RegQueryStringValue(rootKey, subKeyName, 'UninstallString', uninstallString);
  Result := RemoveQuotes(uninstallString);

end;

//============================================================================

function UninstallInstalledVersion: Integer;
var
  uninstallString: String;
  exitCode       : Integer;
  mutexName      : String;
begin

  // Return values:
  // 0 = uninstall string not found or empty
  // 1 = error executing the uninstaller
  // 2 = successfully executed the uninstaller

  Result := 0;
  uninstallString := GetUninstallString();
  if uninstallString = '' then begin
//    MsgBox('Uninstaller not found.', mbInformation, MB_OK);
    Exit;
  end;

  Result := 1;
  if not Exec(uninstallString, '/VERYSILENT /NORESTART /SUPPRESSMSGBOXES +PRESERVEDATA +MUTEX', '', SW_HIDE, ewWaitUntilTerminated, exitCode) then Exit;
//  MsgBox('Uninstaller exit code = ' + IntToStr(exitCode), mbInformation, MB_OK);
  if exitCode <> 0 then Exit;

  mutexName := GetUninstallMutexName;
  while CheckForMutexes(mutexName) do Sleep(100);

//  MsgBox('UninstallInstalledVersion done.', mbInformation, MB_OK);

  Result := 2;

end;

//============================================================================

procedure DeleteDataFolder;
var
  appDir : String;
  dataDir: String;
begin

  appDir := ExpandConstant('{app}');
  dataDir := AddBackslash(appDir) + 'data';

  DelTree(dataDir, true, true, true);

end;

//============================================================================

procedure DeleteLeftoverFolders(forceDelete: Boolean);
var
  appDir      : String;
  appParentDir: String;
  findRec     : TFindRec;
begin

  appDir := ExpandConstant('{app}');
  if forceDelete then begin
    DelTree(appDir, true, true, true);
  end
  else begin
    if FindFirst(appDir, findRec) then begin
      FindClose(findRec);
    end
    else begin
      RemoveDir(appDir);
    end;
  end;

  // If {app}'s parent is empty, remove it as well.
  // This will get rid of e.g. {localappdata}\{companyName} if it is empty
  // after removing {localappdata}\{companyName}\{appName}.
  // This will not delete {programfiles} because it is never empty,
  // even on a fresh Windows installation.
  appParentDir := ExtractFileDir(appDir);
  if FindFirst(appParentDir, findRec) then begin
    FindClose(findRec);
  end
  else begin
    RemoveDir(appParentDir);
  end;

end;

//============================================================================

function PromptForDeletionOfDataFolder: Boolean;
var
  appName: String;
begin

  Result := false;

  appName := RemoveQuotes('{#SetupSetting("AppName")}');

  // NOTE: Yes and No prompts, as well as the meanings of IDYES and IDNO, are reversed here!
  //       Therefore IDYES means "keep the data folder" and IDNO means "delete it".
  //       This is because Yes is the default answer, and the default should be the safer option.

  // Prompt for deletion of whole application folder
  if SuppressibleTaskDialogMsgBox(
    'Cancellazione dei dati di ' + appName,
    'I dati salvati da ' + appName + ' su questo computer includono:' #13#10
    '  - la configurazione del programma;' #13#10
    '  - tutti i tuoi dati anagrafici e storici;' #13#10
    '  - i log di funzionamento (utili per l''assistenza).' #13#10 #13#10
    'Se non hai una copia di backup dei dati, andranno persi per sempre!' #13#10 #13#10
    'Nel dubbio, è sempre meglio NON cancellarli.',
    mbConfirmation,
    MB_YESNO, [
      'No, lascia i dati dove sono.' #13#10 'Voglio poterli recuperare o cancellare in seguito.',
      'Sì, cancella i dati.' #13#10 'Ho compreso il rischio e me ne assumo la responsabilità.'
    ],
    0,
    IDYES
  ) <> IDNO then Exit;

  if SuppressibleTaskDialogMsgBox(
    'Conferma della CANCELLAZIONE dei dati di ' + appName,
    'Perdonami se ti disturbo ancora, ma voglio essere proprio sicuro...' #13#10 #13#10
    'Stai per PERDERE PER SEMPRE tutti i dati di ' + appName + '.' #13#10 #13#10
    'Se non hai fatto un backup, non avrai nessun modo di recuperarli!',
    mbConfirmation,
    MB_YESNO, [
      'No, ci ho ripensato.' #13#10 'Meglio lasciare i dati dove sono, casomai servissero.',
      'Sì, va bene, cancellali.' #13#10 'La perdita dei dati è una mia responsabilità; confermo che li voglio cancellare.'
    ],
    0,
    IDYES
  ) <> IDNO then Exit;

  Result := true;

end;

//============================================================================

function ConfirmDeletionOfDataFolder: Boolean;
begin

  Result := false;

  if IsCommandLineFlagPresent('PRESERVEDATA') then Exit;

#ifdef CONFIRM_DELETION_OF_DATA_FOLDER

  Result := PromptForDeletionOfDataFolder;

#else

  Result := true;

#endif

end;

//============================================================================

<event('InitializeSetup')>
function InitializeSetup__WaitForProgramToTerminate: Boolean;
begin

  WaitForProgramToTerminate;

  Result := True;

end;

//============================================================================

#ifdef UNINSTALL_BEFORE_UPGRADE

<event('CurStepChanged')>
procedure CurStepChanged__UninstallBeforeUpgrade(curStep: TSetupStep);
begin

  if curStep = ssInstall then begin
    WaitForProgramToTerminate;
    UninstallInstalledVersion();
  end;

end;

#endif

//============================================================================

<event('CurStepChanged')>
procedure CurStepChanged__RestartProgram(curStep: TSetupStep);
begin
  
  if curStep = ssDone then begin
    if IsCommandLineFlagPresent('RESTART') then begin
      Log('Restarting program...');
      RestartProgram();
    end;
  end;

end;

//============================================================================

<event('InitializeUninstall')>
function InitializeUninstall__CreateUninstallMutex: Boolean;
begin

  if IsCommandLineFlagPresent('MUTEX') then begin
    CreateMutex(GetUninstallMutexName);
  end;

  Result := True;

end;

//============================================================================

<event('CurUninstallStepChanged')>
procedure CurUninstallStepChanged__DeleteFolders(curStep: TUninstallStep);
var
  binDir: String;
begin

  if curStep = usUninstall then begin
    // ------------------------------------------------------------
    // Always delete the bin subfolder, regardless of its contents.
    // ------------------------------------------------------------
    // For example: a bug is discovered, and during field testing
    // some DLLs are replaced with newly-compiled versions including PDB files.
    // Then a corrected version is distributed.
    // The PDB files, not being listed in the [Files] section, would remain in {app}\bin after uninstall,
    // preventing {app} from being deleted, and generally being useless hubris left around for no reason.
    binDir := ExpandConstant('{app}\bin');
    DelTree(binDir, true, true, true);
  end;

  if curStep = usPostUninstall then begin
    if ConfirmDeletionOfDataFolder() then begin
      DeleteDataFolder;
      DeleteLeftoverFolders(true);
    end
    else begin
      DeleteLeftoverFolders(false);
    end;
  end;

end;

//============================================================================
