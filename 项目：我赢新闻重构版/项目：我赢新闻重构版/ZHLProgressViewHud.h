//
//  ProgressViewHud.h
//  项目：我赢新闻
//
//  Created by 张力 on 16/4/8.
//  Copyright © 2016年 zhangli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHLProgressViewHud : UIView
- (void)showProgressView:(BOOL)b;
- (void)showNotificationError:(NSError *)err byViewController:(UIViewController *)vc;
- (void)showNotification:(BOOL)b byViewController:(UIViewController *)vc;
@end
