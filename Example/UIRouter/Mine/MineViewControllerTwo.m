//
//  MineViewControllerTwo.m
//  UIRouter
//
//  Created by caoye on 16/8/4.
//  Copyright © 2016年 “caoye”. All rights reserved.
//

#import "MineViewControllerTwo.h"
#import "UIRouter.h"
#import "MineModule.h"

@interface MineViewControllerTwo ()

@end

@implementation MineViewControllerTwo

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)backBtn:(id)sender {
    
    selfCallBackBlock(@"2222", CallBackThird);
    [self.router.fromVC(self).jump(Dismiss).closeWithUrl(vcTwoarc) handler:^{
        NSLog(@"wancheng");
    }];
    
}

- (void)dealloc {
    NSLog(@"dealloc");
}

@end
