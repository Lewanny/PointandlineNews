
//
//  LhyRotationBoardCell.m
//  Maximal
//
//  Created by 李宏远 on 15/11/9.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyRotationBoardCell.h"

@interface LhyRotationBoardCell ()



@end

@implementation LhyRotationBoardCell

- (void)dealloc {
    
    [_labelTitel release];
    [_picImage release];
    [super dealloc];
}


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        /* 设置图片view */
        self.picImage = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:self.picImage];
        self.picImage.backgroundColor = [UIColor clearColor];
        self.picImage.image = [UIImage imageNamed:@"zhanwei_01"];
        self.picImage.contentMode = UIViewContentModeScaleAspectFill;
        self.picImage.layer.masksToBounds = YES;
        [self.picImage release];
        
        /* 设置显示标题的label */
        self.labelTitel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.frame.origin.y + (self.frame.size.height - 35) , self.frame.size.width - 40, 22)];
        self.labelTitel.textAlignment = NSTextAlignmentLeft;
        self.labelTitel.textColor = [UIColor whiteColor];
        [self addSubview:self.labelTitel];
        [_labelTitel release];
    }
    
    return self;
    
}

//- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
//    
//    
//    self.picImage.frame = CGRectMake(0, 0, 200, 100);
//}


@end
