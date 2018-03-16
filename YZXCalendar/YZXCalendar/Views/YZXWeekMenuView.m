//
//  YZXWeekMenuView.m
//  YZXCalendar
//
//  Created by 尹星 on 2017/6/27.
//  Copyright © 2017年 尹星. All rights reserved.
//

#import "YZXWeekMenuView.h"
#import "YZXDaysMenuView.h"

static const CGFloat lineView_height = 0.5;

@interface YZXWeekMenuView ()

@property (nonatomic, strong) YZXCalendarHelper     *calendarHelper;

@end

@implementation YZXWeekMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self p_initData];
        [self p_initView];
    }
    return self;
}

- (void)p_initData
{
    self.calendarHelper = YZXCalendarHelper.helper;
}

- (void)p_initView
{
    NSDateFormatter *formatter = [self createDateFormatter];
    formatter.timeZone = self.calendarHelper.calendar.timeZone;
    formatter.locale = self.calendarHelper.calendar.locale;
    NSMutableArray *days = [[formatter veryShortWeekdaySymbols] mutableCopy];
    
    [days enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *weekdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width / 7.f * idx, 0, self.bounds.size.width / 7.f, self.bounds.size.height - lineView_height)];
        weekdayLabel.text = obj;
        weekdayLabel.font = [UIFont systemFontOfSize:10.0];
        weekdayLabel.textAlignment = NSTextAlignmentCenter;
        weekdayLabel.textColor = CustomBlackColor;
        if (idx == 0 || idx == 6) {
            weekdayLabel.textColor = CustomRedColor;
        }
        [self addSubview:weekdayLabel];
    }];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - lineView_height, self.bounds.size.width, lineView_height)];
    lineView.backgroundColor = [UIColor colorWithRed:200 / 255.0 green:200 / 255.0 blue:200 / 255.0 alpha:1];
    [self addSubview:lineView];
}

- (NSDateFormatter *)createDateFormatter
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    
    dateFormatter.timeZone = self.calendarHelper.calendar.timeZone;
    dateFormatter.locale = self.calendarHelper.calendar.locale;
    
    return dateFormatter;
}

@end
