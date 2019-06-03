//
//  SettingTableViewCell.h
//  timeClock
//
//  Created by 林南水 on 2019/5/31.
//  Copyright © 2019 ledon. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingTableViewCell : UITableViewCell

@property (nonatomic, copy) void (^OnChangeBlock)(BOOL on);

@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UILabel *text;

@property (weak, nonatomic) IBOutlet UISwitch *on;

/**
 写入数据

 @param name 图片名字
 @param text 标题
 @param on 0 关 1 开 其他隐藏
 */
- (void)bindWithImageName:(NSString *)name text:(NSString *)text on:(int)on;

@end

NS_ASSUME_NONNULL_END
