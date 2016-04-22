//
//  newCell.h
//  项目：我赢新闻
//
//  Created by 张力 on 16/4/6.
//  Copyright © 2016年 zhangli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newCell : UITableViewCell
@property (strong,nonatomic) UIImageView *imgView;
@property (strong,nonatomic) UILabel *tittleLabel;
@property (strong,nonatomic) UILabel *hitsLabel;
@property (strong,nonatomic) UILabel *timeLabel;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andTableView:(UITableView *)tableView;
@end
