//
//  LhyMainViewController.m
//  Maximal
//
//  Created by 李宏远 on 15/11/7.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyMainViewController.h"
#import "LhyMainCollectionViewCell.h"
#import "LhyRotationBroadcView.h"

#import "LhyInfoViewController.h"
#import "LhySearchViewController.h"

#import "LhyRotationBroadcastModel.h"
#import "LhyAFNetworkTool.h"
#import "LhyMainTableViewController_01.h"
#import "MJRefresh.h"

#import "LhyTabele_01_webViewController.h"

#import "DataHanlder.h"
#import "ConfigurationTheme.h"


@interface LhyMainViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, retain)UICollectionView *collectionViewMain;
@property(nonatomic, retain)NSMutableArray *arrModel;

@property(nonatomic, retain)NSMutableArray *arrPic;
@property(nonatomic, retain)NSMutableArray *arrId;

@property(nonatomic, assign)BOOL isDelete;

@property(nonatomic, retain)UIColor *defaulrColor;
@property(nonatomic, retain)NSMutableArray *picArr;



@end

@implementation LhyMainViewController

- (void)dealloc {
    

    [_defaulrColor release];
    [_picArr release];
    [_arrId release];
    [_arrPic release];
    [_arrModel release];
    [_collectionViewMain release];
    [super dealloc];
}



/* 单例创建VC */
+ (instancetype)sharedMainVC {
    
    static LhyMainViewController *mainVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        mainVC = [[LhyMainViewController alloc] init];
    });
    
    return mainVC;
}


#pragma makr - 数据处理
- (void)handleData {
    
  
    self.arrModel = [NSMutableArray array];
    [LhyAFNetworkTool getUrl:@"http://c.m.163.com/nc/article/headline/T1348647853363/0-140.html" body:nil response:LhyJSON requestHeadFile:nil success:^(NSURLSessionDataTask *task, id responseObject) {

        NSMutableArray *arr = [responseObject objectForKey:@"T1348647853363"];
        NSDictionary *dic = [arr firstObject];
        NSMutableArray *arrM = [dic objectForKey:@"ads"];
        for (NSDictionary *dic in arrM) {
            LhyRotationBroadcastModel *model = [[LhyRotationBroadcastModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            
            /* 判断来筛选图集类型的model */
            if ([model.tag isEqualToString:@"photoset"]) {
                [self.arrModel addObject:model];
            }
            [model release];
        }
    
        LhyRotationBroadcView *rotationView = [[LhyRotationBroadcView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 3.1) modelArray:self.arrModel];
        /* 自动轮播时间 */
        [rotationView openTimerWithDuration:5];
        
        
        [self.collectionViewMain addSubview:rotationView];
        
        [rotationView release];
        
        [self.collectionViewMain.mj_header endRefreshing];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.collectionViewMain reloadData];
        });
      
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        /* 无网络状时 */
        NSLog(@"%@", error);
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"网络无连接,当前为缓存内容" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
        
    }];
    
}




#pragma mark - 创建collectionView

- (void)createCollectionView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width / 3, self.view.frame.size.height / 5.4);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(self.view.frame.size.height / 3.2, 0, 0, 0);
    
    
    self.collectionViewMain = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.collectionViewMain.delegate = self;
    self.collectionViewMain.dataSource = self;

    /* 注册cell类型 */
    [self.collectionViewMain registerClass:[LhyMainCollectionViewCell class] forCellWithReuseIdentifier:@"mainColCell1"];
    
    [self.view addSubview:self.collectionViewMain];
    self.collectionViewMain.backgroundColor = self.defaulrColor;
    
////     给collectionView添加长按手势操作
//    UILongPressGestureRecognizer *longPressGuester = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
//    [self.collectionViewMain addGestureRecognizer:longPressGuester];
    
    
    [self.collectionViewMain release];
}

