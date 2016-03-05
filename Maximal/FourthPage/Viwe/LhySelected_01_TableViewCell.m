
//
//  LhySelected_01_TableViewCell.m
//  Maximal
//
//  Created by 李宏远 on 15/11/13.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhySelected_01_TableViewCell.h"
#import "LhyCommunity_SelectedModel.h"
#import "UIImageView+WebCache.h"
#import "LhyAutoAdaptHeight.h"

@interface LhySelected_01_TableViewCell ()

@property(nonatomic, retain)UIView *backgroundViews;
@property(nonatomic, retain)UIView *seperatorTop;
@property(nonatomic, retain)UIView *seperatorButtom;
@property(nonatomic, retain)UIView *seperatorHerFirst;
@property(nonatomic, retain)UIView *seperatorHerSecond;

@property(nonatomic, retain)UIImageView *imageViewWatch;
@property(nonatomic, retain)UIImageView *imageViewComment;
@property(nonatomic, retain)UIImageView *imageViewSupport;
@property(nonatomic, retain)UILabel *labelWatch;
@property(nonatomic, retain)UILabel *labelComment;
@property(nonatomic, retain)UILabel *labelSupport;
@property(nonatomic, retain)UIButton *buttonSupport;

@property(nonatomic, retain)UIImageView *imageviewUserPic;
@property(nonatomic, retain)UILabel *labelUserName;
@property(nonatomic, retain)UILabel *labelContent;

@property(nonatomic, retain)UIButton *buttonSource;




@property(nonatomic, assign)CGFloat contentCellHeight;

@end

@implementation LhySelected_01_TableViewCell

- (void)dealloc {
   
    [_model release];
    
    [_backgroundViews release];
    [_seperatorTop release];
    [_seperatorButtom release];
    [_seperatorHerFirst release];
    [_seperatorHerSecond release];
    
    [_imageViewWatch release];
    [_imageViewComment release];
    [_imageViewSupport release];
    [_labelSupport release];
    [_labelComment release];
    [_labelWatch release];
    [_buttonSupport release];
    
    [_imageviewUserPic release];
    [_labelUserName release];
    [_buttonSource release];
    
    [_labelContent release];
    [super dealloc];
}


