



//
//  LhyMyInfo_TableViewCell.m
//  Maximal
//
//  Created by 李宏远 on 15/11/19.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyMyInfo_02_TableViewCell.h"
#import "ConfigurationTheme.h"

@interface LhyMyInfo_02_TableViewCell ()

@property(nonatomic, retain)UIImageView *imageViewNext;

@property(nonatomic, retain)UISwitch *switchButton;

@property(nonatomic, assign)BOOL switchIsOn;

@property(nonatomic, copy)NSString *themeIsOn;

@property(nonatomic, retain)UIColor *cellDefaultColor;
@property(nonatomic, retain)UIColor *fontColor;

@end


@implementation LhyMyInfo_02_TableViewCell


- (void)dealloc {
    [_fontColor release];
    [_cellDefaultColor release];
    
    [_themeIsOn release];
    [_switchButton release];
    [_imageViewIcon release];
    [_labelTitle release];
    [_imageViewNext release];
    [super dealloc];
}

#pragma mark - 初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    /* 读取本地文件 */
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"Theme.tex"];
    NSString *readStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    /* 注册消息 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleChangeTheme:) name:@"changeTheme" object:nil];
    
    
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
        
        
        self.switchButton = [[UISwitch alloc] init];
        [self.contentView addSubview:self.switchButton];
        self.switchButton.onTintColor = [UIColor colorWithRed:0.381 green:0.767 blue:1.000 alpha:1.000];
        [self.switchButton addTarget:self action:@selector(changeTheme:) forControlEvents:UIControlEventValueChanged];
        
        /* 如果为夜间模式, 开关默认打开 */
        if ([readStr isEqualToString:@"YES"]) {
            [self.switchButton setOn:YES];
        }
        
        self.imageViewIcon = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageViewIcon];
    //    self.imageViewIcon.backgroundColor = [UIColor grayColor];
        
        
        [self.labelTitle release];
        
    }
    return self;
}

#pragma mark - 发送夜间模式通知
- (void)changeTheme:(UISwitch *)switchButton {
    
    if (self.switchButton.isOn == YES) {
        self.themeIsOn = @"YES";
    } else {
        
        self.themeIsOn = @"NO";
    }
    
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"Theme.tex"];
    [self.themeIsOn writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    NSString *readStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@", readStr);
    
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeTheme" object:self.themeIsOn userInfo:nil];
  
    
    
    
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
    
    self.switchButton.frame = CGRectMake(self.frame.size.width - 65, self.contentView.frame.size.height / 4, 40, 25);
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
