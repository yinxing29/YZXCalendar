//
//  YZXDaysMenuView.h
//  YZXCalendar
//
//  Created by 尹星 on 2017/6/27.
//  Copyright © 2017年 尹星. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZXCalendarDelegate.h"

@interface YZXDaysMenuView : UIView

/**
 自定义初始化
 
 @param frame frame
 @param startDateString 日历的开始时间(日期格式：yyyy年MM月dd日)
 @param endDateString 日历的结束时间(日期格式：yyyy年MM月dd日)
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame
          withStartDateString:(NSString *)startDateString
                endDateString:(NSString *)endDateString;
//点击回调代理
@property (nonatomic, weak) id<YZXCalendarDelegate>         delegate;
//日历单选
@property (nonatomic, copy) NSString             *startDate;

//判断是否为自定义选择（选择日期段）
@property (nonatomic, assign) BOOL         customSelect;
//自定义日历(可选择两个时间的范围)
@property (nonatomic, copy) NSArray              *dateArray;
//自定义日历，控制可选择的日期的最大跨度
@property (nonatomic, assign) NSInteger          maxChooseNumber;

@end
