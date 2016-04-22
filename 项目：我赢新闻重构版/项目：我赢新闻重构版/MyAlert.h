//
//  MyAlert.h
//  23alertControler
//
//  Created by 张力 on 16/3/1.
//  Copyright © 2016年 zhangli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAlert : UIAlertController
+ (void)showAlert:(NSString *)msgTittle message:(NSString *)msg okTitle:(NSString *)okTittle cancel:(NSString *)cancleTittle okHandler:(void (^)(UIAlertAction *action))handler cancelHandler:(void (^)(UIAlertAction *action))cancleHandler controller:(UIViewController *)viewControler;
+ (void)showAlert:(NSString *)msgTittle message:(NSString *)msg okTitle:(NSString *)okTittle okHandler:(void (^ __nullable)(UIAlertAction *action))handler controller:(UIViewController *)viewControler;

@end
