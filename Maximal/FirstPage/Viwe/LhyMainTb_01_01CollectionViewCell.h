//
//  LhyMainTb_01_01CollectionViewCell.h
//  Maximal
//
//  Created by 李宏远 on 15/11/9.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LhyMainTb_01Model;

@interface LhyMainTb_01_01CollectionViewCell : UICollectionViewCell

@property(nonatomic, retain)LhyMainTb_01Model *model;

@property(nonatomic, retain)UILabel *labelTitel;
@property(nonatomic, retain)UILabel *labelSource;


@end
