//
//  RegisterUrlClass.m
//  Router
//
//  Created by caoye on 16/7/29.
//  Copyright © 2016年 caoye. All rights reserved.
//

#import "UIRouter.h"
#import <objc/runtime.h>

//注册的key
static NSString * const blockKey  = @"block";
static NSString * const routerKey = @"router";
static NSString * const classKey  = @"controllerClass";
static NSString * const backBlockKey  = @"backBlockKey";

//调用的key
static NSString * const rouderToVcKey = @"rouderToVcKey";
static NSString * const rouderFromVcKey = @"rouderFromVcKey";
static NSString * const routerNavKey = @"routerNavKey";
static NSString * const routerTypeKey = @"routerTypeKey";
static NSString * const routerBoolKey = @"routerBoolKey";
static NSString * const routerClassKey = @"routerClassKey";

@implementation UIRouter

static UIRouter *sharedAccountManagerInstance = nil;

+ (UIRouter *)shareInstance
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

- (NSMutableDictionary *)dataDict {
    if (!_dataDict) {
        _dataDict = [[NSMutableDictionary alloc] init];
    }
    return _dataDict;
}
- (NSMutableDictionary *)cachDict {
    if (!_cachDict) {
        _cachDict = [[NSMutableDictionary alloc] init];
    }
    return _cachDict;
}

- (NSMutableDictionary *)paramDict {
    if (!_paramDict) {
        _paramDict = [[NSMutableDictionary alloc] init];
    }
    return _paramDict;
}

- (void)registerURLPattern:(NSString *)urlPattern Class:(Class)vcClass toHandler:(componentBlock)blk
{
    NSString * keyString = getCachDictKey(urlPattern);
    NSDictionary * routerDict = getRouterDict(urlPattern, vcClass, blk);
    [self.cachDict setObject:routerDict forKey:keyString];
}

- (UIRouter * (^)(JumpType))jump {
    return ^UIRouter *(JumpType type) {
        [self.dataDict setObject:[NSNumber numberWithInteger:type] forKey:routerTypeKey];
        return self;
    };
}

- (UIRouter * (^)(UIViewController *))fromVC {
    return ^UIRouter *(UIViewController * from) {
        [self.dataDict setObject:from forKey:rouderFromVcKey];
        return self;
    };
}

- (UIRouter * (^)(UIViewController *))toVC {
    return ^UIRouter *(UIViewController * tovc) {
        [self.dataDict setObject:tovc forKey:rouderToVcKey];
        return self;
    };
}

- (UIRouter * (^)(UINavigationController *))fromNav {
    return ^UIRouter *(UINavigationController * fromNav) {
        [self.dataDict setObject:fromNav forKey:routerNavKey];
        return self;
    };
}

- (void)handler:(handlerBlock)block {
    [[UIRouter shareInstance].dataDict setObject:block forKey:routerHandlerKey];
}

- (UIRouter * (^)(NSString *))openUrl {
    return ^UIRouter *(NSString *url) {
        UIViewController * fromVC = self.dataDict[rouderFromVcKey];
        if (!fromVC) {
            fromVC = self.dataDict[routerClassKey];
        }
        
        UINavigationController * nav = self.dataDict[routerNavKey];
        if (!nav) {
            nav = getNav();
        }
        
        JumpType type = [self.dataDict[routerTypeKey] integerValue];
        if (!type) {
            type = Push;
        }
        
        [self.dataDict removeAllObjects];
        [self.paramDict removeAllObjects];
        
        [self analysisUrl:url];
        NSDictionary *cachParam = self.cachDict[getCachDictKey(url)];
        componentBlock blk = cachParam[blockKey];
        if (blk) {
            blk(_paramDict, nav, type, fromVC);
        }

        return self;
    };
}

- (UIRouter * (^)(NSString *,id))openUrlWithParam {
    return ^UIRouter * (NSString *url, id param) {
        UIViewController * fromVC = self.dataDict[rouderFromVcKey];
        if (!fromVC) {
            fromVC = self.dataDict[routerClassKey];
        }
        
        UINavigationController * nav = self.dataDict[routerNavKey];
        if (!nav) {
            nav = getNav();
        }
        
        JumpType type = [self.dataDict[routerTypeKey] integerValue];
        if (!type) {
            type = Push;
        }
        
        [self.dataDict removeAllObjects];
        [self.paramDict removeAllObjects];
        NSDictionary *cachParam = self.cachDict[getCachDictKey(url)];
        componentBlock blk = cachParam[blockKey];
        if (blk) {
            blk(param, nav, type, fromVC);
        }
        
        return self;
    };
}

- (id (^)(NSString *))getVCFromUrl {
    return ^id (NSString *url) {
        NSDictionary *par = self.cachDict[getCachDictKey(url)];
        Class controllerClass = par[classKey];
        if (!controllerClass) {
            return nil;
        }
        return [[controllerClass alloc] init];
    };
}

