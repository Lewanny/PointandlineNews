//
//  LhySearchModel.h
//  Maximal
//
//  Created by 李宏远 on 15/11/18.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyBaseModel.h"

@interface LhySearchModel : LhyBaseModel

@property(nonatomic, copy)NSString *s_title;
@property(nonatomic, copy)NSString *s_content;
@property(nonatomic, copy)NSString *s_imghtml;
@property(nonatomic, copy)NSString *mid;
@property(nonatomic, copy)NSString *author;
@property(nonatomic, copy)NSString *s_datetime;

@end
