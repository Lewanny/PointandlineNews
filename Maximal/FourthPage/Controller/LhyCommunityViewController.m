//
//  LhyCommunityViewController.m
//  Maximal
//
//  Created by 李宏远 on 15/11/7.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyCommunityViewController.h"
#import "LhyInfoViewController.h"
#import "LhyComunity_01_TopCollectionViewCell.h"
#import "LhyCommunity_02_DiscoveryCollectionViewCell.h"
#import "LhyCommunity_03_SelectedCollectionViewCell.h"
#import "LhyCommunity_04_MovieCollectionViewCell.h"

#import "LhyAFNetworkTool.h"
#import "LhyCommunity_DiscoveryModel.h"
#import "LhyCommunity_SelectedModel.h"

#import "MJRefresh.h"
#import "ConfigurationTheme.h"
#import "MBProgressHUD.h"


@interface LhyCommunityViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, retain)UICollectionView *collectionViewContent;
@property(nonatomic, retain)UIView *viewBar;
@property(nonatomic, retain)UIView *bigViewBar;

@property(nonatomic, retain)NSMutableArray *discoveryModelArr;

@property(nonatomic, retain)UIColor *tbDefaultColor;
@property(nonatomic, retain)UIColor *cellDefaultColor;
@property(nonatomic, retain)UIColor *fontColor;
@property(nonatomic, retain)UIColor *viewBarColor;

@property(nonatomic, retain)UIButton *buttonTop1;
@property(nonatomic, retain)UIButton *buttonTop2;
@property(nonatomic, retain)UIButton *buttonTop3;

@property(nonatomic, retain)MBProgressHUD *Loading;

@end

@implementation LhyCommunityViewController

- (void)dealloc {
    
    [_Loading release];
    [_discoveryModelArr release];
  
    [_tbDefaultColor release];
    [_cellDefaultColor release];
    [_fontColor release];
    [_viewBarColor release];
    
    [_bigViewBar release];
    [_collectionViewContent release];
    [_viewBar release];
    [super dealloc];
    
}

/* 单例创建VC */
+ (instancetype)sharedMainVC {
    
    static LhyCommunityViewController *communityVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        communityVC = [[LhyCommunityViewController alloc] init];    });
    
    return communityVC;
}



#pragma mark - 数据处理
- (void)handleDiscoveryData {
    
    [self.Loading show:YES];
    self.discoveryModelArr = [NSMutableArray array];
    [LhyAFNetworkTool getUrl:@"http://dis.myzaker.com/api/list_discussion.php?act=more_discussion" body:nil response:LhyJSON requestHeadFile:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSMutableDictionary *dic = [responseObject objectForKey:@"data"];
        NSMutableArray *arr = [dic objectForKey:@"list"];
        for (NSMutableDictionary *dic in arr) {
            
            LhyCommunity_DiscoveryModel *model = [[LhyCommunity_DiscoveryModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            
            
            
            
//            if (![model.title containsString:@"ZAKER"]) {
//                
//                model.title = [model.title stringByReplacingOccurrencesOfString:@"ZAKER" withString:@"Maximal"];
//            }
//            
//            if ([model.stitle containsString:@"ZAKER"]) {
//                
//                model.stitle = [model.stitle stringByReplacingOccurrencesOfString:@"ZAKER" withString:@"Maximal"];
//            }
            
            
            
            /* 对数据进行相关处理 */
            
            if (![model.title containsString:@"ZAKER"] && ![model.stitle containsString:@"ZAKER"]) {
                
                 [self.discoveryModelArr addObject:model];
            }
            
            [model release];
            
        }
        /* 回到主线程 */
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.collectionViewContent reloadData];
            [self.Loading hide:YES];
            
        });
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}


#pragma mark - 创建collectionView和三个Button

