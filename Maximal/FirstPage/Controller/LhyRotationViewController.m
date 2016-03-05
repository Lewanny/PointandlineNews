

//
//  LhyRotationViewController.m
//  Maximal
//
//  Created by 李宏远 on 15/11/21.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyRotationViewController.h"
#import "LhyRotationCollectionViewCell.h"
#import "LhyAFNetworkTool.h"
#import "LhyRotationModel.h"
#import "LhyAutoAdaptHeight.h"


@interface LhyRotationViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, retain)UIButton *buttonReturn;
@property(nonatomic, retain)UILabel *labelTitle;
@property(nonatomic, retain)UICollectionView *collectionView;
@property(nonatomic, retain)UILabel *labelPageCurrent;
@property(nonatomic, retain)UILabel *labelPageTotal;
@property(nonatomic, retain)UIScrollView *scrollViewContents;

@property(nonatomic, retain)NSMutableArray *arrModel;
@property(nonatomic, retain)NSString *setName;
@property(nonatomic, retain)UILabel *labelContent;

@property(nonatomic, copy)NSString *url1;

@end

@implementation LhyRotationViewController

- (void)dealloc {
    
    [_url1 release];
    [_strTitle release];
    
    [_setName release];
    [_urlStr release];
    [_labelPageTotal release];
    [_labelPageCurrent release];
    [_labelTitle release];
    [_collectionView release];
    [_scrollViewContents release];
    [_labelContent release];
   
    [self.collectionView removeObserver:self forKeyPath:@"contentOffset"];
    
    [super dealloc];
    
}

#pragma mark - 数据处理
- (void)handleData {
    
    NSArray *arrStr = [self.urlStr componentsSeparatedByString:@"|"];
    NSString *url2 = [arrStr objectAtIndex:1];
    self.url1 = [[arrStr firstObject] substringWithRange:NSMakeRange(4, 4)];

    NSString *urlFinal = [NSString stringWithFormat:@"http://c.m.163.com/photo/api/set/%@/%@.json", self.url1, url2];
    
    [LhyAFNetworkTool getUrl:urlFinal body:nil response:LhyJSON requestHeadFile:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSString *str = [responseObject objectForKey:@"settag"];
        NSLog(@"%@", str);
        self.setName = [responseObject objectForKey:@"setname"];
        NSLog(@"%@", self.setName);
        NSMutableArray *arr = [responseObject objectForKey:@"photos"];
        for (NSMutableDictionary *dic in arr) {
        
            LhyRotationModel *model = [[LhyRotationModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.arrModel addObject:model];
            
            [model release];
        }
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self.collectionView reloadData];

            LhyRotationModel *model = [self.arrModel objectAtIndex:0];
            if ([self.url1 isEqualToString:@"0003"]) {
                self.labelContent.text = model.imgtitle;
            } else {
                
                self.labelContent.text = model.note;
            }
            NSLog(@"sss%@", model.note);
            CGFloat height = [LhyAutoAdaptHeight heigntForCellWithContent:model.note width:self.view.frame.size.width - 20 fontSize:14];
            NSLog(@"%f",height);

            self.scrollViewContents.contentSize = CGSizeMake(self.view.frame.size.width - 6, height);
//            
            
            self.labelContent.frame = CGRectMake(10, 0, self.scrollViewContents.frame.size.width  - 20, height );
//
             self.collectionView.scrollEnabled = YES;
            
        });
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
        
    }];
    
}


