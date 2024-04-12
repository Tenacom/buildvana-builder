// Copyright (C) Tenacom. All rights reserved. THIS IS PROPRIETARY SOFTWARE.
// Reproduction and/or distribution of this file by any means, digital or otherwise,
// is prohibited unless expressly permitted by Tenacom.

;=============================================================================
; Internationalization
;=============================================================================

[Setup]
ShowLanguageDialog=no
LanguageDetectionMethod=none

[Languages]
Name: "it"; MessagesFile: "compiler:Languages\Italian.isl"

; Inno Download Plugin language files
#ifdef _INNODOWNLOADPLUGIN_INCLUDED
  #include <unicode\idplang\Italian.iss>
#endif