/* 创建三个Butoon和bar */
- (void)createButtonTopAndBar {
    
    self.buttonTop1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonTop1 .frame = CGRectMake(0, 64, self.view.frame.size.width / 3, self.view.frame.size.height / 17);
    [self.view addSubview:self.buttonTop1];
  //  self.buttonTop1.backgroundColor = [UIColor redColor];
    [self.buttonTop1 setTitle:@"视频" forState:UIControlStateNormal];
    [self.buttonTop1 setBackgroundColor:[UIColor whiteColor]];
    [self.buttonTop1 setTitleColor:self.viewBarColor forState:UIControlStateNormal];
    self.buttonTop1.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.buttonTop1 addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
    self.buttonTop1.tag = 100;
    self.buttonTop1.backgroundColor = self.cellDefaultColor;
    
    
    self.buttonTop2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonTop2.frame = CGRectMake(self.view.frame.size.width / 3, 64, self.view.frame.size.width / 3, self.view.frame.size.height / 17);
    [self.view addSubview:self.buttonTop2];
   // self.buttonTop2.backgroundColor = [UIColor greenColor];
    [self.buttonTop2 setTitle:@"精选" forState:UIControlStateNormal];
    [self.buttonTop2 setBackgroundColor:[UIColor whiteColor]];
    [self.buttonTop2 setTitleColor:self.viewBarColor forState:UIControlStateNormal];
    self.buttonTop2.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.buttonTop2 addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
    self.buttonTop2.tag = 200;
    self.buttonTop2.backgroundColor = self.cellDefaultColor;

    
    
    self.buttonTop3 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonTop3 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 3 * 2, 64, self.view.frame.size.width / 3, self.view.frame.size.height / 17)];
    [self.view addSubview:self.buttonTop3];
    [self.buttonTop3 setTitle:@"发现" forState:UIControlStateNormal];
    [self.buttonTop3 setBackgroundColor:[UIColor whiteColor]];
    [self.buttonTop3 setTitleColor:self.viewBarColor forState:UIControlStateNormal];
    self.buttonTop3.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.buttonTop3 addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
    self.buttonTop3.tag = 300;
    self.buttonTop3.backgroundColor = self.cellDefaultColor;
    
    
    self.bigViewBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.buttonTop1.frame.size.height, self.view.frame.size.width , 1)];
    self.bigViewBar.backgroundColor = [UIColor colorWithWhite:0.789 alpha:1.000];
    [self.buttonTop1 addSubview:self.bigViewBar];
    
    
    self.viewBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.buttonTop1.frame.size.width , 1)];
    [self.bigViewBar addSubview:self.viewBar];
    self.viewBar.backgroundColor = self.viewBarColor;
    
    [self.viewBar release];
    [self.bigViewBar release];
    
    
}



/* 创建tableViewContent */
- (void)createCollectionViewContent {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    self.collectionViewContent = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64 + self.view.frame.size.height / 17+ 1, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
    [self.view addSubview:self.collectionViewContent];
    self.collectionViewContent.delegate = self;
    self.collectionViewContent.dataSource = self;
    self.collectionViewContent.pagingEnabled = YES;
    self.collectionViewContent.bounces = NO;
    self.collectionViewContent.contentOffset = CGPointMake(self.view.frame.size.width * 2, 0);
    self.collectionViewContent.backgroundColor = self.tbDefaultColor;
    
    
    
    /* 注册三种类型的cell */
    [self.collectionViewContent registerClass:[LhyCommunity_02_DiscoveryCollectionViewCell  class] forCellWithReuseIdentifier:@"Community_02_DiscoveryCell"];
    [self.collectionViewContent registerClass:[LhyCommunity_03_SelectedCollectionViewCell class] forCellWithReuseIdentifier:@"Community_03_DiscoveryCell"];
    [self.collectionViewContent registerClass:[LhyCommunity_04_MovieCollectionViewCell class] forCellWithReuseIdentifier:@"Community_04_DiscoveryCell"];
    
    
    [flowLayout release];
    [self.collectionViewContent release];
    
}

#pragma mark - UICollectionView DataSource协议方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 3;
}

/* 返回每一个cell */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    /* 判断collectionView类型 */

        if (indexPath.item == 2) {
            LhyCommunity_02_DiscoveryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Community_02_DiscoveryCell" forIndexPath:indexPath];
            cell.modelArr = self.discoveryModelArr;
            return cell;
        } else if (indexPath.item == 1) {
            
            LhyCommunity_03_SelectedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Community_03_DiscoveryCell" forIndexPath:indexPath];
            return cell;
        } else {
            
            LhyCommunity_04_MovieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Community_04_DiscoveryCell" forIndexPath:indexPath];
            return cell;
            
        }
  
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
    [self.collectionViewContent reloadData];
}

