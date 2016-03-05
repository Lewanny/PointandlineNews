
//  LhySearchModel.m
//  Maximal
//
//  Created by 李宏远 on 15/11/18.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhySearchModel.h"

@implementation LhySearchModel

- (void)dealloc {
    
    [_mid release];
    [_s_content release];
    [_s_imghtml release];
    [_s_title release];
    [super dealloc];
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key  {
    
    
}


@end
