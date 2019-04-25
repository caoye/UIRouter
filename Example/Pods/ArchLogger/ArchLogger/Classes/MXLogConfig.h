//
//  MXLogConfig.h
//  MXLogger
//
//  Created by 王正一 on 16/6/29.
//  Copyright © 2016年 mx. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MXLogLevel){
    MXLogLevelVerbose   = 0,
    MXLogLevelInfo         = 1,
    MXLogLevelWarning   = 2,
    MXLogLevelError       = 3
};

@interface MXLogConfig : NSObject
// 是否开启日志输出(default: Debug = YES, Release = NO)
@property (nonatomic, assign) BOOL enable;
// 日志输出等级(default = Verbose)
@property (nonatomic, assign) MXLogLevel shownLevel;
// 输出日志的颜色集合,四个元素,分别为error,warning,info,verbose.(为固定格式字符串,不了解的不建议手动修改)
@property (nonatomic, strong) NSArray *logColors;
// 日志是否开启本地存储(default = NO)
@property (nonatomic, assign) BOOL localSave;
// 日志本地保存的地址(default = Document)
@property (nonatomic, copy) NSString *logPath;
// 是否启用日志调试窗口(default = NO)
@property (nonatomic, assign) BOOL hasDebugView;
// 自动清理log的时间间隔,单位:天(default = 7)
@property (nonatomic, assign) NSInteger autoClearInterval;

// 默认配置
+ (instancetype)defaultConfiguration;
// 配置输出等级和本地是否保存,其余项取默认值
+ (instancetype)configWithLogLevel:(MXLogLevel)logLevel andLocalSave:(BOOL)saveEnable debugView:(BOOL)viewEnable;

@end
