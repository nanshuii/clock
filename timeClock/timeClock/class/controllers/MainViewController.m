//
//  MainViewController.m
//  timeClock
//
//  Created by 林南水 on 2019/5/31.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "MainViewController.h"
#import "SettingViewController.h"
#import "TimerViewController.h"

@interface MainViewController ()

@property (nonatomic, copy) NSString *hour;
@property (nonatomic, copy) NSString *minute;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL formatAll; // YES 24小时制 NO 12小时制
@property (nonatomic, assign) BOOL showYearMonthDay;
@property (nonatomic, assign) BOOL showAm;
@property (nonatomic, assign) BOOL showWeek;
@property (nonatomic, assign) BOOL showTimer;
@property (nonatomic, strong) NSTimer *timerTimer; // 定时器的定时器
@property (nonatomic, strong) TimerModel *timerModel;
@property (nonatomic, assign) int remainingTime;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(valueUpdate:) name:kMainViewControllerUpdate object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBecomeActive) name:kApplicationDidBecomeActive object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WillResignActive) name:kApplicationWillResignActive object:nil];
    [self setUpUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.showTimer = [UserDefaults getShowTimer];
    self.timerButton.hidden = !self.showTimer;
    if (self.showTimer) {
        [self timerInit];
    }
}

- (void)setUpUI{
    [self.navigationController setNavigationBarHidden:YES];
    self.hourView.layer.cornerRadius = 14;
    self.minuteView.layer.cornerRadius = 14;
    self.hour = @"xx";
    self.minute = @"xx";
    self.formatAll = [UserDefaults getTimeFormat];
    self.showYearMonthDay = [UserDefaults getShowYearMonthDay];
    self.showAm = [UserDefaults getShowAm];
    self.showWeek = [UserDefaults getShowWeek];
    [self getCurrentDate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(getCurrentDate) userInfo:nil repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self timerTimerStop];
}

# pragma mark -- 程序进入前台
- (void)didBecomeActive{
    NSLog(@"进入前台");
    self.showTimer = [UserDefaults getShowTimer];
    self.timerButton.hidden = !self.showTimer;
    if (self.showTimer) {
        [self timerInit];
    }
}

# pragma mark -- 进入前台
- (void)WillResignActive{
    [self timerTimerStop];
    [self.timerButton setTitle:nil forState:normal];
}

# pragma mark -- 获取时间格式
- (void)getTimeFormat{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults valueForKey:kTimeFormat]) {
        BOOL timeFormat = [[defaults valueForKey:kTimeFormat] boolValue];
        self.formatAll = timeFormat;
    } else {
        self.formatAll = YES;
    }
}

# pragma mark -- 获取当前时间
- (void)getCurrentDate{
    NSDate *date = [NSDate new];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    NSString *dateString = [formatter stringFromDate:date];
    NSArray *dates = [dateString componentsSeparatedByString:@" "];
    NSString *dayString = dates[0];
    if (self.showYearMonthDay) {
        self.dateLabel.text = dayString;
    } else {
        dayString = @"";
    }
    NSString *timeString = dates[1];
    NSArray *times = [timeString componentsSeparatedByString:@":"];
    NSString *hourString = times[0];
    NSString *minuteString = times[1];
    int hourValue = [hourString intValue];
    if (self.showWeek) {
        NSInteger week = [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:date] weekday];
        NSString *weekString = @" ";
        if (week == 1) {
            weekString = @"周日";
        }
        else if (week == 2) {
            weekString = @"周一";
        }
        else if (week == 3) {
            weekString = @"周二";
        }
        else if (week == 4) {
            weekString = @"周三";
        }
        else if (week == 5) {
            weekString = @"周四";
        }
        else if (week == 6) {
            weekString = @"周五";
        }
        else if (week == 7) {
            weekString = @"周六";
        }
        dayString = [NSString stringWithFormat:@"%@ %@", dayString, weekString];
        self.dateLabel.text = dayString;
    }
    if (self.formatAll == NO) {
        // 标记上下午
        NSString *am = @"AM";
        if (hourValue >= 12) {
            am = @"PM";
            hourValue -= 12;
            NSString *hourString = [NSString stringWithFormat:@"%i", hourValue];
            if (hourValue < 9) {
                hourString = [NSString stringWithFormat:@"0%@", hourString];
            }
        }
        if (self.showAm) {
            self.dateLabel.text = [NSString stringWithFormat:@"%@ %@", dayString, am];
        } else {
            if (self.showYearMonthDay == NO && self.showWeek == NO) {
                self.dateLabel.hidden = YES;
            }
        }
    } else {
        if (self.showYearMonthDay == NO && self.showWeek == NO) {
            self.dateLabel.hidden = YES;
        }
    }
    
    [self changeHour:hourString mintute:minuteString];
}

