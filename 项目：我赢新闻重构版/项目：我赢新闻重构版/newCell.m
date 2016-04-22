//
//  newCell.m
//  项目：我赢新闻
//
//  Created by 张力 on 16/4/6.
//  Copyright © 2016年 zhangli. All rights reserved.
//

#import "newCell.h"

@implementation newCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andTableView:(UITableView *)tableView{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        float w = [UIScreen mainScreen].bounds.size.width;
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 0.25 * w , 0.25 * w)];
        self.imgView.image = [UIImage imageNamed:@"emty"];
        //self..contentMode = UIViewContentModeScaleToFill;
        [self addSubview:self.imgView];
        self.tittleLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 30, tableView.frame.size.width * 0.5, 50)];
        self.tittleLabel.numberOfLines = 0;//表示不限行数
        [self addSubview:self.tittleLabel];
        
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake( 115 + 0.5 * w, 5, 0.2 * w, 30)];
        
        [self addSubview:self.timeLabel];
        
        self.hitsLabel = [[UILabel alloc]initWithFrame:CGRectMake(115 + 0.5 * w, 50, 0.2 * w, 30 )];
        [self addSubview:self.hitsLabel];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
