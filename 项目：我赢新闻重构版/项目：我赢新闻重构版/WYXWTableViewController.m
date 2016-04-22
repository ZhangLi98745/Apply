//
//  WYXWTableViewController.m
//  项目：我赢新闻重构版
//
//  Created by 张力 on 16/4/14.
//  Copyright © 2016年 zhangli. All rights reserved.
//

#import "WYXWTableViewController.h"

@interface WYXWTableViewController ()<finishReadJsonData>

@end
@implementation WYXWTableViewController
#define H self.view.bounds.size.height
#define W self.view.bounds.size.width
- (void)viewDidLoad{
    [super viewDidLoad];
    _zhl = [[ZHLProgressViewHud alloc]init];
    //self.n.arr = [[NSMutableArray alloc]init];
    self.n.delegate = self;
    self.arr = self.n.arr;
    self.refreshControl = [[UIRefreshControl alloc]init];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"正在刷新..."];
    [self.refreshControl addTarget:self action:@selector(refreshHandler:) forControlEvents:UIControlEventValueChanged];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}
#pragma mark -下拉刷新
- (void)refreshHandler:(UIRefreshControl *)sender{
}

#pragma mark -数据加载之后回调函数
- (void)finishReadJsonData
{   NSLog(@"finishReadJsonData");
    [_zhl showProgressView:NO];
    [_zhl showNotificationError:nil byViewController:self];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
    AppDelegate *a = [UIApplication sharedApplication].delegate;
    self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%li",self.arr.count];
    AudioServicesPlaySystemSound(a.soundID);}
- (void)requestWrongAlert:(NSError *)err
{
    [_zhl showProgressView:NO];
    [_zhl showNotificationError:err byViewController:self];
    [self.arr removeAllObjects];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}
//下载图片的进程
-(void)downloadPic:(NSIndexPath *)i{
    NewsModel *n = self.arr[i.row];
    NSString *str = [NSString stringWithFormat:@"http://115.159.1.248:56666/xinwen/images/%@",n.picture];
    NSURL *url = [NSURL URLWithString:str];
    NSData *data = [NSData dataWithContentsOfURL:url];
    n.imgData = data;
    UIImage *img = [UIImage imageWithData:data];
    newCell *cell = [self.tableView cellForRowAtIndexPath:i];
    
    [cell.imgView performSelectorOnMainThread:@selector(setImage:) withObject:img waitUntilDone:NO];
}
#pragma mark -表格代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"numberOfSectionsInTableView");
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    newCell *cell = [tableView dequeueReusableCellWithIdentifier:@"123"];
    if (cell == nil) {
        cell = [[newCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"123"andTableView:tableView];
    }
    NewsModel *n = self.arr[indexPath.row];
    cell.tittleLabel.text = n.title;
    cell.hitsLabel.text = n.clicks;
    cell.timeLabel.text = n.idid;
    if (n.imgData) {
        cell.imgView.image = [UIImage imageWithData:n.imgData];
    } else {
        cell.imgView.image = [UIImage imageNamed:@"emty"];
        [NSThread detachNewThreadSelector:@selector(downloadPic:) toTarget:self withObject:indexPath];
    }
    cell.imageView.frame =  CGRectMake(5, 5, 0.25 * self.view.bounds.size.width , 0.25 * self.view.bounds.size.width);
    return cell;
    
}
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
    snc.num = 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
    
}

@end
