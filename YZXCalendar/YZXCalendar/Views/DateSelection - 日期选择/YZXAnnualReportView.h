//
//  YZXAnnualReportView.h
//  Replenishment
//
//  Created by 尹星 on 2017/6/30.
//  Copyright © 2017年 ruwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YZXAnnualReportViewDelegate <NSObject>

- (void)clickTheYear:(NSString *)year;

@end

@interface YZXAnnualReportView : UIView

/**
 自定义初始化方法

 @param frame frame
 @param startDateString 开始的年份 (格式为：yyyy年)
 @param endDateString 结束的年份 (格式为：yyyy年)
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame
          withStartDateString:(NSString *)startDateString
                endDateString:(NSString *)endDateString;

@property (nonatomic, weak) id<YZXAnnualReportViewDelegate>         delegate;

//传入年份信息，用于选中（默认为本年，格式为：yyyy年）
@property (nonatomic, copy) NSString             *selectedYear;

@end
