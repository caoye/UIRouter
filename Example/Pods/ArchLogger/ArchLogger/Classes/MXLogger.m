//
//  MXLogger.m
//  MXLogger
//
//  Created by 王正一 on 16/6/27.
//  Copyright © 2016年 mx. All rights reserved.
//

#import "MXLogger.h"
#import "MXLogView.h"
#import <MessageUI/MessageUI.h>

@interface MXLogger()<MFMailComposeViewControllerDelegate>
@property (nonatomic, strong) MXLogConfig *config;
@property (nonatomic, strong) MXLogView *logView;
@property (nonatomic, assign) BOOL isLogShown;

@end

@implementation MXLogger

+ (instancetype)sharedLogger {
    static MXLogger* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)configMXLogWithConfiguration:(MXLogConfig *)configuration {
    self.config = configuration;
    self.isLogShown = NO;
    [self deleteExpireLogWithInterval:_config.autoClearInterval];
    if (_config.hasDebugView) {
//        [self deployLogViewToKeyWindow];
#pragma warnning IMSDK
        UIWindow *keyWin = [UIApplication sharedApplication].keyWindow;
        UITapGestureRecognizer *guesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendMailWithIMSDKLog)];
        guesture.numberOfTapsRequired = 5;
        [keyWin addGestureRecognizer:guesture];
    }
}

/**
 *发送日志到邮箱
 */
- (void)sendMailWithIMSDKLog
{
    // 邮件服务器
    MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
    // 设置邮件代理
    [mailCompose setMailComposeDelegate:self];
    
    // 设置抄送人
    [mailCompose setToRecipients:@[@"duanzhilin@gomeplus.com"]];
    
    NSString *emailContent = @"邮件内容:";
    
    // 是否为HTML格式
    [mailCompose setMessageBody:emailContent isHTML:NO];
    
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"IMLog.log"];
    
    NSFileManager *fileManage = [NSFileManager defaultManager];
    
    if ([fileManage fileExistsAtPath:file]) {
        
        NSData *fileData = [NSData dataWithContentsOfFile:file];
        //添加附件
        [mailCompose addAttachmentData:fileData mimeType:@"" fileName:@"IMLog.log"];
    }
    // 弹出邮件发送视图
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:mailCompose animated:YES completion:nil];
}

- (void)printLogWithObject:(id)object viaLevel:(MXLogLevel)level thenFile:(NSString *)file callerClass:(NSString *)caller callerFunc:(NSString *)func {
    if (!_config) {
        self.config = [MXLogConfig defaultConfiguration];
    }
    if ([self shouldPrintByLevel:level]) {
        NSString *colorString = @"";
        colorString = _config.logColors[level];
        NSString *statusStr;
        switch (level) {
            case MXLogLevelVerbose:
                statusStr = @"Verbose";
                break;
            case MXLogLevelInfo:
                statusStr = @" Info  ";
                break;
            case MXLogLevelWarning:
                statusStr = @"Warning";
                break;
            default:
                statusStr = @" Error ";
                break;
        }
        NSString *desc = [NSString stringWithCString:[object cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding]?:object;
        NSMutableString *printString = [NSMutableString stringWithFormat:@"<%@%@%@> [%@:%d]%@:%@", colorString, statusStr, colorString, [file lastPathComponent], __LINE__, func, desc];
        printf("%s\n" ,printString.UTF8String);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MXLogView" object:printString];
        if (self.config.localSave) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self writeLog:printString ToFile:_config.logPath];
            });
        }
    }
}

- (BOOL)shouldPrintByLevel:(MXLogLevel)outputLevel {
    if (!_config.enable) {
        return NO;
    } else if (outputLevel < _config.shownLevel) {
        return NO;
    } else {
        return YES;
    }
}

- (void)writeLog:(NSString *)log ToFile:(NSString *)logPath {
    BOOL isDirExist = [[NSFileManager defaultManager] fileExistsAtPath:logPath];
    if (!isDirExist) {
        [[NSFileManager defaultManager] createFileAtPath:logPath contents:nil attributes:nil];
    }
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:logPath];
    if (!fileHandle) {
        return;
    }
    [fileHandle seekToEndOfFile];
    NSData *dataToWrite = [[log stringByAppendingString:@"\n"] dataUsingEncoding:NSUTF8StringEncoding];
    if (!dataToWrite) {
        return;
    }
    [fileHandle writeData:dataToWrite];
    [fileHandle closeFile];
}

- (void)showOrHideLogView {
    if (_isLogShown) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MXLogView" object:@"hideLogView"];
        _isLogShown = NO;
    } else {
        if (![UIApplication sharedApplication].keyWindow) {
            [self deployLogViewToKeyWindow];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MXLogView" object:@"showLogView"];
        _isLogShown = YES;
    }
}

// 初始化输出view到keyWindow
- (void)deployLogViewToKeyWindow {
    UIWindow *keyWin = [UIApplication sharedApplication].keyWindow;
    self.logView = [[MXLogView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * 0.7, [UIScreen mainScreen].bounds.size.height * 0.5)];
    [keyWin addSubview:_logView];
    UITapGestureRecognizer *guesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showOrHideLogView)];
    guesture.numberOfTapsRequired = 3;
    [keyWin addGestureRecognizer:guesture];
}

- (void)deleteExpireLogWithInterval:(NSInteger)interval {
    NSString *path = [_config.logPath stringByDeletingLastPathComponent];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    formatter.dateFormat = @"yyyyMMdd";
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    [files enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    NSString *name = obj;
    if ([name rangeOfString:@".log"].location == NSNotFound) return;
    name = [[[[name componentsSeparatedByString:@"."] firstObject] componentsSeparatedByString:@"-"] lastObject];
    if (dateString.integerValue - name.integerValue > interval) {
    [[NSFileManager defaultManager] removeItemAtPath:[path stringByAppendingPathComponent:obj] error:nil];
    }}];
}

@end
