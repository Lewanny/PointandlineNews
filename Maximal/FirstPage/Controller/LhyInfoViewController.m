

//
//  LhyInfoViewController.m
//  Maximal
//
//  Created by 李宏远 on 15/11/7.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyInfoViewController.h"
#import "LhyBaseView.h"

#import "LhyMyInfo_TableViewCell.h"
#import "LhyMyInfo_02_TableViewCell.h"
#import "LhyMyInfo_03_TableViewCell.h"

#import "LhyMYCollectionViewController.h"
#import "DataHanlder.h"

#import "LhyUserInfoViewController.h"
#import "LhyAboutUsViewController.h"

#import "UIImageView+WebCache.h"

#import "ConfigurationTheme.h"

#import "LhyLoginInViewController.h"



@interface LhyInfoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, retain)UIButton *buttonReturn;

@property(nonatomic, retain)LhyBaseView *viewTop;
@property(nonatomic, retain)UIButton *buttonUserPic;
@property(nonatomic, retain)UILabel *labelUserName;

@property(nonatomic, retain)UITableView *tableView;

@property(nonatomic, retain)NSArray *arrTitles;
@property(nonatomic, retain)NSArray *arrImages;

@property(nonatomic, retain)NSMutableArray *modelNarry;

@property(nonatomic, retain)UIColor *tbDefaultColor;
@property(nonatomic, retain)UIColor *cellDefaultColor;
@property(nonatomic, retain)UIColor *fontColor;
@property(nonatomic, retain)NSString *pageType;


@end

@implementation LhyInfoViewController

- (void)dealloc {
    
    [_viewTop release];
    [_labelUserName release];
    [_tableView release];
    
    [_arrTitles release];
    [_arrImages release];
    
    [_pageType release];
    [_tbDefaultColor release];
    [_cellDefaultColor release];
    [_fontColor release];
    [_modelNarry release];
    [super dealloc];
}

#pragma mark - 创建界面和按钮
/* 我的界面上面的View 和view上的label, imageView */
- (void)createTitleView {
    
    self.viewTop = [[LhyBaseView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 4)];
    [self.view addSubview:self.viewTop];
    [self.viewTop release];
    
    /* 我的 */
    UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake(self.viewTop.frame.size.width / 2 - 15, 18, 40, 50)];
    label.text = @"我的";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:17];
    [self.viewTop addSubview:label];
    [label release];
    
    /* 头像 */
    
    self.buttonUserPic = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.buttonUserPic setImage:[UIImage imageNamed:@"zhanwei_02"] forState:UIControlStateNormal];
    self.buttonUserPic.frame = CGRectMake((self.view.frame.size.width - 40)/ 2, 80, 40, 40);
    self.buttonUserPic.layer.cornerRadius = 20;
    self.buttonUserPic.layer.masksToBounds = YES;
    [self.viewTop addSubview:self.buttonUserPic];
    self.buttonUserPic.userInteractionEnabled = YES;
    /* 头像的点击方法添加 */
    [self.buttonUserPic addTarget:self action:@selector(handleCHangeInfo:) forControlEvents:UIControlEventTouchUpInside];
    
    /* 用户名 */
    self.labelUserName = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 200 )/2, self.buttonUserPic.frame.origin.y + 50, 200, 15)];
   // self.labelUserName.text = @"此用户下落不明";
    self.labelUserName.textColor = [UIColor whiteColor];
    self.labelUserName.font = [UIFont boldSystemFontOfSize:14];
    self.labelUserName.textAlignment = NSTextAlignmentCenter;
    [self.viewTop addSubview:self.labelUserName];
    [_labelUserName release];
    
    
}

