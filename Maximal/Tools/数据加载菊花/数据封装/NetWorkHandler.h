//
//  NetWorkHandler.h
//  UI17_网络封装——AFNetworking类_SD_Webimage
//
//  Created by 赵德玉 on 15/10/23.
//  Copyright © 2015年 ui. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetWorkHardlerDelegate <NSObject>
/*协议方法*/
- (void)didFinshLoading:(id)result;

@end

@interface NetWorkHandler : NSObject
@property (nonatomic,retain)id<NetWorkHardlerDelegate> delegate;



+ (void)netWorkHandlerWithURL:(NSString *)str completion:(void(^)(id result))block;

+ (void)netWorkHandleWithRequest:(NSString *)string
                    withHTTPBody:(NSString *)body
                      completion:(void(^)(id result))block;



- (void)netWorkHandleWithURL:(NSString *)str;


@end
