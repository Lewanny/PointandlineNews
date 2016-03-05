//
//  LhyRotationBroadcastModel.m
//  Maximal
//
//  Created by 李宏远 on 15/11/9.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyRotationBroadcastModel.h"

@implementation LhyRotationBroadcastModel

- (void)dealloc {
    
    [_topic release];
    [_block_info release];
    [_type release];
    [_article release];
    [_promotion_img release];
    
    [_imgsrc release];
    [_url release];
    [_tag release];
    [super dealloc];
   
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
    
}


@end
