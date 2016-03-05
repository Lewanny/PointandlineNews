

//
//  LhyUserDataHanlder.m
//  Maximal
//
//  Created by 李宏远 on 15/11/24.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyUserDataHanlder.h"
#import <sqlite3.h>
#import "LhyUserInfoModel.h"

@implementation LhyUserDataHanlder

/* 定义一个sqlite3实例 */
static sqlite3 *UserDB;

/* 创建单例对象 */
+ (LhyUserDataHanlder *)sharedDataBaseCreate {
    static LhyUserDataHanlder *dataHander = nil;
    if (dataHander == nil) {
        
        dataHander = [[LhyUserDataHanlder alloc] init];
    }
    return dataHander;
}

/* 打开数据库 */
- (void)openDB {
    
    /* 输出沙盒文件路径 */
    NSLog(@"%@", NSHomeDirectory());
    /* 如果数据库打开, 直接返回, 不执行下面代码 */
    if (UserDB != nil) {
        NSLog(@"数据库已经打开!!");
        return;
    }
    
    NSString *dbFile = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"UserInfo.db"];
    int result = sqlite3_open(dbFile.UTF8String, &UserDB);
    if (result == SQLITE_OK) {
        NSLog(@"打开数据库成功");
    } else {
        
        NSLog(@"打开数据库失败");
        NSLog(@"error:%d", result);
    }
    
}

/* 创建表格 */
- (void)createTable {
    
    NSString *createSQL = @"CREATE TABLE IF NOT EXISTS UserInfo(keyid INTEGER PRIMARY KEY AUTOINCREMENT, userId TEXT, password TEXT)";
    
    int result = sqlite3_exec(UserDB, createSQL.UTF8String, NULL, NULL, nil);
    
    if (result == SQLITE_OK) {
        NSLog(@"创建表格成功");
    } else {
        
        NSLog(@"创建表格失败");
        NSLog(@"error:%d", result);
    }
    
}

/* 表格中插入model信息 */
- (void)insertInfoWithModel:(LhyUserInfoModel *)model
{
    
    NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO UserInfo(userId, password) VALUES ('%@', '%@')", model.userId, model.password];
    
    int result = sqlite3_exec(UserDB, insertSQL.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
        NSLog(@"添加用户信息成功");
    } else {
        
        NSLog(@"添加用户信息失败");
        NSLog(@"error:%d", result);
    }
    
}

/* 表格中删除数据 */
- (void)deledateInfoWithTitle:(NSString *)userId {
    
    NSString *deledate = [NSString stringWithFormat:@"DELETE FROM UserInfo WHERE userId = '%@'", userId];
    int result = sqlite3_exec(UserDB, deledate.UTF8String, NULL, NULL, nil);
    
    if (result == SQLITE_OK) {
        NSLog(@"删除用户信息成功");
    } else {
        
        NSLog(@"删除用户信息失败");
        NSLog(@"error:%d", result);
    }
}

/* 通过title查找表格中的数据 */
- (NSMutableArray *)selectInfoWithTitle:(NSString *)userId {
    
    NSMutableArray *arrayResult = [NSMutableArray array];
    
    NSString *selectSQL = [NSString stringWithFormat:@"SELECT * FROM UserInfo WHERE userId = '%@'", userId];
    
    sqlite3_stmt *stmt = nil;
    
    int result = sqlite3_prepare_v2(UserDB, selectSQL.UTF8String, -1, &stmt, nil);
    
    if (result == SQLITE_OK) {
        NSLog(@"查询中....");
        
//    //   sqlite3_step(stmt);
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            NSLog(@"----- 有这个 -----");
            
            
            /* 进行取值 */
            const unsigned char *userId = sqlite3_column_text(stmt, 1);
            const unsigned char *password = sqlite3_column_text(stmt, 2);
            
            
            /* model赋值 */
            LhyUserInfoModel *model = [[LhyUserInfoModel alloc] init];
            model.userId = [NSString stringWithUTF8String:(const char *)userId];
            model.password = [NSString stringWithUTF8String:(const char *)password];
            
            [arrayResult addObject:model];
            
            NSLog(@"查询用户信息成功");
         
        }
        
    } else {
        
        NSLog(@"无法查询");
        NSLog(@"error:%d", result);
        sqlite3_finalize(stmt);
    }
    
    return arrayResult;
    
}


/* 查找表格中的所有数据 */
- (NSMutableArray *)selectAllInfo {
    
    NSMutableArray *arrayResult = [NSMutableArray array];
    NSString *selectSQL = [NSString stringWithFormat:@"SELECT * FROM UserInfo"];
    
    sqlite3_stmt *stmt = nil;
    
    int result = sqlite3_prepare_v2(UserDB, selectSQL.UTF8String, -1, &stmt, nil);
    
    if (result == SQLITE_OK) {
        NSLog(@"查询中....");
        
        //sqlite3_step(stmt);
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            
            /* 进行取值 */
            const unsigned char *userId = sqlite3_column_text(stmt, 1);
            const unsigned char *password = sqlite3_column_text(stmt, 2);
        
            
            /* model赋值 */
            LhyUserInfoModel *model = [[LhyUserInfoModel alloc] init];
            model.userId = [NSString stringWithUTF8String:(const char *)userId];
            model.password = [NSString stringWithUTF8String:(const char *)password];

            
            [arrayResult addObject:model];
            
            NSLog(@"查询成功");
            
        }
        
        
    } else {
        
        NSLog(@"无法查询");
        NSLog(@"error:%d", result);
        sqlite3_finalize(stmt);
    }
    
    
    return arrayResult;
    
}



@end