/* 点击更换资料的按钮 */
- (void)handleCHangeInfo:(UIButton *)button {
    
    LhyLoginInViewController *loginInVC = [[LhyLoginInViewController alloc] init];
    if ([self.labelUserName.text isEqualToString:@"此用户下落不明"]) {
        loginInVC.pageType = self.pageType;
        [self presentViewController:loginInVC animated:YES completion:^{
            
        }];
    } else {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认注销当前账号么？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            /* 确认注销后, 将用户名改为默认 */
            self.labelUserName.text = @"此用户下落不明";
            NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
            NSString *userIdPath = [docPath stringByAppendingPathComponent:@"UserId.txt"];
            
            [self.labelUserName.text writeToFile:userIdPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
   
        }];
        [alert addAction:action1];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
    }
 
    [loginInVC release];
    
}

/* 创建返回按钮 */
- (void)createButtonReturn {
    
    self.buttonReturn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.buttonReturn setImage:[UIImage imageNamed:@"circle_icon_back"] forState:UIControlStateNormal];
    self.buttonReturn.frame = CGRectMake(15, 30, 30, 30);
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


#pragma mark - 创建tableView

- (void)createTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height / 4, self.view.frame.size.width, self.view.frame.size.height / 4 *3) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
     self.tableView.dataSource = self;
    self.tableView.backgroundColor = self.tbDefaultColor;
    
    [self.tableView registerClass:[LhyMyInfo_TableViewCell class] forCellReuseIdentifier:@"MyInfo_Cell"];
    [self.tableView registerClass:[LhyMyInfo_02_TableViewCell class] forCellReuseIdentifier:@"MyInfo_02_Cell"];
    [self.tableView registerClass:[LhyMyInfo_03_TableViewCell class] forCellReuseIdentifier:@"MyInfo_03_Cell"];
    self.tableView.scrollEnabled = NO;
    
    [self.tableView release];
}


#pragma mark - tableView协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.view.frame.size.height / 12;
}
/* 返回每一个cell */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        LhyMyInfo_02_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyInfo_02_Cell"];
        cell.labelTitle.text = [self.arrTitles objectAtIndex:indexPath.section];
        cell.imageViewIcon.image = [UIImage imageNamed:[self.arrImages objectAtIndex:indexPath.section]];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = self.cellDefaultColor;
        return cell;
        
    } if (indexPath.section == 3) {
        LhyMyInfo_03_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyInfo_03_Cell"];
        cell.labelTitle.text = [self.arrTitles objectAtIndex:indexPath.section];
        cell.imageViewIcon.image = [UIImage imageNamed:[self.arrImages objectAtIndex:indexPath.section]];
        // cell.selectionStyle = UITableViewCellSelectionStyleNone;
        float tmpSize = [[SDImageCache sharedImageCache] getSize];
        
        NSString *clearMessage = tmpSize >= 1024 * 1024 ? [NSString stringWithFormat:@"当前缓存:%.2fM" , tmpSize / 1024 / 1024] : [NSString stringWithFormat:@"清理缓存(%.2fK)", tmpSize / 1024];
        cell.labelTotalChche.text = clearMessage;
      //  cell.labelTotalChche.textColor =self.fontColor;
        cell.backgroundColor = self.cellDefaultColor;
        return cell;
    }
    
    LhyMyInfo_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyInfo_Cell"];
    cell.labelTitle.text = [self.arrTitles objectAtIndex:indexPath.section];
    cell.imageViewIcon.image = [UIImage imageNamed:[self.arrImages objectAtIndex:indexPath.section]];
   // cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = self.cellDefaultColor;
    return cell;
    
}

