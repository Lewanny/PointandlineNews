//
//  Lhy_Community_Video_ListModel.h
//  Maximal
//
//  Created by 李宏远 on 15/11/18.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyBaseModel.h"

@interface Lhy_Community_Video_ListModel : LhyBaseModel

@property(nonatomic, copy)NSString *descriptions;
@property(nonatomic, copy)NSString *mp4_url;
@property(nonatomic, copy)NSString *cover;
@property(nonatomic, assign)NSNumber *length;
@property(nonatomic, assign)NSNumber *playCount;

@end
