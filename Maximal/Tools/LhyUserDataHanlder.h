//
//  LhyUserDataHanlder.h
//  Maximal
//
//  Created by 李宏远 on 15/11/24.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LhyUserInfoModel;

@interface LhyUserDataHanlder : NSObject



+ (LhyUserDataHanlder *)sharedDataBaseCreate;

- (void)openDB;

- (void)createTable;

- (void)insertInfoWithModel:(LhyUserInfoModel *)model;

- (void)deledateInfoWithTitle:(NSString *)title;

- (NSMutableArray *)selectInfoWithTitle:(NSString *)title;

- (NSMutableArray *)selectAllInfo;




@end