#pragma mark - 返回按钮的创建和点击方法
/* 按钮和view的创建 和显示当前页码的view */
- (void)createReturnButton {
   
    
    /* 返回按钮 */
    self.buttonReturn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.buttonReturn setImage:[UIImage imageNamed:@"common_icon_return"] forState:UIControlStateNormal];;
    self.buttonReturn.frame = CGRectMake(10, 30, 30, 30);
    self.buttonReturn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.buttonReturn];
    [self.buttonReturn setTintColor:[UIColor whiteColor]];
    [self.buttonReturn addTarget:self action:@selector(handleReturnButton:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 创建标题栏
- (void)createLabelTitle {
    
    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(30, 40, self.view.frame.size.width - 60, 30)];
   // self.labelTitle.backgroundColor = [UIColor grayColor];
    self.labelTitle.text = self.strTitle;
    [self.view addSubview:self.labelTitle];
    self.labelTitle.font = [UIFont boldSystemFontOfSize:17];
    self.labelTitle.textColor = [UIColor whiteColor];
    self.labelTitle.textAlignment = NSTextAlignmentCenter;
    
    [self.labelTitle release];
    
    
}

/* 返回button的点击方法 */
- (void)handleReturnButton:(UIButton *)buttonReturn {
    

    [self.navigationController popViewControllerAnimated:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center postNotificationName:@"showTabbar" object:nil];
}

#pragma mark - 页脚控制
- (void)createPagelabel {
    
//    self.labelPageCurrent = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 40,self.collectionView.frame.origin.y + self.collectionView.frame.size.height + 5 , 30, 15)];
//    self.labelPageCurrent.backgroundColor = [UIColor blueColor];
//    self.labelPageCurrent.text = @"1/7";
//    [self.view addSubview:self.labelPageCurrent];
    
    self.labelPageCurrent = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 60,self.collectionView.frame.origin.y + self.collectionView.frame.size.height + 5 - 3 , 30, 20)];
 //   self.labelPageCurrent.backgroundColor = [UIColor blueColor];
    self.labelPageCurrent.text = @"1";
    self.labelPageCurrent.textColor = [UIColor whiteColor];
    self.labelPageCurrent.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:self.labelPageCurrent];
    self.labelPageCurrent.textAlignment = NSTextAlignmentRight;
    
    self.labelPageTotal = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 40 + 10,self.collectionView.frame.origin.y + self.collectionView.frame.size.height + 5  , 30, 15)];
   // self.labelPageTotal.backgroundColor = [UIColor blueColor];
   // self.labelPageTotal.text = [NSString stringWithFormat:@"/%ld", self.arrModel.count];
    self.labelPageTotal.textColor = [UIColor whiteColor];
    self.labelPageTotal.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:self.labelPageTotal];
    
    [self.labelPageTotal release];
    [self.labelPageCurrent release];
    
    
}


#pragma mark - 内容的scrollView
- (void)createScrollView {
    
    self.scrollViewContents = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.labelPageTotal.frame.origin.y + 20 + 5, self.view.frame.size.width, self.view.frame.size.height / 5 - 10)];
    [self.view addSubview:self.scrollViewContents];
    self.scrollViewContents.backgroundColor = [UIColor colorWithRed:0.175 green:0.162 blue:0.195 alpha:1.000];
    self.scrollViewContents.contentSize = CGSizeMake(self.view.frame.size.width - 6, 100);
    
    
    self.labelContent = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.scrollViewContents.frame.size.width  - 20, self.scrollViewContents.frame.size.height  - 10)];
    [self.scrollViewContents addSubview:self.labelContent];
    self.labelContent.font = [UIFont systemFontOfSize:14];
    self.labelContent.textColor = [UIColor whiteColor];
    self.labelContent.backgroundColor = [UIColor clearColor];
    self.labelContent.numberOfLines = 0;
    
    
    [self.scrollViewContents release];
    [self.labelContent release];
    
}

#pragma mark - 创建collectionView
- (void)createCollectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height /5 * 3);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;

    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 90, self.view.frame.size.width, self.view.frame.size.height /5 * 3) collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[LhyRotationCollectionViewCell class] forCellWithReuseIdentifier:@"RotationCell"];
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    
    /* KVO */
    [self.collectionView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.collectionView release];
    [layout release];
    
}

#pragma mark - KVO实现
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    CGFloat newX = [[change objectForKey:@"new"] CGPointValue].x;
   // NSLog(@"%f", newX);
    int newChange = newX;
    int width = self.view.frame.size.width
    ;
    if (newChange % width == 0) {
        /* 两个页脚数 */
        self.labelPageTotal.text = [NSString stringWithFormat:@"/%ld", self.arrModel.count];
        self.labelPageCurrent.text = [NSString stringWithFormat:@"%d", newChange / width + 1];
        if (newChange / width != 0) {
            LhyRotationModel *model = [self.arrModel objectAtIndex:newChange / width ];
            if ([self.url1 isEqualToString:@"0003"]) {
                self.labelContent.text = model.imgtitle;
            } else {
                
                self.labelContent.text = model.note;
            }
            
            CGFloat height = [LhyAutoAdaptHeight heigntForCellWithContent:model.note width:self.view.frame.size.width - 20 fontSize:14];
            NSLog(@"%f",height);
            
            self.scrollViewContents.contentSize = CGSizeMake(self.view.frame.size.width - 6, height + 10);
            //
            
            self.labelContent.frame = CGRectMake(10, 0, self.scrollViewContents.frame.size.width  - 20, height);
        }
        
        
    }
    
    
}

#pragma mark - 协议方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.arrModel.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LhyRotationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RotationCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blackColor];
    
    LhyRotationModel*model = [self.arrModel objectAtIndex:indexPath.row];
    cell.model = model;
    
    return cell;
    
    
}

#pragma mark - 页面即将加载
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.155 green:0.144 blue:0.173 alpha:1.000];

    self.arrModel = [NSMutableArray array];
    
    [self handleData];
    
    [self createReturnButton];
    [self createLabelTitle];
    [self createCollectionView];
    self.collectionView.scrollEnabled = NO;
    [self createPagelabel];
    [self createScrollView];
    
    
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
