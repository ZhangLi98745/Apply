//
//  AppDelegate.h
//  项目：我赢新闻重构版
//
//  Created by 张力 on 16/4/14.
//  Copyright © 2016年 zhangli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"
#import <AudioToolbox/AudioToolbox.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) FMDatabaseQueue *queue;
@property (assign,nonatomic) SystemSoundID soundID;
@end


