
//
//  LhyTMovie_02_ableViewCell.m
//  Maximal
//
//  Created by 李宏远 on 15/11/18.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyTMovie_02_ableViewCell.h"
#import "Lhy_Community_Video_ListModel.h"
#import "UIImageView+WebCache.h"
#import "LhyAVPlayerViewController.h"

#import "LhyCommunityViewController.h"
#import "ConfigurationTheme.h"


#import <AVFoundation/AVFoundation.h>

@interface LhyTMovie_02_ableViewCell ()

@property(nonatomic, retain)UILabel *labelTitle;
@property(nonatomic, retain)UILabel *labelStitle;
@property(nonatomic, retain)UIImageView *imageViewMp4;
@property(nonatomic, retain)UIImageView *imageViewLength;
@property(nonatomic, retain)UILabel *labelLength;
@property(nonatomic, retain)UIImageView *imageViewPlayCount;
@property(nonatomic, retain)UILabel *labelPlayCount;

@property(nonatomic, retain)UIButton *buttonPlay;




@property(nonatomic, retain)UIColor *cellDefaultColor;
@property(nonatomic, retain)UIColor *fontColor;

@end

@implementation LhyTMovie_02_ableViewCell

- (void)dealloc {
    
    [_cellDefaultColor release];
    [_fontColor release];
    
 
    [_model release];
    [_labelStitle release];
    [_labelTitle release];
    [_imageViewMp4 release];
    [_imageViewLength release];
    [_imageViewPlayCount release];
    [_labelLength release];
    [_labelPlayCount release];
    self.labelTitle.textColor = self.fontColor;
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

    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.backgroundColor = self.cellDefaultColor;
    if (self) {
    /* title */
        self.labelTitle = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelTitle];
      //  self.labelTitle.backgroundColor = [UIColor grayColor];
        self.labelTitle.font = [UIFont systemFontOfSize:18];
        self.labelTitle.textColor = self.fontColor;
        [self.labelTitle release];
        
        
        self.labelStitle = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelStitle];
        self.labelStitle.font = [UIFont systemFontOfSize:14];
        self.labelStitle.textColor = [UIColor colorWithWhite:0.600 alpha:1.000];
        //self.backgroundColor = self.cellDefaultColor;
        [self.labelStitle release];
        
   /* iamgePic */
        self.imageViewMp4 = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageViewMp4];
        self.imageViewMp4.backgroundColor = [UIColor grayColor];
        /* 打开用户交互 */
        self.imageViewMp4.userInteractionEnabled = YES;
        self.imageViewMp4.contentMode = UIViewContentModeScaleAspectFill;
        self.imageViewMp4.layer.masksToBounds = YES;
        [self.imageViewMp4 release];
        
    /* 播放按钮 */
        self.buttonPlay = [UIButton buttonWithType:UIButtonTypeCustom];
        self.buttonPlay.alpha = 0.6;
        [self.imageViewMp4 addSubview:self.buttonPlay];
        [self.buttonPlay addTarget:self action:@selector(beginToPlay:) forControlEvents:UIControlEventTouchUpInside];
        
        
        self.imageViewLength = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageViewLength];
      //  self.imageViewLength.backgroundColor = [UIColor grayColor];
        self.imageViewLength.image = [UIImage imageNamed:@"iconfont-iconfonttime"];
        [self.imageViewLength release];
        
        self.imageViewPlayCount = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageViewPlayCount];
       // self.imageViewPlayCount.backgroundColor = [UIColor grayColor];
        self.imageViewPlayCount.image = [UIImage imageNamed:@"iconfont-play"];
        [self.imageViewPlayCount release];
      
   /* count */
        self.labelLength = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelLength];
//     /   self.labelLength.backgroundColor = [UIColor grayColor];
        self.labelLength.font = [UIFont systemFontOfSize:13];
        self.labelLength.textColor = [UIColor grayColor];
        [self.labelLength release];
        
        
        self.labelPlayCount = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelPlayCount];
      //  self.labelPlayCount.backgroundColor = [UIColor grayColor];
        self.labelPlayCount.font = [UIFont systemFontOfSize:13];
        self.labelPlayCount.textColor = [UIColor grayColor];
        [self.labelPlayCount release];
        
    }
    
    return self;
}


