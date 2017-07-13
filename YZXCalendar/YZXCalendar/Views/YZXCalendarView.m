//
//  YZXCalendarView.m
//  YZXCalendar
//
//  Created by 尹星 on 2017/6/28.
//  Copyright © 2017年 尹星. All rights reserved.
//

#import "YZXCalendarView.h"
#import "YZXWeekMenuView.h"
#import "YZXDaysMenuView.h"

@interface YZXCalendarView ()
{
    struct {
        unsigned int didSetTheMaxData : 1;
        unsigned int didSetTheMinData : 1;
    } _dataSourceFlags;
}

@property (nonatomic, strong) YZXWeekMenuView             *weekMenuView;
@property (nonatomic, strong) YZXDaysMenuView             *daysMenuView;

@end

@implementation YZXCalendarView {
    NSString *_startDateString;
    NSString *_endDateString;
}

- (instancetype)initWithFrame:(CGRect)frame withStartDateString:(NSString *)startDateString endDateString:(NSString *)endDateString
{
    self = [super initWithFrame:frame];
    if (self) {
        _startDateString = startDateString;
        _endDateString = endDateString;
        [self p_initData];
        [self p_initView];
    }
    return self;
}

- (void)p_initData
{
    
}

- (void)p_initView
{
    [self addSubview:self.weekMenuView];
    [self addSubview:self.daysMenuView];
}

#pragma mark - 懒加载
- (YZXWeekMenuView *)weekMenuView
{
    if (!_weekMenuView) {
        _weekMenuView = [[YZXWeekMenuView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 40)];
    }
    return _weekMenuView;
}

- (YZXDaysMenuView *)daysMenuView
{
    if (!_daysMenuView) {
        _daysMenuView = [[YZXDaysMenuView alloc] initWithFrame:CGRectMake(0, 40, self.bounds.size.width, self.bounds.size.height - 40) withStartDateString:_startDateString endDateString:_endDateString];
    }
    return _daysMenuView;
}

#pragma mark - setter
- (void)setCustomSelect:(BOOL)customSelect
{
    _customSelect = customSelect;
    _daysMenuView.customSelect = _customSelect;
}

- (void)setDelegate:(id<YZXCalendarDelegate>)delegate
{
    _delegate = delegate;
}

- (void)setDataSource:(id<YZXCalendarDataSource>)dataSource
{
    _dataSource = dataSource;
    _dataSourceFlags.didSetTheMaxData = [_dataSource respondsToSelector:@selector(maxDateInCalendar:)];
    _dataSourceFlags.didSetTheMinData = [_dataSource respondsToSelector:@selector(minDateInCalendar:)];
}

@end
