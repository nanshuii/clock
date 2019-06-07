//
//  NotificationManager.m
//  timeClock
//
//  Created by 林南水 on 2019/6/8.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "NotificationManager.h"
#import <UserNotifications/UserNotifications.h>

@implementation NotificationManager


# pragma mark -- 添加一个定时器通知
+ (void)addTimerNotificationWithModel:(TimerModel *)model{
    [self addNotificationWithTitle:@"定时器时间已到" subtitle:nil body:nil identifier:model.identifier repeat:NO time:model.remainingTime];
}

# pragma mark - 删除一个通知
+ (void)deleteTimerNotificaitonWithIdentifier:(NSString *)identifier{
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center removePendingNotificationRequestsWithIdentifiers:@[identifier]];
}

# pragma mark -- 添加一个延时通知
+ (void)addNotificationWithTitle:(NSString *)title subtitle:(NSString *)subtitle body:(NSString *)body identifier:(NSString *)identifier repeat:(BOOL)repeat time:(int)time{
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = title;
    content.subtitle = subtitle;
    content.body = body;
    content.sound = [UNNotificationSound defaultSound];
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:time repeats:repeat];
    UNNotificationRequest *notificationRequest = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
    // 4、将请求加入通知中心
    [center addNotificationRequest:notificationRequest withCompletionHandler:^(NSError * _Nullable error) {
        if (error == nil) {
            NSLog(@"已成功加推送%@",notificationRequest.identifier);
        } else {
            NSLog(@"error = %@", error);
        }
    }];
}

@end
