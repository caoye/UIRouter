//
//  MXLogConfig.m
//  MXLogger
//
//  Created by 王正一 on 16/6/29.
//  Copyright © 2016年 mx. All rights reserved.
//

#import "MXLogConfig.h"

@implementation MXLogConfig

+ (instancetype)defaultConfiguration {
    MXLogConfig *config = [[self alloc] init];
    config.logPath = [config getLogPath];
    config.logColors = @[@"⚪️", @"🎾", @"⚠️", @"‼️"];
    config.shownLevel = MXLogLevelVerbose;
    config.localSave = NO;
    config.autoClearInterval = 7;
    #if DEBUG
        config.enable = YES;
        config.hasDebugView = YES;
    #else
        config.enable = NO;
        config.hasDebugView = NO;
    #endif
    return config;
}

+ (instancetype)configWithLogLevel:(MXLogLevel)logLevel andLocalSave:(BOOL)saveEnable debugView:(BOOL)viewEnable {
    MXLogConfig *config = [[self alloc] init];
    config.logPath = [config getLogPath];
    config.logColors = @[@"⚪️", @"🎾", @"⚠️", @"‼️"];
    config.shownLevel = logLevel;
    config.localSave = saveEnable;
    config.autoClearInterval = 7;
    config.hasDebugView = viewEnable;
#if DEBUG
    config.enable = YES;
#else
    config.enable = NO;
#endif
    return config;
}

- (NSString *)getLogPath {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    formatter.dateFormat = @"yyyyMMdd";
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"MXLog-%@.log", dateString]];
    return path;
}

@end
