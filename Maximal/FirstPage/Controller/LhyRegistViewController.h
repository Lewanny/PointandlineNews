//
//  LhyRegistViewController.h
//  Maximal
//
//  Created by 李宏远 on 15/11/24.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyBaseViewController.h"

/* 定义协议, 声明协议方法 */
@protocol RegistViewController <NSObject>

-(void)getTrueUserName:(NSString *)name PassWord:(NSString *)passWord;

@end

@interface LhyRegistViewController : LhyBaseViewController

/* 协议属性 */
@property(nonatomic, retain)id<RegistViewController>delegate;

@end
