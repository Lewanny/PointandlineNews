//
//  LhyTabele_01_webViewController.h
//  Maximal
//
//  Created by 李宏远 on 15/11/16.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyBaseViewController.h"
@class LhyMainTb_01Model;


@interface LhyTabele_01_webViewController : LhyBaseViewController

@property(nonatomic, copy)NSString *webUrl;
@property(nonatomic, copy)NSString *titleOfArticle;
@property(nonatomic, copy)NSString *nameOfAuthor;
@property(nonatomic, retain)LhyMainTb_01Model *model;


@end
