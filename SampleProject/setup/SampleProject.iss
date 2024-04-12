;=============================================================================
; Base definitions
;=============================================================================

#define SOURCE_MAINEXE AddBackslash(SETUP_SOURCEDIR) + APP_EXENAME + '.exe'
#define APP_MAINEXE AddBackslash('{app}') + APP_EXENAME + '.exe'

;=============================================================================
; Setup items
;=============================================================================

[Setup]
PrivilegesRequired=admin
MinVersion={#APP_MINWINDOWSVERSION}
ArchitecturesAllowed={#APP_ARCHITECTURES}
ArchitecturesInstallIn64BitMode={#APP_ARCHITECTURES_FOR_64BIT_SETUP}

[Files]
Source: "*.*"; Excludes: "*.pdb;*.json"; DestDir: "{app}"; Flags: recursesubdirs

[UninstallDelete]
Type: filesandordirs; Name: "{commonappdata}\{#APP_SHORTNAME}"

[Run]
Filename: "{#APP_MAINEXE}"; Parameters: "install"; StatusMsg: "Installing service..."; Flags: runascurrentuser runhidden waituntilterminated
Filename: "{#APP_MAINEXE}"; Parameters: "start"; StatusMsg: "Starting service..."; Flags: runascurrentuser runhidden waituntilterminated

[UninstallRun]
RunOnceId: "StopService"; Filename: "{#APP_MAINEXE}"; Parameters: "stop"; StatusMsg: "Stopping service..."; Flags: runascurrentuser runhidden waituntilterminated
RunOnceId: "UninstallService"; Filename: "{#APP_MAINEXE}"; Parameters: "uninstall"; StatusMsg: "Uninstalling service..."; Flags: runascurrentuser runhidden waituntilterminated

;=============================================================================
; Main Setup section
;=============================================================================

[Setup]
AppComments={#APP_COMMENTS}
AppContact={#APP_CONTACT}
AppCopyright={#APP_COPYRIGHT}
AppName={#APP_FULLNAME}
AppVersion={#APP_SEMANTIC_VERSION}
AppVerName="{#APP_FULLNAME} v{#APP_VERSION}"
AppPublisher={#COMPANY_FULLNAME}
AppPublisherURL={#COMPANY_WEBSITE}
AppSupportPhone={#COMPANY_SUPPORTPHONE}

; String version info for the setup executable.
; It's OK to use the real version here, since it's just written
; to the setup EXE.
VersionInfoCompany="{#GetStringFileInfo(SOURCE_MAINEXE, COMPANY_NAME)}"
VersionInfoCopyright="{#GetStringFileInfo(SOURCE_MAINEXE, LEGAL_COPYRIGHT)}"
VersionInfoProductTextVersion="{#GetStringFileInfo(SOURCE_MAINEXE, PRODUCT_VERSION)}"
VersionInfoTextVersion="{#GetStringFileInfo(SOURCE_MAINEXE, FILE_VERSION)}"
VersionInfoVersion="{#GetStringFileInfo(SOURCE_MAINEXE, FILE_VERSION)}"
VersionInfoDescription="{#APP_FULLNAME} Setup"
VersionInfoProductName="{#GetStringFileInfo(SOURCE_MAINEXE, PRODUCT_NAME)}"

DefaultGroupName="{#APP_FULLNAME}"
AlwaysUsePersonalGroup=False
AppendDefaultGroupName=False
DisableProgramGroupPage=True
DefaultDirName="{commonpf}\{#APP_SHORTNAME}"
AllowUNCPath=False
AppendDefaultDirName=False
DisableDirPage=True
CreateUninstallRegKey=yes
AppId="{#APP_FULLNAME}"
UsePreviousAppDir=yes
UsePreviousGroup=yes
UsePreviousLanguage=yes
UsePreviousSetupType=yes
UsePreviousTasks=yes
UsePreviousUserInfo=yes
WizardStyle=modern

Uninstallable=yes
UninstallDisplayIcon="{#APP_MAINEXE}"
UninstallDisplayName="{#APP_FULLNAME}"

AllowNoIcons=no
SolidCompression=yes
Compression=lzma2/ultra64
CompressionThreads=auto

; Downloading and installing dependencies will only work if the memo/ready page is enabled (default behaviour)
DisableStartupPrompt=yes
DisableReadyPage=no
DisableReadyMemo=yes
DisableWelcomePage=yes
AlwaysShowComponentsList=no
ShowComponentSizes=no
AllowCancelDuringInstall=no

;=============================================================================
; Internationalization
;=============================================================================

[Setup]
ShowLanguageDialog=no
LanguageDetectionMethod=none
