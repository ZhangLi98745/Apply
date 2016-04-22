//
//  CollectTableViewController.m
//  项目：我赢新闻重构版
//
//  Created by 张力 on 16/4/14.
//  Copyright © 2016年 zhangli. All rights reserved.
//

#import "CollectTableViewController.h"

@interface CollectTableViewController ()
@property (strong,nonatomic) FMDatabaseQueue *queue;
@end

@implementation CollectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arr = [[NSMutableArray alloc]init];
    AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
    self.queue = appdelegate.queue;
    [self loadDataFromSqlite];
    
}
-(void)viewDidAppear:(BOOL)animated{
    //NSLog(@"ffef");
    [self loadDataFromSqlite];
}
#pragma mark -下拉刷新
- (void)refreshHandler:(UIRefreshControl *)sender{
    [self loadDataFromSqlite];    
}
#pragma mark -sqlite
- (void)loadDataFromSqlite{
    if (!self.refreshControl.refreshing) {
        [self.refreshControl beginRefreshing];
    }
    [self.arr removeAllObjects];
    [self.queue inDatabase:^(FMDatabase *db) {
        [db open];
        NSString *sql = @"select * from newstable";
        FMResultSet *set = [db executeQuery:sql];
        while ([set next]) {
            NewsModel *n = [[NewsModel alloc]init];
            n.idid = [set stringForColumn:@"id"];
            n.title = [set stringForColumn:@"title"];
            n.time = [set stringForColumn:@"time"];
            n.content = [set stringForColumn:@"content"];
            n.author = [set stringForColumn:@"author"];
            n.clicks = [set stringForColumn:@"clicks"];
            n.imgData = [set dataForColumn:@"imageData"];
            [self.arr addObject:n];
        }
        //NSLog(@"%@",self.arr);
        [db close];
    }];
    self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%li",self.arr.count];
    [self.tableView reloadData];
    if (self.refreshControl.refreshing) {
        [self.refreshControl endRefreshing];
    }
    if (self.arr.count == 0) {
        [self.zhl showNotification:YES byViewController:self];
    }else {
        
        [self.zhl showNotification:NO byViewController:self];
    }
}
#pragma mark -重写父类的方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //增加点击数
    NewsModel *n = [[NewsModel alloc]init];
    n = self.arr[indexPath.row];
    NSInteger i = [n.idid integerValue];
    //NSLog(@"%li",i);
    [self.n addClick:i];
    //切换界面
    showNewController *snc = [[showNewController alloc]init];
    [self.navigationController pushViewController:snc animated:YES];
    snc.arr = self.arr;
    snc.indexPath = indexPath;
    snc.num = 1;
}


@end
