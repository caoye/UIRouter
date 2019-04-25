//
//  MessageViewController.h
//  UIRouter
//
//  Created by caoye on 16/8/1.
//  Copyright © 2016年 “caoye”. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *rootTable;

@property (nonatomic, strong) NSArray * dataArray;

@end
