
//  LhySelected_02_TableViewCell.m
//  Maximal
//
//  Created by 李宏远 on 15/11/14.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhySelected_02_TableViewCell.h"
#import "LhyCommunity_SelectedModel.h"
#import "LhyAutoAdaptHeight.h"
#import "UIImageView+WebCache.h"
#import "LhyCommunity_SelectedModel.h"
#import "UIImage+WebP.h"

@interface LhySelected_02_TableViewCell ()

@property(nonatomic, retain)UIImageView *imageViewPic;
@property(nonatomic, copy)NSString *picHeight;

@end

@implementation LhySelected_02_TableViewCell


- (void)dealloc {
    

    [_imageViewPic release];
    [_picHeight release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageViewPic = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageViewPic];
        self.imageViewPic.backgroundColor = [UIColor redColor];
        self.imageViewPic.contentMode = UIViewContentModeScaleAspectFill;
        self.imageViewPic.layer.masksToBounds = YES;
        [self.imageViewPic release];
    }
    
    return self;
}




- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    CGFloat contentCellHeight = [LhyAutoAdaptHeight heigntForCellWithContent:self.model.content width:[UIScreen mainScreen].bounds.size.width - 40 fontSize:14];
    //NSLog(@"%f", self.contentCellHeight);
    if (contentCellHeight >= 52) {
        contentCellHeight = 52;
    }
    
    

    
    self.imageViewPic.frame = CGRectMake(10, 80 + contentCellHeight + 10, self.frame.size.width - 20, ([UIScreen mainScreen].bounds.size.height- 154) / 2);
    
    NSMutableArray *arrPic = self.model.medias;
    NSMutableDictionary *dicPic = [arrPic firstObject];

    
  
    [self.imageViewPic sd_setImageWithURL:[NSURL URLWithString:[dicPic objectForKey:@"url"]] placeholderImage:[UIImage imageNamed:@"zhanwei_02"]];
 
    
}

@end
