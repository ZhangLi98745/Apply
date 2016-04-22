//
//  AppDelegate.m
//  项目：我赢新闻重构版
//
//  Created by 张力 on 16/4/14.
//  Copyright © 2016年 zhangli. All rights reserved.
//

#import "AppDelegate.h"
#import "NewsTableViewController.h"
#import "RankTableViewController.h"
#import "SearchTableViewController.h"
#import "CollectTableViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //返回错误
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);

    //打开数据库
    [self creatFMDBLink];
    [self creatTable];
    //标签栏
    UITabBarController *tab = [[UITabBarController alloc]init];
    
    //用for循环实现
    NSArray *names = @[@"NewsTableViewController,新闻,news",@"RankTableViewController,排行榜,rank",@"SearchTableViewController,搜索,search",@"CollectTableViewController,收藏,collection"];
    NSMutableArray *vcs = [[NSMutableArray alloc]initWithCapacity:4];
    for (NSString *str in names) {
        NSArray *arr = [str componentsSeparatedByString:@","];
        Class class = NSClassFromString(arr[0]);
        UIViewController *vc = [[class alloc]init];
        vc.title = arr[1];
        vc.tabBarItem.image = [UIImage imageNamed:arr[2]];
        vc.tabBarItem.title = arr[1];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        [vcs addObject:nav];
    }
    tab.viewControllers = vcs;
    //显示界面
    [self creatSoundID];
    self.window = [[UIWindow alloc]init];
    self.window.rootViewController = tab;
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)creatFMDBLink{
    //设置数据库
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = paths[0];
    NSString *dbFile = [path stringByAppendingString:@"/db.db"];
    //NSLog(@"%@",dbFile);
    self.queue = [[FMDatabaseQueue alloc]initWithPath:dbFile];
}
- (void)creatTable{
    [self.queue inDatabase:^(FMDatabase *db) {
        NSString *sql = @"create table if not exists newstable(id integer primary key not null,title text,time text,subtitle text,content text,flid text,author text,clicks text,imageData blob)";
        /*BOOL ret = */[db executeUpdate:sql];
        //        if (ret) {
        //            NSLog(@"ok");
        //        }
    }];
}
- (void)creatSoundID{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"msgcome" ofType:@"wav"];
    NSURL *url = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &_soundID);
}
void UncaughtExceptionHandler(NSException *exception){
    NSArray *callStack = [exception callStackSymbols];//堆栈信息
    NSString *reason = [exception reason];//异常原因
    NSString *name = [exception name]; //异常名字
    NSLog(@"%@ %@ %@",callStack,reason,name);
}
@end