/* 改变主题消息 */
- (void)handleChangeTheme:(NSNotification *)noti {
    
    NSString *str = noti.object;
    if ([str isEqualToString:@"YES"]) {
        
        self.collectionViewContent.backgroundColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"bgCellNewColor"];
        
        self.cellDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_NewColor"];
        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontNewColor"];
        self.viewBarColor = [UIColor colorWithRed:244 green:244 blue:244 alpha:1];
        
        
        self.viewBar.backgroundColor = self.viewBarColor;
        UIButton *button = [self.view viewWithTag:(self.viewBar.frame.origin.x /self.viewBar.frame.size.width + 1) *100];
        [button setTitleColor:self.viewBarColor forState:UIControlStateNormal];
        self.buttonTop1.backgroundColor = self.cellDefaultColor;
        self.buttonTop2.backgroundColor = self.cellDefaultColor;
        self.buttonTop3.backgroundColor = self.cellDefaultColor;
        
    } else {
     
        self.collectionViewContent.backgroundColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"bgCellDefaultColor"];
        
        self.cellDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_DefaultColor"];
        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontDefaultColor"];
        self.viewBarColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"DefaultBarColor"];
        
        self.viewBar.backgroundColor = self.viewBarColor;
        UIButton *button = [self.view viewWithTag:(self.viewBar.frame.origin.x /self.viewBar.frame.size.width + 1) *100];
        [button setTitleColor:self.viewBarColor forState:UIControlStateNormal];
        
        self.buttonTop1.backgroundColor = self.cellDefaultColor;
        self.buttonTop2.backgroundColor = self.cellDefaultColor;
        self.buttonTop3.backgroundColor = self.cellDefaultColor;
        
        
    }
    
    
}




#pragma mark - 界面将要出现
- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    [self handleDiscoveryData];
    [self createButtonTopAndBar];
    [self createCollectionViewContent];
    
    self.navigationItem.title = @"社区";
    /* 关闭自动偏移 */
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    /* 导航栏左侧info按钮 */
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"SocialTabBarItemProfile"] style:UIBarButtonItemStylePlain target:self action:@selector(handleInfoButton:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
//    /* KVO编码 */
    [self.collectionViewContent addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
}

#pragma mark - 按钮点击方法 - 控制collectionView偏移量
- (void)handleButton:(UIButton *)button {
    
    self.collectionViewContent.contentOffset = CGPointMake(self.view.frame.size.width * (button.tag - 100)/100, 0);
    
    
}


#pragma mark - kVO编码实现方法

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    //  NSLog(@"%@", change);
    
    CGFloat newX = [[change objectForKey:@"new"] CGPointValue].x;
    
    int changeX = newX;
    int width = self.view.frame.size.width;
    
    NSLog(@"%d", changeX);
    /* 直接根据content的偏移量改变top的偏移量 */
    self.viewBar.frame = CGRectMake(self.buttonTop1.frame.size.width *(changeX / width), 0, self.buttonTop1.frame.size.width , 1);
    
    if (changeX / width  == 0) {
        UIButton *button1 = [self.view viewWithTag:100];
        [button1 setTitleColor:self.viewBarColor forState:UIControlStateNormal];
        
        UIButton *button2 = [self.view viewWithTag:200];
        [button2 setTitleColor:[UIColor colorWithWhite:0.677 alpha:1.000] forState:UIControlStateNormal];
        
        UIButton *button3 = [self.view viewWithTag:300];
        [button3 setTitleColor:[UIColor colorWithWhite:0.677 alpha:1.000] forState:UIControlStateNormal];
    } else if (changeX / width  == 1 ){
        
        UIButton *button1 = [self.view viewWithTag:100];
        [button1 setTitleColor:[UIColor colorWithWhite:0.677 alpha:1.000] forState:UIControlStateNormal];
        
        UIButton *button2 = [self.view viewWithTag:200];
        [button2 setTitleColor:self.viewBarColor forState:UIControlStateNormal];
        
        UIButton *button3 = [self.view viewWithTag:300];
        [button3 setTitleColor:[UIColor colorWithWhite:0.677 alpha:1.000] forState:UIControlStateNormal];
    } else {
        
        
        UIButton *button1 = [self.view viewWithTag:100];
        [button1 setTitleColor:[UIColor colorWithWhite:0.677 alpha:1.000] forState:UIControlStateNormal];
        
        UIButton *button2 = [self.view viewWithTag:200];
        [button2 setTitleColor:[UIColor colorWithWhite:0.677 alpha:1.000]  forState:UIControlStateNormal];
        
        UIButton *button3 = [self.view viewWithTag:300];
        [button3 setTitleColor:self.viewBarColor forState:UIControlStateNormal];
    }

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
