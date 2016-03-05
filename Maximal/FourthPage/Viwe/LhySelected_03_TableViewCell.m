//

//  LhySelected_03_TableViewCell.m
//  Maximal
//
//  Created by 李宏远 on 15/11/14.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhySelected_03_TableViewCell.h"
#import "LhyCommunity_SelectedModel.h"
#import "LhyAutoAdaptHeight.h"
#import "UIImageView+WebCache.h"

@interface LhySelected_03_TableViewCell ()

@property(nonatomic, retain)UIImageView *imageViewPic_01;
@property(nonatomic, retain)UIImageView *imageViewPic_02;

@end

@implementation LhySelected_03_TableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageViewPic_01 = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageViewPic_01];
        self.imageViewPic_01.backgroundColor = [UIColor redColor];
        self.imageViewPic_01.contentMode = UIViewContentModeScaleAspectFill;
        self.imageViewPic_01.layer.masksToBounds = YES;
        
        self.imageViewPic_02 = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageViewPic_02];
        self.imageViewPic_02.backgroundColor = [UIColor redColor];
        self.imageViewPic_02.contentMode = UIViewContentModeScaleAspectFill;
        self.imageViewPic_02.layer.masksToBounds = YES;
        
        [self.imageViewPic_01 release];
        [self.imageViewPic_02 release];
    }
    
    return self;
}


/* 子视图布局 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    CGFloat contentCellHeight = [LhyAutoAdaptHeight heigntForCellWithContent:self.model.content width:[UIScreen mainScreen].bounds.size.width - 40 fontSize:14];
    //NSLog(@"%f", self.contentCellHeight);
    if (contentCellHeight >= 52) {
        contentCellHeight = 52;
    }
    
    
    self.imageViewPic_01.frame = CGRectMake(10, 80 + contentCellHeight + 10, (self.frame.size.width - 20) / 2 - 2, [UIScreen mainScreen].bounds.size.height / 4);
    
    self.imageViewPic_02.frame = CGRectMake(10 + (self.frame.size.width - 20) / 2 + 2, 80 + contentCellHeight + 10, (self.frame.size.width - 20) / 2 - 2, [UIScreen mainScreen].bounds.size.height / 4);
    
    NSMutableArray *arrPic = self.model.medias;
    NSMutableDictionary *dicPic_01 = [arrPic objectAtIndex:0];
    [self.imageViewPic_01 sd_setImageWithURL:[NSURL URLWithString:[dicPic_01 objectForKey:@"url"]] placeholderImage:[UIImage imageNamed:@"zhanwei_02"]];
  
    NSMutableDictionary *dicPic_02 = [arrPic objectAtIndex:1];
    [self.imageViewPic_02 sd_setImageWithURL:[NSURL URLWithString:[dicPic_02 objectForKey:@"url"]] placeholderImage:[UIImage imageNamed:@"zhanwei_02"]];
    
}

@end
