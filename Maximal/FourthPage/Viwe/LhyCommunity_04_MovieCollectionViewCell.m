



//
//  LhyCommunity_04_MovieCollectionViewCell.m
//  Maximal
//
//  Created by 李宏远 on 15/11/18.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyCommunity_04_MovieCollectionViewCell.h"
#import "LhyTMovie_01_ableViewCell.h"
#import "LhyTMovie_02_ableViewCell.h"
#import "LhyAFNetworkTool.h"
#import "Lhy_Community_Video_ListModel.h"
#import "Lhy_Community_Video_SidLstModel.h"

#import "MJRefresh.h"

#import "MBProgressHUD.h"

@interface LhyCommunity_04_MovieCollectionViewCell ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, retain)UITableView *tableView;
@property(nonatomic, retain)NSMutableArray *videoListArr;
@property(nonatomic, retain)NSMutableArray *videoSidListArr;

@property(nonatomic, assign)BOOL isDelete;
@property(nonatomic, assign)NSInteger beginIndex;
@property(nonatomic, assign)NSInteger endIndex;
@property(nonatomic, retain)MBProgressHUD *Loading;

@property(nonatomic, retain)UIView *bgView;

@end

@implementation LhyCommunity_04_MovieCollectionViewCell

- (void)dealloc {
    
    [_bgView release];
    [_Loading release];
    [_tableView release];
    [_videoListArr release];
    [_videoSidListArr release];
    [super dealloc];
    
}



#pragma mark - 数据处理
- (void)handleData {
    
    
    [self.Loading show:YES];
    if (self.isDelete == YES) {
        [self.videoListArr removeAllObjects];
        [self.videoSidListArr removeAllObjects];
        self.beginIndex = 0;
        self.endIndex = 10;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%ld%@%ld%@", @"http://c.3g.163.com/nc/video/home/", self.beginIndex, @"-", self.endIndex, @".html"];
    
    
    [LhyAFNetworkTool getUrl:url body:nil response:LhyJSON requestHeadFile:nil success:^(NSURLSessionDataTask *task, id responseObject) {
       
        NSMutableArray *arrSidList = [responseObject objectForKey:@"videoSidList"];
        for (NSMutableDictionary *dic in arrSidList) {
            
            Lhy_Community_Video_SidLstModel *sidModel = [[Lhy_Community_Video_SidLstModel alloc] init];
            [sidModel setValuesForKeysWithDictionary:dic];
            [self.videoSidListArr addObject:sidModel];
         //   NSLog(@"%@", sidModel.title);
            [sidModel release];
            
        }
        
        
        NSMutableArray *arrList = [responseObject objectForKey:@"videoList"];
        for (NSMutableDictionary *dic in arrList) {
            Lhy_Community_Video_ListModel *model = [[Lhy_Community_Video_ListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.videoListArr addObject:model];
            [model release];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self.tableView reloadData];
            [self.Loading hide:YES];
            
        });
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
       
    }];
    
}


/* bgView的创建 */
- (void)createBgview {
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
  //  self.bgView.frame = self.contentView.bounds;
    self.bgView.backgroundColor = [UIColor greenColor];
    [self addSubview:self.bgView];
    [self.bgView release];
    
}

#pragma makr - 重写初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    
    /* 初始化Model数组 */
    self.videoListArr = [NSMutableArray array];
    self.videoSidListArr = [NSMutableArray array];
    self.beginIndex = 0;
    self.endIndex = 10;
    
   
   // [self createBgview];
   
  
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height - 80) style:UITableViewStyleGrouped];
        [self.contentView addSubview:self.tableView];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        [self.tableView registerClass:[LhyTMovie_01_ableViewCell class] forCellReuseIdentifier:@"Movie_01_Cell"];
        [self.tableView registerClass:[LhyTMovie_02_ableViewCell class] forCellReuseIdentifier:@"Movie_02_Cell"];
        self.tableView.backgroundColor = [UIColor colorWithWhite:0.941 alpha:1.000];
        [self.tableView release];
        
        
    }
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        /* 加载菊花 */
        self.Loading = [MBProgressHUD showHUDAddedTo:self.contentView animated:YES];
        self.Loading.dimBackground = YES;
        self.Loading.animationType = 0;
    });
    
    
    [self handleData];
    
    /* 下拉刷新 */
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
       // NSLog(@"正在刷新数据");
        self.isDelete = YES;
        [self handleData];
        [self.tableView.mj_header endRefreshing];
        
    }];
    [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    self.tableView.mj_header = header;
    
    /* 上拉加载 */
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       // NSLog(@"正在加载数据");
        self.isDelete = NO;
        self.beginIndex += 10;
        
        [self handleData];
        
        [self.tableView.mj_footer endRefreshing];
    //    [self.tableView reloadData];
        
    }];
    
    self.tableView.mj_footer = footer;
    footer.refreshingTitleHidden = YES;
    footer.stateLabel.textColor = [UIColor colorWithWhite:0.941 alpha:1.000];
    
    [footer setTitle:@"Loading more ..." forState:MJRefreshStateRefreshing];
   // [footer setTitle:@"No more data" forState:MJRefreshStateNoMoreData];
    
  
    return self;
 
}

#pragma mark - 协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}
/*  返回分区数量 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.videoListArr.count + 1;
}

/* 返回高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return (self.frame.size.width - 3) / 4;
    }
    return 300;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

/* 返回每个cell */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        LhyTMovie_01_ableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Movie_01_Cell"];
        cell.backgroundColor = [UIColor colorWithWhite:0.877 alpha:1.000];
        
        cell.modelArr = self.videoSidListArr;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
       // cell.backgroundColor = [UIColor colorWithWhite:0.941 alpha:1.000];
        return cell;
      
        
    } else {
        
        LhyTMovie_02_ableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Movie_02_Cell"];
        cell.model = [self.videoListArr objectAtIndex:indexPath.section - 1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithWhite:0.941 alpha:1.000];
        return cell;
    }  
}




@end
