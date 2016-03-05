
//  LhySelected_04_TableViewCell.m
//  Maximal
//
//  Created by 李宏远 on 15/11/14.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhySelected_04_TableViewCell.h"
#import "LhyCommunity_SelectedModel.h"
#import "LhyAutoAdaptHeight.h"
#import "UIImageView+WebCache.h"

@interface LhySelected_04_TableViewCell ()

@property(nonatomic, retain)UIImageView *imageViewPic_01;
@property(nonatomic, retain)UIImageView *imageViewPic_02;
@property(nonatomic, retain)UIImageView *imageViewPic_03;

@end

@implementation LhySelected_04_TableViewCell

/* 重写初始化, 添加三个imageVIew */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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
    }
    
    return self;
}

/* 布局三个view并赋值数据 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    CGFloat contentCellHeight = [LhyAutoAdaptHeight heigntForCellWithContent:self.model.content width:[UIScreen mainScreen].bounds.size.width - 40 fontSize:14];
    //NSLog(@"%f", self.contentCellHeight);
    if (contentCellHeight >= 52) {
        contentCellHeight = 52;
    }

/* 指定三个imageView的frame */
    self.imageViewPic_01.frame = CGRectMake(10, 80 + contentCellHeight + 10, (self.frame.size.width - 20) / 3 - 2, [UIScreen mainScreen].bounds.size.height / 5 - 15);
    
    self.imageViewPic_02.frame = CGRectMake(10 + (self.frame.size.width - 20) / 3 + 1, 80 + contentCellHeight + 10, (self.frame.size.width - 20) / 3 - 2, [UIScreen mainScreen].bounds.size.height / 5 - 15);
    
    self.imageViewPic_03.frame = CGRectMake(10 + (self.frame.size.width - 20) /3 * 2 + 2, 80 + contentCellHeight + 10, (self.frame.size.width - 20) / 3 - 2, [UIScreen mainScreen].bounds.size.height / 5 - 15);
    
/* 为三个图片赋值 */
    NSMutableArray *arrPic = self.model.medias;
    NSMutableDictionary *dicPic_01 = [arrPic objectAtIndex:0];
    [self.imageViewPic_01 sd_setImageWithURL:[NSURL URLWithString:[dicPic_01 objectForKey:@"url"]] placeholderImage:[UIImage imageNamed:@"zhanwei_02"]];
    
    NSMutableDictionary *dicPic_02 = [arrPic objectAtIndex:1];
    [self.imageViewPic_02 sd_setImageWithURL:[NSURL URLWithString:[dicPic_02 objectForKey:@"url"]] placeholderImage:[UIImage imageNamed:@"zhanwei_02"]];
    
    NSMutableDictionary *dicPic_03 = [arrPic objectAtIndex:2];
    [self.imageViewPic_03 sd_setImageWithURL:[NSURL URLWithString:[dicPic_03 objectForKey:@"url"]] placeholderImage:[UIImage imageNamed:@"zhanwei_02"]];
    
}

@end
