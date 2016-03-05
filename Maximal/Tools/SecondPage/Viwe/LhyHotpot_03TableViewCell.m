
//
//  LhyHotpot_03TableViewCell.m
//  Maximal
//
//  Created by 李宏远 on 15/11/11.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyHotpot_03TableViewCell.h"
#import "LhyHotPotModel.h"
#import "UIImageView+WebCache.h"
@interface LhyHotpot_03TableViewCell ()


@property(nonatomic, retain)UIImageView *imageViewPic_01;
@property(nonatomic, retain)UIImageView *imageViewPic_02;
@property(nonatomic, retain)UIImageView *imageViewPic_03;

@end

@implementation LhyHotpot_03TableViewCell


- (void)dealloc {
    [_model release];
    [_labelAuthor_name release];
    [_labelTitel release];
    [_imageViewPic_01 release];
    [_imageViewPic_02 release];
    [_imageViewPic_03 release];
    [super dealloc];
    
}

/* 初始化子控件 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.labelTitel = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelTitel];
        self.labelTitel.textAlignment = NSTextAlignmentLeft;
        self.labelTitel.numberOfLines = 2;
        self.labelTitel.font = [UIFont systemFontOfSize:16];
        
        self.labelAuthor_name = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelAuthor_name];
        self.labelAuthor_name.textAlignment = NSTextAlignmentLeft;
        self.labelAuthor_name.font = [UIFont systemFontOfSize:12];
        
        
        self.imageViewPic_01 = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageViewPic_01];
        self.imageViewPic_01.contentMode = UIViewContentModeScaleAspectFill;
        self.imageViewPic_01.layer.masksToBounds = YES;

        
        self.imageViewPic_02 = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageViewPic_02];
        self.imageViewPic_02.contentMode = UIViewContentModeScaleAspectFill;
        self.imageViewPic_02.layer.masksToBounds = YES;
        
        self.imageViewPic_03 = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageViewPic_03];
        self.imageViewPic_03.contentMode = UIViewContentModeScaleAspectFill;
        self.imageViewPic_03.layer.masksToBounds = YES;
        
        
        [self.imageViewPic_01 release];
        [self.imageViewPic_02 release];
        [self.imageViewPic_03 release];
        [self.labelAuthor_name release];
        [self.labelTitel release];
        
    }
    return self;
}

/* 子控件赋值 */
- (void)layoutSubviews {
    
   
    self.imageViewPic_01.frame = CGRectMake(15, 10, (self.frame.size.width- 50) / 3,self.contentView.frame.size.height / 2);
    self.imageViewPic_02.frame = CGRectMake(25 + (self.frame.size.width- 50) / 3, 10, (self.frame.size.width- 50) / 3, self.contentView.frame.size.height / 2 );
    self.imageViewPic_03.frame = CGRectMake(35 + (self.frame.size.width- 50) / 3 * 2, 10, (self.frame.size.width- 50) / 3, self.contentView.frame.size.height / 2);
    
    
    self.labelAuthor_name.frame = CGRectMake(15, self.labelTitel.frame.origin .y + 60, 120, 15);
    self.labelTitel.frame = CGRectMake(15, 115, self.frame.size.width -  35, 60);
    
}

- (void)setModel:(LhyHotPotModel *)model {
    
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    
    self.labelAuthor_name.text = model.auther_name;
    self.labelTitel.text = model.title;
    
    /* 如果为空, 则为广告 */
    if ([self.labelAuthor_name.text isEqualToString:@""]) {
        self.labelAuthor_name.text = @"广告";
    }
    
    NSMutableArray *arrUrl = [NSMutableArray array];
    for (NSMutableDictionary *dic in model.thumbnail_medias) {
        
        NSString *url = [dic objectForKey:@"url"];
        [arrUrl addObject:url];
    }

    
    [self.imageViewPic_01 sd_setImageWithURL:[arrUrl objectAtIndex:0] placeholderImage:[UIImage imageNamed:@"zhanwei_02"]];
    [self.imageViewPic_02 sd_setImageWithURL:[arrUrl objectAtIndex:1] placeholderImage:[UIImage imageNamed:@"zhanwei_02"]];
    [self.imageViewPic_03 sd_setImageWithURL:[arrUrl objectAtIndex:2] placeholderImage:[UIImage imageNamed:@"zhanwei_02"]];
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
