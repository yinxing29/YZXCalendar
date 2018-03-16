//
//  YZXDateModel.h
//  Replenishment
//
//  Created by 尹星 on 2017/6/30.
//  Copyright © 2017年 ruwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YZXMonthModel;

@interface YZXDateModel : NSObject

@property (nonatomic, copy) NSString             *year;
@property (nonatomic, copy) NSString             *quarter;
@property (nonatomic, copy) NSArray <YZXMonthModel *>             *months;
@property (nonatomic, copy) NSString             *week;
@property (nonatomic, copy) NSString             *day;

@property (nonatomic, assign) BOOL                 isSelected;
@property (nonatomic, strong) NSIndexPath          *indexPath;

- (NSArray<YZXDateModel *> *)achieveYearDateModelWithDate:(NSDate *)startDate toDate:(NSDate *)endDate;
- (NSArray<YZXDateModel *> *)achieveMonthDateModelWithDate:(NSDate *)startDate toDate:(NSDate *)endDate;


@end
