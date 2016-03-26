//
//  DataHanlder.h
//
//  Created by 李宏远 on 15/10/28.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LhyMainTb_01Model;

@interface DataHanlder : NSObject

+ (DataHanlder *)sharedDataBaseCreate;

- (void)openDB;

- (void)createTable;

- (void)insertInfoWithModel:(LhyMainTb_01Model *)model;

- (void)deledateInfoWithTitle:(NSString *)title;

- (NSMutableArray *)selectInfoWithTitle:(NSString *)title;

- (NSMutableArray *)selectAllInfo;


@end
