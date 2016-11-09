//
//  MineModule.m
//  UIRouter
//
//  Created by caoye on 16/8/4.
//  Copyright © 2016年 “caoye”. All rights reserved.
//

#import "MineModule.h"
#import "MineViewController.h"
#import "MineViewControllerOne.h"
#import "MineViewControllerTwo.h"
#import "UIRouter.h"

@implementation MineModule

//注册方法
+ (void)registerURL {
    [[UIRouter shareInstance] registerURLPattern:vcOnerac Class:[MineViewControllerOne class] toHandler:^(id param, UINavigationController *nav, JumpType type, UIViewController *fromVC) {
        MineViewControllerOne * toVC = [[MineViewControllerOne alloc] init];
        [self jumpTovc:type nav:nav fromeV:fromVC toVC:toVC];
    }];
    
    [[UIRouter shareInstance] registerURLPattern:vcTwoarc Class:[MineViewControllerTwo class] toHandler:^(id param, UINavigationController *nav, JumpType type, UIViewController *fromVC) {
        MineViewControllerTwo * toVC = [[MineViewControllerTwo alloc] init];
        UINavigationController * rootNav = [[UINavigationController alloc] initWithRootViewController:toVC];
        [self jumpTovc:type nav:nav fromeV:fromVC toVC:rootNav];
    }];
    
}

@end
