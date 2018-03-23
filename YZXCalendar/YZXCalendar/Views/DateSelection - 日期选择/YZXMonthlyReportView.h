//
//  YZXMonthlyReportView.h
//  Replenishment
//
//  Created by 尹星 on 2017/6/30.
//  Copyright © 2017年 ruwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YZXMonthlyReportViewDelegate <NSObject>

- (void)clickTheMonth:(NSString *)month;

@end

@interface YZXMonthlyReportView : UIView

/**
 自定义初始化方法

 @param frame frame
 @param startDateString 开始的年月份（格式yyyy年MM月）
 @param endDateString 结束的年月份（格式yyyy年MM月）
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame
          withStartDateString:(NSString *)startDateString
                endDateString:(NSString *)endDateString;

@property (nonatomic, weak) id<YZXMonthlyReportViewDelegate>         delegate;

//传入年份信息，用于选中（默认为本年，格式为：yyyy年MM月）
@property (nonatomic, copy) NSString             *selectedMonth;

@end