# pragma mark -- 时间跳动动画效果
- (void)changeHour:(NSString *)hourString mintute:(NSString *)minuteString{
    if (![self.hour isEqualToString:hourString]) {
        self.hour = hourString;
        [UIView transitionWithView:self.minuteView duration:1.0 options:(UIViewAnimationOptionTransitionCurlDown) animations:^{
            self.hourLabel.text = hourString;
        } completion:^(BOOL finished) {
            
        }];
    }
    if (![self.minute isEqualToString:minuteString]) {
        self.minute = minuteString;
        [UIView transitionWithView:self.minuteView duration:1.0 options:(UIViewAnimationOptionTransitionCurlDown) animations:^{
            self.minuteLabel.text = minuteString;
        } completion:^(BOOL finished) {
            
        }];
    }
}

# pragma mark -- 读取定时器model
- (void)timerInit{
    TimerModel *model = [UserDefaults getTimerModel];
    if (model) {
        // 比对date
        NSDate *date = [NSDate new];
        long timestamp = [date timeIntervalSince1970];
        long timestamp2 = [model.date timeIntervalSince1970];
        NSLog(@"timestamp = %li %li", timestamp, timestamp2);
        if (timestamp >= timestamp2) {
            [self timerTimerStop];
            [self.timerButton setTitle:nil forState:normal];
            [UserDefaults deleteTimerModel];
        } else {
            self.timerModel = model;
            self.remainingTime = model.remainingTime;
            [self timerTimerCreate];
        }
    } else {
        [self.timerButton setTitle:nil forState:normal];
    }
}

- (void)timerTimerCreate{
    if (!_timerTimer) {
        _timerTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTimerAction) userInfo:nil repeats:YES];
    }
}

- (void)timerTimerAction{
    NSLog(@"remain time = %i", self.remainingTime);
    self.remainingTime--;
    if (self.remainingTime == 0) {
        [self timerTimerStop];
        [self.timerButton setTitle:nil forState:normal];
        [UserDefaults deleteTimerModel];
        return;
    }
    NSInteger time = self.remainingTime;
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
    NSString *timeString = [NSString stringWithFormat:@"%@:%@:%@", hourString, minuteString, secondString];
    [self.timerButton setTitle:timeString forState:normal];
    [self saveModel];
}

- (void)saveModel{
    self.timerModel.remainingTime = self.remainingTime;
    [UserDefaults setTimerModel:self.timerModel];
}

- (void)timerTimerStop{
    if (_timerTimer) {
        [_timerTimer invalidate];
        _timerTimer = nil;
    }
}


# pragma mark -- value update
- (void)valueUpdate:(NSNotification *)noti{
    NSDictionary *dict = noti.object;
    NSString *type = [dict valueForKey:@"type"];
    BOOL value = [[dict valueForKey:@"value"] boolValue];
    if (type) {
        if ([type isEqualToString:@"timeFormat"]) {
            self.formatAll = value;
        }
        else if ([type isEqualToString:@"am"]) {
            self.showAm = value;
        }
        else if ([type isEqualToString:@"week"]) {
            self.showWeek = value;
        }
        else if ([type isEqualToString:@"yearMonthDay"]) {
            self.showYearMonthDay = value;
        }
        else if ([type isEqualToString:@"timer"]) {
            self.showTimer = value;
            if (value) {
                [self.timerButton setTitle:nil forState:normal];
            }
        }
    }
}

# pragma mark -- 前往设置页面
- (IBAction)toSetting:(id)sender {
    SettingViewController *vc = [SettingViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

# pragma mark -- 前往定时器页面
- (IBAction)toTimer:(id)sender {
    TimerViewController *vc = [TimerViewController new];
    [self.navigationController pushViewController:vc animated:YES];
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
