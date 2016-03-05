
//
//  LhyCommunity_03_SelectedCollectionViewCell.m
//  Maximal
//
//  Created by 李宏远 on 15/11/13.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyCommunity_03_SelectedCollectionViewCell.h"
#import "LhySelected_01_TableViewCell.h"
#import "LhySelected_02_TableViewCell.h"
#import "LhySelected_03_TableViewCell.h"
#import "LhySelected_04_TableViewCell.h"
#import "LhyAutoAdaptHeight.h"
#import "LhyCommunity_SelectedModel.h"
#import "MJRefresh.h"
#import "LhyAFNetworkTool.h"
#import "LhyCommunity_SelectedModel.h"

#import "LhyCommunityViewController.h"
#import "LhySelected_WebViewController.h"
#import "MBProgressHUD.h"

#import "ConfigurationTheme.h"

@interface LhyCommunity_03_SelectedCollectionViewCell ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, retain)UITableView *tableView;
@property(nonatomic, retain)NSMutableArray *modelArr;

@property(nonatomic, assign)BOOL isDelete;

@property(nonatomic, copy)NSString *currentUrl;
@property(nonatomic, retain)MBProgressHUD *Loading;

@property(nonatomic, retain)UIColor *cellDefaultColor;
@property(nonatomic, retain)UIColor *fontColor;



@end

@implementation LhyCommunity_03_SelectedCollectionViewCell



- (void)dealloc {
    
    [_cellDefaultColor release];
    [_fontColor release];
    [_Loading release];
    [_currentUrl release];
    [_tableView release];
    [_modelArr release];
    [super dealloc];
    
}

#pragma mark - 数据处理
- (void)handelSelectedData {
    [self.Loading show:YES];
    if (self.isDelete == YES) {
        self.currentUrl = @"http://dis.myzaker.com/api/get_post_selected.php";
    }

    [LhyAFNetworkTool getUrl:self.currentUrl body:nil response:LhyJSON requestHeadFile:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSMutableDictionary *dic = [responseObject objectForKey:@"data"];
        NSMutableArray *arr = [dic objectForKey:@"posts"];
        
        /* 判断试下拉还是刷新 */
      
        if (self.isDelete == YES) {
            [self.modelArr removeAllObjects];
            self.currentUrl = @"http://dis.myzaker.com/api/get_post_selected.php";
            
        }
        
        NSMutableDictionary *dicurl = [dic objectForKey:@"info"];
        self.currentUrl = [dicurl objectForKey:@"next_url"];
        
        for (NSMutableDictionary *dic in arr) {
            
            LhyCommunity_SelectedModel *model = [[LhyCommunity_SelectedModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            
            if (![model.title containsString:@"ZAKER"] && ![model.auther_name containsString:@"ZAKER"] &&![model.content containsString:@"ZAKER"] && ![[model.auther objectForKey:@"name"] isEqualToString:@"话题小秘书"]) {
              
                [self.modelArr addObject:model];
            }
            [model release];
            
        }
        
        /* 完成刷新 */
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
  
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            [self.Loading hide:YES];
        });
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
    
    
}





#pragma mark - 重写初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    /* 注册消息 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleChangeTheme:) name:@"changeTheme" object:nil];
    
    /* 读取本地文件 */
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"Theme.tex"];
    NSString *readStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    /* 主体颜色 */
    if ([readStr isEqualToString:@"YES"]) {
        self.cellDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_NewColor"];
        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontNewColor"];
        
        
    } else {
        
        self.cellDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_DefaultColor"];
        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontDefaultColor"];
        
    }
    

    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.tableView = [[UITableView alloc] init];
        [self.contentView addSubview:self.tableView];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        //self.tableView.separatorColor = [UIColor redColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.backgroundColor = [UIColor colorWithWhite:0.944 alpha:1.000];

        /* 注册四种类型的cell */
        [self.tableView registerClass:[LhySelected_01_TableViewCell class] forCellReuseIdentifier:@"Selected_01_Cell"];
        [self.tableView registerClass:[LhySelected_02_TableViewCell class] forCellReuseIdentifier:@"Selected_02_Cell"];
        [self.tableView registerClass:[LhySelected_03_TableViewCell class] forCellReuseIdentifier:@"Selected_03_Cell"];
        [self.tableView registerClass:[LhySelected_04_TableViewCell class] forCellReuseIdentifier:@"Selected_04_Cell"];
        
    
    }
    
    // 数据处理前初始化数组
    self.modelArr = [NSMutableArray array];
    self.currentUrl = @"http://dis.myzaker.com/api/get_post_selected.php";

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /* 加载菊花 */
        self.Loading = [MBProgressHUD showHUDAddedTo:self.contentView animated:YES];
        self.Loading.dimBackground = YES;
        self.Loading.animationType = 0;
    });
    [self handelSelectedData];
 
    return self;
}


