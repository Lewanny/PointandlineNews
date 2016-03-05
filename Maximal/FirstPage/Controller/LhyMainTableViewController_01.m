
//
//  LhyMainTableViewController_01.m
//  Maximal
//
//  Created by 李宏远 on 15/11/9.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyMainTableViewController_01.h"
#import "LhyMainTable_01CollectionViewCell.h"
#import "LhyAFNetworkTool.h"
#import "LhyMainTb_01Model.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "LhyBaseBottomView.h"
#import "LhyMainViewController.h"

@interface LhyMainTableViewController_01 ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, retain)UICollectionView *collectionView;

@property(nonatomic, retain)NSMutableArray *modelArr;
@property(nonatomic, retain)NSMutableArray *bigArr;
@property(nonatomic, retain)NSMutableArray *bigTempArr;

@property(nonatomic, copy)NSString *headImageUrl;


@property(nonatomic, retain)UIButton *buttonReturn;
@property(nonatomic, retain)LhyBaseBottomView *viewBottom;
@property(nonatomic, retain)UILabel *labelCurrentPage;
@property(nonatomic, retain)UILabel *labelTotalPage;
@property(nonatomic, retain)UILabel *labelSepetor;


@property(nonatomic, copy)NSString *nextUrl;
@property(nonatomic, copy)NSString *currentUrl;

@property(nonatomic, retain)NSMutableArray *offSetArr;

@property(nonatomic, retain)MBProgressHUD *Loading;




@end

@implementation LhyMainTableViewController_01

- (void)dealloc {
    
  
    [_Loading release];
    [_offSetArr release];
    [_nextUrl release];
    [_labelSepetor release];
    [_labelTotalPage release];
    [_labelCurrentPage release];
    [_viewBottom release];
    [_urlId release];
    [_modelArr release];
    [_bigArr release];
    [_buttonReturn release];
    [_collectionView release];
    [super dealloc];
}

