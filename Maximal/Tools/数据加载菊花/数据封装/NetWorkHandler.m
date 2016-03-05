//
//  NetWorkHandler.m
//  UI17_网络封装——AFNetworking类_SD_Webimage
//
//  Created by 赵德玉 on 15/10/23.
//  Copyright © 2015年 ui. All rights reserved.
//

#import "NetWorkHandler.h"

@interface NetWorkHandler ()<NSURLSessionDelegate>
@property (nonatomic,retain)NSMutableData *data;

@end
@implementation NetWorkHandler

#pragma mark ——————通过delegate 将值传到外部

- (void)netWorkHandleWithURL:(NSString *)str{
    /*初始化*/
    self.data = [NSMutableData data];
    
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
   NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url];
    
    [dataTask resume];
}

/*delegate 方法*/
- (void)URLSession:(NSURLSession * _Nonnull)session dataTask:(NSURLSessionDataTask * _Nonnull)dataTask didReceiveData:(NSData * _Nonnull)data{
  
    /*接收数据*/
    
    [self.data appendData:data];
}


- (void)URLSession:(NSURLSession * _Nonnull)session task:(NSURLSessionTask * _Nonnull)task didCompleteWithError:(NSError * _Nullable)error{
    /*任务完成*/
    
    /*data 处理*/
    NSError *erro = nil;
    id result = [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableContainers error:&erro];
    
    /*通过delegate 将result 传到外面*/
    
    if ([self.delegate respondsToSelector:@selector(didFinshLoading:)]) {
        [self.delegate didFinshLoading:result];
    }
    
    
}





#pragma mark ---通过block 将值传到外部
+ (void)netWorkHandlerWithURL:(NSString *)str completion:(void(^)(id result))block{
    /*生成转码之后的URL*/
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
  NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
      /*data 处理*/
      NSError *erro = nil;
      id result = [ NSJSONSerialization JSONObjectWithData:data options:    NSJSONReadingMutableContainers error:&erro];
    
      /*通过block 将result传给外部使用*/
      block(result);/*相当于block调用*/
      
    }];
    
    
    
    [dataTask resume];
    
}

+(void)netWorkHandleWithRequest:(NSString *)string withHTTPBody:(NSString *)body completion:(void (^)(id))block{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:string]];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    
    NSURLSession *session = [NSURLSession sharedSession];
    
 NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
     NSError *err = nil;
     id result = [NSJSONSerialization JSONObjectWithData:data options:    NSJSONReadingMutableContainers  error:&err];
     
     block(result);
     
    }];
    
    [dataTask resume];
    
}




@end
