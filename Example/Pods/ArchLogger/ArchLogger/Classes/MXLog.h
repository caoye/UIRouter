//
//  MXLog.h
//  MXLogger
//
//  Created by 王正一 on 16/6/27.
//  Copyright © 2016年 mx. All rights reserved.
//

#ifndef MXLog_h
#define MXLog_h

#import "MXLogger.h"

#define MXLog(frmt, ...) [[MXLogger sharedLogger] printLogWithObject:[NSString stringWithFormat:frmt, ##__VA_ARGS__] viaLevel:MXLogLevelVerbose thenFile:[NSString stringWithUTF8String:__FILE__] callerClass:nil callerFunc:[NSString stringWithUTF8String:__PRETTY_FUNCTION__]]
#define MXLogInfo(frmt, ...) [[MXLogger sharedLogger] printLogWithObject:[NSString stringWithFormat:frmt, ##__VA_ARGS__] viaLevel:MXLogLevelInfo thenFile:[NSString stringWithUTF8String:__FILE__] callerClass:nil callerFunc:[NSString stringWithUTF8String:__PRETTY_FUNCTION__]]
#define MXLogWarn(frmt, ...) [[MXLogger sharedLogger] printLogWithObject:[NSString stringWithFormat:frmt, ##__VA_ARGS__] viaLevel:MXLogLevelWarning thenFile:[NSString stringWithUTF8String:__FILE__] callerClass:nil callerFunc:[NSString stringWithUTF8String:__PRETTY_FUNCTION__]]
#define MXLogError(frmt, ...) [[MXLogger sharedLogger] printLogWithObject:[NSString stringWithFormat:frmt, ##__VA_ARGS__] viaLevel:MXLogLevelError thenFile:[NSString stringWithUTF8String:__FILE__] callerClass:nil callerFunc:[NSString stringWithUTF8String:__PRETTY_FUNCTION__]]

#endif /* MXLog_h */