//#pragma mark - Cell的移动
//- (IBAction)handleLongPress:(id)sender {
//    
//    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
//    UIGestureRecognizerState state = longPress.state;
//    
//    CGPoint location = [longPress locationInView:self.collectionViewMain];
//    NSIndexPath *indexPath = [self.collectionViewMain indexPathForItemAtPoint:location];
//    
//    static UIView *snapshot = nil;        //snapshot view
//    static NSIndexPath *sourceIndexPath = nil; //开始拖动时的indexpath
//    
//    switch (state) {
//        case UIGestureRecognizerStateBegan: {
//            if (indexPath) {
//                sourceIndexPath = indexPath;
//                
//                UICollectionViewCell *cell = [self.collectionViewMain cellForItemAtIndexPath:indexPath];
//                
//                // Take a snapshot of the selected row using helper method.
//                snapshot = [self customSnapshoFromView:cell];
//                
//                // Add the snapshot as subview, centered at cell's center...
//                __block CGPoint center = cell.center;
//                snapshot.center = center;
//                snapshot.alpha = 0.0;
//                [self.collectionViewMain addSubview:snapshot];
//                
//                [UIView animateWithDuration:0.25 animations:^{
//                    // Offset for gesture location.
//                    center.y = location.y;
//                    snapshot.center = center;
//                    snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);
//                    snapshot.alpha = 0.98;
//                    
//                    // Fade out.
//                    cell.alpha = 0.0;
//                } completion:^(BOOL finished) {
//                    cell.hidden = YES;
//                }];
//                
//                
//            }
//            break;
//        }
//            
//        case UIGestureRecognizerStateChanged: {
//            CGPoint center = snapshot.center;
//            center.y = location.y;
//            center.x = location.x;
//            snapshot.center = center;
//            
//            // Is destination valid and is it different from source?
//            if (indexPath && ![indexPath isEqual:sourceIndexPath]) {
//                
//                // 更新数据源
//    
//                    NSString *idStr = [self.arrId objectAtIndex:sourceIndexPath.row];
//                    [self.arrId removeObject:idStr];
//                    [self.arrId insertObject:idStr atIndex:indexPath.row];
//                    
//                    UIImage *picImage = [self.picArr objectAtIndex:sourceIndexPath.row];
//                    [self.picArr removeObject:picImage];
//                    [self.picArr insertObject:picImage atIndex:indexPath.row];
//                
//            
//                // 移动item
//                [self.collectionViewMain moveItemAtIndexPath:sourceIndexPath toIndexPath:indexPath];
//
//                sourceIndexPath = indexPath;
//            }
//            break;
//        }
//            
//        default: {
//         // [self.collectionViewMain reloadData];
//            // 拖动结束后,固定cell位置, 隐藏snapshot显示cell
//            UICollectionViewCell *cell = [self.collectionViewMain cellForItemAtIndexPath:sourceIndexPath];
//            [UIView animateWithDuration:0.25 animations:^{
//                
//                snapshot.center = cell.center;
//                snapshot.transform = CGAffineTransformIdentity;
//                snapshot.alpha = 0.0;
//                
//                cell.alpha = 1.0;
//                
//            } completion:^(BOOL finished) {
//                
//                [snapshot removeFromSuperview];
//                cell.hidden = NO;
//                snapshot = nil;
//                
//            }];
//        
//            break;
//        }
//    }
//    
//}

//#pragma mark - snapshotView
//
///* 根据给定的view 返回一个 snapshot View */
//- (UIView *)customSnapshoFromView:(UIView *)inputView {
//    
//    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
//    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
//    snapshot.layer.masksToBounds = NO;
//    snapshot.layer.cornerRadius = 0.0;
//    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
//    snapshot.layer.shadowRadius = 5.0;
//    snapshot.layer.shadowOpacity = 0.4;
//    
//    return snapshot;
//}
//



#pragma mark - collectionView的协议方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.picArr.count;
}

/* 每一个cell */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LhyMainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mainColCell1" forIndexPath:indexPath];
    cell.imageViewPic.image = [self.picArr objectAtIndex:indexPath.item];

    return cell;
}

/* 点击cell的方法实现 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    /* 跳转界面, 并利用消息机制实现tabbar的隐藏 */
    LhyMainTableViewController_01 *tableVC_01 = [[LhyMainTableViewController_01 alloc] init];
    tableVC_01.urlId = [self.arrId objectAtIndex:indexPath.row];
  
    [self.navigationController pushViewController:tableVC_01 animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"hideTabbar" object:nil];
    
    [tableVC_01 release];
    
}

#pragma mark - Cell的移动

- (void)viewWillAppear:(BOOL)animated {
    
    // [self setNeedsStatusBarAppearanceUpdate];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleChangeTheme:) name:@"changeTheme" object:nil];
    [self.collectionViewMain reloadData];
    NSLog(@"%@", self.arrPic);
    
}


- (void)viewDidAppear:(BOOL)animated {
    
}


#pragma mark - 页面将要加载 - 创建导航按钮
- (void)viewDidLoad {
    [super viewDidLoad];

    /* 读取本地文件 */
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"Theme.tex"];
    NSString *readStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    
    /* 主体颜色 */
    if ([readStr isEqualToString:@"YES"]) {
        self.defaulrColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"bgCellNewColor"];
        self.picArr = @[[UIImage imageNamed:@"头条新闻-夜间"], [UIImage imageNamed:@"汽车频道-夜间"], [UIImage imageNamed:@"旅游频道-夜间"], [UIImage imageNamed:@"体育频道-夜间"], [UIImage imageNamed:@"娱乐八卦-夜间"], [UIImage imageNamed:@"财经新闻-夜间"], [UIImage imageNamed:@"科技频道-夜间"], [UIImage imageNamed:@"设计馆-夜间"], [UIImage imageNamed:@"时尚频道-夜间"], [UIImage imageNamed:@"教育频道-夜间"], [UIImage imageNamed:@"电影资讯-夜间"], [UIImage imageNamed:@"美食频道-夜间"], [UIImage imageNamed:@"游戏资讯-夜间"], [UIImage imageNamed:@"爆笑日常-夜间"]].mutableCopy;
 //   sourceIndexPath = nil;
       
    } else {
        
        self.defaulrColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"bgCellDefaultColor"];
        
         self.picArr = @[[UIImage imageNamed:@"头条新闻-白天"], [UIImage imageNamed:@"汽车频道-白天"], [UIImage imageNamed:@"旅游频道-白天"], [UIImage imageNamed:@"体育频道-白天"], [UIImage imageNamed:@"娱乐八卦-白天"], [UIImage imageNamed:@"财经新闻-白天"], [UIImage imageNamed:@"科技频道-白天"], [UIImage imageNamed:@"设计馆-白天"], [UIImage imageNamed:@"时尚频道-白天"], [UIImage imageNamed:@"教育频道-白天"], [UIImage imageNamed:@"电影资讯-白天"], [UIImage imageNamed:@"美食频道-白天"], [UIImage imageNamed:@"游戏资讯-白天"], [UIImage imageNamed:@"爆笑日常-白天"]].mutableCopy;
        
    }
    
    
