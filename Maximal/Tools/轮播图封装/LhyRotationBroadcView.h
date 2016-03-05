//
//  LhyRotationBroadcView.h
//  Maximal
//
//  Created by 李宏远 on 15/11/7.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LhyRotationBroadcastModel;

@interface LhyRotationBroadcView : UIView


- (instancetype)initWithFrame:(CGRect)frame modelArray:(NSMutableArray *)modelArr;

- (void)openTimerWithDuration:(NSTimeInterval)duration;


@end
