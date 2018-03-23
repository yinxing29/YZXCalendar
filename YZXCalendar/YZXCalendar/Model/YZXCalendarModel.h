//
//  YZXCalendarModel.h
//  YZXCalendar
//
//  Created by 尹星 on 2017/6/29.
//  Copyright © 2017年 尹星. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZXCalendarModel : NSObject

@property (nonatomic, assign) NSInteger         numberOfDaysOfTheMonth;
@property (nonatomic, assign) NSInteger         firstDayOfTheMonth;
@property (nonatomic, copy)   NSString          *headerTitle;
//对应section的行数
@property (nonatomic, assign) NSInteger         sectionRow;

- (NSArray<YZXCalendarModel *> *)achieveCalendarModelWithData:(NSDate *)startDate
                                                       toDate:(NSDate *)endDate;

@end
