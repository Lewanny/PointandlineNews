

//
//  LhyCommunity_DiscoveryModel.m
//  Maximal
//
//  Created by 李宏远 on 15/11/13.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyCommunity_DiscoveryModel.h"

@implementation LhyCommunity_DiscoveryModel

- (void)dealloc {
    
    [_stitle release];
    [_pic release];
    [_api_url release];
    [super dealloc];
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}

@end
