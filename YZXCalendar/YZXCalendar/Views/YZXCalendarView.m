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

#pragma mark - <YZXCalendarDelegate>
- (void)clickCalendarWithStartDate:(NSString *)startDate andEndDate:(NSString *)endDate
{
    if (self.customSelect && _delegate && [_delegate respondsToSelector:@selector(clickCalendarWithStartDate:andEndDate:)]) {
        [_delegate clickCalendarWithStartDate:startDate andEndDate:endDate];
    }
}

- (void)clickCalendarDate:(NSString *)date
{
    if (!self.customSelect && _delegate && [_delegate respondsToSelector:@selector(clickCalendarDate:)]) {
        [_delegate clickCalendarDate:date];
    }
}

#pragma mark - 懒加载
- (YZXWeekMenuView *)weekMenuView
{
    if (!_weekMenuView) {
        _weekMenuView = [[YZXWeekMenuView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 20)];
        _weekMenuView.backgroundColor = [UIColor whiteColor];
    }
    return _weekMenuView;
}

- (YZXDaysMenuView *)daysMenuView
{
    if (!_daysMenuView) {
        _daysMenuView = [[YZXDaysMenuView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.weekMenuView.frame), self.bounds.size.width, self.bounds.size.height - CGRectGetMaxY(self.weekMenuView.frame)) withStartDateString:_startDateString endDateString:_endDateString];
        _daysMenuView.delegate = self;
    }
    return _daysMenuView;
}

#pragma mark - setter
- (void)setCustomSelect:(BOOL)customSelect
{
    _customSelect = customSelect;
    _daysMenuView.customSelect = _customSelect;
}

- (void)setStartDate:(NSString *)startDate
{
    _startDate = startDate;
    _daysMenuView.startDate = _startDate;
}

- (void)setDateArray:(NSArray *)dateArray
{
    _dateArray = dateArray;
    _daysMenuView.dateArray = _dateArray;
}

@end
