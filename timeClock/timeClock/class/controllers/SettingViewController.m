//
//  SettingViewController.m
//  timeClock
//
//  Created by 林南水 on 2019/5/31.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"
#import "SettingInfoViewController.h"
#import "TimeClockViewController.h"

@interface SettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) UITableView *tableView;

@property (nonatomic, strong) NSArray *texts;

@property (nonatomic, strong) NSArray *names;

@property (nonatomic, strong) NSMutableArray *ons;

@property (nonatomic, assign) BOOL timeFormat;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpUI];
}

- (void)setUpUI{
    self.texts = @[@"页面设置", @"24小时制",  @"报时设置"];
    self.names = @[@"setting", @"setting", @"setting"];
    self.ons = [NSMutableArray arrayWithCapacity:3];
    [self.ons addObject:@(-1)];
    self.timeFormat = [UserDefaults getTimeFormat];
    if (self.timeFormat) {
        [self.ons addObject:@(1)];
    } else {
        [self.ons addObject:@(0)];
    }
    [self.ons addObject:@(-1)];
    [self.baseView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.baseView.mas_top);
        make.bottom.mas_equalTo(self.baseView.mas_bottom);
        make.left.mas_equalTo(self.baseView.mas_left);
        make.right.mas_equalTo(self.baseView.mas_right);
    }];
}

# pragma mark -- 返回
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

# pragma mark -- tableView
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 200, 200) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"SettingTableViewCell" bundle:nil] forCellReuseIdentifier:@"SettingTableViewCell"];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.texts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WEAKSELF(weakSelf);
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingTableViewCell" forIndexPath:indexPath];
    [cell bindWithImageName:self.names[indexPath.row] text:self.texts[indexPath.row] on:[self.ons[indexPath.row] intValue]];
    [cell setOnChangeBlock:^(BOOL on) {
        [weakSelf onChangeWith:on index:indexPath.row];
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 0) {
        SettingInfoViewController *vc = [SettingInfoViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.section == 0 && indexPath.row == 2) {
        TimeClockViewController *vc = [TimeClockViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)onChangeWith:(BOOL)on index:(NSInteger)index{
    if (index == 1) {
        // 时间格式
        self.timeFormat = on;
        [UserDefaults setTimeFormat:on];
        NSDictionary *dict = @{
                               @"type": @"timeFormat",
                               @"value": @(on),
                               };
        [[NSNotificationCenter defaultCenter] postNotificationName:kMainViewControllerUpdate object:dict];
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
