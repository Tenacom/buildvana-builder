// Copyright (C) Tenacom. All rights reserved. THIS IS PROPRIETARY SOFTWARE.
// Reproduction and/or distribution of this file by any means, digital or otherwise,
// is prohibited unless expressly permitted by Tenacom.

;=============================================================================
; Common Setup section items
;=============================================================================

[Setup]
AppId="{#APP_ID}"

AppComments={#APP_COMMENTS}
AppContact={#APP_CONTACT}
AppCopyright={#APP_COPYRIGHT}
AppName={#APP_FULLNAME}
AppVersion={#APP_SEMANTIC_VERSION}
AppPublisher={#COMPANY_FULLNAME}
AppPublisherURL={#COMPANY_WEBSITE}
AppSupportPhone={#COMPANY_SUPPORTPHONE}

; Don't set a version number, since it can change during an update.
; The updater cannot modify the registry if it's run under a normal user account.
AppVerName="{#APP_FULLNAME} v{#APP_VERSION}"

; String version info for the setup executable.
; It's OK to use the real version here, since it's just written
; to the setup EXE.
VersionInfoCompany="{#COMPANY_FULLNAME}"
VersionInfoCopyright="{#APP_COPYRIGHT}"
VersionInfoProductTextVersion="{#APP_SEMANTIC_VERSION}"
VersionInfoTextVersion="{#APP_SEMANTIC_VERSION}"
VersionInfoVersion={#APP_VERSION}
VersionInfoDescription="{#APP_FULLNAME} Setup"
VersionInfoProductName="{#APP_FULLNAME}"

SolidCompression=yes
Compression=lzma2/ultra64
CompressionThreads=auto

MinVersion={#APP_MINWINDOWSVERSION}
ArchitecturesAllowed={#APP_ARCHITECTURES}
ArchitecturesInstallIn64BitMode={#APP_ARCHITECTURES_FOR_64BIT_SETUP}

#ifdef SOURCE_LICENSEFILE
  LicenseFile={#SOURCE_LICENSEFILE}
#endif

WizardStyle=modern
