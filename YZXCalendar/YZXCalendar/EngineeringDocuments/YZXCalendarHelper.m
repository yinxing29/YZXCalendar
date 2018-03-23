//
//  YZXCalendarCommonMethods.m
//  YZXCalendar
//
//  Created by 尹星 on 2017/6/28.
//  Copyright © 2017年 尹星. All rights reserved.
//

#import "YZXCalendarHelper.h"
#import "YZXCalendarModel.h"

@interface YZXCalendarHelper () {
    NSCalendar *_calendar;
}

@end

@implementation YZXCalendarHelper

+ (instancetype)helper
{
    static YZXCalendarHelper *helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[YZXCalendarHelper alloc] init];
        
        helper.yearReportStartDate = @"1970年";
        helper.yearReportEndDate = [helper.yearFormatter stringFromDate:[NSDate date]];
        helper.monthReportStartDate = @"1970年01月";
        helper.monthReportEndDate = [helper.yearAndMonthFormatter stringFromDate:[NSDate date]];
        helper.dayReportStartDate = @"1970年01月01日";
        helper.dayReportEndDate = [helper.yearMonthAndDayFormatter stringFromDate:[NSDate date]];
        helper.customDateStartDate = helper.dayReportStartDate;
        helper.customDateEndDate = helper.dayReportEndDate;
    });
    return helper;
}

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

- (BOOL)date:(NSDate *)date isTheSameMonthThan:(NSDate *)otherDate
{
    NSDateComponents *components = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:date];
    NSDateComponents *otherComponents = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:otherDate];
    
    return components.year == otherComponents.year && components.month == otherComponents.month;

}

- (YZXDateWithTodayType)determineWhetherForTodayWithIndexPaht:(NSIndexPath *)indexPath
                                                        model:(YZXCalendarModel *)model
{
    //今天
    NSDateFormatter *formatter = self.yearMonthAndDayFormatter;
    //获取当前cell上表示的天数
    NSString *dayString = [NSString stringWithFormat:@"%@%ld日",model.headerTitle,indexPath.item - (model.firstDayOfTheMonth - 2)];
    NSDate *dayDate = [formatter dateFromString:dayString];
    
    if (dayDate) {
        if ([YZXCalendarHelper.helper date:[NSDate date] isTheSameDateThan:dayDate]) {
            return YZXDateEqualToToday;
        }else if ([dayDate compare:[NSDate date]] == NSOrderedDescending) {
            return YZXDateLaterThanToday;
        }else {
            return YZXDateEarlierThanToday;
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
    NSDate *textDate = [self.calendar dateByAddingComponents:components toDate:[self.yearMonthAndDayFormatter dateFromString:dateString] options:0];
    return [self.yearMonthAndDayFormatter stringFromDate:textDate];
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
    NSDateFormatter *formatter = [self yearAndMonthFormatter];
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
    NSDateFormatter *formatter = [self yearAndMonthFormatter];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = number;
    NSDate *textDate = [self.calendar dateByAddingComponents:components toDate:[formatter dateFromString:dateString] options:0];
    return [formatter stringFromDate:textDate];
}

- (NSDateFormatter *)yearFormatter
{
    return [[self class] createFormatterWithDateFormat:@"yyyy年"];
}

- (NSDateFormatter *)yearAndMonthFormatter
{
    return [[self class] createFormatterWithDateFormat:@"yyyy年MM月"];
}

- (NSDateFormatter *)yearMonthAndDayFormatter
{
    return [[self class] createFormatterWithDateFormat:@"yyyy年MM月dd日"];
}

@end
