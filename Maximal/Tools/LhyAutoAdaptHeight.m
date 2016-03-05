
//
//  LhyAutoAdaptHeight.m
//  Maximal
//
//  Created by 李宏远 on 15/11/14.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyAutoAdaptHeight.h"
#import <UIKit/UIKit.h>

@implementation LhyAutoAdaptHeight

// 文字自适应高度方法
+ (CGFloat)heigntForCellWithContent:(NSString *)content width:(NSInteger)width fontSize:(NSInteger)fontSize{
    
    CGRect rect = [content boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    
    return rect.size.height;
}

// 图片自适应高度
+ (CGFloat)heigntForCellWithImage:(UIImage *)image {
    
 //   UIImage *image = [UIImage imageNamed:imageName];
    
    return [UIScreen mainScreen].bounds.size.width * image.size.height / image.size.width;
    
}


@end
