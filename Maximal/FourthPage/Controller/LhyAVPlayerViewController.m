
//
//  LhyAVPlayerViewController.m
//  Maximal
//
//  Created by 李宏远 on 15/11/21.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyAVPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "LhyAVPlayerViewController.h"

#import "LhyCommunityViewController.h"


@interface LhyAVPlayerViewController ()

@property(nonatomic, retain)AVPlayer *player;
@property(nonatomic, retain)AVPlayerItem *playeItem;
@property(nonatomic ,retain)AVPlayerLayer *playerlayer;
@property(nonatomic, retain)UIView *backView;
@property(nonatomic, retain)UIView *topView;
@property(nonatomic, retain)UIProgressView *progressView; // 进度条
@property(nonatomic, retain)UISlider *slider; // 滑动条
@property(nonatomic, retain)UILabel *currentTimeLabel;
@property(nonatomic, retain)UILabel *totalTimeLAbel;
@property(nonatomic, retain)UIActivityIndicatorView *activityView;
@property(nonatomic, retain)UIButton *startButton;
@property(nonatomic, retain)UIButton *buttonOff;
@property(nonatomic, retain)UILabel *labelTitle;

@property(nonatomic, assign)CGFloat height;
@property(nonatomic, assign)CGFloat width;

@end

@interface LhyAVPlayerViewController ()

@end

@implementation LhyAVPlayerViewController

#pragma mark - dealloc方法
- (void)dealloc {
    
    [_titleStr release];
    [_urlStr release];
    
    [_player release];
    [_playeItem release];
    [_playerlayer release];
    [_backView release];
    [_topView release];
    [_progressView release];
    [_slider release];
    
    [_activityView release];
    [_totalTimeLAbel release];
    [_currentTimeLabel release];
    [_labelTitle release];
    [super dealloc];
    
}



#pragma mark - 页面加载完成
- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    [self beginToPlay];
    /* 方法调用 */
    [self createProgressView];
    [self createSlider];
    [self createCurrentTimeLabel];
    [self creataButton];
    [self createTitle];

    [self createButtonOff];
    [self createGuseter];
    
}



#pragma mark - 播放方法
- (void)beginToPlay{
    
    _height = self.view.frame.size.width;
    _width = self.view.frame.size.height;
  
    self.playeItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.urlStr]];
    self.player = [AVPlayer playerWithPlayerItem:self.playeItem];
    
    self.playerlayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerlayer.frame = CGRectMake(0, 0, _width, _height);
    self.playerlayer.videoGravity = AVLayerVideoGravityResize;
    self.playerlayer.backgroundColor = [UIColor blackColor].CGColor;
    [self.view.layer addSublayer:self.playerlayer];
    [self.player play];
    
    /* 播放完成的通知 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEndPlayVideo:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
    
    /* backVIew */
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _width, _height)];
    self.backView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.backView];
    self.backView.userInteractionEnabled  =YES;
    [self.backView release];
    
    
    /* topView */
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _width, _height * 0.15)];
    self.topView.backgroundColor = [UIColor blackColor];
    self.topView.alpha = 0.5;
    [self.backView addSubview:self.topView];
    [self.topView release];
    
    
    /* 系统加载菊花 */
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.activityView.center = self.backView.center;
    [self.view addSubview:self.activityView];
    [self.activityView startAnimating];
    [self.activityView release];
    
        /* backView自动消失, 延迟线程 */
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
            [UIView animateWithDuration:0.5 animations:^{
                self.backView.alpha = 0;
            }];
    
        });
    
    /* 计时器 */
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(changeWithTime) userInfo:nil repeats:YES];
    
}

#pragma mark - 横屏代码
- (BOOL)shouldAutorotate{
    return YES;
} //NS_AVAILABLE_IOS(6_0);当前viewcontroller是否支持转屏

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskLandscape;
} //当前viewcontroller支持哪些转屏方向

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeRight;
}

- (BOOL)prefersStatusBarHidden
{
    return NO; // 返回NO表示要显示，返回YES将hiden
}




#pragma mark -创建progressView
- (void)createProgressView {
    
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(52, 352, _width * 0.77, 15)];
    [self.backView addSubview:self.progressView];
    [self.progressView release];
    
}

#pragma mark - 创建UISlider
- (void)createSlider {
    
    self.slider = [[UISlider alloc] initWithFrame:CGRectMake(self.progressView.frame.origin.x - 2, self.progressView.frame.origin.y - 7, _width * 0.78, 15)];
    [self.backView addSubview:self.slider];
    [self.slider setThumbImage:[UIImage imageNamed:@"iconfont-yuan副本"] forState:UIControlStateNormal];
    /* 滑动方法 */
    [self.slider addTarget:self action:@selector(progressSlider:) forControlEvents:UIControlEventValueChanged];
    [self.slider release];
    
}

