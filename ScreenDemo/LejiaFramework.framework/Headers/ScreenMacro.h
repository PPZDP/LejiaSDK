//
//  ScreenMacro.h
//  LeJiaScreenProject
//
//  Created by sos1a2a3a on 2018/11/9.
//  Copyright © 2018 lijiarui. All rights reserved.
//

// true or  false
#define LogOn false

#if LogOn
#define AILogInfo(fmt, ...) NSLog((fmt), ##__VA_ARGS__);
#else
#define AILogInfo(fmt, ... )

#endif
