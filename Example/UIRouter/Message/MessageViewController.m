//
//  MessageViewController.m
//  UIRouter
//
//  Created by caoye on 16/8/1.
//  Copyright © 2016年 “caoye”. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageModule.h"
#import "MessageView.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

static NSString * kCellIdentify = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    _dataArray = [[NSArray alloc] initWithObjects:@"直接push",@"对vc有设置的push",@"present",@"其他类型", nil];
    [_rootTable registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentify];
//    _rootTable.delegate = self;
//    _rootTable.dataSource = self;
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
            [self other];
            break;
        default:
            break;
    }
}

- (void)push {
    
//    [[UIRouter shareInstance] openURL:vcOne withParam:@{@"bookId": @"newbook"} navORvc:self.navigationController block:^(id param) {
//        NSLog(@"回调  :%@", param);
//    }];
}

- (void)configVC {
    //    UIViewController * vc = [[UIRouter shareInstance] getViewControllerWithUrl:vcTwo];
    //    vc.hidesBottomBarWhenPushed = YES;
    //    [[UIRouter shareInstance] openUrlWithController:vc withParam:@{@"bookId": @"123456"} model:PushViewController navORvc:self.navigationController animated:YES block:^(id param) {
    //        NSLog(@"回调:%@", param);
    //    }];
    
//    [[UIRouter shareInstance] openURL:vcTwo withParam:@{@"bookId": @"123456"} navORvc:self.navigationController block:^(id param) {
//        NSLog(@"回调  :%@", param);
//    }];
}

- (void)present {
//    [[UIRouter shareInstance] openURL:vcThree withParam:@{@"bookId": @"33234"} navORvc:self block:^(id param) {
//        NSLog(@"回调:%@", param);
//    }];
}

- (void)other {
    
    //    MessageView * view = [[UIRouter shareInstance] getViewControllerWithUrl:viewFour];
    //    NSLog(@"其它类型:%p",view);
}

@end
