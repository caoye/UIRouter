//
//  BaseModule.h
//  Pods
//
//  Created by caoye on 16/8/5.
//
//

#import <Foundation/Foundation.h>
#import "UIRouter.h"

@interface BaseModule : NSObject

+ (void)jumpTovc:(JumpType)type nav:(UINavigationController *)nav fromeV:(UIViewController *)fromVC toVC:(id)toVC;
+ (void)registerURL;

@end
