//
//  LhyMainTable_01CollectionViewCell.m
//  Maximal
//
//  Created by 李宏远 on 15/11/9.
//  Copyright © 2015年 李宏远. All rights reserved.
//
// self.frame.size.height = 627
#import "LhyMainTable_01CollectionViewCell.h"
#import "LhyMainTb_01_01CollectionViewCell.h"
#import "LhyMainTb_01_02CollectionViewCell.h"
#import "LhyMainTb_01_03CollectionViewCell.h"
#import "LhyMainTb_01Model.h"
#import "UIImageView+WebCache.h"


#import "LhyTabele_01_webViewController.h"
#import "LhyMainViewController.h"
#import "ConfigurationTheme.h"

@interface LhyMainTable_01CollectionViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic, retain)UICollectionView *collectionView;
@property(nonatomic, retain)UIImageView *imageViewTitle;
@property(nonatomic, retain)UICollectionViewFlowLayout *flowLayout;

@property(nonatomic, retain)UIColor *cellDefaultColor;
@property(nonatomic, retain)UIColor *fontColor;


@end

@implementation LhyMainTable_01CollectionViewCell

- (void)dealloc {
    
    
    [_cellDefaultColor release];
    [_fontColor release];
    [_headImageUrl release];
    [_modelArray release];
    [_imageViewTitle release];
    [_collectionView release];
    [super dealloc];
    
}

/* 重写初始化方法, 创建子控件 */
- (instancetype)initWithFrame:(CGRect)frame{
    
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
        /* 子控件titleView */
        self.imageViewTitle = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, self.contentView.frame.size.width, 70)];
        [self.contentView addSubview:self.imageViewTitle];
        [self.imageViewTitle setBackgroundColor:self.cellDefaultColor];
        
        
        [self.imageViewTitle release];
        
        /* 子控件UIcollectionView */
        self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
        //flowLayout.itemSize = CGSizeMake(90 , 90);
        self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.flowLayout.minimumLineSpacing = 1;
        self.flowLayout.minimumInteritemSpacing = 1;
        
        self.flowLayout.itemSize = CGSizeMake(self.frame.size.width / 2 - 0.25, (self.frame.size.height - 77) / 5 -1);
        
        
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 90, self.contentView.frame.size.width, self.contentView.frame.size.height - 50) collectionViewLayout:self.flowLayout];
        self.collectionView.backgroundColor = [UIColor colorWithWhite:0.933 alpha:1.000];
        [self.contentView addSubview:self.collectionView];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        
        /* 注册三种cell */
        [self.collectionView registerClass:[LhyMainTb_01_01CollectionViewCell class] forCellWithReuseIdentifier:@"MainTb_01_01Cell"];
        [self.collectionView registerClass:[LhyMainTb_01_02CollectionViewCell class] forCellWithReuseIdentifier:@"MainTb_01_02Cell"];
        [self.collectionView registerClass:[LhyMainTb_01_03CollectionViewCell class] forCellWithReuseIdentifier:@"MainTb_01_03Cell"];
        
  
        [self.flowLayout release];
        [self.collectionView release];
        
    }
    
    
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



#pragma mark - UIcollectionVIew Datasource 协议方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 6;
    
}


/* 返回每一个cell */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.item > 0 && indexPath.item < 5) {
        
        LhyMainTb_01_01CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainTb_01_01Cell" forIndexPath:indexPath];
        cell.backgroundColor = self.cellDefaultColor;
        /* 传值 */
        cell.model = [self.modelArray objectAtIndex:indexPath.item];
 
        cell.labelTitel.textColor = self.fontColor;
        return cell;

    } else if (indexPath.row >= 5)
    {
        
        LhyMainTb_01_02CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainTb_01_02Cell" forIndexPath:indexPath];
        cell.backgroundColor = self.cellDefaultColor;
        /* 传值 */
        cell.model = [self.modelArray objectAtIndex:indexPath.item];
        return cell;

        
    } else {
        
     
        LhyMainTb_01_03CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainTb_01_03Cell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor colorWithRed:0.734 green:1.000 blue:0.719 alpha:1.000];
        /* 传值 */
        cell.model = [self.modelArray objectAtIndex:indexPath.item];
     //   cell.labelTitel.textColor = self.fontColor;
        return cell;
        
    }
    
}

#pragma mark - Cell的点击方法, 单例方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LhyTabele_01_webViewController *webViewVC = [[LhyTabele_01_webViewController alloc] init];
    
    /* 传值 */
    LhyMainTb_01Model *model = [self.modelArray objectAtIndex:indexPath.row];
    
    webViewVC.model = model;
    
    webViewVC.webUrl = model.weburl;
    webViewVC.titleOfArticle = model.title;
    webViewVC.nameOfAuthor = model.auther_name;
    
    
    /* 通过单例方法创建找到VC */
    [[LhyMainViewController sharedMainVC].navigationController pushViewController:webViewVC animated:YES];
    
    
    
    [webViewVC release];
}

#pragma mark - UICollectionViewdelegateFlowLayout协议方法
/* 用此协议方法, 实现定制collectionViewCell */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.item > 0 && indexPath.item < 5) {
        
        
       // cell.frame = CGRectMake(0,0 , self.frame.size.width / 2 - 0.25, (self.frame.size.height - 77) / 5 -1);
        return CGSizeMake(self.frame.size.width / 2 - 0.5, (self.frame.size.height - 90) * 0.62 / 3);
        
        
    } else if (indexPath.row >= 5)
    {
        return CGSizeMake(self.frame.size.width, (self.frame.size.height - 90) * 0.62 / 3);
        
        
        
    } else {
        
        
        return CGSizeMake(self.frame.size.width, (self.frame.size.height - 90) * 0.38);
       
        
    }
    

    
}


/* 重写属性modelArr的初始化方法, 重新读取数据 */
- (void)setModelArray:(NSMutableArray *)modelArray {
    
    /* 头部图片赋值 */
  //  NSLog(@"%@", self.headImageUrl);
    [self.imageViewTitle sd_setImageWithURL:[NSURL URLWithString:self.headImageUrl]];
    if (_modelArray!= modelArray) {
        [_modelArray release];
        _modelArray = [modelArray retain];
    }
   
// 将无图片的model放到数组的最后
    NSMutableArray *arr = [NSMutableArray array];
    for (LhyMainTb_01Model *model in self.modelArray) {
        if ([model.media isEqualToArray:@[]]) {
            [arr addObject:model];
        }
    }

    [modelArray removeObjectsInArray:arr];
    [modelArray addObjectsFromArray:arr];
//
    [self.collectionView reloadData];
    
    //
    
   // NSLog(@"%@", modelArray);

}




@end
