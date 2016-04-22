//
//  NewsTableViewController.m
//  项目：我赢新闻重构版
//
//  Created by 张力 on 16/4/14.
//  Copyright © 2016年 zhangli. All rights reserved.
//

#import "NewsTableViewController.h"
#import "ZHLScrollView.h"
@interface NewsTableViewController ()
@property (strong,nonatomic) ZHLScrollView *scrollTittleView;
@property (assign,nonatomic) UIButton *b;
@end

@implementation NewsTableViewController
#define H self.view.bounds.size.height
#define W self.view.bounds.size.width
- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollTittleView = [[ZHLScrollView alloc]initWithFrame:CGRectMake(0, 0, W, 44)];
    NSArray *buttonArr = @[@"最新",@"国内",@"国际",@"社会",@"关注"];
    for ( int i = 0; i < buttonArr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = i + 1;
        [button setTitle:buttonArr[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickHandler:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollTittleView addButton:button];
    }
    self.navigationItem.titleView = _scrollTittleView;
    self.n = [[NewsModel alloc]init];
    self.n.delegate = self;
    self.n.arr = [[NSMutableArray alloc]init];
    self.arr = self.n.arr;
    NSLog(@"%@",self.n);
    [self.n getNewsByID:1];
    [self.zhl showProgressView:YES];

}
#pragma mark -下拉刷新
- (void)refreshHandler:(UIRefreshControl *)sender{
    [self.n getNewsByID:(int)self.b.tag];
}
- (void)clickHandler:(UIButton *)sender{
    if (sender != self.b) {
        self.b = sender;
        NSLog(@"%li",sender.tag);
        [self.zhl showNotificationError:nil byViewController:self];
        [_scrollTittleView selectButton:sender];
        //显示加载进度的试图
        [self.zhl showProgressView:YES];
        [self.n getNewsByID:(int)sender.tag];
    }
    
}
- (void)finishReadJsonData
{   NSLog(@"finishReadJsonData");
    [self.zhl showProgressView:NO];
    [self.zhl showNotificationError:nil byViewController:self];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
    AppDelegate *a = [UIApplication sharedApplication].delegate;
    self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%li",self.arr.count];
    AudioServicesPlaySystemSound(a.soundID);}
- (void)requestWrongAlert:(NSError *)err
{
    [self.zhl showProgressView:NO];
    [self.zhl showNotificationError:err byViewController:self];
    [self.arr removeAllObjects];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

@end
