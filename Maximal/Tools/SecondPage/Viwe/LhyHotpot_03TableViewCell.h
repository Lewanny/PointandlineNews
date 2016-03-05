//
//  LhyHotpot_03TableViewCell.h
//  Maximal
//
//  Created by 李宏远 on 15/11/11.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LhyHotPotModel;

@interface LhyHotpot_03TableViewCell : UITableViewCell

@property(nonatomic, retain)LhyHotPotModel *model;
@property(nonatomic, retain)UILabel *labelTitel;
@property(nonatomic, retain)UILabel *labelAuthor_name;

@end
