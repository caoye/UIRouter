//
//  MineViewControllerOne.m
//  UIRouter
//
//  Created by caoye on 16/8/1.
//  Copyright © 2016年 “caoye”. All rights reserved.
//

#import "MineViewControllerOne.h"
#import "UIRouter.h"
#import "MineModule.h"

@interface MineViewControllerOne ()

@end

@implementation MineViewControllerOne

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)backBtn:(id)sender {
    if (self.callBackBlock) {
        self.callBackBlock(@"11111", CallBackThird);
    }
    self.router.closeWithUrl(vcOnerac);
}

- (void)dealloc {
    NSLog(@"deallocss");
}

@end
 
