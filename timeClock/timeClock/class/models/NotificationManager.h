//
//  NotificationManager.h
//  timeClock
//
//  Created by 林南水 on 2019/6/8.
//  Copyright © 2019 ledon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimerModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NotificationManager : NSObject

/**
 添加一个定时器通知

 @param model model description
 */
+ (void)addTimerNotificationWithModel:(TimerModel *)model;

/**
 删除一个定时器通知

 @param identifier identifier description
 */
+ (void)deleteTimerNotificaitonWithIdentifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
