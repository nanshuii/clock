//
//  MainViewController.h
//  timeClock
//
//  Created by 林南水 on 2019/5/31.
//  Copyright © 2019 ledon. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainViewController : UIViewController

// 中间的时间文字
@property (weak, nonatomic) IBOutlet UIView *hourView;
@property (weak, nonatomic) IBOutlet UILabel *hourLabel;
@property (weak, nonatomic) IBOutlet UIView *minuteView;
@property (weak, nonatomic) IBOutlet UILabel *minuteLabel;

// 当前年月日
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

// 定时器按钮
@property (weak, nonatomic) IBOutlet UIButton *timerButton;


@end

NS_ASSUME_NONNULL_END
