//
//  YZXCalendarModel.m
//  YZXCalendar
//
//  Created by 尹星 on 2017/6/29.
//  Copyright © 2017年 尹星. All rights reserved.
//

#import "YZXCalendarModel.h"
#import "YZXCalendarHelper.h"

@interface YZXCalendarModel ()

@property (nonatomic, strong) YZXCalendarHelper             *calendarHelper;

@end

@implementation YZXCalendarModel

- (NSArray<YZXCalendarModel *> *)achieveCalendarModelWithData:(NSDate *)startDate toDate:(NSDate *)endDate
{
    NSMutableArray *modelArray = [NSMutableArray array];
    
    NSDateFormatter *formatter = [YZXCalendarHelper createFormatterWithDateFormat:@"yyyy年MM月"];
    //判断所给年月距离当前年月有多少个月
    NSDateComponents *components = [self.calendarHelper.calendar components:NSCalendarUnitMonth fromDate:startDate toDate:endDate options:NSCalendarWrapComponents];
    //循环遍历得到从给定年月一直到当前年月的所有年月信息
    for (NSInteger i = 0; i<=components.month; i++) {
        NSDateComponents *monthComponents = [[NSDateComponents alloc] init];
        monthComponents.month = i;
        NSDate *headerDate = [self.calendarHelper.calendar dateByAddingComponents:monthComponents toDate:startDate options:0];
        NSString *headerTitle = [formatter stringFromDate:headerDate];
        
        //获取此section所表示月份的天数
        NSRange daysOfMonth = [self.calendarHelper.calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:headerDate];
        NSUInteger numberOfDaysInMonth = daysOfMonth.length;
        
        //获取此section所表示月份的第一天是第一个星期的第几天（当前日历的每个星期的第一天是星期日）
        NSDateComponents *comps = [self.calendarHelper.calendar components:NSCalendarUnitWeekday fromDate:headerDate];
        NSInteger firstDayInMonth = [comps weekday];
        
        NSInteger sectionRow = ((numberOfDaysInMonth + firstDayInMonth - 1) % 7 == 0) ? ((numberOfDaysInMonth + firstDayInMonth - 1) / 7) : ((numberOfDaysInMonth + firstDayInMonth - 1) / 7 + 1);
        
        YZXCalendarModel *model = [[YZXCalendarModel alloc] init];
        model.numberOfDaysOfTheMonth = numberOfDaysInMonth;
        model.firstDayOfTheMonth = firstDayInMonth;
        model.headerTitle = headerTitle;
        model.sectionRow = sectionRow;
        
        [modelArray addObject:model];
    }
    return [modelArray copy];
}

#pragma mark - 懒加载
- (YZXCalendarHelper *)calendarHelper
{
    if (!_calendarHelper) {
        _calendarHelper = [[YZXCalendarHelper alloc] init];
    }
    return _calendarHelper;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@",@{@"headerTitle":self.headerTitle,@"numberOfDaysTheMonth":@(self.numberOfDaysOfTheMonth),@"firstDayOfTheMonth":@(self.firstDayOfTheMonth),@"sectionRow":@(self.sectionRow)}];
}

@end