/* 重写初始化 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
     
    /* 底部的view和四条分割线 */
        self.backgroundViews = [[UIView alloc] init];
        [self.contentView addSubview:self.backgroundViews];
        self.backgroundViews.backgroundColor = [UIColor whiteColor];
        self.backgroundViews.layer.cornerRadius = 6;
        
        self.seperatorTop = [[UIView alloc] init];
        [self.contentView addSubview:self.seperatorTop];
        self.seperatorTop.backgroundColor = [UIColor colorWithWhite:0.951 alpha:1.000];
        
        self.seperatorButtom = [[UIView alloc] init];
        [self.contentView addSubview:self.seperatorButtom];
        self.seperatorButtom.backgroundColor = [UIColor colorWithWhite:0.951 alpha:1.000];
        
        
        self.seperatorHerFirst = [[UIView alloc] init];
        [self.contentView addSubview:self.seperatorHerFirst];
        self.seperatorHerFirst.backgroundColor = [UIColor colorWithWhite:0.951 alpha:1.000];
        
        self.seperatorHerSecond = [[UIView alloc] init];
        [self.contentView addSubview:self.seperatorHerSecond];
        self.seperatorHerSecond.backgroundColor = [UIColor colorWithWhite:0.951 alpha:1.000];
        
        
    /* 下面的2个imageView + 1个button 和3个label */
        /*imageviwe*/
        
        self.buttonSupport = [[UIButton alloc] init];
        [self.contentView addSubview:self.buttonSupport];
        //self.buttonSupport.backgroundColor = [UIColor yellowColor];
        
        self.imageViewWatch = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageViewWatch];
      //  self.imageViewWatch.backgroundColor = [UIColor grayColor];
        self.imageViewWatch.image = [UIImage imageNamed:@"Eye-gray"];
        
        self.imageViewComment = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageViewComment];
     //   self.imageViewComment.backgroundColor = [UIColor grayColor];
        self.imageViewComment.image = [UIImage imageNamed:@"common_icon_comment_s"];
        
        self.imageViewSupport = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageViewSupport];
    //  self.imageViewSupport.backgroundColor = [UIColor grayColor];
        self.imageViewSupport.image = [UIImage imageNamed:@"Thumb-gray-16"];
        
        /* label */
        self.labelWatch = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelWatch];
       // self.labelWatch.backgroundColor = [UIColor grayColor];
        self.labelWatch.font = [UIFont systemFontOfSize:12];
        self.labelWatch.textColor = [UIColor colorWithWhite:0.720 alpha:1.000];
        
        self.labelComment = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelComment];
      //  self.labelComment.backgroundColor = [UIColor grayColor];
        self.labelComment.font = [UIFont systemFontOfSize:12];
        self.labelComment.textColor = [UIColor colorWithWhite:0.720 alpha:1.000];
        
        self.labelSupport = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelSupport];
       // self.labelSupport.backgroundColor = [UIColor grayColor];
        self.labelSupport.font = [UIFont systemFontOfSize:12];
        self.labelSupport.textColor = [UIColor colorWithWhite:0.720 alpha:1.000];
        
        
        
        
    /* 上部的头像view, 用户名和来源 */
        self.imageviewUserPic= [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageviewUserPic];
       // self.imageviewUserPic.backgroundColor = [UIColor grayColor];
        self.imageviewUserPic.layer.cornerRadius = 15;
        self.imageviewUserPic.layer.masksToBounds = YES;
        self.imageviewUserPic.contentMode = UIViewContentModeScaleAspectFill;
        self.imageviewUserPic.layer.masksToBounds = YES;
        
        self.labelUserName = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelUserName];
       // self.labelUserName.backgroundColor = [UIColor grayColor];
        self.labelUserName.font = [UIFont systemFontOfSize:14];
        self.labelUserName.textAlignment = NSTextAlignmentLeft;
        self.labelUserName.textColor = [UIColor colorWithRed:0.144 green:0.594 blue:1.000 alpha:1.000];
        
        self.buttonSource = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.contentView addSubview:self.buttonSource];
       // [self.buttonSource setBackgroundColor:[UIColor grayColor]];
        self.buttonSource.contentHorizontalAlignment = NSTextAlignmentRight;
        [self.buttonSource setTitleColor:[UIColor colorWithWhite:0.652 alpha:1.000] forState:UIControlStateNormal];
        self.buttonSource.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.buttonSource setTitle:@"" forState:UIControlStateNormal];
        
// 设置labelContent
        self.labelContent = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelContent];
       // self.labelContent.backgroundColor = [UIColor grayColor];
        self.labelContent.font = [UIFont systemFontOfSize:14];
        self.labelContent.numberOfLines = 3;
        
 
        [self.backgroundViews release];
        [self.seperatorTop release];
        [self.seperatorButtom release];
        [self.seperatorHerFirst release];
        [self.seperatorHerSecond release];
        
        [self.imageViewWatch release];
        [self.imageViewComment release];
        [self.imageViewSupport release];
        [self.labelSupport release];
        [self.labelWatch release];
        [self.labelComment release];
        
        [self.labelUserName release];
        [self.imageviewUserPic release];
        
        [self.labelContent release];
        
    }
    return self;
}



