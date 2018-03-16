//
//  YZXAnnualReportView.m
//  Replenishment
//
//  Created by 尹星 on 2017/6/30.
//  Copyright © 2017年 ruwang. All rights reserved.
//

#import "YZXAnnualReportView.h"
#import "YZXDateModel.h"

@interface YZXAnnualReportView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView             *tableView;
@property (nonatomic, copy) NSArray <YZXDateModel *>  *dataSource;
@property (nonatomic, strong) YZXDateModel            *model;

@end

static const CGFloat cell_height = 30.0;

@implementation YZXAnnualReportView {
    NSString *_startDateString;
    NSString *_endDateString;
}

- (instancetype)initWithFrame:(CGRect)frame
          withStartDateString:(NSString *)startDateString
                endDateString:(NSString *)endDateString
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        if (startDateString.length < 5 || endDateString.length < 5) {
            errorLog(@"--------------日期格式错误(正确格式：yyyy年)----------------");
        }
        _startDateString = [startDateString substringWithRange:NSMakeRange(0, 5)];
        _endDateString = [endDateString substringWithRange:NSMakeRange(0, 5)];
        [self p_initData];
        [self p_initView];
    }
    return self;
}

- (void)p_initData
{
    self.dataSource = [NSArray array];
    NSDateFormatter *formatter = YZXCalendarHelper.helper.yearFormatter;
    NSDate *startDate = [formatter dateFromString:_startDateString];
    NSDate *endDate = [formatter dateFromString:_endDateString];
    self.dataSource = [self.model achieveYearDateModelWithDate:startDate toDate:endDate];
    
}

- (void)p_initView
{
    [self addSubview:self.tableView];
}

#pragma mark - <UITabBarDelegate,UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cell_height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    self.dataSource[indexPath.row].indexPath = indexPath;
    cell.textLabel.text = self.dataSource[indexPath.row].year;
    cell.textLabel.font = FONT15;
    cell.tintColor = CustomRedColor;
    if (self.dataSource[indexPath.row].isSelected) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.textLabel.textColor = CustomRedColor;
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textColor = CustomBlackColor;
    }
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    cell.selectionStyle = NO;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedYear = nil;
    [self.dataSource enumerateObjectsUsingBlock:^(YZXDateModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isSelected) {
            obj.isSelected = NO;
            [self.tableView reloadRowsAtIndexPaths:@[obj.indexPath] withRowAnimation:UITableViewRowAnimationNone];
            *stop = YES;
        }
    }];
    
    self.dataSource[indexPath.row].isSelected = YES;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    if (_delegate && [_delegate respondsToSelector:@selector(clickTheYear:)]) {
        [_delegate clickTheYear:self.dataSource[indexPath.row].year];
    }
}

#pragma mark - setter
- (void)setSelectedYear:(NSString *)selectedYear
{
    if (selectedYear.length < 5) {
        errorLog(@"--------------日期格式错误(正确格式：yyyy年)----------------");
    }
    
    _selectedYear = [selectedYear substringWithRange:NSMakeRange(0, 5)];
    
    if (!_selectedYear) {
        return;
    }
    
    __block NSInteger row = 0;
    [self.dataSource enumerateObjectsUsingBlock:^(YZXDateModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //将默认选中的年份取消
        if (obj.isSelected) {
            obj.isSelected = NO;
        }
        //设置传入年份model的isSelected为YES
        if (self.selectedYear && [obj.year isEqualToString:self.selectedYear]) {
            row = idx;
            obj.isSelected = YES;
            self.selectedYear = nil;
        }
    }];
    [self.tableView reloadData];
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

#pragma mark - 懒加载
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = CustomLineColor;
        _tableView.separatorColor = CustomLineColor;
    }
    return _tableView;
}

- (YZXDateModel *)model
{
    if (!_model) {
        _model = [[YZXDateModel alloc] init];
    }
    return _model;
}

@end
