//
//  LhyAFNetworkTool.h
//  NewAttitudes
//
//  Created by 李宏远 on 15/11/6.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LhyResopnseStyle) {
    LhyJSON,
    LhyXML,
    LhyData,
};

typedef NS_ENUM(NSUInteger, LhyRequestStyle) {
    RequestJSON,
    RequestString,
    RequestDefault
};

@interface LhyAFNetworkTool : NSObject


+ (void)getUrl:(NSString *)url body:(id)body response:(LhyResopnseStyle)style requestHeadFile:(NSDictionary *)headFile  success:(void (^)(NSURLSessionDataTask* task, id responseObject))success failure:(void (^)(NSURLSessionDataTask* task, NSError *error))faliure;

+ (void)postUrlString:(NSString *)url
                 body:(id)body
             response:(LhyResopnseStyle)style
            bodyStyle:(LhyRequestStyle)bodyStyle
      requestHeadFile:(NSDictionary *)headFile
              success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