/* cell的点击方法 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        if ([self.labelUserName.text isEqualToString:@"此用户下落不明"]) {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先登陆后查看收藏夹" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:^{
                
                [self.tableView reloadData];
            }];
            
            
        } else {
            
            /* 打开数据库, 并查找所有数据 */
            [[DataHanlder sharedDataBaseCreate] openDB];
            self.modelNarry = [[DataHanlder sharedDataBaseCreate] selectAllInfo];
            NSLog(@"%@", self.modelNarry);
            
            LhyMYCollectionViewController *myCollectionVC = [[LhyMYCollectionViewController alloc] init];
  
            /* 传值 */
            [self.navigationController pushViewController:myCollectionVC animated:YES];
        }

        /* 清除缓存 */
    } else if (indexPath.section == 3) {
        
        float tmpSize = [[SDImageCache sharedImageCache] getSize];
        
        NSString *clearMessage = tmpSize >= 1024 * 1024 ? [NSString stringWithFormat:@"清理缓存(%.2fM)" , tmpSize / 1024 / 1024] : [NSString stringWithFormat:@"清理缓存(%.2fK)", tmpSize / 1024];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:clearMessage preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [self.tableView reloadData];
        }];
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [[SDImageCache sharedImageCache]clearDisk];
            
            //清除内存缓存
            [[[SDWebImageManager sharedManager] imageCache] clearMemory];
            
            //清除系统缓存
            [[NSURLCache sharedURLCache] removeAllCachedResponses];
           
            [self.tableView reloadData];
            
        }];
        
        [alert addAction:action2];
        [alert addAction:action1];
        [self presentViewController:alert animated:YES completion:nil];
        
        
    } else if (indexPath.section == 0){
        
        LhyUserInfoViewController *userInfoVc = [[LhyUserInfoViewController alloc] init];
        [self.navigationController pushViewController:userInfoVc animated:YES];
        userInfoVc.titleName = [self.arrTitles objectAtIndex:indexPath.section];
        
        [userInfoVc release];
    } else if (indexPath.section == 4) {
        
        LhyAboutUsViewController *aboutUsVc = [[LhyAboutUsViewController alloc] init];
        [self.navigationController pushViewController:aboutUsVc animated:YES];
        aboutUsVc.titleName = [self.arrTitles objectAtIndex:indexPath.section];
        
        [aboutUsVc release];
        
    }
    
    
}


#pragma mark - 数组的创建
- (void)createArray {
    
    self.arrTitles = @[@"我的信息", @"我的收藏", @"夜间模式", @"清除缓存", @"关于我们"];
    self.arrImages = @[@"myinfo-userInfo", @"myinfo-love", @"myinfo-night", @"myinfo-clear", @"myinfo-About"];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self.tableView reloadData];
}


#pragma mark - 页面将要出现
/* 加载本地当前用户名 */
- (void)viewDidAppear:(BOOL)animated {
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString *userIdPath = [docPath stringByAppendingPathComponent:@"UserId.txt"];
    NSString *userName = [NSString stringWithContentsOfFile:userIdPath encoding:NSUTF8StringEncoding error:nil];
    if (userName == nil) {
        self.labelUserName.text = @"此用户下落不明";
    } else {
        
        self.labelUserName.text = userName;
    }
}


#pragma mark - 页面已经加载
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageType= @"myInfo";
    
    
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
        
        
    } else {
        
        self.tbDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"bgCellDefaultColor"];
        self.cellDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_DefaultColor"];
        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontDefaultColor"];
       
    }

    
    
    self.modelNarry = [NSMutableArray array];
    [self createArray];
    
    [self createTitleView];
    NSString *docPath1 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString *userIdPath = [docPath1 stringByAppendingPathComponent:@"UserId.txt"];
    NSString *userName = [NSString stringWithContentsOfFile:userIdPath encoding:NSUTF8StringEncoding error:nil];
    if (userName == nil) {
        self.labelUserName.text = @"此用户下落不明";
    } else {
        
        self.labelUserName.text = userName;
    }
    [self createButtonReturn];
    [self createTableView];

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的";
    
}


/* 改变主题消息 */
- (void)handleChangeTheme:(NSNotification *)noti {
    
    NSString *str = noti.object;
    if ([str isEqualToString:@"YES"]) {
        
        self.tableView.backgroundColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"bgCellNewColor"];
        
        self.tbDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"bgCellNewColor"];
        self.cellDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_NewColor"];
        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontNewColor"];

        
    } else {
        
        self.tableView.backgroundColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"bgCellDefaultColor"];
        
        self.tbDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"bgCellDefaultColor"];
        self.cellDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_DefaultColor"];
        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontDefaultColor"];
  
    }
    
    
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
