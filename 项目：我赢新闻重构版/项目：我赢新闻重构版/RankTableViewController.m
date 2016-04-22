//
//  RankTableViewController.m
//  项目：我赢新闻重构版
//
//  Created by 张力 on 16/4/14.
//  Copyright © 2016年 zhangli. All rights reserved.
//

#import "RankTableViewController.h"

@interface RankTableViewController ()

@end

@implementation RankTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.n = [[NewsModel alloc]init];
    self.n.delegate = self;
    self.n.arr = [[NSMutableArray alloc]init];
    self.arr = self.n.arr;
    [self.n getRank];
    [self.zhl showNotificationError:nil byViewController:self];
    [self.zhl showProgressView:YES];
}
#pragma mark -下拉刷新
- (void)refreshHandler:(UIRefreshControl *)sender{
    [self.n getRank];
}

@end