/* 改变主题消息 */
- (void)handleChangeTheme:(NSNotification *)noti {
    
    NSString *str = noti.object;
    if ([str isEqualToString:@"YES"]) {
        
        self.cellDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_NewColor"];
        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontNewColor"];
        
        
    } else {
        
        self.cellDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_DefaultColor"];
        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontDefaultColor"];
        
    }
    
    
}



#pragma mark - TableView协议方法

/* cell的个数 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.modelArr.count;
    
}

/* cell的高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LhyCommunity_SelectedModel *model = [self.modelArr objectAtIndex:indexPath.row];
    
    /* 自适应文字高度 */
    CGFloat contentHeight = [LhyAutoAdaptHeight heigntForCellWithContent:model.content width:[UIScreen mainScreen].bounds.size.width - 40 fontSize:14];
    if (contentHeight >= 52) {
        contentHeight = 52;
    }
    
    /* 自适应图片高度 */
//    NSMutableArray *picArr = model.medias;
//    NSMutableDictionary *picDic = [picArr firstObject];
//    UIImage *imagePic = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[picDic objectForKey:@"url"]]]];
//    //NSLog(@"%f", imagePic.size.width);
//    
//    CGFloat picHeight = [LhyAutoAdaptHeight heigntForCellWithImage:imagePic];
   // NSLog(@"%f", picHeight);
    
   // return 130 + contentHeight + picHeight;
    
    NSMutableDictionary *dicSpeciaInfo = model.special_info;
    NSString *type = [dicSpeciaInfo objectForKey:@"item_type"];
    
    if (type == nil) {
        return 130 + contentHeight;
    } else if ([type isEqualToString:@"1"]){

        return 130 + contentHeight + ([UIScreen mainScreen].bounds.size.height- 154) / 2;
 
    } else if ([type isEqualToString:@"2"]) {
        
        return 130 + contentHeight + [UIScreen mainScreen].bounds.size.height / 4;
    } else {
        
        return 130 + contentHeight + [UIScreen mainScreen].bounds.size.height / 5 - 15;
    }
   
}

/* 返回每一个cell */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LhyCommunity_SelectedModel *model = [self.modelArr objectAtIndex:indexPath.row];
    NSMutableDictionary *dicSpeciaInfo = model.special_info;
    NSString *type = [dicSpeciaInfo objectForKey:@"item_type"];
    
    if (type == nil) {
        
        LhySelected_01_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Selected_01_Cell"];
        cell.backgroundColor = [UIColor colorWithWhite:0.944 alpha:1.000];
        cell.model = [self.modelArr objectAtIndex:indexPath.item];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else if ([type isEqualToString:@"1"]){
        
        LhySelected_02_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Selected_02_Cell"];
        cell.backgroundColor = [UIColor colorWithWhite:0.944 alpha:1.000];
        cell.model = [self.modelArr objectAtIndex:indexPath.item];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else if ([type isEqualToString:@"2"]) {
        
        LhySelected_03_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Selected_03_Cell"];
        cell.backgroundColor = [UIColor colorWithWhite:0.944 alpha:1.000];
        cell.model = [self.modelArr objectAtIndex:indexPath.item];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        
        LhySelected_04_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Selected_04_Cell"];
        cell.backgroundColor = [UIColor colorWithWhite:0.944 alpha:1.000];
        cell.model = [self.modelArr objectAtIndex:indexPath.item];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}


#pragma mark - cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LhySelected_WebViewController *Selected_WebVC = [[LhySelected_WebViewController alloc] init];
    /* 传值 */
    Selected_WebVC.model = [self.modelArr objectAtIndex:indexPath.row];
    [[LhyCommunityViewController sharedMainVC].navigationController pushViewController:Selected_WebVC animated:YES];
    
    /* 隐藏两个bar */
    [[LhyCommunityViewController sharedMainVC].navigationController setNavigationBarHidden:YES animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTabbar" object:nil];
    
    [Selected_WebVC release];
    
}




/* 布局子视图即tableview */
- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 150);
    
    /* 下拉刷新 */
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        NSLog(@"正在刷新数据");
        self.isDelete = YES;
        [self handelSelectedData];
        [self.tableView reloadData];
        
    }];
    // 设置文字
    // [header setTitle:@"Pull down to refresh" forState:MJRefreshStateIdle];
    // [header setTitle:@"Release to refresh" forState:MJRefreshStatePulling];
    [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    
    // 设置字体
    //  header.stateLabel.font = [UIFont systemFontOfSize:15];
    //  header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    // 设置颜色
    //   header.stateLabel.textColor = [UIColor redColor];
    //  header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    self.tableView.mj_header = header;
    header.lastUpdatedTimeLabel.hidden = YES;
    
    
    /* 上拉加载 */
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"正在加载数据");
        //  self.isDelete = NO;
        [self handelSelectedData];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    self.tableView.mj_footer = footer;
    //  [footer setTitle:@"Click or drag up to refresh" forState:MJRefreshStateIdle];
    [footer setTitle:@"Loading more ..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"No more data" forState:MJRefreshStateNoMoreData];
    
}



@end
