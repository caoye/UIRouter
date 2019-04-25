//
//  BaseModule.m
//  Pods
//
//  Created by caoye on 16/8/5.
//
//

#import "BaseModule.h"

@implementation BaseModule

+ (void)registerURL {
    
}

+ (void)jumpTovc:(JumpType)type nav:(UINavigationController *)nav fromeV:(UIViewController *)fromVC toVC:(id)toVC urlString:(NSString *)urlStr {
    callBackBlock block = [[[UIRouter router].cachDict objectForKey:getCachDictKey(urlStr)] objectForKey:backBlockKey];
    if ([toVC isKindOfClass:[UIViewController class]]) {
        ((UIViewController *)toVC).callBackBlock = block;
    }
    
    if ([toVC isKindOfClass:[UINavigationController class]]) {
        ((UINavigationController *)toVC).visibleViewController.callBackBlock = block;
    }
    
    if (type == Push) {
        handlerBlock completion = [UIRouter shareInstance].dataDict[routerHandlerKey];
        if (completion) {
            completion();
        }
        [nav pushViewController:toVC animated:YES];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [fromVC presentViewController:toVC animated:YES completion:^{
                handlerBlock completion = [UIRouter shareInstance].dataDict[routerHandlerKey];
                if (completion) {
                    completion();
                }
            }];
        });
    }
}

+ (void)jumpTovc:(JumpType)type nav:(UINavigationController *)nav fromeV:(UIViewController *)fromVC toVC:(id)toVC {
    
    if (type == Push) {
        handlerBlock completion = [UIRouter shareInstance].dataDict[routerHandlerKey];
        if (completion) {
            completion();
        }
        [nav pushViewController:toVC animated:YES];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [fromVC presentViewController:toVC animated:YES completion:^{
                handlerBlock completion = [UIRouter shareInstance].dataDict[routerHandlerKey];
                if (completion) {
                    completion();
                }
            }];
        });
    }
}

@end
