//
//  TimerModel.h
//  timeClock
//
//  Created by 林南水 on 2019/6/7.
//  Copyright © 2019 ledon. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface TimerModel : NSObject

@property (nonatomic, assign) BOOL open; // 是否开启

@property (nonatomic, assign) int remainingTime; // 剩余时间

@property (nonatomic, assign) int allTime;

@property (nonatomic, strong) NSDate *date;

@property (nonatomic, copy) NSString *identifier; // identifier



@end

NS_ASSUME_NONNULL_END
