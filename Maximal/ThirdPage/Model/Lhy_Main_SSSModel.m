//

//  Lhy_Main_SSSModel.m
//  Maximal
//
//  Created by 李宏远 on 15/11/17.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "Lhy_Main_SSSModel.h"

@implementation Lhy_Main_SSSModel

- (void)dealloc {
    
    [_weekend release];
    [_pos_str release];
    [_thumbnail_medias release];
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}

@end
