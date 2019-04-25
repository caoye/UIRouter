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
static NSString * const backBlockKey  = @"backBlockKey";

typedef NS_ENUM(NSUInteger, JumpType) {
    Push,
    Present,
    Pop,
    PopRoot,
    PopSome,
    Dismiss,
};

typedef NS_ENUM(NSInteger, CallBackType) {
    CallBackFirst,
    CallBackSecond,
    CallBackThird,
    CallBackFourth,
    CallBackFifth,
    CallBackSixth,
    CallBackSeventh,
    CallBackEighth,
    CallBackNinth,
    CallBackTenth
};

@interface UIRouter : NSObject

typedef void (^componentBlock) (id param, UINavigationController *nav, JumpType type, UIViewController *fromVC);
typedef void (^handlerBlock) (void);
typedef void (^callBackBlock)(id param, CallBackType type);

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

- (UIRouter *)callBackBlock:(callBackBlock)callBack;
- (void)handler:(handlerBlock)block;

// 绑定URI和Class
- (void)registerURLPattern:(NSString *)urlPattern Class:(Class)vcClass toHandler:(componentBlock)blk;

// 注册业务模块
- (void)registerModules:(NSArray *)modulesArray;

// 带回调模块之间调用
+ (id)postModuleWithTarget:(NSString *)moduleStr action:(SEL)aSelector withObject:(id)obj;

// 不带回调模块之间调用
+ (id)postModuleWithTarget:(NSString *)moduleStr action:(SEL)aSelector withObject:(id)obj callBackBlock:(void (^)(id blockParam))block;

NSString *getCachDictKey(NSString *router);



@end

@interface NSObject (UIRouter)

@property (nonatomic, strong) UIRouter *router;
@property (nonatomic,copy) callBackBlock callBackBlock;

@end

