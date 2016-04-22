//
//  ZHLScrollView.m
//  项目：我赢新闻
//
//  Created by 张力 on 16/4/14.
//  Copyright © 2016年 zhangli. All rights reserved.
//

#import "ZHLScrollView.h"

@interface ZHLScrollView () //延展
@property (strong,nonatomic) NSMutableArray *buttonArray;
@property (strong,nonatomic) UIView *lineView;
@end

@implementation ZHLScrollView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.buttonArray = [[NSMutableArray alloc] init];
        self.showsHorizontalScrollIndicator = NO;//关闭水平滚动指示器
    }
    return self;
}
//添加按钮
-(void)addButton:(UIButton *)button
{   if(_buttonArray.count == 0)//第一个按钮
    {
        [button setTitleColor:[UIColor redColor]  forState:UIControlStateNormal];
        _lineView=[[UIView alloc]initWithFrame:CGRectMake(5 * (_buttonArray.count + 1) + _buttonArray.count * 100,43,100,2)];
        _lineView.backgroundColor=[UIColor redColor];
        //NSLog(@"line");
        [button addSubview:_lineView];
    }

    button.frame = CGRectMake(5 * (_buttonArray.count + 1) + _buttonArray.count * 100, 0, 100, 40);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_buttonArray addObject:button];
    [self addSubview:button];
    //判断是否需要滚动
    if (( button.frame.origin.x + button.frame.size.width ) > self.frame.size.width) {
        self.contentSize = CGSizeMake(button.frame.origin.x + button.frame.size.width , self.frame.size.height);
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeUI) name:UIDeviceOrientationDidChangeNotification object:nil];
}
//移动线
- (void)selectButton:(UIButton *)b
{   for (UIButton *button in _buttonArray) {
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    [b setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
        _lineView.frame = CGRectMake(b.frame.origin.x, 43, 100, 2);
    } completion:nil];
}
-(void)changeUI
{
    NSLog(@"%s",__func__);
    NSLog(@"%@",NSStringFromCGRect(self.frame));
}
@end

