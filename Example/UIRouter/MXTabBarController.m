//
//  MXTabBarController.m
//  UIRouter
//
//  Created by caoye on 16/8/1.
//  Copyright © 2016年 “caoye”. All rights reserved.
//

#import "MXTabBarController.h"
#import "MessageViewController.h"
#import "WorkViewController.h"
#import "MineViewController.h"
#import "MessageModule.h"
#import "UIRouter.h"

@interface MXTabBarController ()

@end

@implementation MXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTabbar];
}

- (void)setTabbar {
    
    //    UIViewController *messageVC = [[UIRouter shareInstance] getViewControllerWithUrl:rootvc];
    MessageViewController * messageVC = [[MessageViewController alloc] init];
    UINavigationController * nav1 = [[UINavigationController alloc] initWithRootViewController:messageVC];
    UITabBarItem *messageItem = [[UITabBarItem alloc] initWithTitle:@"消息" image:[UIImage imageNamed:@"tab_message_nor"] selectedImage:[UIImage imageNamed:@"tab_message_sel"]];
    nav1.tabBarItem = messageItem;
    
    WorkViewController * workVC = [[WorkViewController alloc] init];
    UINavigationController * nav2 = [[UINavigationController alloc] initWithRootViewController:workVC];
    UITabBarItem *workItem = [[UITabBarItem alloc] initWithTitle:@"通讯录" image:[UIImage imageNamed:@"tab_work_nor"] selectedImage:[UIImage imageNamed:@"tab_work_sel"]];
    nav2.tabBarItem = workItem;
    
    MineViewController * mineVC = [[MineViewController alloc] init];
    UINavigationController * nav3 = [[UINavigationController alloc] initWithRootViewController:mineVC];
    UITabBarItem *mineItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"tab_mine_nor"] selectedImage:[UIImage imageNamed:@"tab_mine_sel"]];
    nav3.tabBarItem = mineItem;
    
    NSArray *controllers = [[NSArray alloc] initWithObjects:nav3,nav2,nav1, nil];
    self.viewControllers = controllers;
}

@end