/* 创建pic 和id 的数组, 当前12, 共14 */
    
    /* id数组 */
    NSArray *idArray = @[@"660",@"7", @"981", @"8", @"9", @"4", @"13", @"11812", @"12", @"11", @"10530", @"10386" , @"10376", @"11581"];
    self.arrId = [NSMutableArray arrayWithArray:idArray];
   // NSLog(@"%@", self.arrId);
    
    
    [self handleData];
    [self createCollectionView];
    
    
    self.navigationItem.title = @"订阅";
    /* 导航栏左侧info按钮 */
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"SocialTabBarItemProfile"] style:UIBarButtonItemStylePlain target:self action:@selector(handleInfoButton:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    
    /* 导航栏右侧search按钮 */
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ExploreSearchButton"] style:UIBarButtonItemStylePlain target:self action:@selector(handleSearchButton:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    /* 创建轮播图的占位图 */
    UIImageView *imagePlaceHoler = [[UIImageView alloc] init];
    imagePlaceHoler.image = [UIImage imageNamed:@"zhanwei_01"];
    imagePlaceHoler.backgroundColor = [UIColor colorWithRed:0.878 green:0.961 blue:0.996 alpha:1.000];
    imagePlaceHoler.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 3.1);
    [self.collectionViewMain addSubview:imagePlaceHoler];
    
    [imagePlaceHoler release];
    
    
}


/* 改变主题消息 */
- (void)handleChangeTheme:(NSNotification *)noti {
    
    NSString *str = noti.object;
    if ([str isEqualToString:@"YES"]) {
        self.collectionViewMain.backgroundColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"bgCellNewColor"];
        
            self.defaulrColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"bgCellNewColor"];
            self.picArr = @[[UIImage imageNamed:@"头条新闻-夜间"], [UIImage imageNamed:@"汽车频道-夜间"], [UIImage imageNamed:@"旅游频道-夜间"], [UIImage imageNamed:@"体育频道-夜间"], [UIImage imageNamed:@"娱乐八卦-夜间"], [UIImage imageNamed:@"财经新闻-夜间"], [UIImage imageNamed:@"科技频道-夜间"], [UIImage imageNamed:@"设计馆-夜间"], [UIImage imageNamed:@"时尚频道-夜间"], [UIImage imageNamed:@"教育频道-夜间"], [UIImage imageNamed:@"电影资讯-夜间"], [UIImage imageNamed:@"美食频道-夜间"], [UIImage imageNamed:@"游戏资讯-夜间"], [UIImage imageNamed:@"爆笑日常-夜间"]].mutableCopy;
            
        
    } else {
        
        self.collectionViewMain.backgroundColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"bgCellDefaultColor"];
        
        
        self.picArr = @[[UIImage imageNamed:@"头条新闻-白天"], [UIImage imageNamed:@"汽车频道-白天"], [UIImage imageNamed:@"旅游频道-白天"], [UIImage imageNamed:@"体育频道-白天"], [UIImage imageNamed:@"娱乐八卦-白天"], [UIImage imageNamed:@"财经新闻-白天"], [UIImage imageNamed:@"科技频道-白天"], [UIImage imageNamed:@"设计馆-白天"], [UIImage imageNamed:@"时尚频道-白天"], [UIImage imageNamed:@"教育频道-白天"], [UIImage imageNamed:@"电影资讯-白天"], [UIImage imageNamed:@"美食频道-白天"], [UIImage imageNamed:@"游戏资讯-白天"], [UIImage imageNamed:@"爆笑日常-白天"]].mutableCopy;
    }
    
    NSLog(@"%@", self.collectionViewMain.subviews);
    
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

/* 点击search按钮的方法 */
- (void)handleSearchButton:(UITabBarItem *)barItem {
    
    LhySearchViewController *searchVC = [[LhySearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"hideTabbar" object:nil];
    
    [searchVC release];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
