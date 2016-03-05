//
//  LhyMainTb_01Model.m
//  Maximal
//
//  Created by 李宏远 on 15/11/10.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyMainTb_01Model.h"

@implementation LhyMainTb_01Model


- (void)dealloc {
    
    
    [_thumbnail_medias release];
    [_special_info release];
    [_weburl release];
    [_page release];
    [_index release];
    [_media release];
    [super dealloc];
 
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}


@end
