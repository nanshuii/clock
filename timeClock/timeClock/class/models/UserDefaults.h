//
//  UserDefaults.h
//  timeClock
//
//  Created by 林南水 on 2019/6/1.
//  Copyright © 2019 ledon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimerModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserDefaults : NSObject


/**
 获取24小时制；默认YES

 @return YES代表24小时 NO代表12小时
 */
+ (BOOL)getTimeFormat;

/**
 设置24小时制

 @param format YES代表24小时 NO代表12小时
 */
+ (void)setTimeFormat:(BOOL)format;

/**
 获取是否显示年月日；默认显示

 @return BOOL
 */
+ (BOOL)getShowYearMonthDay;

/**
 设置是否显示年月日

 @param show BOOL
 */
+ (void)setShowYearMonthDay:(BOOL)show;

/**
 获取是否显示上下午 默认YES

 @return BOOL
 */
+ (BOOL)getShowAm;

/**
 设置是否显示上下午

 @param show BOOL
 */
+ (void)setShowAm:(BOOL)show;

/**
 获取是否显示星期

 @return BOOL 默认YES
 */
+ (BOOL)getShowWeek;

/**
 设置是否显示星期

 @param show BOOL
 */
+ (void)setShowWeek:(BOOL)show;

/**
 获取计时器model

 @return return value description
 */
+ (TimerModel *)getTimerModel;

/**
 设置计时器model

 @param model model description
 */
+ (void)setTimerModel:(TimerModel *)model;

/**
 移除计时器model
 */
+ (void)deleteTimerModel;

/**
 获取是否显示定时器

 @return return value description
 */
+ (BOOL)getShowTimer;

/**
 设置是否显示定时器

 @param timer timer description
 */
+ (void)setShowTimer:(BOOL)timer;

@end

NS_ASSUME_NONNULL_END
