
//
//  LhyBaseModel.m
//  NewAttitudes
//
//  Created by 李宏远 on 15/11/6.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyBaseModel.h"

@implementation LhyBaseModel

- (void)dealloc {
    
    [_title release];
    [super dealloc];
}

//- (instancetype)initWithDic:(NSDictionary *)dic {
//    
//    self = [super init];
//    if (self) {
//        
//        /**
//         *  KVC 的赋值方法
//         */
//        //[self setValuesForKeysWithDictionary:dic];
//        
//  
//    }
//    
//    return self;
//    
//}
/* KVC的纠错方法 */
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
//    if ([key isEqualToString:@"id"]) {
//        
//        self.mId = value;
//    }
    
}



@end
