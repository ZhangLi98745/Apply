//
//  showNewController.h
//  项目：我赢新闻
//
//  Created by 张力 on 16/4/7.
//  Copyright © 2016年 zhangli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
@interface showNewController : UIViewController
@property (strong,nonatomic) NSMutableArray *arr;
@property (strong,nonatomic) NSIndexPath *indexPath;
@property (assign,nonatomic) NSInteger num;

@end
