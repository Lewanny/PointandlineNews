



//
//  LhyMyInfo_TableViewCell.m
//  Maximal
//
//  Created by 李宏远 on 15/11/19.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyMyInfo_TableViewCell.h"
#import "ConfigurationTheme.h"

@interface LhyMyInfo_TableViewCell ()

@property(nonatomic, retain)UIImageView *imageViewNext;
@property(nonatomic, retain)UIColor *cellDefaultColor;
@property(nonatomic, retain)UIColor *fontColor;


@end


@implementation LhyMyInfo_TableViewCell


- (void)dealloc {
    
    [_cellDefaultColor release];
    [_fontColor release];
    
    [_imageViewIcon release];
    [_labelTitle release];
    [_imageViewNext release];
    [super dealloc];
}

#pragma mark - 初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    /* 注册消息 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleChangeTheme:) name:@"changeTheme" object:nil];
    
    /* 读取本地文件 */
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"Theme.tex"];
    NSString *readStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    /* 主体颜色 */
    if ([readStr isEqualToString:@"YES"]) {
    
        self.cellDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_NewColor"];
        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontNewColor"];
        
        
    } else {
        

        self.cellDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_DefaultColor"];
        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontDefaultColor"];
        
    }

    self.backgroundColor = self.cellDefaultColor;
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.labelTitle = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelTitle];
       // self.labelTitle.backgroundColor = [UIColor grayColor];
       // self.labelTitle.text  = @"我的收藏";
        self.labelTitle.font = [UIFont systemFontOfSize:15];
        self.labelTitle.textColor = self.fontColor;
        
        self.imageViewNext = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageViewNext];
        self.imageViewNext.image = [UIImage imageNamed:@"addRootBlock_toolbar_next"];
        
        self.imageViewIcon = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageViewIcon];
       // self.imageViewIcon.backgroundColor = [UIColor grayColor];
        
        
        [self.labelTitle release];
        
    }
    return self;
}

/* 改变主题消息 */
- (void)handleChangeTheme:(NSNotification *)noti {
    
    NSString *str = noti.object;
    if ([str isEqualToString:@"YES"]) {
        
        self.backgroundColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_NewColor"];
       
        self.cellDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_NewColor"];
        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontNewColor"];
        self.labelTitle.textColor = self.fontColor;
        
        
    } else {
        
        self.backgroundColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_DefaultColor"];
        

        self.cellDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_DefaultColor"];
        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontDefaultColor"];
        self.labelTitle.textColor = self.fontColor;
        
    }
    
    
}

#pragma mark - 重新布局子视图
- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.labelTitle.frame = CGRectMake(50, self.contentView.frame.size.height / 3, 60, self.contentView.frame.size.height / 3);
 
    
    self.imageViewIcon.frame = CGRectMake(12, self.contentView.frame.origin.x + 15, self.contentView.frame.size.height - 30, self.contentView.frame.size.height - 30);
    
    self.imageViewNext.frame = CGRectMake(self.frame.size.width - 30, self.contentView.frame.origin.x + 15, self.contentView.frame.size.height - 38, self.contentView.frame.size.height - 30);
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
