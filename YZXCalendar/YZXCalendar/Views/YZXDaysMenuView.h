//
//  YZXDaysMenuView.h
//  YZXCalendar
//
//  Created by 尹星 on 2017/6/27.
//  Copyright © 2017年 尹星. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZXDaysMenuView : UIView

/**
 自定义初始化
 
 @param frame frame
 @param startDateString 日历的开始时间(日期格式：yyyy年MM月dd日)
 @param endDateString 日历的结束时间(日期格式：yyyy年MM月dd日)
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame withStartDateString:(NSString *)startDateString endDateString:(NSString *)endDateString;

@property (nonatomic, assign) BOOL         customSelect;

@end
