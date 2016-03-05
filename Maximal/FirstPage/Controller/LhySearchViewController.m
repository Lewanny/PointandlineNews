
//
//  LhySearchViewController.m
//  Maximal
//
//  Created by 李宏远 on 15/11/18.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhySearchViewController.h"
#import "LhyBaseView.h"
#import "LhyAFNetworkTool.h"
#import "LhySearchModel.h"
#import "LhySearch_TableViewCell.h"
#import "UIImageView+WebCache.h"
#import "LhyTabele_01_webViewController.h"
#import "MJRefresh.h"

@interface LhySearchViewController ()<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, retain)UIButton *buttonReturn;
@property(nonatomic, retain)UISearchBar *searchBar;

@property(nonatomic, copy)NSString *keyWordStr;
@property(nonatomic, retain)NSMutableArray *modelArr;

@property(nonatomic, retain)UITableView *tableView;

@property(nonatomic ,retain)NSString *currentUrl;
@property(nonatomic, assign)NSInteger pageNum;

@property(nonatomic, retain)UILabel *labelUserId;

@end

@implementation LhySearchViewController

- (void)dealloc {
    
    [_labelUserId release];
    [_searchBar release];
    [_keyWordStr release];
    [_modelArr release];
    [super dealloc];
}


#pragma mark - 数据处理
- (void)handleData {
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@%ld", @"http://search.myzaker.com/api/?c=main&act=getArticles&keyword=", self.keyWordStr, @"&app_ids=310000%2C660%2C7%2C981%2C4%2C13%2C8%2C9%2C11604%2C11812%2C12%2C11%2C10530&offset=", self.pageNum];
    
    [LhyAFNetworkTool getUrl:urlStr body:nil response:LhyJSON requestHeadFile:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSMutableDictionary *dic = [responseObject objectForKey:@"data"];
        NSMutableArray *arr = [dic objectForKey:@"list"];
        for (NSMutableDictionary *dic in arr) {
            LhySearchModel *model = [[LhySearchModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            
            /* 字符串的处理 */
           
           
//            NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
//            
////            NSDictionary *dic2 = [NSDictionary dictionaryWithObjects:@[[UIColor whiteColor], [UIFont boldSystemFontOfSize:16]] forKeys:@[NSForegroundColorAttributeName, NSFontAttributeName]];
////            self.navigationBar.titleTextAttributes = dic;
//        
//             NSRange range = [model.s_title rangeOfString:@"AAA"];
//             NSMutableAttributedString *attr;
//            [attr setAttributes:dic range:range];
//            
        /* 去掉两个标记 */
            model.s_title = [model.s_title stringByReplacingOccurrencesOfString:@"</b>" withString:[NSString stringWithFormat:@""]];
            model.s_title = [model.s_title stringByReplacingOccurrencesOfString:@"<b>" withString:[NSString stringWithFormat:@""]];
            
            model.s_content = [model.s_title stringByReplacingOccurrencesOfString:@"</b>" withString:[NSString stringWithFormat:@""]];
            model.s_content = [model.s_title stringByReplacingOccurrencesOfString:@"<b>" withString:[NSString stringWithFormat:@""]];
            
            
           
         //   NSLog(@"%@", self.searchBar.text);

            [self.modelArr addObject:model];
            [model release];
            
        }
        
/* 完成刷新 */
        [self.tableView.mj_footer endRefreshing];
       // NSLog(@"%@", self.modelArr);
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self.tableView reloadData];
        
            if (self.modelArr.count == 0) {
                
                self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                self.tableView.hidden = YES;
                self.labelUserId.hidden = NO;
                
                
            } else {
                self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            }
            
        });
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}


#pragma mark - 未找到搜索结果时的提示
- (void)createNoResultLabel {
    
    self.labelUserId = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
    self.labelUserId.center = self.view.center;
    self.labelUserId.text = @"未找到相关搜索结果...";
    [self.view addSubview:self.labelUserId];
    self.labelUserId.textAlignment = NSTextAlignmentCenter;
    self.labelUserId.textColor = [UIColor colorWithWhite:0.648 alpha:1.000];
    self.labelUserId.font = [UIFont systemFontOfSize:22];
    self.labelUserId.hidden = YES;

}

#pragma mark - 创建tableView
- (void)creataTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[LhySearch_TableViewCell class] forCellReuseIdentifier:@"Search_Cell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    /* 下拉加载刷新 */
       MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"正在加载数据");
      //  self.isDelete = NO;
           
           self.pageNum += 20;
           [self handleData];
        
    
    }];
    self.tableView.mj_footer = footer;
    [footer setTitle:@"Click or drag up to refresh" forState:MJRefreshStateIdle];
    [footer setTitle:@"Loading more ..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"No more data" forState:MJRefreshStateNoMoreData];
    
    
    
}

