//
//  LhySearch_TableViewCell.h
//  Maximal
//
//  Created by 李宏远 on 15/11/18.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LhySearchModel;
@interface LhySearch_TableViewCell : UITableViewCell

@property(nonatomic, retain)LhySearchModel *model;
@property(nonatomic, copy)NSString *keyWordStr;

@end
