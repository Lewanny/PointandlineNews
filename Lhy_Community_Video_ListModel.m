



//
//  Lhy_Community_Video_ListModel.m
//  Maximal
//
//  Created by 李宏远 on 15/11/18.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "Lhy_Community_Video_ListModel.h"

@implementation Lhy_Community_Video_ListModel

- (void)dealloc {
    
    [_descriptions release];
    [_mp4_url release];
    [_length release];
    [_playCount release];
    [super dealloc];
}



- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
   
   /* 纠错方法 */
        if ([key isEqualToString:@"description"]) {
    
            self.descriptions = value;
        }
}

@end
