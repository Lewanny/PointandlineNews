
//
//  LhyRotationModel.m
//  Maximal
//
//  Created by 李宏远 on 15/11/21.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyRotationModel.h"

@implementation LhyRotationModel


- (void)dealloc {
    
    [_simgurl release];
    [_imgtitle release];
    [_note release];
    [_imgurl release];
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
