




//
//  LhyTMovie_01_ableViewCell.m
//  Maximal
//
//  Created by 李宏远 on 15/11/18.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyTMovie_01_ableViewCell.h"
#import "Lhy_Community_Video_SidLstModel.h"
#import "UIImageView+WebCache.h"

#import "Lhy_Video_Sort_ViewController.h"
#import "LhyCommunityViewController.h"

#import "ConfigurationTheme.h"

@interface LhyTMovie_01_ableViewCell ()

@property(nonatomic, retain)UIButton *buttonMore;
@property(nonatomic, retain)UIImageView *imageViewPic;
@property(nonatomic, retain)UILabel *labelName;

@property(nonatomic, retain)UIColor *cellDefaultColor;
@property(nonatomic, retain)UIColor *fontColor;

@end

@implementation LhyTMovie_01_ableViewCell



- (void)dealloc {
    
    [_fontColor release];
    [_cellDefaultColor release];
    
    [_labelName release];
    [_imageViewPic release];
    [_modelArr release];
    [super dealloc];
    
}


#pragma mark - 重写初始化方法
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
        
        self.cellDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"VCDefaultColor"];
        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontDefaultColor"];
    }

    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        for (int i = 1; i < 5; i++) {
            
            self.buttonMore = [UIButton buttonWithType:UIButtonTypeSystem];
            self.buttonMore.frame = CGRectMake((([UIScreen mainScreen].bounds.size.width - 3) / 4 + 1) * (i - 1), 0, ([UIScreen mainScreen].bounds.size.width - 3) / 4, ([UIScreen mainScreen].bounds.size.width - 3) / 4);
            [self.contentView addSubview:self.buttonMore];
            self.buttonMore.layer.cornerRadius = 1;
            self.buttonMore.layer.borderColor = [UIColor colorWithWhite:0.955 alpha:1.000].CGColor;
            self.buttonMore.backgroundColor = [UIColor whiteColor];
            self.buttonMore.tag = 100 * i;
            
           // self.buttonMore.backgroundColor = [UIColor redColor];
            /* 添加点击方法 */
            [self.buttonMore addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            self.imageViewPic = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 3) / 4 / 4, 10, ([UIScreen mainScreen].bounds.size.width - 3) / 4 / 2, ([UIScreen mainScreen].bounds.size.width - 3) / 4 / 2)];
            self.imageViewPic.layer.cornerRadius = ([UIScreen mainScreen].bounds.size.width - 3) / 4 / 2 / 2;
            [self.buttonMore addSubview:self.imageViewPic];
            self.buttonMore .backgroundColor = self.cellDefaultColor;
            self.imageViewPic.contentMode = UIViewContentModeScaleAspectFill;
            self.imageViewPic.layer.masksToBounds = YES;
            [self.imageViewPic release];
        
            
            self.labelName = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 3) / 4 / 4, ([UIScreen mainScreen].bounds.size.width - 3) / 4 - 30, ([UIScreen mainScreen].bounds.size.width - 3) / 4 / 2, 20)];
          //  self.labelName.backgroundColor = [UIColor grayColor];
            self.labelName.textAlignment = NSTextAlignmentCenter;
            self.labelName.font = [UIFont systemFontOfSize:15];
            [self.buttonMore addSubview:self.labelName];
            self.labelName.textColor = self.fontColor;
          //  self.buttonMore .backgroundColor = self.cellDefaultColor;
           // NSLog(@"%@", model.title);
            [self.labelName release];
            
        }
        
        
    }
    return self;
}


/* 改变主题消息 */
- (void)handleChangeTheme:(NSNotification *)noti {
    
    NSString *str = noti.object;
    if ([str isEqualToString:@"YES"]) {
        
        self.cellDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_NewColor"];
        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontNewColor"];
        
        self.labelName.textColor = self.fontColor;
        self.buttonMore .backgroundColor = self.cellDefaultColor;
        for (int i = 0;  i < 4; i++) {
            UIButton *button = [self.contentView.subviews objectAtIndex:i];
            button.backgroundColor = self.cellDefaultColor;
            
        }
        
    } else {
        
        self.cellDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"VCDefaultColor"];
        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontDefaultColor"];
        
        self.labelName.textColor = self.fontColor;
        /* 用for循环找到每一个button对象 */
        for (int i = 0;  i < 4; i++) {
            UIButton *button = [self.contentView.subviews objectAtIndex:i];
            button.backgroundColor = self.cellDefaultColor;
            
        }

        
    }
}



#pragma mark - 重写set方法 
- (void)setModelArr:(NSMutableArray *)modelArr {
    
    if (_modelArr != modelArr) {
        [_modelArr release];
        _modelArr = [modelArr retain];
    }

    /** < 会走两遍set方法, 第一遍为空 > */
    
   // NSLog(@"aaaa");
   // NSLog(@"%@", self.modelArr);
    
    /* 等数据加载完成, 传值成功后 */
    if (modelArr.count != 0) {
        
        /* 用for循环找到每一个button对象 */
        for (int i = 0;  i < 4; i++) {
            UIButton *button = [self.contentView.subviews objectAtIndex:i];
            
            Lhy_Community_Video_SidLstModel *model = [modelArr objectAtIndex:i];
            
           /* 找到button的子视图 */
            UIImageView *imageView = [button.subviews objectAtIndex:0];
            UILabel *labelTitle = [button.subviews objectAtIndex:1];
        
           /* 赋值 */
            labelTitle.text = model.title;
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:[UIImage imageNamed:@"zhanwei_01"]];
        }
    }
}


#pragma mark - button点击事件

- (void)handleAction:(UIButton *)button {
    
    
    Lhy_Video_Sort_ViewController *Video_SortVC = [[Lhy_Video_Sort_ViewController alloc] init];
    /* 传值 */
    Lhy_Community_Video_SidLstModel *model = [self.modelArr objectAtIndex:button.tag / 100 - 1];
    
    Video_SortVC.model = model;
    
    [[LhyCommunityViewController sharedMainVC].navigationController pushViewController:Video_SortVC animated:YES];
    
    /* 隐藏两个bar */
    [[LhyCommunityViewController sharedMainVC].navigationController setNavigationBarHidden:YES animated:YES];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"hideTabbar" object:nil];
    
    [Video_SortVC release];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
