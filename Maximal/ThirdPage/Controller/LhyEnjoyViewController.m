//
//  LhyEnjoyViewController.m
//  Maximal
//
//  Created by 李宏远 on 15/11/7.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyEnjoyViewController.h"
#import "LhyInfoViewController.h"
#import "LhyEnjoy_01TableViewCell.h"
#import "LhyEnjoy_02TableViewCell.h"
#import "LhyEnjoy_03TableViewCell.h"
#import "LhyAFNetworkTool.h"
#import "LhyEnjoy_SSSMoreViewController.h"

#import "LhyEnjoy_MainModel.h"
#import "LhyEnjoy_Main_ItemsModel.h"

#import "MJRefresh.h"

#import "LhyEnjoy_WebViewController.h"

#import "LhyEnjoy_MoreViewController.h"

#import "ConfigurationTheme.h"
#import "MBProgressHUD.h"

@interface LhyEnjoyViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, retain)UITableView *tableView;
@property(nonatomic, retain)NSMutableArray *modelArray;
@property(nonatomic, retain)NSMutableArray *itemArr;

@property(nonatomic, retain)UIColor *tbDefaultColor;
@property(nonatomic, retain)UIColor *cellDefaultColor;
@property(nonatomic, retain)UIColor *fontColor;

/* 通过属性来判断, 是下拉刷新, 还是上拉加载 */
@property(nonatomic, assign)BOOL isDeleteData;
@property(nonatomic, retain)MBProgressHUD *Loading;

@end

@implementation LhyEnjoyViewController

- (void)dealloc {
    
    [_Loading release];
    [_fontColor release];
    [_tbDefaultColor release];
    [_cellDefaultColor release];
    
    [_tableView release];
    [_modelArray release];
    [_itemArr release];
    [super dealloc];
}

/* 单例创建VC */
+ (instancetype)sharedEnjoyVC {
    
    static LhyEnjoyViewController *enjoyVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        enjoyVC = [[LhyEnjoyViewController alloc] init];
    });
    return enjoyVC;
}


#pragma mark - 数据处理

- (void)handleData {
    
    [self.Loading show:YES];
    [LhyAFNetworkTool getUrl:@"http://wl.myzaker.com/?c=columns" body:nil response:LhyJSON requestHeadFile:nil success:^(NSURLSessionDataTask *task, id responseObject) {
       
        NSMutableDictionary *dic = [responseObject objectForKey:@"data"];
        NSMutableArray *arr = [dic objectForKey:@"columns"];
        for (NSMutableDictionary *dic in arr) {
            
            LhyEnjoy_MainModel *model = [[LhyEnjoy_MainModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            
            
            NSMutableArray *arrItems = [dic objectForKey:@"items"];
            model.itemsArr = [NSMutableArray array];
            for (NSMutableDictionary *dic in arrItems) {
            
                LhyEnjoy_Main_ItemsModel *modelItems = [[LhyEnjoy_Main_ItemsModel alloc] init];
                [modelItems setValuesForKeysWithDictionary:dic];
                [model.itemsArr addObject:modelItems];
                [modelItems release];

            }
            
            [self.modelArray addObject:model];
            
            [model release];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self.tableView reloadData];
            [self.Loading hide:YES];
           
        });
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
    
    
}

/* 创建tableView */
- (void)createTableView  {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = self.tbDefaultColor;
    
    /* 注册三种cell */
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuse"];
    [self.tableView registerClass:[LhyEnjoy_01TableViewCell class] forCellReuseIdentifier:@"Enjoy_01Cell"];
    [self.tableView registerClass:[LhyEnjoy_02TableViewCell class] forCellReuseIdentifier:@"Enjoy_02Cell"];
    [self.tableView registerClass:[LhyEnjoy_03TableViewCell class] forCellReuseIdentifier:@"Enjoy_03Cell"];
    
    [self.tableView release];
    
}

#pragma mark - 页面将要出现
- (void)viewWillAppear:(BOOL)animated {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /* 加载菊花 */
        self.Loading = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.Loading.dimBackground = YES;
        self.Loading.animationType = 2;
    });
    [self.tableView reloadData];
}

