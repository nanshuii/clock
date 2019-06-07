//
//  TimerViewController.h
//  timeClock
//
//  Created by 林南水 on 2019/6/7.
//  Copyright © 2019 ledon. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *timerView;

@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;


@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end

NS_ASSUME_NONNULL_END
