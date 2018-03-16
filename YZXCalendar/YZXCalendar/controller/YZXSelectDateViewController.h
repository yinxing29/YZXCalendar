//
//  YZXSelectDateViewController.h
//  Replenishment
//
//  Created by 尹星 on 2017/7/19.
//  Copyright © 2017年 ruwang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,YZXSelectedDateType) {
    YZXAllSelectedType = 0,
    YZXSalesTrendsType,//销售趋势（没有总累计，自定义最多31天）
};

/**
 block回调

 @param startDate 自定义时间时返回的开始时间，非自定义时间时返回当前选择的时间
 @param endDate 自定义时间时返回的结束时间，非自定义时为nil
 @param selectedType 查看的报表类型
 */
typedef void (^ConfirmTheDateBlock) (NSString *startDate,NSString *endDate, YZXTimeToChooseType selectedType);

@interface YZXSelectDateViewController : UIViewController

@property (nonatomic, copy) ConfirmTheDateBlock             confirmTheDateBlock;

//记录上次所传参数
@property (nonatomic, assign) YZXTimeToChooseType         selectedType;
@property (nonatomic, copy) NSString             *startDate;
@property (nonatomic, copy) NSString             *endDate;

@property (nonatomic, assign) YZXSelectedDateType         selectedDateType;

/**
 自定义时最多选择的天数
 */
@property (nonatomic, assign) NSInteger         maxChooseNumber;

@end