- (void (^)(NSString *))deregisterURL {
    return ^void (NSString *url) {
        NSString * keySting = getCachDictKey(url);
        [[UIRouter shareInstance].cachDict removeObjectForKey:keySting];
    };
}

- (UIRouter * (^)(BOOL))animated {
    return ^UIRouter *(BOOL animated) {
        [self.dataDict setObject:[NSNumber numberWithBool:animated] forKey:routerBoolKey];
        return self;
    };
}

- (UIRouter * (^)(NSString *))closeWithUrl {
    return ^UIRouter * (NSString *url) {
        
        UIViewController * fromVC = self.dataDict[rouderFromVcKey];
        if (!fromVC) {
            fromVC = self.dataDict[routerClassKey];
        }
        
        UIViewController * toVC = self.dataDict[rouderToVcKey];
        
        JumpType type = [self.dataDict[routerTypeKey] integerValue];
        if (!type) {
            type = Pop;
        }
        
        UINavigationController * nav = self.dataDict[routerNavKey];
        id navOrVc = (nav==nil) ? fromVC : nav;
        
        if (!nav) {
            nav = getNav();
        }
        
        BOOL animated = [self.dataDict[routerBoolKey] boolValue];
        if (!self.dataDict[routerBoolKey]) {
            animated = YES;
        }
        
        switch (type) {
            case Pop:
                popViewController(nav, animated);
                break;
            case PopSome:
                popToSomeViewControlelr(nav, toVC, animated);
                break;
            case PopRoot:
                popToRootViewController(nav, animated);
                break;
            case Dismiss:
                dissmissViewController(navOrVc, animated);
                break;
            default:
                break;
        }
        [self.dataDict removeAllObjects];
        return self;
    };
}

//分解url获取传值
- (NSMutableDictionary *)analysisUrl:(NSString *)urlString {
    NSURL * url = [NSURL URLWithString:urlString];
    NSString * paramString = url.query;
    NSArray * paramArray = [paramString componentsSeparatedByString:@"&"];
    [self.paramDict removeAllObjects];
    [paramArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray* paramArr = [obj componentsSeparatedByString:@"="];
        if (paramArr.count > 1) {
            NSString* key = [paramArr objectAtIndex:0];
            NSString* value = [paramArr objectAtIndex:1];
            _paramDict[key] = value;
        }
    }];
    
    return _paramDict;
}

static inline void popViewController(id nav, BOOL animated) {
    if ([[nav class] isSubclassOfClass:[UINavigationController class]]) {
        [nav popViewControllerAnimated:animated];
    }
}

static inline void popToSomeViewControlelr(id nav, UIViewController *vc, BOOL animated) {
    if ([[nav class] isSubclassOfClass:[UINavigationController class]]) {
        [nav popToViewController:vc animated:animated];
    }
}

static inline void popToRootViewController(id nav, BOOL animated) {
    if ([[nav class] isSubclassOfClass:[UINavigationController class]]) {
        [nav popToViewController:((UINavigationController *)nav).viewControllers.firstObject animated:animated];
    }
}

static inline void dissmissViewController(id nav, BOOL animated) {
    dispatch_async(dispatch_get_main_queue(), ^{
        handlerBlock completion = [UIRouter shareInstance].dataDict[routerHandlerKey];
        [nav dismissViewControllerAnimated:animated completion:^{
            if (completion) {
                completion();
            }
        }];
    });
}

static inline NSDictionary *getRouterDict(NSString * router, Class vcClass, componentBlock blk) {
    return @{classKey:vcClass, routerKey:router, blockKey:blk};
}

static inline NSString *getCachDictKey(NSString *router) {
    NSURL * url = [NSURL URLWithString:router];
    NSString * keyString = [NSString stringWithFormat:@"%@%@", url.host,url.path];
    return keyString;
}

static inline UINavigationController *getNav() {
    id class = [UIRouter shareInstance].dataDict[routerClassKey];
    if ([class isKindOfClass:[UIViewController class]]) {
        return ((UIViewController*)class).navigationController;
    } else if ([class isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController *)class;
    }
    return nil;
}

- (id)tabbarSelectedWithClass:(id)class andIndex:(NSInteger)index andBlock:(void (^)(id blockParam))block{
    NSString * selectIndex = @"setSelectedIndex:";
    id manager = class;
    SEL customSelector = NSSelectorFromString(selectIndex);
    NSAssert1(customSelector, @"不存在方法%@", selectIndex);
    
    id result;
    if ([manager respondsToSelector:customSelector]){
        IMP imp = [manager methodForSelector:customSelector];
        id (*func)(id, SEL, id ) = (void *)imp;
        result = func(manager, customSelector,block);
    }
    return result;
}

@end

#pragma mark - UIRouter Category
@implementation NSObject (UIRouter)
@dynamic router;

- (UIRouter *)router {
    UIRouter *rout = [UIRouter shareInstance];
    [rout.dataDict setObject:self forKey:routerClassKey];
    return rout;
}

@end


