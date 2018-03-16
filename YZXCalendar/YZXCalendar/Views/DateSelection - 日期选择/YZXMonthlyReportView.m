//
//  YZXMonthlyReportView.m
//  Replenishment
//
//  Created by 尹星 on 2017/6/30.
//  Copyright © 2017年 ruwang. All rights reserved.
//

#import "YZXMonthlyReportView.h"
#import "YZXDateModel.h"
#import "YZXMonthTableViewHeaderView.h"

#import "YZXMonthModel.h"

#define self_width self.bounds.size.width
#define self_height self.bounds.size.height
#define yearTableView_width self_width / 4.0
#define monthTableView_width self_width - yearTableView_width

static const CGFloat header_height = 20.0;
static const CGFloat cell_height = 30.0;
static const CGFloat lineView_width = 0.5;

@interface YZXMonthlyReportView ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) UITableView             *yearTableView;
@property (nonatomic, strong) UITableView             *monthTableView;
@property (nonatomic, strong) YZXMonthTableViewHeaderView *headerView;

@property (nonatomic, copy) NSArray <YZXDateModel *>             *dataSource;

@property (nonatomic, strong) YZXDateModel            *model;

@end

@implementation YZXMonthlyReportView {
    NSString *_startDateString;
    NSString *_endDateString;
    BOOL     _isScrollDown;
}

- (instancetype)initWithFrame:(CGRect)frame withStartDateString:(NSString *)startDateString endDateString:(NSString *)endDateString
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        if (startDateString.length < 8 || endDateString.length < 8) {
            errorLog(@"--------------日期格式错误(正确格式:yyyy年MM月)----------------");
        }
        _startDateString = [startDateString substringWithRange:NSMakeRange(0, 8)];
        _endDateString = [endDateString substringWithRange:NSMakeRange(0, 8)];
        [self p_initData];
        [self p_initView];
    }
    return self;
}

- (void)p_initData
{
    _isScrollDown = YES;
    self.dataSource = [NSArray array];

    NSDateFormatter *formatter = [YZXCalendarHelper createFormatterWithDateFormat:@"yyyy年MM月"];
    NSDate *startDate = [formatter dateFromString:_startDateString];
    NSDate *endDate = [formatter dateFromString:_endDateString];
    //获取两个时间段之间的所有年月份信息
    self.dataSource = [self.model achieveMonthDateModelWithDate:startDate toDate:endDate];
}

- (void)p_initView
{
    [self addSubview:self.yearTableView];
    [self addSubview:self.monthTableView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(yearTableView_width, 0, lineView_width, self_height)];
    lineView.backgroundColor = [UIColor colorWithRed:200 / 255.0 green:200 / 255.0 blue:200 / 255.0 alpha:1];
    [self addSubview:lineView];
}

