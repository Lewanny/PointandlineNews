//
//  LhyMainTb_01_03CollectionViewCell.m
//  Maximal
//
//  Created by 李宏远 on 15/11/9.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyMainTb_01_03CollectionViewCell.h"
#import "LhyMainTb_01Model.h"
#import "UIImageView+WebCache.h"

@interface LhyMainTb_01_03CollectionViewCell ()


@property(nonatomic, retain)UIImageView *imageViewPic;


@end

@implementation LhyMainTb_01_03CollectionViewCell




- (void)dealloc {
    
    [_model release];
    [_imageViewPic release];
    [_labelTitel release];
    [super dealloc];
    
}

- (instancetype)initWithFrame:(CGRect)frame {
       self = [super initWithFrame:frame];
    if (self) {
        
        self.imageViewPic = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:self.imageViewPic];
        self.imageViewPic.contentMode = UIViewContentModeScaleAspectFill;
        self.imageViewPic.layer.masksToBounds = YES;
        
        self.labelTitel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.imageViewPic.frame.origin.y + (self.imageViewPic.frame.size.height - 30), self.frame.size.width - 20, 30)];
        self.labelTitel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.labelTitel];
        self.labelTitel.textColor = [UIColor whiteColor];
        self.labelTitel.font = [UIFont boldSystemFontOfSize:18];

        [self.labelTitel release];
        [self.imageViewPic release];
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

    NSMutableDictionary *dic = [model.media firstObject];
    [self.imageViewPic sd_setImageWithURL:[dic objectForKey:@"m_url"] placeholderImage:[UIImage imageNamed:@"zhanwei_01"]];
    
}


@end
