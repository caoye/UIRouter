//
//  MessageModule.m
//  UIRouter
//
//  Created by caoye on 16/8/2.
//  Copyright © 2016年 “caoye”. All rights reserved.
//

#import "MessageModule.h"
#import "MessageViewController.h"
#import "MessageViewControllerOne.h"
#import "MessageViewControllerTwo.h"
#import "MessageViewControllerThree.h"
#import "MessageView.h"

@implementation MessageModule

//注册方法
+ (void)load {
    
//    [[UIRouter shareInstance] registerURLPattern:vcOne Class:[MessageViewControllerOne class]  toHandler:^(id param, id nav, UIViewController *toVC) {
//        [nav pushViewController:toVC animated:YES];
//    }];
//    
//    [[UIRouter shareInstance] registerURLPattern:vcTwo Class:[MessageViewControllerTwo class]  toHandler:^(id param, id nav, UIViewController *toVC) {
//        toVC.hidesBottomBarWhenPushed = YES;
//        [nav pushViewController:toVC animated:YES];
//    }];
//    
//    [[UIRouter shareInstance] registerURLPattern:vcThree Class:[MessageViewControllerThree class]  toHandler:^(id param, id nav, UIViewController *toVC) {
//        [nav presentViewController:toVC animated:YES completion:^{
//            
//        }];
//    }];
    
}

@end
