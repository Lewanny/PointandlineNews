//
//  LhyEnjoy_MainModel.h
//  Maximal
//
//  Created by 李宏远 on 15/11/13.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyBaseModel.h"
@class LhyEnjoy_Main_ItemsModel;

@interface LhyEnjoy_MainModel : LhyBaseModel

@property(nonatomic, retain)NSMutableDictionary *banner;
@property(nonatomic, retain)NSMutableArray *items;
@property(nonatomic, retain)NSMutableArray *itemsArr;
@property(nonatomic, copy)NSString *style;
@property(nonatomic, copy)NSString *more_icon;

@property(nonatomic, retain)NSMutableDictionary *more_info;
@property(nonatomic, copy)NSString *show_more;

@end