/* 状态栏颜色 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleDefault;
}


#pragma mark - 数据处理
- (void)handleData {

        [self.Loading show:YES];
   
    
    self.modelArr = [NSMutableArray array];
    self.bigTempArr = [NSMutableArray array];
    

    /* 判断当前的url */
    if ([self.nextUrl isEqualToString:@"http://iphone.myzaker.com/zaker/news.php?app_id="]) {
        
        self.currentUrl = [NSString stringWithFormat:@"%@%@",@"http://iphone.myzaker.com/zaker/news.php?app_id=",  self.urlId];
    } else {
        self.currentUrl = self.nextUrl;
        
    }
    
    [LhyAFNetworkTool getUrl:self.currentUrl body:nil response:LhyJSON requestHeadFile:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSMutableDictionary *dic = [responseObject objectForKey:@"data"];
        
        /* 出去下一页的url */
        NSMutableDictionary *nexturlDic = [dic objectForKey:@"info"];
        self.nextUrl = [nexturlDic objectForKey:@"next_url"];
        
        
        /* 取出headView的view */
        NSMutableDictionary *ipadconfigDic = [dic objectForKey:@"ipadconfig"];
        NSMutableArray *pagesArr = [ipadconfigDic objectForKey:@"pages"];
        NSMutableDictionary *headImageDic = [pagesArr firstObject];
        NSMutableDictionary *diyDic = [headImageDic objectForKey:@"diy"];
        self.headImageUrl = [diyDic objectForKey:@"bgimage_url"];
        
        NSMutableArray *arr = [dic objectForKey:@"articles"];
        
        for (NSMutableDictionary *dic in arr) {
            
            LhyMainTb_01Model *model = [[LhyMainTb_01Model alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            /* 对数据进行相关处理 */
            if ([model.title containsString:@"ZAKER"]) {
                
                model.title = [model.title stringByReplacingOccurrencesOfString:@"ZAKER" withString:@"Maximal"];
            }
            
            if ([model.auther_name containsString:@"ZAKER"]) {
                
                model.auther_name = [model.auther_name stringByReplacingOccurrencesOfString:@"ZAKER" withString:@"Maximal"];
            }
            
            [self.modelArr addObject:model];
           [model release];
        }
        
        
      // 根据数据的page值, 对数据进行分页排序
   for (int i = 0; i < self.modelArr.count - 1; i++) {
        for (int j = 0; j < self.modelArr.count - i - 1; j++) {
        LhyMainTb_01Model *model1 = [self.modelArr objectAtIndex:i];
            NSInteger page1 = [model1.page integerValue];
            LhyMainTb_01Model *model2 = [self.modelArr objectAtIndex:j];
            NSInteger page2 = [model2.page integerValue];
            LhyMainTb_01Model *model = [[LhyMainTb_01Model alloc] init];
            if (page1 >= page2) {
        
                    model = model1;
                    model1 = model2;
                    model2 = model;
                }
            
        }
   }
        
        
        
/* 把每个model放到小数组里, 小数组放到大数组里 */
        
        /* 首先如果个数不足,补齐个数 */
        if (self.modelArr.count < 36) {
            
            NSInteger num = 36 - self.modelArr.count;
                for (int i = 0; i < num; i++) {
                    LhyMainTb_01Model *model = [self.modelArr objectAtIndex:i + 4];
                    [self.modelArr addObject:model];
                }
        }
 
        /* 固定广告位置 */
        
        NSMutableArray *arrTemp = [NSMutableArray array];
        
        for (int i = 0; i < self.modelArr.count; i++) {
            LhyMainTb_01Model *model = [self.modelArr objectAtIndex:i];
            if ([model.auther_name isEqualToString:@""]) {
                [arrTemp addObject:model];
                
            }
        }
   
        [self.modelArr removeObjectsInArray:arrTemp];
   
        if (arrTemp != nil) {
            for (LhyMainTb_01Model *model in arrTemp) {
                
                [self.modelArr insertObject:model atIndex:15];
            }
        }
        
         //NSLog(@"%@", self.modelArr);
       
    
        
        /* 1. 创建大数组 */
        //self.bigArr = [NSMutableArray array];
        for (int i = 0; i < self.modelArr.count / 6; i++) {
            NSMutableArray *arr = [[NSMutableArray alloc] init];
            [self.bigTempArr addObject:arr];
            [arr release];
        }
        
        /* 2.便利modelArr, 将model放到对应的小数组中 */
        for (int i = 0; i < self.modelArr.count; i++) {
            LhyMainTb_01Model *model = [self.modelArr objectAtIndex:i];
            NSMutableArray *arr = [self.bigTempArr objectAtIndex:i / 6];
            [arr addObject:model];
        }
    
        /* 临时数组添加到大数组 */
        [self.bigArr addObjectsFromArray:self.bigTempArr];
        
        
       // NSLog(@"%@", self.bigArr);
        
        
        /* 设置总页码 */
        self.labelTotalPage.text = [NSString stringWithFormat:@"%ld", self.bigArr.count];
        
        
        
    
        /* 完成刷新 */
        [self.collectionView.mj_footer endRefreshing];
        /* 回到主线程中读取数据 */
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.collectionView reloadData];
            [self.Loading hide:NO];

        });
       
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
    
}




#pragma mark - 创建collectionView
- (void)createCollectionView {
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height - 40);
   // NSLog(@"%f", self.view.frame.size.height);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumLineSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 40) collectionViewLayout:flowLayout];
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.903 alpha:1.000];
    self.collectionView.contentSize = CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    /* 注册三种cell */
    [self.collectionView registerClass:[LhyMainTable_01CollectionViewCell class] forCellWithReuseIdentifier:@"mainTable_01cell"];
   
    /* KVO编码 */
    [self.collectionView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    
    [flowLayout release];
    [self.collectionView release];
    
}

#pragma mark - KVO监测当前是第几页(需要一个存放偏移量的数组), 并开始加载下一页数据
///* kvo编码实现 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context  {
   // NSLog(@"%@", change);
    
        CGFloat newX = [[change objectForKey:@"new"] CGPointValue].x;
        int a = newX;
        int b = self.view.frame.size.width;
        if (a % b == 0) {
            self.labelCurrentPage.text = [NSString stringWithFormat:@"%d", a / b + 1] ;
        }
    
    
    //加载到第五页时加载下一条数据, 通过数组判断数据是否加载过
    if (a / b % 6 == 3) {
        NSNumber *offSet = [NSNumber numberWithInt:a / b];
        if (![self.offSetArr containsObject:offSet]) {
            
            [self handleData];
            [self.collectionView reloadData];
            [self.offSetArr addObject:offSet];
        }
        
//        [self handleData];
//        [self.collectionView reloadData];
    }
    
}




