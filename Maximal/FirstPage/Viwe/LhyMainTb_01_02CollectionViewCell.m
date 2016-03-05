//
//  LhyMainTb_01_02CollectionViewCell.m
//  Maximal
//
//  Created by 李宏远 on 15/11/9.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyMainTb_01_02CollectionViewCell.h"
#import "LhyMainTb_01Model.h"

@interface LhyMainTb_01_02CollectionViewCell ()


@end

@implementation LhyMainTb_01_02CollectionViewCell









- (void)dealloc {
    
    [_model release];
    [_labelSource release];
    [_labelTitel release];
    [super dealloc];
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.labelTitel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, self.frame.size.width - 20, self.contentView.frame.size.height/ 3)];
        self.labelTitel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.labelTitel];
        self.labelTitel.numberOfLines = 2;
        self.labelTitel.font = [UIFont boldSystemFontOfSize:18];
        [self.labelTitel release];
        
        
        self.labelSource = [[UILabel alloc] initWithFrame:CGRectMake(10, 15+self.contentView.frame.size.height/ 2 , 100, 20)];
        self.labelSource.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.labelSource];
        self.labelSource.font = [UIFont systemFontOfSize:12];
        self.labelSource.textColor = [UIColor colorWithWhite:0.615 alpha:1.000];
        [self.labelSource release];
    }
    return self;
}

/* 重写setModel方法 */
- (void)setModel:(LhyMainTb_01Model *)model {
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    /* 子控件赋值 */
    self.labelTitel.text = model.title;
    self.labelSource.text = model.auther_name;
    
}


@end
