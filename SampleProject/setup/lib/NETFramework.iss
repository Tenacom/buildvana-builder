#ifndef _NETFRAMEWORK_INCLUDED
#define _NETFRAMEWORK_INCLUDED

#include "InnoDownloadPlugin.iss"

;=============================================================================
; .NET Framework prerequisite definitions
;=============================================================================

#ifndef NETFRAMEWORK_VERSION
  #error NETFRAMEWORK_VERSION not defined.
#endif

#if NETFRAMEWORK_VERSION == '4.6.1'
  #define NETFRAMEWORK_REGISTRY_VERSION 394254
  #define NETFRAMEWORK_SETUP_NAME 'NDP461-KB3102438-Web.exe'
  #define NETFRAMEWORK_SETUP_URL 'https://go.microsoft.com/fwlink/?LinkId=671728'
#elif NETFRAMEWORK_VERSION == '4.7.1'
  #define NETFRAMEWORK_REGISTRY_VERSION 461308
  #define NETFRAMEWORK_SETUP_NAME 'NDP471-KB4033344-Web.exe'
  #define NETFRAMEWORK_SETUP_URL 'https://go.microsoft.com/fwlink/?LinkId=852092'
#elif NETFRAMEWORK_VERSION == '4.7.2'
  #define NETFRAMEWORK_REGISTRY_VERSION 461808
  #define NETFRAMEWORK_SETUP_NAME 'NDP472-KB4054531-Web.exe'
  #define NETFRAMEWORK_SETUP_URL 'https://go.microsoft.com/fwlink/?LinkId=863262'
#else
  #error NETFRAMEWORK_VERSION has an unrecognized value.
#endif

[Code]

//============================================================================
// Global data
//============================================================================

var
  g_NETFramework_Installed: Boolean;
  g_NETFramework_SetupPath: string;

//============================================================================
// .NET Framework dependency management
//============================================================================

function NETFramework_IsInstalled: Boolean;
var
  release: Cardinal;
begin

  Result := RegQueryDWordValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full', 'Release', release) and (release >= {#NETFRAMEWORK_REGISTRY_VERSION});

end;

function NETFramework_InitializeSetup: Boolean;
begin

  Result := true;
  g_NETFramework_Installed := NETFramework_IsInstalled;
  if g_NETFramework_Installed then Exit;

  if SuppressibleMsgBox(
    '{#APP_FULLNAME} richiede la versione {#NETFRAMEWORK_VERSION} di .NET Framework, che non è ancora installata sul tuo computer.' + #13#10
    + #13#10
    + 'Se scegli di proseguire, .NET Framework {#NETFRAMEWORK_VERSION} verrà scaricato e installato prima di installare {#APP_FULLNAME}.' + #13#10
    + 'Altrimenti l''installazione verrà interrotta.' + #13#10
    + #13#10
    + 'Vuoi proseguire con l''installazione di .NET Framework e {#APP_FULLNAME}?'
    , mbConfirmation, MB_YESNO, IDYES
  ) <> IDYES then Result := false;

end;

procedure NETFramework_InitializeWizard;
begin

  if g_NETFramework_Installed then Exit;

  g_NETFramework_SetupPath := ExpandConstant('{tmp}') + '\{#NETFRAMEWORK_SETUP_NAME}';
  idpAddFile('{#NETFRAMEWORK_SETUP_URL}', g_NETFramework_SetupPath);
  idpDownloadAfter(wpReady);

end;

function NETFramework_PrepareToInstall(var NeedsRestart: Boolean): string;
var
  resultCode: Integer;
begin

  if g_NETFramework_Installed then begin
    Result := '';
    Exit;
  end;

  Exec(g_NETFramework_SetupPath, '/norestart /passive /showrmui', '', SW_SHOW, ewWaitUntilTerminated, resultCode);
  case resultCode of
    0: Result := '';
    1641, 3010: begin
      NeedsRestart := true;
      Result := '';
    end;
    1602: Result := 'L''installazione di .NET Framework è stata annullata.';
    1603: Result := 'L''installazione di .NET Framework è stata interrotta a causa di un errore.';
    5100: Result := 'Questo computer non soddisfa le specifiche richieste per l''installazione di .NET Framework.';
    else Result := 'Installazione di .NET Framework non riuscita. Codice errore: ' + IntToStr(resultCode);
  end;

end;

[Setup]

#endif
