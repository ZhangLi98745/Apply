//
//  WYXWTableViewController.h
//  项目：我赢新闻重构版
//
//  Created by 张力 on 16/4/14.
//  Copyright © 2016年 zhangli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "finishReadJsonData.h"

#import "ZHLProgressViewHud.h"
#import "AppDelegate.h"
#import "NewsModel.h"
#import "newCell.h"
#import "showNewController.h"
@interface WYXWTableViewController : UITableViewController
@property (strong,nonatomic) ZHLProgressViewHud *zhl;
@property (strong,nonatomic) NSMutableArray *arr;
@property (strong,nonatomic) NewsModel *n;


@end
