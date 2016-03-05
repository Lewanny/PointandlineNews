
//  LhyComunity_01_TopCollectionViewCell.m
//  Maximal
//
//  Created by 李宏远 on 15/11/12.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyComunity_01_TopCollectionViewCell.h"

@interface LhyComunity_01_TopCollectionViewCell ()


@end

@implementation LhyComunity_01_TopCollectionViewCell

- (void)dealloc {
    
    [_labelTitle release];
    [super dealloc];
}




- (instancetype)initWithFrame:(CGRect)frame {

    self =[super initWithFrame:frame];
    if (self) {
        
        /* 创建与布局子控件 */
        self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width / 4, self.contentView.frame.size.height / 4, self.contentView.frame.size.width / 2, self.contentView.frame.size.height / 2 )];
        [self.contentView addSubview:self.labelTitle];
       // self.labelTitle.backgroundColor = [UIColor grayColor];
      
        self.labelTitle.textColor = [UIColor colorWithWhite:0.684 alpha:1.000];
        self.labelTitle.textAlignment = NSTextAlignmentCenter;
        self.labelTitle.font = [UIFont systemFontOfSize:14];
        
        [self.labelTitle release];
    }
    
    return self;
    
}


@end
