//
//  SettingTableViewCell.m
//  timeClock
//
//  Created by 林南水 on 2019/5/31.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "SettingTableViewCell.h"

@implementation SettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)bindWithImageName:(NSString *)name text:(NSString *)text on:(int)on{
    self.image.image = [UIImage imageNamed:name];
    self.text.text = text;
    if (on == 0) {
        self.on.hidden = NO;
        [self.on setOn:NO];
    } else if (on == 1) {
        self.on.hidden = NO;
        [self.on setOn:YES];
    } else {
        self.on.hidden = YES;
    }
}


- (IBAction)onChange:(UISwitch *)sender {
    if (_OnChangeBlock) {
        _OnChangeBlock(sender.on);
    }
}


@end
