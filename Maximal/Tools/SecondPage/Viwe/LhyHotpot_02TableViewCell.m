
//
//  LhyHotpot_02TableViewCell.m
//  Maximal
//
//  Created by 李宏远 on 15/11/11.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyHotpot_02TableViewCell.h"
#import "LhyHotPotModel.h"
#import "UIImageView+WebCache.h"

@interface LhyHotpot_02TableViewCell ()


@property(nonatomic, retain)UIImageView *imageViewPic;

@end

@implementation LhyHotpot_02TableViewCell





- (void)dealloc {
    [_model release];
    [_imageViewPic release];
    [_labelAuthor_name release];
    [_labelTitel release];
    [super dealloc];
    
}

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
        self.labelAuthor_name.font = [UIFont systemFontOfSize:12];
        self.labelAuthor_name.textAlignment = NSTextAlignmentLeft;
        
        
        self.imageViewPic = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageViewPic];
        self.imageViewPic.contentMode = UIViewContentModeScaleAspectFill;
        self.imageViewPic.layer.masksToBounds = YES;
        
        
        [self.imageViewPic release];
        [self.labelAuthor_name release];
        [self.labelTitel release];
        
    }
    return self;
}

- (void)layoutSubviews {
    
    
    

    self.imageViewPic.frame = CGRectMake(self.frame.size.width / 3 * 2 + 15, 10, self.contentView.frame.size.width - (self.frame.size.width / 3 * 2 + 30), self.frame.size.height - 20);
    self.labelTitel.frame = CGRectMake(15, 10, self.frame.size.width -  self.imageViewPic.frame.size.width - 55 , self.contentView.frame.size.height - 40);
    self.labelAuthor_name.frame = CGRectMake(15, self.labelTitel.frame.size.height + 10, 120, 15);
}

- (void)setModel:(LhyHotPotModel *)model {
    
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    
    self.labelTitel.text = model.title;
    self.labelAuthor_name.text = model.auther_name;
    /* 如果为空, 则为广告 */
    if ([self.labelAuthor_name.text isEqualToString:@""]) {
        self.labelAuthor_name.text = @"广告";
    }
    
    NSDictionary *dic = [model.thumbnail_medias firstObject];
    [self.imageViewPic sd_setImageWithURL:[dic objectForKey:@"url"] placeholderImage:[UIImage imageNamed:@"zhanwei_02"]];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
