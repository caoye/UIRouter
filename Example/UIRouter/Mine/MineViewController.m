//
//  MineViewController.m
//  UIRouter
//
//  Created by caoye on 16/8/1.
//  Copyright © 2016年 “caoye”. All rights reserved.
//

#import "MineViewController.h"
#import "UIRouter.h"
#import "MineModule.h"

@interface MineViewController ()

@end

@implementation MineViewController

static NSString * kCellIdentify = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    _dataArray = [[NSArray alloc] initWithObjects:@"直接push",@"获取某个vc",@"present",@"其他类型", nil];
    [_rootTable registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentify];
    _rootTable.delegate = self;
    _rootTable.dataSource = self;

//    UILabel *labeOne = ({
//        UILabel *label = [[UILabel alloc] init];
//        label;
//    });
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentify forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", _dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
            [self push];
            break;
        case 1:
            [self configVC];
            break;
        case 2:
            [self present];
            break;
        case 3:
            [self getMessageData];
            break;
        default:
            break;
    }
}

- (void)push {
    
   //简单用法
    self.router.openUrl(vcOnerac);
    
//    //带界面跳转完成回调用法
//    [[self.router callBackBlock:^(id param, CallBackType type) {
//        NSLog(@"-------%@---%ld",param, type);
//    }].openUrl(vcOnerac) handler:^{
//        NSLog(@"wancheng");
//    }];
//
    
    
    //传参数用法
//    self.router.openUrlWithParam(vcOnerac,@"参数");
    
    
//    UIRouter.router.fromNav(self.navigationController).openUrl(vcOnerac);
}

- (void)configVC {
    UIViewController * v1 = self.router.getVCFromUrl(vcOnerac);
    NSLog(@"******%@",v1);
}

- (void)present {
    //模态界面用法
    [[self.router callBackBlock:^(id param, CallBackType type) {
        NSLog(@"-------%@---%ld",param, type);
    }].jump(Present).openUrl(vcTwoarc) handler:^{
        NSLog(@"present 完成");
    }];
}

- (void)getMessageData {
   NSArray *dataArray = [UIRouter postModuleWithTarget:@"MessageModule" action:@selector(getMessageData) withObject:@"123"];
    NSLog(@"********%@", dataArray);
}

@end
