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
+ (void)registerURL {
    
    [[UIRouter shareInstance] registerURLPattern:vcOne Class:[MessageViewControllerOne class]  toHandler:^(id param, UINavigationController *nav, JumpType type, UIViewController *fromVC) {
        MessageViewControllerOne * toVC = [[MessageViewControllerOne alloc] init];
        [self jumpTovc:type nav:nav fromeV:fromVC toVC:toVC urlString:vcOne];
    }];
    
    [[UIRouter shareInstance] registerURLPattern:vcTwo Class:[MessageViewControllerTwo class]  toHandler:^(id param, UINavigationController *nav, JumpType type, UIViewController *fromVC) {
        MessageViewControllerTwo * toVC = [[MessageViewControllerTwo alloc] init];
        toVC.hidesBottomBarWhenPushed = YES;
        [self jumpTovc:type nav:nav fromeV:fromVC toVC:toVC urlString:vcTwo];
    }];
    
}

- (NSArray *)getMessageData {
    MXMessageData *mxData = [[MXMessageData alloc] init];
    return [mxData messageData];
}


@end
