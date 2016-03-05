

//
//  LhyUserInfoModel.m
//  Maximal
//
//  Created by 李宏远 on 15/11/24.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyUserInfoModel.h"

@implementation LhyUserInfoModel

- (void)dealloc {
    
    [_userId release];
    [_password release];
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
    
}

@end
