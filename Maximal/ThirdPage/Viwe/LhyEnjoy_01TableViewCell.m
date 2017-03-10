//
//  LhyEnjoy_01TableViewCell.m
//  Maximal
//
//  Created by 李宏远 on 15/11/12.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyEnjoy_01TableViewCell.h"
#import "LhyEnjoy_MainModel.h"
#import "UIImageView+WebCache.h"

@interface LhyEnjoy_01TableViewCell ()

@property(nonatomic, retain)UIImageView *imageViewTitel;
@property(nonatomic, retain)UIImageView *imageViewMoreIcon;

@end

@implementation LhyEnjoy_01TableViewCell


- (void)dealloc {
    
    [_imageViewMoreIcon release];
    [_model release];
    [_imageViewTitel release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        /* 创建子控件imageViewTitel */
        self.imageViewTitel = [[UIImageView alloc] init];
      //  self.imageViewTitel.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.imageViewTitel];
        
        self.imageViewMoreIcon = [[UIImageView alloc] init];
      //  self.imageViewMoreIcon.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:self.imageViewMoreIcon];
        
        [self.imageViewTitel release];
        [self.imageViewMoreIcon release];
        
    }
    
    return self;
}

/* 重写setMoedel方法, 完成子控件赋值 */
- (void)setModel:(LhyEnjoy_MainModel *)model {
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    NSMutableDictionary *dic = model.banner;
    
    
    
    [self.imageViewTitel sd_setImageWithURL:[dic objectForKey:@"m_url"] placeholderImage:[UIImage imageNamed:@"zhanwei_01"]];
    
    
    [self.imageViewMoreIcon sd_setImageWithURL:[NSURL URLWithString:model.more_icon]  ];
 
    
}


/* 子控件imageViewTitle的布局 */
- (void)layoutSubviews {
    
    [super layoutSubviews];
//    self.imageViewTitel.frame = CGRectMake(self.contentView.frame.size.width / 4, self.contentView.frame.size.height / 5 * 2, self.contentView.frame.size.width / 2 - 20, self.contentView.frame.size.height / 5 + 10);
    self.imageViewTitel.frame = CGRectMake(0, - 5, self.contentView.frame.size.width, self.contentView.frame.size.height  + 20);
    
    self.imageViewMoreIcon.frame = CGRectMake(self.frame.size.width - 40, self.frame.size.height / 3, 30 , 30);
    //NSLog(@"%f", self.frame.size.height);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