/* 改变主题消息 */
- (void)handleChangeTheme:(NSNotification *)noti {
    
    NSString *str = noti.object;
    if ([str isEqualToString:@"YES"]) {
        self.tableView.backgroundColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"bgCellNewColor"];
        self.cellDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_NewColor"];
        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontNewColor"];
    } else {
        
        self.tableView.backgroundColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"bgCellDefaultColor"];
        self.cellDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_DefaultColor"];
        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontDefaultColor"];
    }
    
    
}


#pragma mark - 界面加载
- (void)viewDidLoad {
    [super viewDidLoad];
/* 需要刷新, 数组初始化必须要数据处理外部 */
    self.modelArray = [NSMutableArray array];
    /* 注册消息 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleChangeTheme:) name:@"changeTheme" object:nil];
    [self handleData];
    
    /* 读取本地文件 */
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"Theme.tex"];
    NSString *readStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    /* 主体颜色 */
    if ([readStr isEqualToString:@"YES"]) {
        self.tbDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"bgCellNewColor"];
        self.cellDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_NewColor"];
        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontNewColor"];
        
    } else {
        
        self.tbDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"bgCellDefaultColor"];
        self.cellDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_DefaultColor"];
        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontDefaultColor"];
    }
    
    
    
    
    [self createTableView];

    self.navigationItem.title = @"玩乐";
    /* 导航栏左侧info按钮 */
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"SocialTabBarItemProfile"] style:UIBarButtonItemStylePlain target:self action:@selector(handleInfoButton:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];


}


/* 点击info按钮的方法 */
- (void)handleInfoButton:(UITabBarItem *)barItem {
    
    LhyInfoViewController *infoVC = [[LhyInfoViewController alloc] init];
    [self.navigationController pushViewController:infoVC animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"hideTabbar" object:nil];
    [infoVC release];
    
}


