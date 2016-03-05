//
//  LhyMainCollectionViewCell.m
//  Maximal
//
//  Created by 李宏远 on 15/11/7.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyMainCollectionViewCell.h"

@interface LhyMainCollectionViewCell ()

//@property(nonatomic, retain)UILabel *labelTitle;


@end

@implementation LhyMainCollectionViewCell

- (void)dealloc {
    
   // [_labelTitle release];
    [_imageViewPic release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
//        self.labelTitle = [[UILabel alloc] init];
//        [self.contentView addSubview:self.labelTitle];
//        [self.labelTitle release];
//        self.labelTitle.backgroundColor = [UIColor grayColor];
        
        self.imageViewPic = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageViewPic];
        [self.imageViewPic release];
        self.imageViewPic.backgroundColor = [UIColor grayColor];
        
    }
    
    return self;
    
}


- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    
    //self.labelTitle.frame = CGRectMake(self.contentView.frame.origin.x + 30, self.contentView.frame.origin.y + 95, self.contentView.frame.size.width / 2,self.contentView.frame.size.height / 8);
    
    //self.imageViewPic.frame = CGRectMake(self.contentView.frame.origin.x + 36, self.contentView.frame.origin.y + 30, self.contentView.frame.size.width / 2.5,self.contentView.frame.size.height / 2.5);
    self.imageViewPic.frame = self.contentView.frame;

    
}


@end
