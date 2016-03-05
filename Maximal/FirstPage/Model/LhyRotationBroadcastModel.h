//
//  LhyRotationBroadcastModel.h
//  Maximal
//
//  Created by 李宏远 on 15/11/9.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyBaseModel.h"

@interface LhyRotationBroadcastModel : LhyBaseModel

@property(nonatomic, copy)NSString *promotion_img;
@property(nonatomic, retain)NSMutableDictionary *article;
@property(nonatomic, copy)NSString *type;
@property(nonatomic, retain)NSMutableDictionary *block_info;
@property(nonatomic, retain)NSMutableDictionary *topic;

@property(nonatomic, retain)NSString *imgsrc;
@property(nonatomic, retain)NSString *url;
@property(nonatomic, copy)NSString *tag;

@end
