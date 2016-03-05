

//
//  LhySearch_TableViewCell.m
//  Maximal
//
//  Created by 李宏远 on 15/11/18.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhySearch_TableViewCell.h"
#import "LhySearchModel.h"
#import "LhyAutoAdaptHeight.h"
#import "UIImageView+WebCache.h"

@interface LhySearch_TableViewCell ()

@property(nonatomic, retain)UILabel *labelTitle;
@property(nonatomic, retain)UILabel *labelContent;
@property(nonatomic, retain)UILabel *labelAuthor;
@property(nonatomic, retain)UILabel *lableTime;



@property(nonatomic, retain)UIImageView *imageViewPic;
@property(nonatomic, retain)NSMutableArray *keyWordArr;


@end

@implementation LhySearch_TableViewCell

- (void)dealloc {
    
    [_labelAuthor release];
    [_labelTitle release];
    [_labelContent release];
    [_imageViewPic release];
    [_lableTime release];
    [super dealloc];
}


#pragma mark - 重写初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        self.labelTitle = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelTitle];
       // self.labelTitle.backgroundColor = [UIColor grayColor];
        self.labelTitle.font =[UIFont boldSystemFontOfSize:16];
        self.labelTitle.numberOfLines = 2;
        
        self.labelContent = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelContent];
       // self.labelContent.backgroundColor = [UIColor grayColor];
        self.labelContent.font =[UIFont boldSystemFontOfSize:14];
        self.labelContent.textColor = [UIColor colorWithWhite:0.528 alpha:1.000];
        self.labelContent.numberOfLines = 2;
        
        self.labelAuthor = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelAuthor];
       // self.labelAuthor.backgroundColor = [UIColor grayColor];
        self.labelAuthor.font =[UIFont boldSystemFontOfSize:12];
        self.labelAuthor.textColor = [UIColor colorWithWhite:0.528 alpha:1.000];
        self.labelAuthor.numberOfLines = 2;
        
        self.lableTime = [[UILabel alloc] init];
        [self.contentView addSubview:self.lableTime];
        // self.labelAuthor.backgroundColor = [UIColor grayColor];
        self.lableTime.font =[UIFont boldSystemFontOfSize:12];
        self.lableTime.textColor = [UIColor colorWithWhite:0.528 alpha:1.000];
        self.lableTime.numberOfLines = 2;
        
        self.imageViewPic = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageViewPic];
        self.imageViewPic.backgroundColor = [UIColor grayColor];
        
        [_imageViewPic release];
        [self.labelTitle release];
        [self.labelAuthor release];
        [self.labelContent release];
    }
    
    return self;
}

#pragma mark - 重写set方法
- (void)setModel:(LhySearchModel *)model {
    
    if (_model!= model) {
        [_model release];
        _model = [model retain];
    }
    
   // NSLog(@"%@", model.s_title);
}


#pragma mark - 重新布局子视图

- (void)layoutSubviews {
    
    [super layoutSubviews];
/* 标题部分 */
    CGFloat labelTitleHeight = [LhyAutoAdaptHeight heigntForCellWithContent:self.model.s_title width:self.contentView.frame.size.width - 20 - 95 fontSize:16];
    if (labelTitleHeight > 40) {
        labelTitleHeight = 40;
    }
    
    self.labelTitle.frame = CGRectMake(10, 12, self.contentView.frame.size.width - 20 - 95, labelTitleHeight);
/* 小写转大写 */
    for (NSInteger i=0; i<self.keyWordStr.length; i++) {
        if ([self.keyWordStr characterAtIndex:i]>='a'&[self.keyWordStr characterAtIndex:i]<='z') {
            //A  65  a  97
            char  temp=[self.keyWordStr characterAtIndex:i]-32;
            NSRange range=NSMakeRange(i, 1);
            self.keyWordStr =[self.keyWordStr stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"%c",temp]];
        }
    }
    
/* 关键字部分高亮显示 */
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:self.model.s_title];
    NSRange range = [self.model.s_title rangeOfString:self.keyWordStr];
    [attriStr setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:range];
    
    self.labelTitle.attributedText = attriStr; /// 高度为38, 19]

    
    
    [attriStr release];

    
/* 内容部分 */
  //  CGFloat labelContentheight = [LhyAutoAdaptHeight heigntForCellWithContent:self.model.s_content width:self.contentView.frame.size.width - 20 - 95 fontSize:12];
    if (labelTitleHeight > 25) {
        self.labelContent.frame = CGRectMake(10, labelTitleHeight + 15, self.contentView.frame.size.width - 20 - 95, 17);
    } else {
        
        self.labelContent.frame = CGRectMake(10, labelTitleHeight + 15, self.contentView.frame.size.width - 20 - 95, 35);
    }
    
    /* 关键字部分高亮显示 */
    NSMutableAttributedString *attriStr_02 = [[NSMutableAttributedString alloc] initWithString:self.model.s_content];
    NSRange range_02 = [self.model.s_title rangeOfString:self.keyWordStr];
    [attriStr_02 setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:range_02];
    self.labelContent.attributedText = attriStr_02; /// 高度为38
    
/* 作者部分 */
    self.labelAuthor.frame = CGRectMake(10, self.contentView.frame.size.height - 22, 110, 15);
    self.labelAuthor.text = self.model.author;
 
/* 时间部分 */
    self.lableTime.frame = CGRectMake(100, self.contentView.frame.size.height - 22, 80, 15);
    self.lableTime.text = self.model.s_datetime;
    
/* 图片部分 */
    self.imageViewPic.frame = CGRectMake(self.contentView.frame.size.width -  90, 12.5, 80, 75);
    NSArray *strArr = [self.model.s_imghtml componentsSeparatedByString:@"/"];
    
    if (strArr.count  > 9) {
      

      //  NSLog(@"%@", strArr);
        
    /* 转换出URL格式 */
        NSString *urlStrPic = [strArr objectAtIndex:9];
        NSArray *strArr2 = [urlStrPic componentsSeparatedByString:@""">"];
        NSString *Url_02 = [strArr2 firstObject];
        NSString *url_01 = [NSString stringWithFormat:@"%@", [strArr objectAtIndex:8]];
        
        NSString *urlStrTem = [NSString stringWithFormat:@"%@%@%@%@",@"http://zkres.myzaker.com/", url_01, @"/", Url_02];
        NSString *urlStr = [urlStrTem substringWithRange:NSMakeRange(0, 64)];
        
      //  NSLog(@"%@", Url_02);
        NSLog(@"%@", urlStr);
        NSLog(@"aaa");
        
        [self.imageViewPic sd_setImageWithURL:[NSURL URLWithString:urlStr]];
       
    } else  {
        
        self.imageViewPic.image = [UIImage imageNamed:@"zhanwei_02"];
    }

    
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
