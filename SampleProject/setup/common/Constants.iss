// Copyright (C) Tenacom. All rights reserved. THIS IS PROPRIETARY SOFTWARE.
// Reproduction and/or distribution of this file by any means, digital or otherwise,
// is prohibited unless expressly permitted by Tenacom.

//============================================================================
// Required constants
//============================================================================

#ifndef APP_FULLNAME
  #error APP_FULLNAME must be defined and equal to the full path of the installed executable.
#endif

#ifndef APP_EXENAME
  #error APP_EXENAME must be defined and equal to the file name of the installed executable (without extension).
#endif

#ifndef APP_SEMANTIC_VERSION
  #error APP_SEMANTIC_VERSION must be defined and equal to the informational version of the project.
#endif

#ifndef APP_MINWINDOWSVERSION
  #error APP_MINWINDOWSVERSION must be defined and equal to the minimum required Windows version to run the program.
#endif

#ifndef APP_ARCHITECTURES
  #error APP_ARCHITECTURES must be defined and equal to the list of supported CPU architectures.
#endif

#ifndef APP_ARCHITECTURES_FOR_64BIT_SETUP
  #error APP_ARCHITECTURES_FOR_64BIT_SETUP must be defined and equal to the list of CPU architectures requiring 64-bit setup mode.
#endif

//============================================================================
// Optional constants
//============================================================================

#ifndef APP_ID
  #define APP_ID APP_FULLNAME
#endif

#ifndef APP_MAINEXE
  #define APP_MAINEXE "{app}\bin\" + APP_EXENAME + ".exe"
#endif

#ifndef SOURCE_LICENSEFILE
  #define SOURCE_LICENSEFILE ""
#endif

#ifndef APP_COMMENTS
  #define APP_COMMENTS ""
#endif

#ifndef APP_CONTACT
  #define APP_CONTACT "info@tenacom.it"
#endif

#ifndef APP_COPYRIGHT
  #define APP_COPYRIGHT "Copyright (c) Tenacom. Tutti i diritti riservati."
#endif

#ifndef COMPANY_SHORTNAME
  #define COMPANY_SHORTNAME "Tenacom"
#endif

#ifndef COMPANY_FULLNAME
  #define COMPANY_FULLNAME "Tenacom di R. De Agostini"
#endif

#ifndef COMPANY_WEBSITE
  #define COMPANY_WEBSITE "https://tenacom.it"
#endif

#ifndef COMPANY_SUPPORTPHONE
  #define COMPANY_SUPPORTPHONE "assistenza@tenacom.it"
#endif
