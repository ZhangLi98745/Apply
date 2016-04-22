//
//  showNewController.m
//  项目：我赢新闻
//
//  Created by 张力 on 16/4/7.
//  Copyright © 2016年 zhangli. All rights reserved.
//

#import "showNewController.h"
#import "NewsModel.h"
#import "MyAlert.h"
#import "AppDelegate.h"

@interface showNewController ()<UIApplicationDelegate>
@property (strong,nonatomic) UITextView *contentView;
@property (strong,nonatomic) FMDatabaseQueue *queue;
@end

@implementation showNewController
#define H self.view.bounds.size.height
#define W self.view.bounds.size.width
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //导航栏右键
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    if (self.num == 0) {
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"收藏" style:UIBarButtonItemStylePlain target:self action:@selector(collectNews)];
        self.navigationItem.rightBarButtonItem = rightButton;
    } else if (self.num == 1){
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(deleteNewInSqlite)];
        self.navigationItem.rightBarButtonItem = rightButton;

    }
    AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
    self.queue = appdelegate.queue;
    [self creatLabel];
}

#pragma mark -view
- (void)creatLabel{
    NewsModel *n = self.arr[_indexPath.row];
    //获得状态栏的高度
    //CGFloat statusHeight=[UIApplication sharedApplication].statusBarFrame.size.height;
    //获得导航栏的高度
    //CGFloat navigationHeight=self.navigationController.navigationBar.frame.size.height;
    UILabel * titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, W, 80)];
    titleLabel.text=n.title;
    titleLabel.font=[UIFont systemFontOfSize:24];
    titleLabel.numberOfLines=0;
    titleLabel.textAlignment=NSTextAlignmentCenter;
    //作者
    UILabel * authorLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 80, W/2, 40)];
    authorLabel.text=n.author;
    authorLabel.textAlignment=NSTextAlignmentCenter;
 
    //时间
    UILabel * timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(W/2,80, W/2, 40)];
    timeLabel.text=n.time;
    timeLabel.textAlignment=NSTextAlignmentCenter;

    //内容
    UITextView *contentText = [[UITextView alloc]init];
    contentText.frame = CGRectMake(0, 120, W, 50);
    //NSLog(@"==%g",contentText.frame.size.height);
    contentText.text = n.content;
    contentText.font=[UIFont systemFontOfSize:18.2];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:contentText.font forKey:NSFontAttributeName];
    CGRect rect = [contentText.text boundingRectWithSize:CGSizeMake(contentText.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dict context:nil];
    //NSLog(@"%@",NSStringFromCGSize(rect.size));
    //获得文本的高度
    //CGRect textFrame = [[contentText layoutManager]usedRectForTextContainer:[contentText textContainer]];
//    contentText.frame = CGRectMake(0, 120, W, textFrame.size.height);
     //NSLog(@"%@",NSStringFromCGSize(textFrame.size));
    // NSLog(@"==%g",contentText.frame.size.height);
    contentText.frame = CGRectMake(0, 120, W, rect.size.height);
    contentText.scrollEnabled = NO;
    contentText.editable=NO;
    //设置滚动界面
    UIScrollView *sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, W, H)];
    //sv.backgroundColor = [UIColor blueColor];
    sv.contentSize = CGSizeMake(W, contentText.frame.size.height + 80);
    contentText.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:sv];
    [sv addSubview:titleLabel];
    [sv addSubview:authorLabel];
    [sv addSubview:timeLabel];
    [sv addSubview:contentText];
    
    

}

#pragma mark -fmdb
//穿件数据库连接
//创建表

//收藏新闻
- (void)collectNews{
    BOOL ret = [self checkRepeatItem];
    if (!ret) {
        [MyAlert showAlert:@"提示!" message:@"当前新闻已被收藏" okTitle:@"知道了" okHandler:nil controller:self];
    } else {
        if([self insertToDatabase]){
            [MyAlert showAlert:@"恭喜！" message:@"新闻被收藏，可以在新闻标签中刷新查看" okTitle:@"知道了" okHandler:nil controller:self];
        } else {
            [MyAlert showAlert:@"警告" message:@"新闻收藏失败！" okTitle:@"知道了"  okHandler:nil controller:self];
        }
    }
}
//数据查重
- (BOOL)checkRepeatItem{
    __block BOOL ret;
    NewsModel *n = self.arr[_indexPath.row];
    [self.queue inDatabase:^(FMDatabase *db) {
        [db open];
        NSString *sql = @"select * from newstable where id=?";
        FMResultSet *set = [db executeQuery:sql,[NSNumber numberWithInteger:[n.idid integerValue]]];
        if ([set next]) {
            //重复，保存失败
            ret = NO;
        } else {
            //提示保存
            ret = YES;
            //set = nil;
        }
        //set = nil;
        [set close];
    }];
    //NSLog(@"%d",ret);
    return ret;
}
//插入数据
- (BOOL)insertToDatabase{
    __block BOOL result;
    NewsModel *n = self.arr[_indexPath.row];
    [self.queue inDatabase:^(FMDatabase *db) {
        [db open];
        NSString *sql = [NSString stringWithFormat:@"insert into newstable(id,title,time,subtitle,content,flid,author,clicks,imageData) values (?,?,?,?,?,?,?,?,?)"];
        BOOL ret = [db executeUpdate:sql,[NSNumber numberWithInteger:[n.idid integerValue]],n.title,n.time,n.subtitle,n.content,n.flid,n.author,n.clicks,n.imgData];
        //NSLog(@"======%@",n.imgData);
        if (ret) {
            result = YES;
        } else {
            result = NO;
        }
        [db close];
    }];
    //NSLog(@"%d",result);
    return result;
}
//删除数据
- (void)deleteNewInSqlite{
    NewsModel *n = self.arr[_indexPath.row];
    [self.queue inDatabase:^(FMDatabase *db) {
        [db open];
        NSString *sql = @"delete from newstable where id=?";
        BOOL ret = [db executeUpdate:sql,[NSNumber numberWithInteger:[n.idid integerValue]]];
        if (ret) {
            //确认删除
            [MyAlert showAlert:@"注意" message:@"确定要删除吗？" okTitle:@"确定" cancel:@"取消" okHandler:^(UIAlertAction *action) {
                [self.navigationController popViewControllerAnimated:YES];
                //[[NSNotificationCenter defaultCenter]postNotificationName:@"update" object:nil userInfo:@{@"update":self.indexPath}];
            } cancelHandler:nil controller:self];
        } else {
            //提示保存
            [MyAlert showAlert:@"提示" message:@"删除失败" okTitle:@"知道了" okHandler:nil controller:self];
        }
        [db close];
    }];
}
@end
