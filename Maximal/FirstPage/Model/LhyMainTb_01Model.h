//
//  LhyMainTb_01Model.h
//  Maximal
//
//  Created by 李宏远 on 15/11/10.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyBaseModel.h"

@interface LhyMainTb_01Model : LhyBaseModel


@property(nonatomic, copy)NSString *page;
@property(nonatomic, copy)NSString *index;
@property(nonatomic, retain)NSMutableArray *media;
@property(nonatomic, copy)NSString *weburl;
@property(nonatomic, copy)NSMutableDictionary *special_info;
@property(nonatomic, copy)NSMutableArray *thumbnail_medias;



@end
