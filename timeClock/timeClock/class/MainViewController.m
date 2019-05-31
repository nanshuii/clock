//
//  MainViewController.m
//  timeClock
//
//  Created by 林南水 on 2019/5/31.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (nonatomic, copy) NSString *hour;
@property (nonatomic, copy) NSString *minute;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL formatAll; // YES 24小时制 NO 12小时制

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpUI];
}

- (void)setUpUI{
    self.hourView.layer.cornerRadius = 10;
    self.minuteView.layer.cornerRadius = 10;
    [self getTimeFormat];
    self.formatAll = NO;
    [self getCurrentDate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(getCurrentDate) userInfo:nil repeats:YES];
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
    NSArray *dates = [dateString componentsSeparatedByString:@" "];
    NSString *dayString = dates[0];
    dayString = [NSString stringWithFormat:@"%@ %@", dayString, weekString];
    self.dateLabel.text = dayString;
    NSString *timeString = dates[1];
    NSArray *times = [timeString componentsSeparatedByString:@":"];
    NSString *hourString = times[0];
    NSString *minuteString = times[1];
    [self timeShow:hourString minute:minuteString];
}

# pragma mark -- 显示时间
- (void)timeShow:(NSString *)hour minute:(NSString *)minute{
    int hourValue = [hour intValue];
//    int minuteValue = [minute intValue];
    if (self.formatAll == NO) {
        // 标记上下午
        NSString *am = @"AM";
        if (hourValue >= 12) {
            am = @"PM";
            hourValue -= 12;
            NSString *hourString = [NSString stringWithFormat:@"%i", hourValue];
            if (hourValue < 9) {
                hourString = [NSString stringWithFormat:@"0%@", hourString];
                hour = hourString;
            }
        }
        NSString *string = self.dateLabel.text;
        self.dateLabel.text = [NSString stringWithFormat:@"%@ %@", string, am];
    }
    self.hour = hour;
    self.minute = minute;
    if (self.hour && self.minute) {
        self.hourLabel.text = hour;
        self.minuteLabel.text = minute;
    } else {
        self.hourLabel.text = hour;
        self.minuteLabel.text = minute;
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