#pragma mark - TableView协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.modelArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

/* 返回每一个cell */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LhySearch_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Search_Cell"];
    cell.model = [self.modelArr objectAtIndex:indexPath.row];
    cell.keyWordStr = self.keyWordStr;
    return cell;
    
}

/* cell的点击方法 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LhyTabele_01_webViewController *webViewVC = [[LhyTabele_01_webViewController alloc] init];
    
    /* 传值 */
    LhySearchModel *model = [self.modelArr objectAtIndex:indexPath.row];
    
    /* 拼接webURL */
    NSString *webUrl = [NSString stringWithFormat:@"%@%@", @"http://iphone.myzaker.com/l.php?l=", model.mid];
    webViewVC.webUrl = webUrl;
    webViewVC.titleOfArticle = model.s_title;
    webViewVC.nameOfAuthor = model.author;
    
    /* 通过单例方法创建找到VC */
    [self.navigationController pushViewController:webViewVC animated:YES];
    
    
    
    [webViewVC release];

    
    
}


#pragma mark - searchbar的创建
/* 我的界面上面的View 和searchBar */
- (void)createTitleView {
    
    LhyBaseView *view = [[LhyBaseView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [self.view addSubview:view];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(40, 25, self.view.frame.size.width - 60, 35)];
    /* 去掉搜索栏的背景图片 */
    [[[self.searchBar.subviews objectAtIndex:0].subviews objectAtIndex:0]removeFromSuperview];
    [view addSubview:self.searchBar];
//    self.searchBar.placeholder = @"搜索文章和频道                                           ";
    self.searchBar.placeholder = @"搜索文章和频道";
    self.searchBar.layer.cornerRadius = 10;
    /* 设置圆角 */
    UIView *view11 = [self.searchBar.subviews  firstObject];
    UITextField *textfield = [view11.subviews firstObject];
    textfield.layer.cornerRadius = 14;
   // self.searchBar.searchResultsButtonSelected = YES;
    
    [self.searchBar setContentMode:UIViewContentModeLeft];
  //  [self.searchBar setShowsCancelButton:YES animated:YES];
    
    self.searchBar.delegate = self;
    //[self.searchBar release];
    [view release];
    
    
}

#pragma mark - searchBar协议方法

/* 开始编辑时 */
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
    self.searchBar.showsCancelButton = YES;
    self.labelUserId.hidden = YES;
    
    /* 更改cancel为取消 */
    for(id button in [self.searchBar.subviews[0] subviews])
    {
        if([button isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)button;
            [btn setTitle:@"取消" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:16];
//            btn.frame = CGRectMake(btn.frame.origin.x + 30, btn.frame.origin.y+ 30, btn.frame.size.width, btn.frame.size.height);
            
        }
    }
  
}

/* 点击取消按钮时 */
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    /* 回收键盘, 隐藏取消按钮 */
    [self.searchBar resignFirstResponder];
    self.searchBar.showsCancelButton = NO;
    self.tableView.hidden = YES;
    
}

/* 点击搜索按钮时 */
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    /* 初始化数组并移除原有的tableView */
    [self.tableView removeFromSuperview];
    self.modelArr = [NSMutableArray array];
    self.pageNum = 0;
    
    [self.searchBar resignFirstResponder];
   // NSLog(@"%@", self.searchBar.text);
    self.keyWordStr = self.searchBar.text;
    [self handleData];
    [self creataTableView];
    
}





#pragma mark - 返回按钮
/* 创建返回按钮 */
- (void)createButtonReturn {
    
    self.buttonReturn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.buttonReturn setImage:[UIImage imageNamed:@"circle_icon_back"] forState:UIControlStateNormal];
    self.buttonReturn.frame = CGRectMake(10, 25, 30, 30);
    self.buttonReturn.tintColor = [UIColor whiteColor];
    [self.view addSubview:self.buttonReturn];

    
    /* 按钮添加点击方法 */
    [self.buttonReturn addTarget:self action:@selector(handleReturnButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
}


/* 返回按钮点击方法的实现 */
- (void)handleReturnButton:(UIButton *)buttonReturn {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"showTabbar" object:nil];
}


#pragma mark - 页面将要出现
- (void)viewWillAppear:(BOOL)animated {
    
    self.labelUserId.hidden = YES;
}

#pragma mark - 页面即将加载
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTitleView];
    [self createButtonReturn];
    [self createNoResultLabel];
    
    /* 初始化数组 */
 //   self.modelArr = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的";
    
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
