//
//  ProgressViewHud.m
//  项目：我赢新闻
//
//  Created by 张力 on 16/4/8.
//  Copyright © 2016年 zhangli. All rights reserved.
//

#import "ZHLProgressViewHud.h"
@interface ZHLProgressViewHud ()
@property (strong,nonatomic) UIView *progressView, *backView;
@property (strong,nonatomic) UIActivityIndicatorView *act;
@property (strong,nonatomic) UILabel *note,*errLabel;
@property (strong,nonatomic) UIImageView *errorRequestView;
@end

@implementation ZHLProgressViewHud
@synthesize progressView,backView,act,note,errLabel,errorRequestView;

#define H [UIScreen mainScreen].bounds.size.height
#define W [UIScreen mainScreen].bounds.size.width
#define SBH [UIApplication sharedApplication].statusBarFrame.size.height
#define NBH
- (void)showProgressView:(BOOL)b{
    if (b == YES) {
        if (progressView == nil) {
            //开始动画
            progressView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
            progressView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
            [[UIApplication sharedApplication].keyWindow addSubview:progressView];
            //创建背景view
            backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, W/ 2, H/4)];
            backView.center = progressView.center;
            backView.backgroundColor = [UIColor blackColor];
            backView.layer.cornerRadius = 10;
            [progressView addSubview:backView];
            //创建活动指示器
            act = [[UIActivityIndicatorView alloc]init];
            act.frame = CGRectMake(W / 4 - 18.5, H / 8 - 30, 37, 37);
            act.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
            [backView addSubview:act];
            [act startAnimating];
            //创建提示消息
            note = [[UILabel alloc]initWithFrame:CGRectMake(0, H / 2 + 30, W, 40)];
            note.font = [UIFont systemFontOfSize:20];
            note.text = @"正在加载...";
            note.textAlignment = NSTextAlignmentCenter;
            note.textColor = [UIColor whiteColor];
            [progressView addSubview:note];
        } else {
            //隐藏
            progressView.hidden = NO;
        }
    } else if (b == NO) {
        //结束动画
        progressView.hidden = YES;
    }
}
- (void)showNotificationError:(NSError *)err byViewController:(UIViewController *)vc {
    if (err != nil) {
        if (errorRequestView == nil){
            errorRequestView = [[UIImageView alloc]initWithFrame:CGRectMake(W/2 - 64, H / 2 - 106, 128, 106)];
            errorRequestView.image = [UIImage imageNamed:@"null"];
            //[[UIApplication sharedApplication].keyWindow addSubview:errorRequestView];
            [vc.view addSubview:errorRequestView];
            //显示文字
            errLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, H / 2, W, 30)];
            errLabel.textAlignment = NSTextAlignmentCenter;
            //NSLog(@"%@",[err localizedDescription]);
            if ([[err localizedDescription]isEqualToString:@"似乎已断开与互联网的连接。"]) {
                errLabel.text = @"网络断开,请开启网络后重试";
            }else if ([[err localizedDescription]isEqualToString:@"请求超时。"]){
                errLabel.text = @"网络不给力,稍后重试";
            }else {
                errLabel.text = @"空空如也!";
            }
            [vc.view addSubview:errLabel];
        } else {
            errorRequestView.hidden = NO;
            errLabel.hidden = NO;
        }
    }else if (err == nil){
        errLabel.hidden = YES;
        errorRequestView.hidden = YES;
        //NSLog(@"diaoyong");
    }

}
- (void)showNotification:(BOOL)b byViewController:(UIViewController *)vc {
        if (b){
            if (errLabel == nil) {
            errorRequestView = [[UIImageView alloc]initWithFrame:CGRectMake(W/2 - 64, H / 2 - 106, 128, 106)];
            errorRequestView.image = [UIImage imageNamed:@"null"];
            //[[UIApplication sharedApplication].keyWindow addSubview:errorRequestView];
            [vc.view addSubview:errorRequestView];
            //显示文字
            errLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, H / 2, W, 30)];
            errLabel.textAlignment = NSTextAlignmentCenter;
            //NSLog(@"%@",[err localizedDescription]);
            errLabel.text = @"空空如也!";
            [vc.view addSubview:errLabel];
            }else {
                errorRequestView.hidden = NO;
                errLabel.hidden = NO;
            }
        } else {
            errorRequestView.hidden = YES;
            errLabel.hidden = YES;
        }
}

@end
