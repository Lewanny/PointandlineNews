//
//  LhyDiscovery_01_TableViewCell.m
//  Maximal
//
//  Created by 李宏远 on 15/11/13.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyDiscovery_01_TableViewCell.h"
#import "LhyCommunity_DiscoveryModel.h"
#import "UIImageView+WebCache.h"

@interface LhyDiscovery_01_TableViewCell ()

@property(nonatomic, retain)UIImageView *imageViewPic;

@property(nonatomic, retain)UILabel *labelIntro;


@end

@implementation LhyDiscovery_01_TableViewCell

- (void)dealloc {
    
    [_model release];
    [_imageViewPic release];
    [_labelIntro release];
    [_labelTitel release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.imageViewPic = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageViewPic];
        self.imageViewPic.contentMode = UIViewContentModeScaleAspectFill;
        self.imageViewPic.layer.masksToBounds = YES;
     //   self.imageViewPic.backgroundColor = [UIColor greenColor];
        
        self.labelTitel = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelTitel];
       // self.labelTitel.backgroundColor = [UIColor grayColor];
        self.labelTitel.font = [UIFont systemFontOfSize:17];
        
        self.labelIntro= [[UILabel alloc] init];
        [self.contentView addSubview:self.labelIntro];
      //  self.labelIntro.backgroundColor = [UIColor grayColor];
        self.labelIntro.font = [UIFont systemFontOfSize:12];
        self.labelIntro.textColor = [UIColor colorWithWhite:0.655 alpha:1.000];
        
    
        [self.labelTitel release];
        [self.labelIntro release];
        [self.imageViewPic release];
    }
    
    return  self;
}

- (void)setModel:(LhyCommunity_DiscoveryModel *)model {
    
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    
    self.labelTitel.text = model.title;
    self.labelIntro.text = model.stitle;
    if ([model.title containsString:@"Maximal"]) {
        self.imageViewPic.image = [UIImage imageNamed:@"logo"];
    } else{
        [self.imageViewPic sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"zhanwei_02"]];
    }
}


/* 布局子控件 */
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.imageViewPic.frame = CGRectMake(10, self.frame.size.height / 5, self.frame.size.width / 8, self.frame.size.height / 5 * 3);
    self.labelTitel.frame = CGRectMake(self.imageViewPic.frame.size.width + 25, self.imageViewPic.frame.origin.y + 5, self.frame.size.width / 2, self.frame.size.height / 4);
    self.labelIntro.frame =  CGRectMake(self.imageViewPic.frame.size.width + 25, self.frame.size.height / 3 * 2, self.frame.size.width / 3 * 2, self.frame.size.height / 7);
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
