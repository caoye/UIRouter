//
//  RegisterUrlClass.h
//  Router
//
//  Created by caoye on 16/7/29.
//  Copyright © 2016年 caoye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSString * const routerHandlerKey = @"routerHandlerKey";

typedef NS_ENUM(NSUInteger, JumpType) {
    Push,
    Present,
    Pop,
    PopRoot,
    PopSome,
    Dismiss,
};

@interface UIRouter : NSObject

typedef void (^componentBlock) (id param, UINavigationController *nav, JumpType type, UIViewController *fromVC);
typedef void (^handlerBlock) (void);

@property (nonatomic, strong) NSMutableDictionary * dataDict;
@property (nonatomic, strong) NSMutableDictionary * paramDict;
@property (nonatomic, strong) NSMutableDictionary * cachDict;

@property(nonatomic, copy) UIRouter *(^jump)(JumpType type);
@property(nonatomic, copy) UIRouter *(^fromVC)(UIViewController *VC);
@property(nonatomic, copy) UIRouter *(^toVC)(UIViewController *VC);
@property(nonatomic, copy) UIRouter *(^fromNav)(UINavigationController *nav);
@property(nonatomic, copy) UIRouter *(^openUrl)(NSString *url);
@property(nonatomic, copy) UIRouter *(^openUrlWithParam)(NSString *url,id param);
@property(nonatomic, copy) UIRouter *(^animated)(BOOL animated);
@property(nonatomic, copy) UIRouter *(^closeWithUrl)(NSString *url);
@property(nonatomic, copy) id (^getVCFromUrl)(NSString *url);
@property(nonatomic, copy) void (^deregisterURL)(NSString *url);

+ (UIRouter *)shareInstance;
- (void)handler:(handlerBlock)block;
- (void)registerURLPattern:(NSString *)urlPattern Class:(Class)vcClass toHandler:(componentBlock)blk;

@end

@interface NSObject (UIRouter)

@property (nonatomic, strong) UIRouter *router;

@end
