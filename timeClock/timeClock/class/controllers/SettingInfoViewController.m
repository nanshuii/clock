//
//  SettingInfoViewController.m
//  timeClock
//
//  Created by 林南水 on 2019/6/1.
//  Copyright © 2019 ledon. All rights reserved.
//

#import "SettingInfoViewController.h"
#import "SettingTableViewCell.h"

@interface SettingInfoViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) UITableView *tableView;

@property (nonatomic, strong) NSArray *texts;

@property (nonatomic, strong) NSArray *names;

@property (nonatomic, strong) NSMutableArray *ons;

@end

@implementation SettingInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpUI];
}

- (void)setUpUI{
    self.texts = @[@"显示年月日", @"显示上下午", @"显示星期"];
    self.names = @[@"setting", @"setting", @"setting"];
    self.ons = [NSMutableArray arrayWithCapacity:3];
    BOOL showYearMonthDay = [UserDefaults getShowYearMonthDay];
    if (showYearMonthDay) {
        [self.ons addObject:@(1)];
    } else {
        [self.ons addObject:@(0)];
    }
    BOOL timeFormat = [UserDefaults getTimeFormat];
    if (timeFormat) {
        [self.ons addObject:@(-1)];
    } else {
        BOOL showAm = [UserDefaults getShowAm];
        if (showAm) {
            [self.ons addObject:@(1)];
        } else {
            [self.ons addObject:@(0)];
        }
    }
    BOOL showWeek = [UserDefaults getShowWeek];
    if (showWeek) {
        [self.ons addObject:@(1)];
    } else {
        [self.ons addObject:@(0)];
    }
    [self.baseView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.baseView.mas_top);
        make.bottom.mas_equalTo(self.baseView.mas_bottom);
        make.left.mas_equalTo(self.baseView.mas_left);
        make.right.mas_equalTo(self.baseView.mas_right);
    }];
}

# pragma mark -- back
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
}

- (void)onChangeWith:(BOOL)on index:(NSInteger)index{
    if (index == 0) {
        // 年月日
        [UserDefaults setShowYearMonthDay:on];
        NSDictionary *dict = @{
                               @"type": @"yearMonthDay",
                               @"value": @(on),
                               };
        [[NSNotificationCenter defaultCenter] postNotificationName:kMainViewControllerUpdate object:dict];
    }
    else if (index == 1) {
        // 上下午
        [UserDefaults setShowAm:on];
        NSDictionary *dict = @{
                               @"type": @"am",
                               @"value": @(on),
                               };
        [[NSNotificationCenter defaultCenter] postNotificationName:kMainViewControllerUpdate object:dict];
    }
    else if (index == 2) {
        // 星期
        [UserDefaults setShowWeek:on];
        NSDictionary *dict = @{
                               @"type": @"week",
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
