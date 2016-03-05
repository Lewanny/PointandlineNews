//
//  LhyCommunity_SelectedModel.h
//  Maximal
//
//  Created by 李宏远 on 15/11/14.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyBaseModel.h"

@interface LhyCommunity_SelectedModel : LhyBaseModel

@property(nonatomic, copy)NSString *content;
@property(nonatomic, copy)NSString *hot_num;
@property(nonatomic, copy)NSString *comment_count;
@property(nonatomic, copy)NSString *like_num;
@property(nonatomic, retain)NSMutableDictionary *auther;
@property(nonatomic, copy)NSString *date;
@property(nonatomic, retain)NSMutableArray *medias;
@property(nonatomic, retain)NSMutableDictionary *special_info;

@property(nonatomic, copy)NSString *weburl;

@end