#pragma mark - TableViewDataSource协议方法
/* 根据modelArr的count数, 返回分区数 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.modelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return self.view.frame.size.height / 8 - 10;
    } else {
        
        LhyEnjoy_MainModel *model = [self.modelArray objectAtIndex:indexPath.section];
        if ([model.style isEqualToString:@"all_pic"]) {
            return self.view.frame.size.height / 4 + 30;
        } else {
            return self.view.frame.size.height / 2 - 50;
        }
    }
    
  
}

/* 分会每个分区的cell个数 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    LhyEnjoy_MainModel *model = [self.modelArray objectAtIndex:section];
    return model.itemsArr.count + 1;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LhyEnjoy_MainModel *model = [self.modelArray objectAtIndex:indexPath.section];
    if (indexPath.row == 0) {
        LhyEnjoy_01TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Enjoy_01Cell"];
        tableView.separatorColor = [UIColor whiteColor];
        cell.model = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = self.cellDefaultColor;
        return cell;
    } else {
        
        if ([model.style isEqualToString:@"all_pic"]) {
            LhyEnjoy_02TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Enjoy_02Cell"];
            LhyEnjoy_Main_ItemsModel *modelItems = [model.itemsArr objectAtIndex:indexPath.row - 1];
            cell.model = modelItems;
            tableView.separatorColor = [UIColor whiteColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = self.cellDefaultColor;
            return cell;
            
        } else {
            
            LhyEnjoy_03TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Enjoy_03Cell"];
            LhyEnjoy_Main_ItemsModel *modelItems = [model.itemsArr objectAtIndex:indexPath.row - 1];
            cell.model = modelItems;
            tableView.separatorColor = [UIColor colorWithWhite:0.700 alpha:1.000];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = self.cellDefaultColor;
            cell.labelTitle.textColor = self.fontColor;
            cell.labelIntro.textColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontNewColor"];
            return cell;
            
        }
        
    }

}


/* cell的点击方法, 跳转界面 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    LhyEnjoy_MainModel *model = [self.modelArray objectAtIndex:indexPath.section];
    LhyEnjoy_WebViewController *enjoy_webVC = [[LhyEnjoy_WebViewController alloc] init];
   
    if ([model.show_more isEqualToString:@"N"]) {
        if (indexPath.row == 0) {
            return;
        } else {
            LhyEnjoy_Main_ItemsModel *itemModel = [model.itemsArr objectAtIndex:indexPath.row - 1];
            NSMutableDictionary *urlDic = itemModel.web;
            enjoy_webVC.webUrl = [urlDic objectForKey:@"url"];
            enjoy_webVC.titleOfArtical = itemModel.title;
            NSLog(@"%@", itemModel.title);
            
            [self.navigationController pushViewController:enjoy_webVC animated:YES];
            
            /* 隐藏两个bar */
            [self.navigationController setNavigationBarHidden:YES animated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTabbar" object:nil];
         //   NSLog(@"bbb");
        }
    } else {
        if (indexPath.row == 0) {
            
            if ([model.style isEqualToString:@"s_follow_pic"]) {
                
                LhyEnjoy_SSSMoreViewController *SSS_enjoy_moreVc = [[LhyEnjoy_SSSMoreViewController alloc] init];
                [self.navigationController pushViewController:SSS_enjoy_moreVc animated:YES];
                NSMutableDictionary *nextUrlDic = model.more_info;
                
                /* 传值 */
                SSS_enjoy_moreVc.urlStr = [nextUrlDic objectForKey:@"api_url"];
                SSS_enjoy_moreVc.titleOfHeadView = model.title;
                
                /* 隐藏两个bar */
                [self.navigationController setNavigationBarHidden:YES animated:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTabbar" object:nil];
                
                [SSS_enjoy_moreVc release];
            }   else {
                
                LhyEnjoy_MoreViewController *enjoy_moreVC = [[LhyEnjoy_MoreViewController alloc] init];
                NSMutableDictionary *nextUrlDic = model.more_info;
                enjoy_moreVC.strUrl = [nextUrlDic objectForKey:@"api_url"];
                
                NSLog(@"%@", [nextUrlDic objectForKey:@"api_url"]);
                
                /* 传值 */
                enjoy_moreVC.titleOfHeadView = model.title;
                [self.navigationController pushViewController:enjoy_moreVC animated:YES];
                
                [self.navigationController setNavigationBarHidden:YES animated:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTabbar" object:nil];
            }
            
        } else {
            if ([model.style isEqualToString:@"s_follow_pic"]) {
                ;
                LhyEnjoy_Main_ItemsModel *itemModel = [model.itemsArr objectAtIndex:indexPath.row - 1];
                NSMutableDictionary *urlDic = itemModel.weekend;
                enjoy_webVC.webUrl = [urlDic objectForKey:@"content_url"];
                enjoy_webVC.titleOfArtical = itemModel.title;
                [self.navigationController pushViewController:enjoy_webVC animated:YES];
                
                /* 隐藏两个bar */
                [self.navigationController setNavigationBarHidden:YES animated:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTabbar" object:nil];
            
            } else if([model.style isEqualToString:@"all_pic"]) {
                
                LhyEnjoy_Main_ItemsModel *itemModel = [model.itemsArr objectAtIndex:indexPath.row - 1];
                NSMutableDictionary *urlDic = itemModel.web;
                enjoy_webVC.webUrl = [urlDic objectForKey:@"url"];
                enjoy_webVC.titleOfArtical = itemModel.title;
                
                NSLog(@"%@", itemModel.title);
                [self.navigationController pushViewController:enjoy_webVC animated:YES];
                
                /* 隐藏两个bar */
                [self.navigationController setNavigationBarHidden:YES animated:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTabbar" object:nil];
                
                
                
            } else {
                LhyEnjoy_Main_ItemsModel *itemModel = [model.itemsArr objectAtIndex:indexPath.row - 1];
                NSMutableDictionary *urlDic = itemModel.article;
                enjoy_webVC.webUrl = [urlDic objectForKey:@"weburl"];
                enjoy_webVC.titleOfArtical = itemModel.title;
                [self.navigationController pushViewController:enjoy_webVC animated:YES];
                
                /* 隐藏两个bar */
                [self.navigationController setNavigationBarHidden:YES animated:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTabbar" object:nil];
                
            }
            
        }
        
    }
    
    [enjoy_webVC release];
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 10;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
