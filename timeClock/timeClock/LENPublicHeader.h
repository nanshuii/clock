//
//  LENPublicHeader.h
//  timeClock
//
//  Created by 林南水 on 2019/5/31.
//  Copyright © 2019 ledon. All rights reserved.
//

#ifndef LENPublicHeader_h
#define LENPublicHeader_h


#define WEAKSELF(weakSelf)  __weak __typeof(&*self)weakSelf = self;

# pragma mark -- 屏幕参数
// 全屏的宽度
#define kFullScreenWidth           ([UIScreen mainScreen].bounds.size.width)
// 全屏的高度
#define kFullScreenHeight          ([UIScreen mainScreen].bounds.size.height)

#define kNavigationBarHeight        44.00f                               // 导航栏的高度 iOS11
#define kNavigationBarHeightBigger  64.00f                               // 导航栏的高度 iOS9 iOS10


# pragma mark -- 颜色转换
//色码转RGB UIColor
#undef UIColorFromHex
#define UIColorFromHex(hexValue) ([UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0x00FF00) >> 8))/255.0 blue:((float)(hexValue & 0x0000FF))/255.0 alpha:1.0])
//附带透明度
#undef UIColorFromHexA
#define UIColorFromHexA(hexValue,a) ([UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0x00FF00) >> 8))/255.0 blue:((float)(hexValue & 0x0000FF))/255.0 alpha:(a)])


# pragma mark -- 自定义的存储变量
#define kTimeFormat @"kTimeFormat"  // 24小时制 BOOL YES 24小时
#define KShowYearMonthDay @"KShowYearMonthDay" // 显示年月日
#define kShowAM @"kShowAM" // 显示上下午
#define kShowWeek @"kShowWeek" // 显示星期
#define kShowHourTiming @"kShowHourTiming" // 显示整点报时
#define kHourTiming @"kHourTiming" // 是否开启整点报时
#define KHourTimingHiddenType @"KHourTimingHiddenType" // 免到扰时间类型
#define kHourTimingIdentifier @"kHourTimingIdentifier" // 整点报时通知的identifier
#define kHourTimingHours @"kHourTimingHours" // 目前已经注册的时间通知


# pragma mark -- 自定义的通知时间
#define kMainViewControllerUpdate @"kMainViewControllerUpdate" // 主页的值发生变化




#endif /* LENPublicHeader_h */
