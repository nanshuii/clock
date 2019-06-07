//
//  TimerViewController.m
//  timeClock
//
//  Created by 林南水 on 2019/6/7.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "TimerViewController.h"
#import "TimerModel.h"
#import "LENCycleProgressView.h"
#import "NotificationManager.h"

@interface TimerViewController ()

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) int currentTime;

@property (nonatomic, assign) int allTime;

@property (nonatomic, strong) LENCycleProgressView *progressView;

@property (nonatomic, assign) BOOL pause;

@property (nonatomic, strong) TimerModel *timerModel;

@property (nonatomic, strong) NSDate *date;

@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toRoot) name:kApplicationWillResignActive object:nil];
    [self setUpUI];
}

- (void)setUpUI{
    self.progressView = [[LENCycleProgressView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    [self.timerView addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.timerView.mas_centerX);
        make.centerY.mas_equalTo(self.timerView.mas_centerY);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(300);
    }];
    TimerModel *model = [UserDefaults getTimerModel];
    if (model) {
        BOOL open = model.open;
        if (open) {
            [self.startButton setTitle:@"暂停" forState:normal];
            [self timerCreate];
        } else {
            self.pause = YES;
        }
        NSLog(@"dict = %@", [model mj_keyValues]);
        self.timerLabel.hidden = NO;
        self.timePicker.hidden = YES;
        self.allTime = model.allTime;
        self.currentTime = model.allTime - model.remainingTime;
        [self progressAnimation];
        self.timerModel = model;
    } else {
        self.progressView.hidden = YES;
        [self setPickerValue];
        self.cancelButton.enabled = NO;
    }
}

# pragma mark -- back
- (IBAction)back:(id)sender {
    [self timerStop];
    [self.navigationController popViewControllerAnimated:YES];
}

# pragma mark -- toRoot
- (void)toRoot{
    [self timerStop];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

# pragma mark -- 设置picker的值
- (void)setPickerValue{
    NSDate *date = [NSDate new];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [formatter stringFromDate:date];
    NSArray *dates = [dateString componentsSeparatedByString:@" "];
    NSString *ymd = dates[0];
    NSString *string = [NSString stringWithFormat:@"%@ 00:01:00", ymd];
    NSDate *currentDate = [formatter dateFromString:string];
    self.timePicker.date = currentDate;
}

# pragma mark -- 开始 暂停 取消
- (IBAction)startAction:(UIButton *)sender {
    NSLog(@"date = %@", self.timePicker.date);
    if ([sender.titleLabel.text isEqualToString:@"开始"]) {
        // 开始
        if (self.pause) {
            [self timerCreate];
            [self.startButton setTitle:@"暂停" forState:normal];
            self.pause = NO;
            [self saveModel];
            [NotificationManager addTimerNotificationWithModel:self.timerModel];
        } else {
            NSDate *date = self.timePicker.date;
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"HH:mm:ss"];
            NSString *dateString = [formatter stringFromDate:date];
            NSArray *dates = [dateString componentsSeparatedByString:@":"];
            NSString *hourString = dates[0];
            int hour = [hourString intValue];
            NSString *minuteString = dates[1];
            int minute = [minuteString intValue];
            self.allTime = hour * 3600 + minute *60;
            self.currentTime = 0;
            [self.progressView circleAnimationWithValue:0];
            [self timerCreate];
            [self.startButton setTitle:@"暂停" forState:normal];
            self.cancelButton.enabled = YES;
            self.timerLabel.hidden = NO;
            self.timePicker.hidden = YES;
            self.progressView.hidden = NO;
            //
            NSDate *currentDate = [NSDate new];
            self.date = [NSDate dateWithTimeInterval:self.allTime sinceDate:currentDate];
            [self saveModel];
            [NotificationManager addTimerNotificationWithModel:self.timerModel];
        }
    } else {
        // 暂停
        [self timerStop];
        [self.startButton setTitle:@"开始" forState:normal];
        self.pause = YES;
        [self saveModel];
        [NotificationManager deleteTimerNotificaitonWithIdentifier:kTimerIdentifier];
    }
}

- (IBAction)cancelAction:(UIButton *)sender {
    [self stop];
    [NotificationManager deleteTimerNotificaitonWithIdentifier:kTimerIdentifier];
}

# pragma mark -- 添加Model
- (void)saveModel{
    TimerModel * model = [TimerModel new];
    model.allTime = self.allTime;
    model.remainingTime = self.allTime - self.currentTime;
    model.identifier = kTimerIdentifier;
    model.open = !self.pause;
    model.date = self.date;
    [UserDefaults setTimerModel:model];
    self.timerModel = model;
}

# pragma mark -- 结束计时器
- (void)stop{
    self.cancelButton.enabled = NO;
    [self.startButton setTitle:@"开始" forState:(UIControlStateNormal)];
    self.pause = NO;
    self.currentTime = 0;
    self.allTime = 0;
    self.timerLabel.hidden = YES;
    self.progressView.hidden = YES;
    self.timePicker.hidden = NO;
    [self timerStop];
    [UserDefaults deleteTimerModel];
    self.timerModel = nil;
    [self setPickerValue];
    self.date = nil;
}

# pragma mark -- timer
- (void)timerCreate{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    }
}

- (void)timerAction{
    self.currentTime += 1;
    [self progressAnimation];
    [self saveModel];
    if (self.currentTime >= self.allTime) {
        [self stop];
    }
}

- (void)timerStop{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)progressAnimation{
    NSString *timeString = [self timeStringSetting];
    self.timerLabel.text = timeString;
    CGFloat single = 864000000 / self.allTime;
    CGFloat value = single * self.currentTime / 864000000;
    NSLog(@"value = %f", value);
    [self.progressView circleAnimationWithValue:value];
}

- (NSString *)timeStringSetting{
    NSInteger time = self.allTime - self.currentTime;
    NSInteger hour = time / 60 / 60;
    NSString *hourString = [NSString stringWithFormat:@"%li", (long)hour];
    if (hour < 10) {
        hourString = [NSString stringWithFormat:@"0%@", hourString];
    }
    NSInteger time2 = time - hour * 60 * 60;
    NSInteger minute = time2 / 60;
    NSString *minuteString = [NSString stringWithFormat:@"%li", (long)minute];
    if (minute < 10) {
        minuteString = [NSString stringWithFormat:@"0%@", minuteString];
    }
    NSInteger second = time2 % 60;
    NSString *secondString = [NSString stringWithFormat:@"%li", (long)second];
    if (second < 10) {
        secondString = [NSString stringWithFormat:@"0%@", secondString];
    }
    if (hour > 0) {
        NSString *timeString = [NSString stringWithFormat:@"%@:%@:%@", hourString, minuteString, secondString];
        return timeString;
    } else {
        NSString *timeString = [NSString stringWithFormat:@"%@:%@", minuteString, secondString];
        return timeString;
    }
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
