

//
//  LhyEnjoy_02TableViewCell.m
//  Maximal
//
//  Created by 李宏远 on 15/11/12.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyEnjoy_02TableViewCell.h"
#import "LhyEnjoy_MainModel.h"
#import "UIImageView+WebCache.h"
#import "LhyEnjoy_Main_ItemsModel.h"

@interface LhyEnjoy_02TableViewCell ()

@property(nonatomic, retain)UIImageView *imageViewPic;


@end

@implementation LhyEnjoy_02TableViewCell


- (void)dealloc {
    
    [_model release];
    [_imageViewPic release];
    [_labelBigFont release];
    [_LabelSmallFont release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        /* cell子控件的创建 */
        self.imageViewPic = [[UIImageView alloc] init];
      //  self.imageViewPic.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.imageViewPic];
        self.imageViewPic.contentMode = UIViewContentModeRedraw;
        self.imageViewPic.layer.masksToBounds = YES;
        
        self.labelBigFont = [[UILabel alloc] init];
      //  self.labelBigFont.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.labelBigFont];
       // self.labelBigFont.textColor = [UIColor whiteColor];
        self.labelBigFont.textAlignment = NSTextAlignmentCenter;
        self.labelBigFont.font = [UIFont boldSystemFontOfSize:20];
        
        self.LabelSmallFont = [[UILabel alloc] init];
    //    self.LabelSmallFont.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:self.LabelSmallFont];
     //   self.LabelSmallFont.textColor = [UIColor whiteColor];
        self.LabelSmallFont.textAlignment = NSTextAlignmentCenter;
        self.LabelSmallFont.font = [UIFont systemFontOfSize:16];
        
        [self.labelBigFont release];
        [self.LabelSmallFont release];
        [self.imageViewPic release];
        
    }
    
    return self;
}








/* cell子控件的布局 */
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.imageViewPic.frame = CGRectMake(0, 10, self.contentView.frame.size.width, self.frame.size.height - 10);
   // self.labelBigFont.frame = CGRectMake(15, self.contentView.frame.size.height / 2 - 25, self.contentView.frame.size.width - 30, 30);
   // self.LabelSmallFont.frame = CGRectMake(self.labelBigFont.frame.origin.x, self.labelBigFont.frame.origin.y + 35, self.labelBigFont.frame.size.width, 30);
    
    
}

/* 重写set方法, 完成数据的添加 */
- (void)setModel:(LhyEnjoy_Main_ItemsModel *)model {
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    
//    /* 切割字符串 */
//    if (![model.title isEqualToString:@"潮流地图"]) {
//        
//        if ([model.title containsString:@" "]) {
//            
//            NSArray *arr = [model.title componentsSeparatedByString:@" "];
//            self.labelBigFont.text = [arr objectAtIndex:0];
//            self.LabelSmallFont.text = [arr objectAtIndex:1];
//        
//            
//        } else if ([model.title containsString:@"，"]){
//            
//            NSArray *arr = [model.title componentsSeparatedByString:@"，"];
//            self.labelBigFont.text = [arr objectAtIndex:0];
//            self.LabelSmallFont.text = [arr objectAtIndex:1];
//            
//        } else {
//            
//            self.labelBigFont.text = model.title;
//        }
//        
//    }
//    
   

    
    [self.imageViewPic sd_setImageWithURL:[model.pic objectForKey:@"m_url"] placeholderImage:[UIImage imageNamed:@"zhanwei_01"]];
    
 //   NSLog(@"%@", model.title);
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
