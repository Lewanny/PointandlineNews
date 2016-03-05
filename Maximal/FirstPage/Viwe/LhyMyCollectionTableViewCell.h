//
//  LhyMyCollectionTableViewCell.h
//  Maximal
//
//  Created by 李宏远 on 15/11/19.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LhyMainTb_01Model;

@interface LhyMyCollectionTableViewCell : UITableViewCell

@property(nonatomic, retain)LhyMainTb_01Model *model;
@property(nonatomic, retain)UILabel *labelNum;
@property(nonatomic, retain)UILabel *labelTitle;

@end
