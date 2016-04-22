//
//  NewsModel.m
//  项目：我赢新闻重构版
//
//  Created by 张力 on 16/4/14.
//  Copyright © 2016年 zhangli. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel
//获得新闻
- (void)getNewsByID:(int )i{
    NSLog(@"getNewsByID");
    NSString *str = [NSString stringWithFormat:@"http://115.159.1.248:56666/xinwen/getnews.php?id=%d",i];
    NSURL *url = [[NSURL alloc]initWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dt = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            [self performSelectorOnMainThread:@selector(requestWrong:) withObject:error waitUntilDone:NO];
        }
        [self performSelectorOnMainThread:@selector(readJsonData:) withObject:data waitUntilDone:NO];
    }];
    [dt resume];
}
- (void)getRank{
    //[self.arr removeAllObjects];
    NSString *str = [NSString stringWithFormat:@"http://115.159.1.248:56666/xinwen/getorders.php"];
    NSURL *url = [[NSURL alloc]initWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dt = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            [self performSelectorOnMainThread:@selector(requestWrong:) withObject:error waitUntilDone:NO];
        }
        [self performSelectorOnMainThread:@selector(readJsonData:) withObject:data waitUntilDone:NO];
    }];
    [dt resume];
}
- (void)getSearchResultBy:(NSString *)_s{
    NSString *s = [NSString stringWithFormat:@"http://115.159.1.248:56666/xinwen/getsearchs.php"];
    NSURL *url = [[NSURL alloc]initWithString:s];
    //NSLog(@"%@",url);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    request.HTTPMethod = @"post";
    NSString *bodyStr = [NSString stringWithFormat:@"content=%@",_s];
    request.HTTPBody = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dt = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //NSLog(@"收到");
        if (error) {
            //NSLog(@"jjkjlkj");
            [self performSelectorOnMainThread:@selector(requestWrong:) withObject:error waitUntilDone:NO];
        }
        [self performSelectorOnMainThread:@selector(readJsonData:) withObject:data waitUntilDone:NO];
    }];
    [dt resume];
    
}
- (void)addClick:(NSInteger)i{
    //NSLog(@"addClick");
    NSString *str = [NSString stringWithFormat:@"http://115.159.1.248:56666/xinwen/setclicks.php?id=%li",i];
    NSURL *url = [[NSURL alloc]initWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dt = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //        if (error) {
        //            [self performSelectorOnMainThread:@selector(requestWrong:) withObject:error waitUntilDone:NO];
        //        }
        [self performSelectorOnMainThread:@selector(readStringData:) withObject:data waitUntilDone:NO];
    }];
    [dt resume];
}
-(void)readJsonData:(NSData *)data{
    NSLog(@"readJsonData");
    if (data) {
        [self.arr removeAllObjects];
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dic in arr) {
            NewsModel *new = [[NewsModel alloc]init];
            [new setValuesForKeysWithDictionary:dic];
            [self.arr addObject:new];
        }
        //NSLog(@"read");
        [self.delegate finishReadJsonData];
    }
}
-(void)readStringData:(NSData *)data{
    //NSLog(@"readstring");
    if (data) {
        //[self.arr removeAllObjects];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"==%@==",str);
    }
}
- (void)requestWrong:(NSError *)error{
    [self.delegate requestWrongAlert:error];
}
@end
