//
//  YZXCalendarCommonMethods.h
//  YZXCalendar
//
//  Created by 尹星 on 2017/6/28.
//  Copyright © 2017年 尹星. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YZXCalendarModel;

typedef NS_ENUM(NSUInteger, YZXDateWithTodayType) {
    YZXDateEqualToToday = 1,//当天
    YZXDateEarlierThanToday,//早于当天
    YZXDateLaterThanToday,//晚于当天
};

//销售报表中时间段选择
typedef NS_ENUM(NSUInteger ,YZXTimeToChooseType) {
    YZXTimeToChooseInAll = 0,
    YZXTimeToChooseInDay,
    YZXTimeToChooseInMonth,
    YZXTimeToChooseInYear,
    YZXTimeToChooseInCustom,
};

@interface YZXCalendarHelper : NSObject

+ (instancetype)helper;


/**
 年报开始，结束时间（时间格式:yyyy年）
 */
@property (nonatomic, copy) NSString         *yearReportStartDate;
@property (nonatomic, copy) NSString         *yearReportEndDate;

/**
 月报开始，结束时间（时间格式:yyyy年MM月）
 */
@property (nonatomic, copy) NSString         *monthReportStartDate;
@property (nonatomic, copy) NSString         *monthReportEndDate;

/**
 日报开始，结束时间（时间格式:yyyy年MM月dd日）
 */
@property (nonatomic, copy) NSString         *dayReportStartDate;
@property (nonatomic, copy) NSString         *dayReportEndDate;

/**
 自定义时间（自选时间段）开始，结束时间（时间格式:yyyy年MM月dd日）
 */
@property (nonatomic, copy) NSString         *customDateStartDate;
@property (nonatomic, copy) NSString         *customDateEndDate;

//yyyy年
- (NSDateFormatter *)yearFormatter;
//yyyy年MM月
- (NSDateFormatter *)yearAndMonthFormatter;
//yyyy年MM月dd日
- (NSDateFormatter *)yearMonthAndDayFormatter;

- (NSCalendar *)calendar;

//生成自定义dateFormatter
+ (NSDateFormatter *)createFormatterWithDateFormat:(NSString *)dateFormat;
//日期是否相同
- (BOOL)date:(NSDate *)date isTheSameDateThan:(NSDate *)otherDate;
//月份是否相同
- (BOOL)date:(NSDate *)date isTheSameMonthThan:(NSDate *)otherDate;

- (YZXDateWithTodayType)determineWhetherForTodayWithIndexPaht:(NSIndexPath *)indexPath model:(YZXCalendarModel *)model;

- (NSString *)beforeOneDayWithDate:(NSString *)dateString;
- (NSString *)afterOneDayWithDate:(NSString *)dateString;

- (NSString *)beforeOneMonthWithDate:(NSString *)dateString;
- (NSString *)afterOneMonthWithDate:(NSString *)dateString;

- (NSString *)beforeOneYearWithDate:(NSString *)dateString;
- (NSString *)afterOneYearWithDate:(NSString *)dateString;

@end
