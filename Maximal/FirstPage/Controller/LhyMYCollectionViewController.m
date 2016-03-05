

//
//  LhyMYCollectionViewController.m
//  Maximal
//
//  Created by 李宏远 on 15/11/19.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyMYCollectionViewController.h"
#import "LhyMyCollectionTableViewCell.h"
#import "LhyMainTb_01Model.h"

#import "LhyTabele_01_webViewController.h"
#import "DataHanlder.h"
#import "LhyBaseBottomView.h"

#import "ConfigurationTheme.h"

@interface LhyMYCollectionViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, retain)UIButton *buttonReturn;
@property(nonatomic, retain)LhyBaseBottomView *viewBottom;
@property(nonatomic, retain)UIImageView *imageViewTop;
@property(nonatomic, retain)UIView *viewBorder;

@property(nonatomic, retain)UITableView *tableView;
@property(nonatomic, retain)UIButton *buttonEdit;

@property(nonatomic, assign)BOOL selectedButton;

@property(nonatomic, retain)UIColor *cellDefaultColor;
@property(nonatomic, retain)UIColor *fontColor;
@property(nonatomic, retain)UIColor *tbDefaultColor;

@property(nonatomic, retain)UILabel *labelNoReuslt;


@end

@implementation LhyMYCollectionViewController


- (void)dealloc {
    
    [_labelNoReuslt release];
    [_tbDefaultColor release];
    [_cellDefaultColor release];
    [_fontColor release];
    
    [_modelArr release];
    [_tableView release];
    [_viewBorder release];
    [_imageViewTop release];
    [_viewBottom release];
    [super dealloc];
}

#pragma mark - 页面将要出现方法, 读取数据库数据
- (void)viewWillAppear:(BOOL)animated {
    self.modelArr = [NSMutableArray arrayWithCapacity:0];
    /* 打开数据库, 并查找所有数据 */
    [[DataHanlder sharedDataBaseCreate] openDB];
    self.modelArr = [[DataHanlder sharedDataBaseCreate] selectAllInfo];
    NSLog(@"%@", self.modelArr);
    if (self.modelArr.count == 0) {
        self.tableView.separatorStyle = 0;
        self.tableView.hidden = YES;
        self.labelNoReuslt.hidden = NO;
        
    } else {
        self.labelNoReuslt.hidden = YES;
    }
    
    
    [self.tableView reloadData];
}


#pragma mark - 未找到搜索结果时的提示
- (void)createNoResultLabel {
    
    self.labelNoReuslt = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
    self.labelNoReuslt.center = self.view.center;
    self.labelNoReuslt.text = @"暂无收藏内容...";
    [self.view addSubview:self.labelNoReuslt];
    self.labelNoReuslt.textAlignment = NSTextAlignmentCenter;
    self.labelNoReuslt.textColor = [UIColor colorWithWhite:0.648 alpha:1.000];
    self.labelNoReuslt.font = [UIFont systemFontOfSize:22];
    self.labelNoReuslt.hidden = YES;
    
}

#pragma mark - 返回按钮的创建和上下view的创建和点击方法
/* 按钮和view的创建 */
- (void)createReturnButtonAndButtomView {
    /* 底部view */
    self.viewBottom = [[LhyBaseBottomView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 40)];
    //self.viewBottom.backgroundColor = [UIColor colorWithWhite:0.955 alpha:1.000];
    [self.view addSubview:self.viewBottom];
    self.viewBottom.layer.borderWidth = 1;
    self.viewBottom.layer.borderColor = [UIColor colorWithWhite:0.799 alpha:1.000].CGColor;
    
    
    /* 头部view */
    self.imageViewTop = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 70)];
    self.imageViewTop.backgroundColor = self.cellDefaultColor;
    [self.view addSubview:self.imageViewTop];
    self.imageViewTop.image = [UIImage imageNamed:@"fav"];
    /* 边界线 */
    self.viewBorder = [[UIView alloc] initWithFrame:CGRectMake(0, 69.5, self.imageViewTop.frame.size.width, 0.5)];
    [self.imageViewTop addSubview:self.viewBorder];
    self.viewBorder.backgroundColor = [UIColor colorWithWhite:0.668 alpha:1.000];
    


    
    /* 返回按钮 */
    self.buttonReturn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.buttonReturn setImage:[UIImage imageNamed:@"common_icon_return"] forState:UIControlStateNormal];;
    self.buttonReturn.frame = CGRectMake(10, 5, 30, 30);
    [self.viewBottom addSubview:self.buttonReturn];
    [self.buttonReturn addTarget:self action:@selector(handleReturnButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.viewBorder release];
    [self.imageViewTop release];
    [self.viewBottom release];
}

