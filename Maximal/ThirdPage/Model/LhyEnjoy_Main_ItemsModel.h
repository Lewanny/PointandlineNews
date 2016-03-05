//
//  LhyEnjoy_Main_ItemsModel.h
//  Maximal
//
//  Created by 李宏远 on 15/11/13.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyBaseModel.h"

@interface LhyEnjoy_Main_ItemsModel : LhyBaseModel

@property(nonatomic, retain)NSMutableDictionary *pic;
@property(nonatomic, copy)NSString *content;
@property(nonatomic, retain)NSMutableDictionary *article;
@property(nonatomic, retain)NSMutableDictionary *web;
@property(nonatomic, retain)NSMutableDictionary *weekend;
@property(nonatomic, copy)NSString *type;


@end
