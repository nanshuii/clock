//
//  UserDefaults.m
//  timeClock
//
//  Created by 林南水 on 2019/6/1.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "UserDefaults.h"

@implementation UserDefaults

/**
 获取24小时制
 
 @return YES代表24小时 NO代表12小时
 */
+ (BOOL)getTimeFormat{
    BOOL format = YES;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults valueForKey:kTimeFormat]) {
        format = [[defaults valueForKey:kTimeFormat] boolValue];
    }
    return format;
}

/**
 设置24小时制
 
 @param format YES代表24小时 NO代表12小时
 */
+ (void)setTimeFormat:(BOOL)format{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:[NSNumber numberWithBool:format] forKey:kTimeFormat];
    [defaults synchronize];
}

/**
 获取是否显示年月日；默认显示
 
 @return BOOL
 */
+ (BOOL)getShowYearMonthDay{
    BOOL show = YES;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults valueForKey:KShowYearMonthDay]) {
        show = [[defaults valueForKey:KShowYearMonthDay] boolValue];
    }
    return show;
}

/**
 设置是否显示年月日
 
 @param show BOOL
 */
+ (void)setShowYearMonthDay:(BOOL)show{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:[NSNumber numberWithBool:show] forKey:KShowYearMonthDay];
    [defaults synchronize];
}

/**
 获取是否显示上下午
 
 @return BOOL
 */
+ (BOOL)getShowAm{
    BOOL show = YES;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults valueForKey:kShowAM]) {
        show = [[defaults valueForKey:kShowAM] boolValue];
    }
    return show;
}

/**
 设置是否显示上下午
 
 @param show BOOL
 */
+ (void)setShowAm:(BOOL)show{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:[NSNumber numberWithBool:show] forKey:kShowAM];
    [defaults synchronize];
}

/**
 获取是否显示星期
 
 @return BOOL
 */
+ (BOOL)getShowWeek{
    BOOL show = YES;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults valueForKey:kShowWeek]) {
        show = [[defaults valueForKey:kShowWeek] boolValue];
    }
    return show;
}

/**
 设置是否显示星期
 
 @param show BOOL
 */
+ (void)setShowWeek:(BOOL)show{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:[NSNumber numberWithBool:show] forKey:kShowWeek];
    [defaults synchronize];
}

/**
 获取计时器model
 
 @return return value description
 */
+ (TimerModel *)getTimerModel{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults valueForKey:kTimerModel]) {
        NSDictionary *dict = [defaults valueForKey:kTimerModel];
        TimerModel *model = [TimerModel mj_objectWithKeyValues:dict];
        return model;
    } else {
        return nil;
    }
}

/**
 设置计时器model
 
 @param model model description
 */
+ (void)setTimerModel:(TimerModel *)model{
    NSDictionary *dict = [model mj_keyValues];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:dict forKey:kTimerModel];
    [defaults synchronize];
}

/**
 移除计时器model
 */
+ (void)deleteTimerModel{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:kTimerModel];
    [defaults synchronize];
}

/**
 获取是否显示定时器
 
 @return return value description
 */
+ (BOOL)getShowTimer{
    BOOL show = YES;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults valueForKey:kShowTimer]) {
        show = [[defaults valueForKey:kShowTimer] boolValue];
    }
    return show;
}

/**
 设置是否显示定时器
 
 @param timer timer description
 */
+ (void)setShowTimer:(BOOL)timer{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:[NSNumber numberWithBool:timer] forKey:kShowTimer];
    [defaults synchronize];
}


@end
