//
//  LENPublicHeader.h
//  timeClock
//
//  Created by 林南水 on 2019/5/31.
//  Copyright © 2019 ledon. All rights reserved.
//

#ifndef LENPublicHeader_h
#define LENPublicHeader_h


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
#define kTimeFormat @"kTimeFormat" 







#endif /* LENPublicHeader_h */
