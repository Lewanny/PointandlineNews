//
//  DataHanlder.m
//
//  Created by 李宏远 on 15/10/28.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "DataHanlder.h"
#import <sqlite3.h>
#import "LhyMainTb_01Model.h"

@implementation DataHanlder

/* 定义一个sqlite3实例 */
static sqlite3 *db;

/* 创建单例对象 */
+ (DataHanlder *)sharedDataBaseCreate {
    static DataHanlder *dataHander = nil;
    if (dataHander == nil) {
        
        dataHander = [[DataHanlder alloc] init];
    }
    return dataHander;
}

/* 打开数据库 */
- (void)openDB {
    
    /* 输出沙盒文件路径 */
    NSLog(@"%@", NSHomeDirectory());
    /* 如果数据库打开, 直接返回, 不执行下面代码 */
    if (db != nil) {
        NSLog(@"数据库已经打开!!");
        return;
    }
    
    NSString *dbFile = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"MyCollection.db"];
    int result = sqlite3_open(dbFile.UTF8String, &db);
    if (result == SQLITE_OK) {
        NSLog(@"打开数据库成功");
    } else {
        
        NSLog(@"打开数据库失败");
        NSLog(@"error:%d", result);
    }

}

/* 创建表格 */
- (void)createTable {
    
    NSString *createSQL = @"CREATE TABLE IF NOT EXISTS MyCollectionInfo(keyid INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, author TEXT, webUrl TEXT)";
    
    int result = sqlite3_exec(db, createSQL.UTF8String, NULL, NULL, nil);
    
    if (result == SQLITE_OK) {
        NSLog(@"创建表格成功");
    } else {
        
        NSLog(@"创建表格失败");
        NSLog(@"error:%d", result);
    }
    
}

/* 表格中插入model信息 */
- (void)insertInfoWithModel:(LhyMainTb_01Model *)model
{
    
    NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO MyCollectionInfo(title, author, webUrl) VALUES ('%@', '%@', '%@')", model.title, model.auther_name, model.weburl];
    
    int result = sqlite3_exec(db, insertSQL.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
        NSLog(@"收藏成功");
    } else {
        
        NSLog(@"收藏失败");
        NSLog(@"error:%d", result);
    }
    
}

/* 表格中删除数据 */
- (void)deledateInfoWithTitle:(NSString *)title {
    
    NSString *deledate = [NSString stringWithFormat:@"DELETE FROM MyCollectionInfo WHERE title = '%@'", title];
    int result = sqlite3_exec(db, deledate.UTF8String, NULL, NULL, nil);
    
    if (result == SQLITE_OK) {
        NSLog(@"删除收藏成功");
    } else {
        
        NSLog(@"删除收藏失败");
        NSLog(@"error:%d", result);
    }
}

/* 通过title查找表格中的数据 */
- (NSMutableArray *)selectInfoWithTitle:(NSString *)title {
    
    NSMutableArray *arrayResult = [NSMutableArray array];
    
    NSString *selectSQL = [NSString stringWithFormat:@"SELECT * FROM MyCollectionInfo WHERE title = '%@'", title];
    
    sqlite3_stmt *stmt = nil;
    
    int result = sqlite3_prepare_v2(db, selectSQL.UTF8String, -1, &stmt, nil);
    
    if (result == SQLITE_OK) {
        NSLog(@"查询中....");
        
     //   sqlite3_step(stmt);
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            NSLog(@"----- 有这个 -----");

            
            /* 进行取值 */
            const unsigned char *title = sqlite3_column_text(stmt, 1);
            const unsigned char *author = sqlite3_column_text(stmt, 2);
            const unsigned char *webUrl = sqlite3_column_text(stmt, 3);
            
            
            /* model赋值 */
            LhyMainTb_01Model *model = [[LhyMainTb_01Model alloc] init];
            model.title = [NSString stringWithUTF8String:(const char *)title];
            model.auther_name = [NSString stringWithUTF8String:(const char *)author];
            model.weburl = [NSString stringWithUTF8String:(const char *)webUrl];
            [arrayResult addObject:model];
            
            NSLog(@"查询成功");
//            if (arrayResult == nil) {
//                NSLog(@"查找不到数据");
//            } else {
//                
//                NSLog(@"查询成功");
//
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
    NSString *selectSQL = [NSString stringWithFormat:@"SELECT * FROM MyCollectionInfo"];
    
    sqlite3_stmt *stmt = nil;
    
    int result = sqlite3_prepare_v2(db, selectSQL.UTF8String, -1, &stmt, nil);
    
    if (result == SQLITE_OK) {
        NSLog(@"查询中....");
        
        //sqlite3_step(stmt);
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            
            /* 进行取值 */
            const unsigned char *title = sqlite3_column_text(stmt, 1);
            const unsigned char *author = sqlite3_column_text(stmt, 2);
            const unsigned char *webUrl = sqlite3_column_text(stmt, 3);
            
            /* model赋值 */
            LhyMainTb_01Model *model = [[LhyMainTb_01Model alloc] init];
            model.title = [NSString stringWithUTF8String:(const char *)title];
            model.auther_name = [NSString stringWithUTF8String:(const char *)author];
            model.weburl = [NSString stringWithUTF8String:(const char *)webUrl];
            
            [arrayResult addObject:model];
            
            NSLog(@"查询成功");
            //            if (arrayResult == nil) {
            //                NSLog(@"查找不到数据");
            //            } else {
            //
            //                NSLog(@"查询成功");
            //
        }
        
        
    } else {
        
        NSLog(@"无法查询");
        NSLog(@"error:%d", result);
        sqlite3_finalize(stmt);
    }
    
    
    return arrayResult;
    
}



@end
