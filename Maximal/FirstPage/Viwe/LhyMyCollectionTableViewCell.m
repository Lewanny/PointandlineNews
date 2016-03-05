
//
//  LhyMyCollectionTableViewCell.m
//  Maximal
//
//  Created by 李宏远 on 15/11/19.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyMyCollectionTableViewCell.h"
#import "LhyMainTb_01Model.h"

@interface LhyMyCollectionTableViewCell ()




@property(nonatomic, retain)UILabel *labelAythor;

@end
@implementation LhyMyCollectionTableViewCell


- (void)dealloc {
    
    [_labelAythor release];
    [_labelNum release];
    [_labelTitle release];
    [super dealloc];
}

#pragma mark - 重写初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.labelTitle = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelTitle];
      //  self.labelTitle.backgroundColor = [UIColor grayColor];
        
        self.labelAythor = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelAythor];
      //  self.labelAythor.backgroundColor = [UIColor grayColor];
        self.labelAythor.font = [UIFont systemFontOfSize:12];
        self.labelAythor.textColor = [UIColor colorWithWhite:0.646 alpha:1.000];
        
        self.labelNum = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelNum];
    //    self.labelNum.backgroundColor = [UIColor grayColor];
        
        
        
        [self.labelTitle release];
        [self.labelAythor release];
        [self.labelNum release];
    }
    
    return self;
    
}


#pragma mark - 布局子视图
- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.labelNum.frame = CGRectMake(10, 8, 25, self.frame.size.height / 2);
    self.labelTitle.frame = CGRectMake(self.labelNum.frame.origin.x + 30, 8, self.frame.size.width - 50, self.frame.size.height / 2);
    self.labelAythor.frame = CGRectMake(self.labelNum.frame.origin.x + 30, self.labelTitle.frame.origin.y + self.frame.size.height / 2 + 3, 90, 10);
    
    /* 铺数据 */
    self.labelTitle.text = self.model.title;
    self.labelAythor.text = self.model.auther_name;
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
