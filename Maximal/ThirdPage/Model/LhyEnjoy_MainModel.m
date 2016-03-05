//
//  LhyEnjoy_MainModel.m
//  Maximal
//
//  Created by 李宏远 on 15/11/13.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyEnjoy_MainModel.h"
#import "LhyEnjoy_Main_ItemsModel.h"

@implementation LhyEnjoy_MainModel

- (void)dealloc {
    
    [_itemsArr release];
    [_banner release];
    [_style release];
    [_items release];
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}


@end