#pragma mark - 滑动事件实现
- (void)progressSlider:(UISlider *)slider {
    /* 拖动来改变视频进度 */
    if (self.player.status == AVPlayerStatusReadyToPlay) {
        /* 总时间 */
        CGFloat totalTime = self.playeItem.duration.value / self.playeItem.duration.timescale;

        /* 拖动的秒数 */
        NSInteger dragSecond = floorf(totalTime * self.slider.value); //求小于本身的最大整数
        NSLog(@"%ld", dragSecond);
        
        /* 需要转成CMTime类型 */
        CMTime dragCMTime = CMTimeMake(dragSecond, 1);
        /* 播放暂停 */
        [self.player pause];
        
        /* 跳转播放进度 */
        [self.player seekToTime:dragCMTime completionHandler:^(BOOL finished) {
            [self.player play];
        }];
    }
    
}


#pragma mark - 当前播放时间label
- (void)createCurrentTimeLabel {
    
    self.currentTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_width *0.86 +5, self.slider.frame.origin.y - 3, 100, 20)];
    [self.backView addSubview:self.currentTimeLabel];
    self.currentTimeLabel.textColor = [UIColor whiteColor];
    self.currentTimeLabel.font = [UIFont systemFontOfSize:13];
    self.currentTimeLabel.text = @"00:00/00:00";
    [self.currentTimeLabel release];
}


#pragma mark - 计时器方法
- (void)changeWithTime {
    
    if (self.playeItem.duration.timescale != 0) {
        
        /* 更改总进度条和当前进度条进度 */
        self.slider.maximumValue = 1;
        self.slider.value = CMTimeGetSeconds([self.playeItem currentTime]) / (self.playeItem.duration.value / _playeItem.duration.timescale);
        
        /* 当前时间进度 */
        NSInteger currentMin = (NSInteger)CMTimeGetSeconds([self.playeItem currentTime]) / 60;
        NSInteger currentSecond = (NSInteger)CMTimeGetSeconds([self.playeItem currentTime]) % 60;
        
        /* 总时长 */
        NSInteger totalMin = (NSInteger)self.playeItem.duration.value / self.playeItem.duration.timescale / 60;
        NSInteger totalSecond = (NSInteger)self.playeItem.duration.value / self.playeItem.duration.timescale % 60;
        
        self.currentTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld / %02ld:%02ld", currentMin, currentSecond, totalMin, totalSecond];
    }
    if (self.player.status == AVPlayerStatusReadyToPlay) {
        
        [self.activityView stopAnimating];
    } else {
        
        [self.activityView startAnimating];
    }
    
    
}

#pragma mark - 播放和下一首按钮
- (void)creataButton {
    
    self.startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.startButton.frame = CGRectMake(12, self.playerlayer.frame.size.height - 40, 30, 30);
    [self.backView addSubview:self.startButton];
    if (self.player.rate == 1) {
        [self.startButton setImage:[UIImage imageNamed:@"pauseBtn"] forState:UIControlStateNormal];
    } else {
        [self.startButton setImage:[UIImage imageNamed:@"playBtn"] forState:UIControlStateNormal];
    }
    [self.startButton addTarget:self action:@selector(handleStart:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 创建TieleLabel
- (void)createTitle
{
    self.labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(20, 25, _width - 40, 20)];
    [self.backView addSubview:self.labelTitle];
    self.labelTitle.textColor = [UIColor whiteColor];
    self.labelTitle.font = [UIFont boldSystemFontOfSize:17];
    self.labelTitle.text = self.titleStr;
    self.labelTitle.textAlignment = NSTextAlignmentCenter;
    [self.labelTitle release];
}

/* 按钮点击方法 */

- (void)handleStart:(UIButton *)button {
    
    if (button.selected) {
        [self.player play];
        [self.startButton setImage:[UIImage imageNamed:@"pauseBtn"] forState:UIControlStateNormal];
        
    } else {
        [self.player pause];
        [self.startButton setImage:[UIImage imageNamed:@"playBtn"] forState:UIControlStateNormal];
    }
    button.selected = !button.selected;
    
}

#pragma mark - 轻拍手势创建
- (void)createGuseter {
    
    /* 创建手势 */
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tap];
    [tap release];
    
}
/* 轻拍手势处理方法 */
- (void)tapAction:(UITapGestureRecognizer *)tap {
    if (self.backView.alpha == 1) {
        [UIView animateWithDuration:0.5 animations:^{
            self.backView.alpha = 0;
        }];
    } else if (self.backView.alpha != 1) {
        [UIView animateWithDuration:0.5 animations:^{
            self.backView.alpha = 1;
        }];
    }
    
    if (self.backView.alpha == 1) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.8 animations:^{
                
                self.backView.alpha = 0;
            }];
            
        });
        
    }
    
}

#pragma mark - 返回按钮
- (void)createButtonOff {
    
    self.buttonOff = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.buttonOff setImage:[UIImage imageNamed:@"circle_icon_back"] forState:UIControlStateNormal];
    self.buttonOff.frame = CGRectMake(10, 15, 40, 40);
    [self.backView addSubview:self.buttonOff];
    [self.buttonOff addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)backButtonAction {

    [self.player pause];
    [[LhyCommunityViewController sharedMainVC]dismissViewControllerAnimated:YES completion:^{
        
    }];
}

/* 完成播放通知 */
- (void)didEndPlayVideo:(id)sender {
    
    [[LhyCommunityViewController sharedMainVC]dismissViewControllerAnimated:YES completion:^{
        
    }];
    
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
