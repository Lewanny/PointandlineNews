//
//  LhyAutoAdaptHeight.h
//  Maximal
//
//  Created by 李宏远 on 15/11/14.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LhyAutoAdaptHeight : NSObject

+ (CGFloat)heigntForCellWithContent:(NSString *)content width:(NSInteger)width fontSize:(NSInteger)fontSize;

+ (CGFloat)heigntForCellWithImage:(UIImage *)image;

@end
