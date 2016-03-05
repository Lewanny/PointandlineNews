


//
//  LhyCommunity_SelectedModel.m
//  Maximal
//
//  Created by 李宏远 on 15/11/14.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyCommunity_SelectedModel.h"

@implementation LhyCommunity_SelectedModel

- (void)dealloc {
 
    [_weburl release];
    [_comment_count release];
    [_content release];
    [_hot_num release];
    [_like_num release];
    [_auther release];
    [_date release];
    [_medias release];
    [_special_info release];
    [super dealloc];
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}

@end