/* 返回button的点击方法 */
- (void)handleReturnButton:(UIButton *)buttonReturn {
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
  
}

#pragma mark - 创建tableView
- (void)createTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 72, self.view.frame.size.width, self.view.frame.size.height - 70) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[LhyMyCollectionTableViewCell class] forCellReuseIdentifier:@"MyCollectionCell"];
    self.tableView.backgroundColor = self.tbDefaultColor;
    if (self.modelArr == nil) {
        self.tableView.separatorStyle = 0;
        self.tableView.hidden = YES;
    }
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    
    
}

#pragma mark - tableViewx协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.modelArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.view.frame.size.height / 11;
}

/* 返回每一个Cell */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LhyMyCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCollectionCell"];
    cell.model = [self.modelArr objectAtIndex:indexPath.row];
    cell.labelNum.text = [NSString stringWithFormat:@"%02ld%@", indexPath.row + 1, @"."];
    cell.backgroundColor = self.cellDefaultColor;
    cell.labelTitle.textColor = self.fontColor;
    return cell;
    
}


#pragma mark - 创建编辑按钮
- (void)createEditButton {
    /* 返回按钮 */
    self.buttonEdit = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.buttonEdit setImage:[UIImage imageNamed:@"DailyHot_PreferencesButton_inDark"] forState:UIControlStateNormal];
    self.buttonEdit.frame = CGRectMake(self.viewBottom.frame.size.width - 40, 5, 30, 30);
    [self.viewBottom addSubview:self.buttonEdit];
    [self.buttonEdit addTarget:self action:@selector(handleEditButton:) forControlEvents:UIControlEventTouchUpInside];
    self.buttonEdit = (UIButton *)self.editButtonItem;
  
}

- (void)handleEditButton:(UIButton *)buttonEdit {
    
    self.selectedButton = !self.selectedButton;
    
    if (self.selectedButton) {
        [self.tableView setEditing:YES animated:YES];
    } else {
        
        [self.tableView setEditing:NO animated:YES];
    }
    
    
}

/* 进入退出编辑zhuangt */
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    /* 调用父类方法, 实现edit和Done切换 */
    [super setEditing:editing animated:YES];
    
    /* tableView 进入/退出编辑状态 */
    [self.tableView setEditing:editing animated:animated];
}

#pragma mark - 编辑的协议方法
/* 哪些可以编辑 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return YES;
}

/* 编辑类型 */
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
    
}

/* 提交编辑操作 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        /* 处理数据源, 删除数据库数据 */
      //  [self.tableView reloadData];
        
        
        NSLog(@"%@", self.modelArr);
        
        LhyMainTb_01Model *model = [self.modelArr objectAtIndex:indexPath.row];
        [[DataHanlder sharedDataBaseCreate] deledateInfoWithTitle:model.title];
        
        
        [self.modelArr removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
        
        /* 收藏夹被清空时,   隐藏tableview, 出现tableView */
        if (self.modelArr.count == 0) {
            self.tableView.hidden = YES;
            self.labelNoReuslt.hidden = NO;
        }
        
    }
    
}

/* 每个cell的点击方法 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LhyTabele_01_webViewController *webVC = [[LhyTabele_01_webViewController alloc] init];
    /* 传值 */
    LhyMainTb_01Model *model = [self.modelArr objectAtIndex:indexPath.row];
    webVC.titleOfArticle = model.title;
    webVC.nameOfAuthor = model.auther_name;
    webVC.webUrl = model.weburl;
    webVC.model = model;
    [self.navigationController pushViewController:webVC animated:YES];
    
    [webVC release];
}



#pragma mark - 移动cell



#pragma mark - 页面完成加载
- (void)viewDidLoad {
    
    self.modelArr = [NSMutableArray array];
    

    
    /* 读取本地文件 */
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"Theme.tex"];
    NSString *readStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    /* 主体颜色 */
    if ([readStr isEqualToString:@"YES"]) {
        
        self.cellDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_NewColor"];
        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontNewColor"];
        self.tbDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"bgCellNewColor"];
        self.imageViewTop.backgroundColor = self.cellDefaultColor;
        
    } else {
        
        self.cellDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_DefaultColor"];
        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontDefaultColor"];
         self.tbDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"bgCellDefaultColor"];
        self.imageViewTop.backgroundColor = self.cellDefaultColor;
    }

    
    
    
    self.selectedButton = NO;
    [super viewDidLoad];
    
    //
    [self createTableView];
    [self createNoResultLabel];
    [self createReturnButtonAndButtomView];
    
    [self createEditButton];
    // Do any additional setup after loading the view.
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
