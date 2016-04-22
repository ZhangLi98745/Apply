//
//  finishReadJsonData.h
//  项目：我赢新闻
//
//  Created by 张力 on 16/4/7.
//  Copyright © 2016年 zhangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol finishReadJsonData <NSObject>
- (void)finishReadJsonData;
- (void)requestWrongAlert:(NSError *)err;
@end
