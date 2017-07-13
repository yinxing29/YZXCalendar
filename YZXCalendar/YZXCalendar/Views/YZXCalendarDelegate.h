//
//  YZXCalendarDelegate.h
//  YZXCalendar
//
//  Created by 尹星 on 2017/7/6.
//  Copyright © 2017年 尹星. All rights reserved.
//

#ifndef YZXCalendarDelegate_h
#define YZXCalendarDelegate_h

@class YZXCalendarView;

@protocol YZXCalendarDelegate <NSObject>


@end

@protocol YZXCalendarDataSource <NSObject>

- (NSDate *)maxDateInCalendar:(YZXCalendarView *)calendar;

- (NSDate *)minDateInCalendar:(YZXCalendarView *)calendar;

@end

#endif /* YZXCalendarDelegate_h */
