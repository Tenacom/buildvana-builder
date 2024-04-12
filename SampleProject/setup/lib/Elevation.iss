#ifndef _ELEVATION_INCLUDED
#define _ELEVATION_INCLUDED

[Code]

procedure ExitProcess(uExitCode: UINT);
  external 'ExitProcess@kernel32.dll stdcall';

function ShellExecute(hwnd: HWND; lpOperation: string; lpFile: string; lpParameters: string; lpDirectory: string; nShowCmd: Integer): THandle;
  external 'ShellExecuteW@shell32.dll stdcall';

function IsElevated: Boolean;
begin

  Result := IsAdminLoggedOn or IsPowerUserLoggedOn;

end;

function Elevate: Boolean;
var
  i: Integer;
  j: Integer;
  s: string;
  params: string;
  retVal: Integer;
begin

  // Collect current instance parameters
  j := 1;
  for i := 1 to ParamCount do begin
    s := ParamStr(I);
    // Unique log file name for the elevated instance
    if CompareText(Copy(S, 1, 5), '/LOG=') = 0 then begin
      s := s + '-elevated';
    end;
    // Don't add /LANG parameter, it will be added later
    if CompareText(Copy(S, 1, 6), '/LANG=') <> 0 then begin
      if j > 1 then params := params + ' ';
      params := params + AddQuotes(s);
      Inc(j);
    end;
  end;

  // Add selected language, so the user doesn't get prompted for it again.
  params := params + '/LANG=' + ActiveLanguage;

  Log(Format('Elevating setup with parameters: [%s]', [params]));
  retVal := ShellExecute(0, 'runas', ExpandConstant('{srcexe}'), params, '', SW_SHOW);
  Log(Format('Running elevated setup returned [%d]', [retVal]));
  Result := retVal > 32;
  // If elevated executing of this setup succeeded, then...
  if Result then begin
    Log('Elevation succeeded');
    // Exit this non-elevated setup instance
    ExitProcess(0);
  end
  else begin
    Log(Format('Elevation failed: [%s]', [SysErrorMessage(retVal)]));
    MsgBox(
      'Errore #' + IntToStr(retVal) + ':' + #13#10
      + SysErrorMessage(retVal) + #13#10
      , mbCriticalError, MB_OK);
    ExitProcess(retVal);
  end;

end;

[Setup]

#endif
