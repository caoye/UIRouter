//
//  BaseModule.h
//  Pods
//
//  Created by caoye on 16/8/5.
//
//

#import <Foundation/Foundation.h>
#import "UIRouter.h"

#define selfCallBackBlock(param, type) \
    if (self.callBackBlock && [self isMemberOfClass:[UIViewController class]]) {\
        self.callBackBlock(param, type);\
    } else {\
        NSLog(@"触发回调者不是<UIViewController>或者没有设置回调处理");\
    }

@interface BaseModule : NSObject

// 有回调
+ (void)jumpTovc:(JumpType)type nav:(UINavigationController *)nav fromeV:(UIViewController *)fromVC toVC:(id)toVC urlString:(NSString *)urlStr;
// 无回调
+ (void)jumpTovc:(JumpType)type nav:(UINavigationController *)nav fromeV:(UIViewController *)fromVC toVC:(id)toVC;
+ (void)registerURL;

@end
