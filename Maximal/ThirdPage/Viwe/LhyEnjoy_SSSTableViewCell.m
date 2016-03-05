
//  LhyEnjoy_SSSTableViewCell.m
//  Maximal
//
//  Created by 李宏远 on 15/11/17.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyEnjoy_SSSTableViewCell.h"
#import "Lhy_Main_SSSModel.h"
#import "UIImageView+WebCache.h"

@interface LhyEnjoy_SSSTableViewCell ()

@property(nonatomic, retain)UIImageView *imageViewPic;
@property(nonatomic, retain)UILabel *labelTitle;
@property(nonatomic, retain)UILabel *labelIntro;


@end

@implementation LhyEnjoy_SSSTableViewCell

- (void)dealloc {
    
    [_model release];
    [_imageViewPic release];
    [_labelIntro release];
    [_labelTitle release];
    [super dealloc];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        /* 子控件的创建 */
        self.imageViewPic = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageViewPic];
        self.imageViewPic.backgroundColor = [UIColor grayColor];
        self.imageViewPic.contentMode = UIViewContentModeTop;
        self.imageViewPic.layer.masksToBounds = YES;
        
        self.labelTitle = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelTitle];
        //    self.labelTitle.backgroundColor = [UIColor redColor];
        self.labelTitle.textAlignment = NSTextAlignmentCenter;
        self.labelTitle.font = [UIFont systemFontOfSize:16];
        
        
        self.labelIntro = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelIntro];
        //   self.labelIntro.backgroundColor = [UIColor blueColor];
        self.labelIntro.textAlignment = NSTextAlignmentCenter;
        self.labelIntro.textColor = [UIColor colorWithWhite:0.685 alpha:1.000];
        self.labelIntro.font = [UIFont systemFontOfSize:11];
       
        
        
        [self.imageViewPic release];
    }
    
    return self;
    
}

- (void)setModel:(Lhy_Main_SSSModel *)model {
    
 if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    
    self.labelTitle.text = model.title;
    self.labelIntro.text = model.pos_str;
    
    NSMutableDictionary *dci = [model.thumbnail_medias firstObject];
    [self.imageViewPic sd_setImageWithURL:[NSURL URLWithString:[dci objectForKey:@"m_url"]] placeholderImage:[UIImage imageNamed:@"zhanwei_01"]];
    
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.imageViewPic.frame = CGRectMake(0, 10, self.contentView.frame.size.width, self.contentView.frame.size.height / 3 * 2);
    self.labelTitle.frame = CGRectMake(15, self.imageViewPic.frame.size.height + 30, self.contentView.frame.size.width - 30, 30);
    self.labelIntro.frame = CGRectMake(15, self.imageViewPic.frame.size.height + 60, self.contentView.frame.size.width - 30, 15);
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
