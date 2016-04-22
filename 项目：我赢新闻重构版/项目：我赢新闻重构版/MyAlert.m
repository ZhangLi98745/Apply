//
//  MyAlert.m
//  23alertControler
//
//  Created by 张力 on 16/3/1.
//  Copyright © 2016年 zhangli. All rights reserved.
//

#import "MyAlert.h"

@implementation MyAlert
+ (void)showAlert:(NSString *)msgTittle message:(NSString *)msg okTitle:(NSString *)okTittle cancel:(NSString *)cancleTittle okHandler:(void (^ __nullable)(UIAlertAction *action))handler cancelHandler:(void (^ __nullable)(UIAlertAction *action))cancleHandler controller:(UIViewController *)viewControler{
    //屏幕中间弹出来
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:msgTittle message:msg preferredStyle:UIAlertControllerStyleAlert];
    //每一个UIAlertAction都是一个按钮，
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:okTittle style:UIAlertActionStyleDefault handler:handler];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:cancleTittle style:UIAlertActionStyleDefault handler:cancleHandler];
    //将按钮添加到UIAlertController上
    [ac addAction:action1];
    [ac addAction:action2];
    //显示UIAlertController
    //注意只有控制器中才有presentViewController方法
    [viewControler presentViewController:ac animated:YES completion:nil];
}

+ (void)showAlert:(NSString *)msgTittle message:(NSString *)msg okTitle:(NSString *)okTittle okHandler:(void (^ __nullable)(UIAlertAction *action))handler controller:(UIViewController *)viewControler{
    //屏幕中间弹出来
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:msgTittle message:msg preferredStyle:UIAlertControllerStyleAlert];
    //每一个UIAlertAction都是一个按钮，
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:okTittle style:UIAlertActionStyleDefault handler:handler];
    [ac addAction:action1];
    [viewControler presentViewController:ac animated:YES completion:nil];
}
@end