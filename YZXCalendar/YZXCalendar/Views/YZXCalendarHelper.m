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
