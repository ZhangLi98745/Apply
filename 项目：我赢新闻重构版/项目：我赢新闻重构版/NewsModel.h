//
//  NewsModel.h
//  项目：我赢新闻重构版
//
//  Created by 张力 on 16/4/14.
//  Copyright © 2016年 zhangli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "finishReadJsonData.h"
@interface NewsModel : NSObject
@property (strong,nonatomic) NSMutableArray *arr;
@property (weak,nonatomic) id<finishReadJsonData> delegate;
@property (strong,nonatomic) NSString *idid,*title,*picture,*time,*subtitle,*content,*flid,*author,*clicks;
@property (strong,nonatomic) NSData *imgData;

- (void)getNewsByID:(int )i;
- (void)getRank;
- (void)getSearchResultBy:(NSString *)_s;
- (void)addClick:(NSInteger)i;

@end
