//
//  MXLogger.h
//  MXLogger
//
//  Created by 王正一 on 16/6/27.
//  Copyright © 2016年 mx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXLogConfig.h"

@interface MXLogger : NSObject

+ (instancetype)sharedLogger;

- (void)configMXLogWithConfiguration:(MXLogConfig *)configuration;

// MARK: - 日志输出方法,不建议手动调用,请用宏
- (void)printLogWithObject:(id)object viaLevel:(MXLogLevel)level thenFile:(NSString *)file callerClass:(NSString *)caller callerFunc:(NSString *)func;

@end