#pragma mark - <UITabBarDelegate,UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.yearTableView) {
        return 1;
    }else {
        return self.dataSource.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.yearTableView) {
        return self.dataSource.count;
    }else {
        return self.dataSource[section].months.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section > 0) {
        return header_height;
    }
    return 0.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == self.monthTableView && section > 0) {
        YZXMonthTableViewHeaderView *headerView = [[YZXMonthTableViewHeaderView alloc] initWithFrame:CGRectMake(0, 0, self_width, header_height) withText:self.dataSource[section].year];
        return headerView;
    }
    return nil;
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
    if (tableView == self.yearTableView) {
        self.dataSource[indexPath.row].indexPath = indexPath;
        cell.textLabel.text = self.dataSource[indexPath.row].year;
        cell.textLabel.font = FONT15;
        if (self.dataSource[indexPath.row].isSelected) {
            cell.textLabel.textColor = CustomRedColor;
        }else {
            cell.textLabel.textColor = CustomBlackColor;
        }
    }else {
        cell.tintColor = CustomRedColor;
        cell.textLabel.text = self.dataSource[indexPath.section].months[indexPath.row].month;
        cell.textLabel.font = FONT15;
        self.dataSource[indexPath.section].months[indexPath.row].indexPath = indexPath;
        //为当前月份时标记本月
        if (indexPath.section == 0 && indexPath.row == 0) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@ 本月",self.dataSource[indexPath.section].months[indexPath.row].month];
        }
        if (self.dataSource[indexPath.section].months[indexPath.row].isSelected) {
            cell.textLabel.textColor = CustomRedColor;
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.textColor = CustomBlackColor;
        }
    }
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    cell.selectionStyle = NO;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.yearTableView) {
        [self scrollToTopOfSection:indexPath.row animated:YES];
        [self changeSelectedIndexPathWithTableView:self.yearTableView selectedIndexPath:[NSIndexPath indexPathWithIndex:indexPath.row]];
    }else {
        [self changeSelectedIndexPathWithTableView:self.monthTableView selectedIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{//下滑
    if ((tableView == self.monthTableView) && !_isScrollDown && (self.monthTableView.dragging || self.monthTableView.decelerating)) {
        [self selectRowAtIndexPath:section];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{//上滑
    if ((tableView == self.monthTableView) && _isScrollDown && (self.monthTableView.dragging || self.monthTableView.decelerating)) {
        [self selectRowAtIndexPath:section + 1];
    }
}

// 当拖动右边TableView的时候，处理左边TableView
- (void)selectRowAtIndexPath:(NSInteger)index
{
    [self changeSelectedIndexPathWithTableView:self.yearTableView selectedIndexPath:[NSIndexPath indexPathWithIndex:index]];
    
    [self.yearTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index - 1 inSection:0]
                                     animated:YES
                               scrollPosition:UITableViewScrollPositionTop];
}

- (void)scrollToTopOfSection:(NSInteger)section animated:(BOOL)animated
{
    [self.monthTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]
                                     animated:YES
                               scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //记录上一次滑动时的offsetY的值用于判断是上滑还是下滑
    static CGFloat lastOffsetY = 0;
    //记录上一次滑动时的section，只有当section改变是才会走对应方法（减少循环次数）
    static NSIndexPath *lastIndexPath;
    if (scrollView == self.monthTableView) {
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
        
        NSIndexPath *indexPath = [self.monthTableView indexPathForRowAtPoint:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y + cell_height)];
        
        //因为monthTableView第一个section是从section = 1开始的，所以不会调用tableView:willDisplayHeaderView方法,需要特殊处理
        if (lastIndexPath.section != indexPath.section && indexPath.section == 0 && (self.monthTableView.dragging || self.monthTableView.decelerating)) {
            [self changeSelectedIndexPathWithTableView:self.yearTableView selectedIndexPath:indexPath];
            [self.yearTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.section inSection:0]
                                                animated:YES
                                          scrollPosition:UITableViewScrollPositionTop];
        }else if (lastIndexPath.section != indexPath.section && indexPath.section == 1 && (self.monthTableView.dragging || self.monthTableView.decelerating)) {
            [self changeSelectedIndexPathWithTableView:self.yearTableView selectedIndexPath:indexPath];
        }
        
        lastIndexPath = indexPath;
    }
}

- (void)changeSelectedIndexPathWithTableView:(UITableView *)tableView selectedIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.yearTableView) {
        [self.dataSource enumerateObjectsUsingBlock:^(YZXDateModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.isSelected) {
                obj.isSelected = NO;
                [self.yearTableView reloadRowsAtIndexPaths:@[obj.indexPath] withRowAnimation:UITableViewRowAnimationNone];
                *stop = YES;
            }
        }];
        self.dataSource[indexPath.section].isSelected = YES;
        [self.yearTableView reloadRowsAtIndexPaths:@[self.dataSource[indexPath.section].indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }else {
        [self.dataSource enumerateObjectsUsingBlock:^(YZXDateModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj.months enumerateObjectsUsingBlock:^(YZXMonthModel * _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
                if (obj1.isSelected) {
                    obj1.isSelected = NO;
                    [self.monthTableView reloadRowsAtIndexPaths:@[obj1.indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    *stop1 = YES;
                    *stop = YES;
                }
            }];
        }];
        self.dataSource[indexPath.section].months[indexPath.row].isSelected = YES;
        [self.monthTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        if (_delegate && [_delegate respondsToSelector:@selector(clickTheMonth:)]) {
            [_delegate clickTheMonth:[NSString stringWithFormat:@"%@%@",self.dataSource[indexPath.section].year,self.dataSource[indexPath.section].months[indexPath.row].month]];
        }
    }
}

#pragma mark - setter
- (void)setSelectedMonth:(NSString *)selectedMonth
{
    if (selectedMonth.length < 8) {
        errorLog(@"--------------日期格式错误(正确格式:yyyy年MM月)---------------");
    }
    _selectedMonth = [selectedMonth substringWithRange:NSMakeRange(0, 8)];
    
    if (!_selectedMonth) {
        return;
    }
    __block NSInteger section = 0;
    __block NSInteger row = 0;
    [self.dataSource enumerateObjectsUsingBlock:^(YZXDateModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //将默认选中的年份取消
        if (obj.isSelected) {
            obj.isSelected = NO;
            //将默认选中的月份取消
            [self.dataSource[idx].months enumerateObjectsUsingBlock:^(YZXMonthModel * _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
                if (obj1.isSelected) {
                    obj1.isSelected = NO;
                    *stop1 = YES;
                }
            }];
        }
        
        if ([obj.year isEqualToString:[self.selectedMonth substringWithRange:NSMakeRange(0, 5)]]) {
            //设置传入的年份选中
            section = idx;
            obj.isSelected = YES;
            
            [self.dataSource[section].months enumerateObjectsUsingBlock:^(YZXMonthModel * _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
                //设置传入的月份选中
                if ([obj1.month isEqualToString:[self.selectedMonth substringWithRange:NSMakeRange(5, 3)]]) {
                    row = idx1;
                    obj1.isSelected = YES;
                    
                    _selectedMonth = nil;
                    *stop1 = YES;
                }
            }];
            *stop = YES;
        }
    }];
    [self.yearTableView reloadData];
    [self.yearTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:section inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    
    [self.monthTableView reloadData];
    [self.monthTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark - 懒加载
- (YZXDateModel *)model
{
    if (!_model) {
        _model = [[YZXDateModel alloc] init];
    }
    return _model;
}

- (UITableView *)yearTableView
{
    if (!_yearTableView) {
        _yearTableView = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 0, yearTableView_width, self_height) style:UITableViewStylePlain];
        _yearTableView.delegate = self;
        _yearTableView.dataSource = self;
        _yearTableView.tableFooterView = [[UIView alloc] init];
        _yearTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _yearTableView;
}

- (UITableView *)monthTableView
{
    if (!_monthTableView) {
        _monthTableView = [[BaseTableView alloc] initWithFrame:CGRectMake(yearTableView_width + lineView_width, 0, monthTableView_width - lineView_width, self_height) style:UITableViewStylePlain];
        _monthTableView.delegate = self;
        _monthTableView.dataSource = self;
        _monthTableView.tableFooterView = [[UIView alloc] init];
        _monthTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _monthTableView;
}

- (YZXMonthTableViewHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[YZXMonthTableViewHeaderView alloc] initWithFrame:CGRectMake(0, 0, self_width, header_height)];
    }
    return _headerView;
}

@end
