

//
//  LhyCommunity_02_DiscoveryCollectionViewCell.m
//  Maximal
//
//  Created by 李宏远 on 15/11/13.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyCommunity_02_DiscoveryCollectionViewCell.h"
#import "LhyDiscovery_01_TableViewCell.h"
#import "LhyAFNetworkTool.h"
#import "LhyDiscovery_01_TableViewCell.h"
#import "LhyCommunity_DiscoveryModel.h"

#import "LhyDiscovery_Detail_ViewController.h"
#import "LhyCommunityViewController.h"

#import "ConfigurationTheme.h"

@interface LhyCommunity_02_DiscoveryCollectionViewCell ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, retain)UITableView *tableView;
@property(nonatomic, retain)UIColor *tbDefaultColor;
@property(nonatomic, retain)UIColor *cellDefaultColor;
@property(nonatomic, retain)UIColor *fontColor;
@property(nonatomic, retain)UIColor *viewBarColor;



@end

@implementation LhyCommunity_02_DiscoveryCollectionViewCell


- (void)dealloc {
    
    [_tbDefaultColor release];
    [_cellDefaultColor release];
    [_fontColor release];
    [_viewBarColor release];
    
    [_modelArr release];
    [_tableView release];
    [_modelArr release];
    [super dealloc];
    
}






#pragma mark - 重写初始化方法
/* 创建item上的tableView */
- (instancetype)initWithFrame:(CGRect)frame {
    
    /* 注册消息 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleChangeTheme:) name:@"changeTheme" object:nil];

    /* 读取本地文件 */
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"Theme.tex"];
    NSString *readStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    /* 主体颜色 */
    if ([readStr isEqualToString:@"YES"]) {
        self.tbDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"bgCellNewColor"];
        self.cellDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_NewColor"];
        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontNewColor"];
        self.viewBarColor = [UIColor colorWithRed:244 green:244 blue:244 alpha:1];
        
    } else {
        
        self.tbDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"bgCellDefaultColor"];
        self.cellDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_DefaultColor"];
        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontDefaultColor"];
        self.viewBarColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"DefaultBarColor"];
    }

    
    self = [super initWithFrame:frame];
    if (self) {
        
     //   [self handleData];
      
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height  - 150) style:UITableViewStylePlain];
        [self.contentView addSubview:self.tableView];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView registerClass:[LhyDiscovery_01_TableViewCell class] forCellReuseIdentifier:@"Discovery_01_Cell"];
        self.tableView.backgroundColor = self.tbDefaultColor;
        if (self.modelArr.count == 0) {
            self.tableView.separatorStyle = 0;
        }

        [self.tableView release];
    }
    
    return self;
}

/* 改变主题消息 */
- (void)handleChangeTheme:(NSNotification *)noti {
    
    NSString *str = noti.object;
    if ([str isEqualToString:@"YES"]) {
        
        self.tableView.backgroundColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"bgCellNewColor"];
        
        self.cellDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_NewColor"];
        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontNewColor"];
        self.viewBarColor = [UIColor colorWithRed:244 green:244 blue:244 alpha:1];
        
        
      
        
    } else {
        
        self.tableView.backgroundColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"bgCellDefaultColor"];
        
        self.cellDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_DefaultColor"];
        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontDefaultColor"];
        self.viewBarColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"DefaultBarColor"];
        
      
        
    }
    

}


/* 重写setter方法 */
- (void)setModelArr:(NSMutableArray *)modelArr {
    
    if (_modelArr != modelArr) {
        [_modelArr release];
        _modelArr = [modelArr retain];
    }
    
    [self.tableView reloadData];
    if (self.modelArr.count == 0) {
        self.tableView.separatorStyle = 0;
    } else {
        self.tableView.separatorStyle= 1;
    }
}



#pragma mark - tableView的协议方法
/* cell个数 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.modelArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.frame.size.height / 10 +3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    LhyDiscovery_01_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Discovery_01_Cell"];
    cell.model = [self.modelArr objectAtIndex:indexPath.row];
    cell.backgroundColor = self.cellDefaultColor;
    cell.labelTitel.textColor = self.fontColor;
    return cell;
}


/* 点击cell的方法 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    LhyDiscovery_Detail_ViewController *Discovery_DetailVC = [[LhyDiscovery_Detail_ViewController alloc] init];
    /* 传值 */
    LhyCommunity_DiscoveryModel *model = [self.modelArr objectAtIndex:indexPath.row];
    Discovery_DetailVC.urlStr = model.api_url;
    Discovery_DetailVC.titleOfHeadView = model.title;
    [[LhyCommunityViewController sharedMainVC].navigationController pushViewController:Discovery_DetailVC animated:YES];
    
    /* 隐藏两个bar */
    [[LhyCommunityViewController sharedMainVC].navigationController setNavigationBarHidden:YES animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTabbar" object:nil];
    
    
    [Discovery_DetailVC release];
    
}




@end
