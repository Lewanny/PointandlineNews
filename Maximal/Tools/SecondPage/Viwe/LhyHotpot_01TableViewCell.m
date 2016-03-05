
//
//  LhyHotpot_01TableViewCell.m
//  Maximal
//
//  Created by 李宏远 on 15/11/11.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyHotpot_01TableViewCell.h"
#import "LhyHotPotModel.h"

@interface LhyHotpot_01TableViewCell ()
//
//@property(nonatomic, retain)UILabel *labelTitel;
//@property(nonatomic, retain)UILabel *labelAuthor_name;

@end

@implementation LhyHotpot_01TableViewCell

- (void)dealloc {
    [_model release];
    [_labelAuthor_name release];
    [_labelTitel release];
    [super dealloc];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.labelTitel = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelTitel];
    //    self.labelTitel.backgroundColor = [UIColor grayColor];
        self.labelTitel.textAlignment = NSTextAlignmentLeft;
        self.labelTitel.font = [UIFont systemFontOfSize:16];
        self.labelTitel.numberOfLines = 2;
        
        self.labelAuthor_name = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelAuthor_name];
        self.labelAuthor_name.textAlignment = NSTextAlignmentLeft;
        self.labelAuthor_name.font = [UIFont systemFontOfSize:12];
        
        [self.labelAuthor_name release];
        [self.labelTitel release];
        
    }
    return self;
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
    
}


- (void)layoutSubviews {
    
    self.labelTitel.frame = CGRectMake(15, 10, self.frame.size.width - 30, self.contentView.frame.size.height - 40);
    self.labelAuthor_name.frame = CGRectMake(15, self.labelTitel.frame.size.height + 10, 120, 15);
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