#pragma mark - CollectionView协议方法实现
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.bigArr.count;
}

/* 返回每一个item */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LhyMainTable_01CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mainTable_01cell" forIndexPath:indexPath];
    /* 传值imageurl */
    cell.headImageUrl = self.headImageUrl;
    cell.backgroundColor = [UIColor whiteColor];
    /* 传值model */
    cell.modelArray = [self.bigArr objectAtIndex:indexPath.item];
  //  NSLog(@"%@", self.headImageUrl);
    return cell;
    
    
}

#pragma mark - 返回按钮的创建和点击方法
/* 按钮和view的创建 和显示当前页码的view */
- (void)createReturnButton {
    /* 底部view */
    self.viewBottom = [[LhyBaseBottomView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 40)];
// self.viewBottom.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.viewBottom];
    self.viewBottom.layer.borderWidth = 1;
    self.viewBottom.layer.borderColor = [UIColor colorWithWhite:0.799 alpha:1.000].CGColor;
    
    /* 显示页码的label */
    self.labelCurrentPage = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 47, 15, 20, 10)];
 //   self.labelCurrentPage.backgroundColor = [UIColor grayColor];
    self.labelCurrentPage.text = @"1";
   // self.labelCurrentPage.textColor = [UIColor colorWithWhite:0.694 alpha:1.000];
    self.labelCurrentPage.font = [UIFont systemFontOfSize:13];
    self.labelCurrentPage.textAlignment = NSTextAlignmentRight;
    [self.viewBottom addSubview:self.labelCurrentPage];
    
    self.labelSepetor = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 30, 15, 10, 10)];
//    self.labelSepetor.backgroundColor = [UIColor greenColor];
    self.labelSepetor.text = @"/";
 //   self.labelSepetor.textColor = [UIColor colorWithWhite:0.694 alpha:1.000];
    self.labelSepetor.font = [UIFont systemFontOfSize:13];
    self.labelSepetor.textAlignment = NSTextAlignmentCenter;
    [self.viewBottom addSubview:self.labelSepetor];
    
    
    self.labelTotalPage = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 23, 15, 20, 10)];
//    self.labelTotalPage.backgroundColor = [UIColor redColor];
 //   self.labelTotalPage.text = [NSString stringWithFormat:@"%ld", self.modelArr.count];
  //  self.labelTotalPage.textColor = [UIColor colorWithWhite:0.694 alpha:1.000];
    self.labelTotalPage.text = @"6";
    self.labelTotalPage.font = [UIFont systemFontOfSize:13];
    self.labelTotalPage.textAlignment = NSTextAlignmentLeft;
    [self.viewBottom addSubview:self.labelTotalPage];
    
    /* 返回按钮 */
    self.buttonReturn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.buttonReturn setImage:[UIImage imageNamed:@"common_icon_return"] forState:UIControlStateNormal];;
    self.buttonReturn.frame = CGRectMake(10, 5, 30, 30);
    [self.viewBottom addSubview:self.buttonReturn];
    [self.buttonReturn addTarget:self action:@selector(handleReturnButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.labelTotalPage release];
    [self.labelSepetor release];
    [self.labelCurrentPage release];
    [self.viewBottom release];
}

/* 返回button的点击方法 */
- (void)handleReturnButton:(UIButton *)buttonReturn {
    
    /* 移除观察者 */
    [self.collectionView removeObserver:self forKeyPath:@"contentOffset"];
    [self.navigationController popViewControllerAnimated:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center postNotificationName:@"showTabbar" object:nil];
}


#pragma mark - 页面将要出现
- (void)viewWillAppear:(BOOL)animated {
    
 
    
 
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /* 加载菊花 */
        self.Loading = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.Loading.dimBackground = YES;
        self.Loading.animationType = 0;
    });
    
    
}


#pragma mark - 页面将要加载
- (void)viewDidLoad {
    [super viewDidLoad];
    /* 初始化存放Model的数组 */
    self.bigArr = [NSMutableArray array];
    self.offSetArr = [NSMutableArray array];
    self.nextUrl = @"http://iphone.myzaker.com/zaker/news.php?app_id=";
    
    [self handleData];
    [self createCollectionView];
    [self createReturnButton];
    
    
    /* 导航栏显示 */
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    
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
