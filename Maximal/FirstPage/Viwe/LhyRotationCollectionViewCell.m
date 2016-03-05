

//
//  LhyRotationCollectionViewCell.m
//  Maximal
//
//  Created by 李宏远 on 15/11/21.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyRotationCollectionViewCell.h"
#import "LhyRotationModel.h"
#import "UIImageView+WebCache.h"

#import "LhyAutoAdaptHeight.h"

@interface LhyRotationCollectionViewCell ()

@property(nonatomic, retain)UIImageView *imageViewPic;

@property(nonatomic, assign)CGFloat picHeight;

@end

@implementation LhyRotationCollectionViewCell

- (void)dealloc {
    
    [_model release];
    [_imageViewPic release];
    [super dealloc];
}

#pragma mark - 重写初始化
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageViewPic = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageViewPic];
        self.imageViewPic.backgroundColor = [UIColor grayColor];
        self.imageViewPic.contentMode = UIViewContentModeScaleAspectFill;
        self.imageViewPic.layer.masksToBounds = YES;
        
        [self.imageViewPic release];
        
    }
    
    return self;
    
}


- (void)setModel:(LhyRotationModel *)model {
    
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    
    self.picHeight =  [LhyAutoAdaptHeight heigntForCellWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.imgurl]]]];
     NSLog(@"%f", self.picHeight);
    [self.imageViewPic sd_setImageWithURL:[NSURL URLWithString:model.imgurl] placeholderImage:[UIImage imageNamed:@"zhanwei_01"]];
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    
    
    self.imageViewPic.frame = CGRectMake(0, self.contentView.frame.size.height /5, self.contentView.frame.size.width, self.contentView.frame.size.height / 5 * 3);
    
}



@end