/* 重写初始化方法, 完成数据的加载 */
- (void)setModel:(LhyCommunity_SelectedModel *)model {
    
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
/* 用户名和头像 */
    NSMutableDictionary *dicUser = model.auther;
    self.labelUserName.text = [dicUser objectForKey:@"name"];
    if ([model.auther_name isEqualToString:@"话题小秘书"]) {
        
        self.imageviewUserPic.image = [UIImage imageNamed:@"logo-1"];
    } else {
        [self.imageviewUserPic sd_setImageWithURL:[NSURL URLWithString:[dicUser objectForKey:@"icon"]] placeholderImage:[UIImage imageNamed:@"zhanwei_02"]];
    }
    
/* 来源 */
    NSMutableDictionary *dicSpecial = model.special_info;
    if ([dicSpecial objectForKey:@"discussion_title"]== nil) {
//        NSString *source = [NSString stringWithFormat:@"%@%@", @"# ", [dicSpecial objectForKey:@"discussion_title"]];
        [self.buttonSource setTitle:@"" forState:UIControlStateNormal];
    } else {
        NSString *source = [NSString stringWithFormat:@"%@%@", @"# ", [dicSpecial objectForKey:@"discussion_title"]];
        [self.buttonSource setTitle:source forState:UIControlStateNormal];
        
    }
    
    
/* 评论, 查看, 点赞的数量 */
    
    int totalCount = [model.hot_num intValue];
    int million = totalCount / 1000;
    int num = totalCount % 1000;
    NSString *numStr = [NSString stringWithFormat:@"%d", num];
    NSString *pointStr = [numStr substringToIndex:1];
    int pointer = [pointStr intValue];
    NSLog(@"%@", pointStr);
    
    if (totalCount >= 1000) {
        
        self.labelWatch.text = [NSString stringWithFormat:@"%d%@%d%@", million, @".", pointer, @"k"];
        
    } else {
        
        self.labelWatch.text = [NSString stringWithFormat:@"%@", model.hot_num];
        
    }
    NSLog(@"%@", model.hot_num);
    
  //  self.labelWatch.text = model.hot_num;
    self.labelComment.text = model.comment_count;
    self.labelSupport.text = model.like_num;
    
// labelContent的内容
    self.contentCellHeight = [LhyAutoAdaptHeight heigntForCellWithContent:model.content width:[UIScreen mainScreen].bounds.size.width - 40 fontSize:14];
    //NSLog(@"%f", self.contentCellHeight);
    if (self.contentCellHeight >= 52) {
        self.contentCellHeight = 52;
    }
    self.labelContent.text = model.content;
}


#pragma mark - 子视图布局
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
/* 分割线和底部view */
    self.backgroundViews.frame = CGRectMake(10, 10, self.frame.size.width - 20, self.frame.size.height - 10);
    self.seperatorTop.frame = CGRectMake(10, self.frame.origin.x + 65, self.frame.size.width - 20, 1);
    self.seperatorButtom.frame = CGRectMake(10, self.frame.size.height - 36, self.frame.size.width - 20, 1);
    
    self.seperatorHerFirst.frame = CGRectMake(10 + (self.frame.size.width - 20) / 3, self.frame.size.height - 36, 1, 36);
    
    self.seperatorHerSecond.frame = CGRectMake(10 + (self.frame.size.width - 20) / 3 * 2, self.frame.size.height - 36, 1, 36);
   
/* 下面的三个imageView 和label */
    self.imageViewWatch.frame = CGRectMake(10 + 40, self.frame.size.height - 25, 15, 15);
    self.labelWatch.frame = CGRectMake(5 + 40 + 25, self.frame.size.height - 25, 50, 15);
    
    self.imageViewComment.frame = CGRectMake(10 + 40 + (self.frame.size.width - 20) / 3 - 1, self.frame.size.height - 25, 15, 15);
    self.labelComment.frame = CGRectMake(5 + 40 + 25 + (self.frame.size.width - 20) / 3 - 1, self.frame.size.height - 25, 50, 15);
    
    self.buttonSupport.frame = CGRectMake(10 + (self.frame.size.width - 20) / 3 * 2, self.frame.size.height - 35 , (self.frame.size.width - 20) / 3, 35);
    self.imageViewSupport.frame = CGRectMake(10 + 40 + (self.frame.size.width - 20) / 3 * 2 - 1, self.frame.size.height - 25, 15, 15);
    self.labelSupport.frame = CGRectMake(5 + 40 + 25 + (self.frame.size.width - 20) / 3 *2 - 1, self.frame.size.height - 25, 50, 15);
  
/* 上部的头像view, 用户名和来源 */
    self.imageviewUserPic.frame = CGRectMake(25, 25, 30, 30);
    self.labelUserName.frame = CGRectMake(60, 30, self.frame.size.width / 3, 20);
    self.buttonSource.frame = CGRectMake(self.frame.size.width / 7 * 4, 35, self.frame.size.width /3 + 10, 15);
    
/* 显示content的label */
    self.labelContent.frame = CGRectMake(20, 80, self.frame.size.width - 40, self.contentCellHeight);
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
