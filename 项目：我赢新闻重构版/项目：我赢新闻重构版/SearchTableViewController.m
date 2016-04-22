//
//  SearchTableViewController.m
//  项目：我赢新闻重构版
//
//  Created by 张力 on 16/4/14.
//  Copyright © 2016年 zhangli. All rights reserved.
//

#import "SearchTableViewController.h"

@interface SearchTableViewController ()<UISearchBarDelegate>
@property (strong,nonatomic) UISearchBar *searchBar;
@end

@implementation SearchTableViewController
#define H self.view.bounds.size.height
#define W self.view.bounds.size.width
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _searchBar = [[UISearchBar alloc]init];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, W, H - 40 ) style:UITableViewStylePlain];
    _searchBar.frame = CGRectMake(0, 0, W, 40);
    _searchBar.placeholder = @"输入想要查找的内容";
    self.searchBar.delegate = self;
    self.navigationItem.title = @"搜索";
    [self.view addSubview:self.searchBar];
    //self.tableView.tableHeaderView = self.searchBar;
    //初始化数据模型
    self.n = [[NewsModel alloc]init];
    self.n.arr = [[NSMutableArray alloc]init];
    self.arr = self.n.arr;
    self.n.delegate = self;
    
}

#pragma mark -searchBar
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [_searchBar setShowsCancelButton:YES animated:NO];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [_searchBar setShowsCancelButton:NO animated:YES];
    [self.n getSearchResultBy:_searchBar.text];
    [_searchBar resignFirstResponder];
    [self.zhl showProgressView:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [_searchBar setShowsCancelButton:NO animated:YES];
    [_searchBar resignFirstResponder];
}

#pragma mark -下拉刷新
- (void)refreshHandler:(UIRefreshControl *)sender{
    NSLog(@"%s",__func__);
    [self searchBarSearchButtonClicked:_searchBar];
}
@end
