//
//  YZXCalendarCommonMethods.m
//  YZXCalendar
//
//  Created by 尹星 on 2017/6/28.
//  Copyright © 2017年 尹星. All rights reserved.
//

#import "YZXCalendarHelper.h"
#import "YZXCalendarModel.h"
#import <UIKit/UIKit.h>

@interface YZXCalendarHelper () {
    NSCalendar *_calendar;
    NSDateFormatter *_formatter;
}

@end

@implementation YZXCalendarHelper

- (NSCalendar *)calendar
{
    if(!_calendar){
#ifdef __IPHONE_8_0
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
#endif
        _calendar.timeZone = [NSTimeZone localTimeZone];
        _calendar.locale = [NSLocale currentLocale];
    }
    
    return _calendar;
}

+ (NSDateFormatter *)createFormatterWithDateFormat:(NSString *)dateFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = dateFormat;
    return formatter;
}

- (BOOL)date:(NSDate *)date isTheSameDateThan:(NSDate *)otherDate
{
    NSDateComponents *components = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    NSDateComponents *otherComponents = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:otherDate];
    
    return components.year == otherComponents.year && components.month == otherComponents.month && components.day == otherComponents.day;
}

- (WWTDateWithTodayType)determineWhetherForTodayWithIndexPaht:(NSIndexPath *)indexPath model:(YZXCalendarModel *)model
{
    //今天
    NSDateFormatter *formatter = [[YZXCalendarHelper new] formatter];
    //获取当前cell上表示的天数
    NSString *dayString = [NSString stringWithFormat:@"%@%ld日",model.headerTitle,indexPath.item - (model.firstDayOfTheMonth - 2)];
    NSDate *dayDate = [formatter dateFromString:dayString];
    
    if (dayDate) {
        if ([YZXCalendarHelper.helper date:[NSDate date] isTheSameDateThan:dayDate]) {
            return WWTDateEqualToToday;
        }else if ([dayDate compare:[NSDate date]] == NSOrderedDescending) {
            return WWTDateLaterThanToday;
        }else {
            return WWTDateEarlierThanToday;
        }
    }
    return NO;
}

- (NSString *)beforeOneDayWithDate:(NSString *)dateString
{
    return [self p_calculateTheDayWithNumber:-1 withDate:dateString];
}
- (NSString *)afterOneDayWithDate:(NSString *)dateString
{
    return [self p_calculateTheDayWithNumber:1 withDate:dateString];
}

- (NSString *)p_calculateTheDayWithNumber:(NSInteger)number withDate:(NSString *)dateString
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = number;
    NSDate *textDate = [self.calendar dateByAddingComponents:components toDate:[self.formatter dateFromString:dateString] options:0];
    return [self.formatter stringFromDate:textDate];
}

- (NSString *)beforeOneMonthWithDate:(NSString *)dateString
{
    return [self p_calculateTheMonthWithNumber:-1 withDate:dateString];
}

- (NSString *)afterOneMonthWithDate:(NSString *)dateString
{
    return [self p_calculateTheMonthWithNumber:1 withDate:dateString];
}

- (NSString *)p_calculateTheMonthWithNumber:(NSInteger)number withDate:(NSString *)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy年MM月";
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = number;
    NSDate *textDate = [self.calendar dateByAddingComponents:components toDate:[formatter dateFromString:dateString] options:0];
    return [formatter stringFromDate:textDate];
}

- (NSString *)beforeOneYearWithDate:(NSString *)dateString
{
    return [self p_calculateTheYearWithNumber:-1 withDate:dateString];
}

- (NSString *)afterOneYearWithDate:(NSString *)dateString
{
    return [self p_calculateTheYearWithNumber:1 withDate:dateString];
}

- (NSString *)p_calculateTheYearWithNumber:(NSInteger)number withDate:(NSString *)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy年";
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = number;
    NSDate *textDate = [self.calendar dateByAddingComponents:components toDate:[formatter dateFromString:dateString] options:0];
    return [formatter stringFromDate:textDate];
}

- (NSDateFormatter *)formatter
{
    if (!_formatter) {
        _formatter = [[NSDateFormatter alloc] init];
        _formatter.dateFormat = @"yyyy年MM月dd日";
    }
    return _formatter;
}

+ (instancetype)helper
{
    static YZXCalendarHelper *helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[YZXCalendarHelper alloc] init];
    });
    return helper;
}

@end
