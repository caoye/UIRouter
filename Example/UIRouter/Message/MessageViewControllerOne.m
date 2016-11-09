//
//  MessageViewControllerOne.m
//  UIRouter
//
//  Created by caoye on 16/8/1.
//  Copyright © 2016年 “caoye”. All rights reserved.
//

#import "MessageViewControllerOne.h"
#import "MessageModule.h"

@interface MessageViewControllerOne ()

@end

@implementation MessageViewControllerOne

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"传递参数：%@", self.param);
}

- (IBAction)backHandleClick:(id)sender {
//    NSDictionary * dict = @{@"name":@"张三"};
//    self.handleBlock(dict);
//    
//    [[UIRouter shareInstance] closeViewControllerWithNavORvc:self.navigationController model:PopViewController viewController:nil animated:YES completion:^{
//        
//    }];
}

- (void)dealloc {
    NSLog(@"shif");
}

@end