/* 改变主题消息 */
- (void)handleChangeTheme:(NSNotification *)noti {
    
    NSString *str = noti.object;
    if ([str isEqualToString:@"YES"]) {
        
        self.cellDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_NewColor"];
        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontNewColor"];
        self.backgroundColor = self.cellDefaultColor;
        self.labelTitle.textColor = self.fontColor;
        
    } else {
        
        self.cellDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_DefaultColor"];
        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontDefaultColor"];
        self.backgroundColor = self.cellDefaultColor;
        self.labelTitle.textColor = self.fontColor;
    }
}



#pragma mark - 布局子视图 
- (void)layoutSubviews {
    [super layoutSubviews];
    self.labelTitle.frame = CGRectMake(10, 12, self.contentView.frame.size.width  -  20, 20);
    self.labelStitle.frame = CGRectMake(10, 40 , self.contentView.frame.size.width  -  20, 15);
    self.imageViewMp4.frame = CGRectMake(10, 65, self.contentView.frame.size.width  -  20, 190);

    self.imageViewLength.frame = CGRectMake(10, 271, 15, 15);
    self.labelLength.frame = CGRectMake(30, 268, 60, 20);
    self.imageViewPlayCount.frame = CGRectMake(100, 270, 15, 15);
    self.labelPlayCount.frame = CGRectMake(120, 268, 60, 20);
    
    self.buttonPlay.frame = CGRectMake(self.imageViewMp4.frame.size.width / 2 - 25, self.imageViewMp4.frame.size.height / 2 - 25, 50, 50);
}

#pragma mark - 重写初始化方法
- (void)setModel:(Lhy_Community_Video_ListModel *)model {
    
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    
    self.labelTitle.text = model.title;
    self.labelStitle.text = model.descriptions;
    [self.imageViewMp4 sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"zhanwei_01"]];
    
    [self.buttonPlay setImage:[UIImage imageNamed:@"iconfont-bofang-2"] forState:UIControlStateNormal];
    
    /* 字符格式转换 */
    int length = [model.length intValue];
    NSLog(@"%d", length);
    if (length < 60) {
        if (length >= 10) {
            
            self.labelLength.text = [NSString stringWithFormat:@"%@%@%02d", @"00", @":", length];
        } else {
            
             self.labelLength.text = [NSString stringWithFormat:@"%@%@%02d", @"00", @":0", length];
        }
       
    } else {
        
        int second = length % 60;
        int minute = length / 60;
        if (minute < 10) {
            if (second >= 10) {
                 self.labelLength.text = [NSString stringWithFormat:@"%@%d%@%d", @"0", minute, @":", second];
            } else {
                self.labelLength.text = [NSString stringWithFormat:@"%@%d%@%d", @"0", minute, @":0", second];
            }
            
        } else {
            if (second >= 10) {
                self.labelLength.text = [NSString stringWithFormat:@"%d%@%d", minute, @":", second];
            } else {
                
                self.labelLength.text = [NSString stringWithFormat:@"%d%@%d", minute, @":0", second];
                
            }
        }
    }
    
    
    int totalCount = [model.playCount intValue];
    int million = totalCount / 10000;
    int num = totalCount % 10000;
    NSString *numStr = [NSString stringWithFormat:@"%d", num];
    NSString *pointStr = [numStr substringToIndex:1];
    int pointer = [pointStr intValue];
    NSLog(@"%@", pointStr);
    
    if (totalCount >= 10000) {
        
        self.labelPlayCount.text = [NSString stringWithFormat:@"%d%@%d%@", million, @".", pointer, @"万"];
        
    } else {
        
        self.labelPlayCount.text = [NSString stringWithFormat:@"%@", model.playCount];
        
    }
}


#pragma mark - 播放方法
- (void)beginToPlay:(UIButton *)button{
    
    LhyAVPlayerViewController *AVcontroller = [[LhyAVPlayerViewController alloc] init];
    
    /* 传值 */
    AVcontroller.urlStr = self.model.mp4_url;
    AVcontroller.titleStr = self.model.title;
    [[LhyCommunityViewController sharedMainVC] presentViewController:AVcontroller animated:YES completion:^{
        
    }];
    
    [AVcontroller release];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
