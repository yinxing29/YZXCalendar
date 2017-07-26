//
//  YZXCalendarDelegate.h
//  Replenishment
//
//  Created by 尹星 on 2017/7/19.
//  Copyright © 2017年 ruwang. All rights reserved.
//

#ifndef YZXCalendarDelegate_h
#define YZXCalendarDelegate_h

#import <UIKit/UIKit.h>

@protocol YZXCalendarDelegate <NSObject>

- (void)clickCalendarDate:(NSString *)date;

- (void)clickCalendarWithStartDate:(NSString *)startDate
                        andEndDate:(NSString *)endDate;

@end


#endif /* YZXCalendarDelegate_h */
