//
//  LhyRotationBroadcView.m
//  Maximal
//
//  Created by 李宏远 on 15/11/7.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyRotationBroadcView.h"
#import "LhyRotationBoardCell.h"
#import "UIImageView+WebCache.h"
#import "LhyRotationBroadcastModel.h"
#import "LhyAFNetworkTool.h"
#import "LhyMainViewController.h"

#import "LhyMainTb_01Model.h"

#import "LhyRotationViewController.h"

@interface LhyRotationBroadcView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, assign)NSInteger picNumber;
@property(nonatomic, retain)UICollectionView *collectionView;
@property(nonatomic, retain)UIPageControl *pageControl;

@property(nonatomic, retain)NSMutableArray *picArray;

@property(nonatomic, retain)NSTimer *timer;
@property(nonatomic, assign)NSTimeInterval duration;

@property(nonatomic, retain)NSMutableArray *blockModelArr;
@property(nonatomic, retain)NSMutableArray *topicModelArr;



@end

@implementation LhyRotationBroadcView

- (void)dealloc {
    
    
    [_collectionView release];
    [_pageControl release];
    [_picArray release];
    [super dealloc];
}

/**
 *  封装轮播图
 *
 *  @param frame  位置大小
 *  @param picArr 存放图片的数组
 *
 *  @return 初始化方法
 */
- (instancetype)initWithFrame:(CGRect)frame modelArray:(NSMutableArray *)modelArr
 {
     /* 初始化数组 */
     self.blockModelArr = [NSMutableArray array];
     self.topicModelArr = [NSMutableArray array];
     
    self = [super initWithFrame:frame];
    if (self) {
        /* 传值和数据处理 */
        self.picNumber = modelArr.count;
        NSString *modelFirst = [modelArr objectAtIndex:0];
        NSString *modelLast =[modelArr lastObject];
        [modelArr insertObject:modelLast atIndex:0];
        [modelArr addObject:modelFirst];
        self.picArray = modelArr;
        

 /* 设置collectionView */
        self.backgroundColor = [UIColor grayColor];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
        layout.minimumLineSpacing = 0;
        
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        self.collectionView.contentSize = CGSizeMake(self.frame.size.width * (self.picNumber+ 2), self.frame.size.height);
        [self addSubview:self.collectionView];
        
        self.collectionView.backgroundColor = [UIColor colorWithRed:1.000 green:0.637 blue:0.544 alpha:1.000];
        
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.pagingEnabled = YES;
        //self.collectionView.bounces = NO;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        [self.collectionView registerClass:[LhyRotationBoardCell class] forCellWithReuseIdentifier:@"RotationBoardCell"];
        self.collectionView.contentOffset = CGPointMake(self.frame.size.width, 0);
 /* 设置pageControl */
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((self.frame.size.width -  self.picNumber * 20) / 2 , self.frame.size.height - 13, self.picNumber * 20, 10)];
       // self.pageControl.backgroundColor = [UIColor grayColor];
        self.pageControl.numberOfPages = self.picNumber;
        
        [self addSubview:self.pageControl];
  
    
        [self.pageControl release];
        [layout release];
        [self.collectionView release];
        
    }
    return self;
}

#pragma mark - 创建定时器相关
- (void)openTimerWithDuration:(NSTimeInterval)duration {
    
    self.duration = duration;
    [self startTimer];
    
}


- (void)startTimer{
    
    self.timer = [NSTimer timerWithTimeInterval:self.duration target:self selector:@selector(changeOffSet:) userInfo:nil repeats:YES];
    
    /** <Runloop> */
 //   [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
   
    
}

#pragma mark - 设置拖动时定时器关闭, 结束拖动时开始

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.timer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [self startTimer];
}


- (void)changeOffSet:(NSTimer *)timer {
       
    
            self.collectionView.contentOffset = CGPointMake(self.collectionView.contentOffset.x + self.frame.size.width, self.collectionView.contentOffset.y);
            _pageControl.currentPage=self.collectionView.contentOffset.x/self.bounds.size.width-1;
    
            if (self.collectionView.contentOffset.x>=self.collectionView.contentSize.width-self.bounds.size.width) {
                
                self.collectionView.contentOffset=CGPointMake(self.bounds.size.width,self.collectionView.contentOffset.y);
                _pageControl.currentPage=0;
            }
            else if (self.collectionView.contentOffset.x<self.bounds.size.width) {
                self.collectionView.contentOffset=CGPointMake(self.collectionView.contentSize.width-(self.bounds.size.width*2),self.collectionView.contentOffset.y);
                _pageControl.currentPage=self.collectionView.contentOffset.x/self.bounds.size.width-1;
            }
            else{
                
            }

}


#pragma mark - collectionViewDatasource方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.picNumber + 2;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LhyRotationBoardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RotationBoardCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithWhite:0.900 alpha:1.000];
    LhyRotationBroadcastModel *model = [self.picArray objectAtIndex:indexPath.row];
    [cell.picImage sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    cell.labelTitel.text = model.title;
    return cell;
    
}

/* cell的点击方法 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    

    LhyRotationBroadcastModel *Model = [self.picArray objectAtIndex:indexPath.row];

    LhyRotationViewController *rotationVC = [[LhyRotationViewController alloc] init];
    /* 传值 */
    rotationVC.urlStr = Model.url;
    rotationVC.strTitle = Model.title;
    
    [[LhyMainViewController sharedMainVC].navigationController pushViewController:rotationVC animated:YES
     ];
    
    
    // 隐藏两个bar
    [[LhyMainViewController sharedMainVC].navigationController setNavigationBarHidden:YES animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTabbar" object:nil];
    
    [rotationVC release];
    
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.collectionView.contentOffset.x>=self.collectionView.contentSize.width-self.bounds.size.width) {
        self.collectionView.contentOffset=CGPointMake(self.bounds.size.width,self.collectionView.contentOffset.y);
        _pageControl.currentPage=0;
    }
    else if (self.collectionView.contentOffset.x<self.bounds.size.width) {
        self.collectionView.contentOffset=CGPointMake(self.collectionView.contentSize.width-(self.bounds.size.width*2),self.collectionView.contentOffset.y);
        _pageControl.currentPage=self.collectionView.contentOffset.x/self.bounds.size.width-1;
    }
    else{
        _pageControl.currentPage=self.collectionView.contentOffset.x/self.bounds.size.width-1;
    }
    
    self.pageControl.currentPage = self.collectionView.contentOffset.x / self.frame.size.width - 1;
    
    
}


@end
