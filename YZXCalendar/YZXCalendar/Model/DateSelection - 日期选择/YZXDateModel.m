//
//  YZXDateModel.m
//  Replenishment
//
//  Created by 尹星 on 2017/6/30.
//  Copyright © 2017年 ruwang. All rights reserved.
//

#import "YZXDateModel.h"
#import "YZXMonthModel.h"

@interface YZXDateModel ()

@end

@implementation YZXDateModel

- (NSArray<YZXDateModel *> *)achieveYearDateModelWithDate:(NSDate *)startDate toDate:(NSDate *)endDate
{
    NSMutableArray *modelArray = [NSMutableArray array];
    NSDateFormatter *formatter = [YZXCalendarHelper createFormatterWithDateFormat:@"yyyy年"];
    
    //计算开始年份到结束年份的差值
    NSDateComponents *components = [YZXCalendarHelper.helper.calendar components:NSCalendarUnitYear fromDate:startDate toDate:endDate options:NSCalendarWrapComponents];
    //循环遍历，计算开始年份到结束年份中的所有年份
    for (int i = 0; i<=components.year; i++) {
        NSDateComponents *yearComponents = [[NSDateComponents alloc] init];
        yearComponents.year = -i;//年份倒叙排列
        NSDate *textDate = [YZXCalendarHelper.helper.calendar dateByAddingComponents:yearComponents toDate:endDate options:0];
        NSString *text = [formatter stringFromDate:textDate];
        
        YZXDateModel *model = [[YZXDateModel alloc] init];
        model.year = text;
        model.isSelected = NO;
        if ([textDate compare:endDate] == NSOrderedSame) {
            model.isSelected = YES;
        }
        [modelArray addObject:model];
    }
    return [modelArray copy];
}

- (NSArray<YZXDateModel *> *)achieveMonthDateModelWithDate:(NSDate *)startDate toDate:(NSDate *)endDate
{
    NSMutableArray *modelArray = [NSMutableArray array];
    NSDateFormatter *formatter = [YZXCalendarHelper helper].yearAndMonthFormatter;
    //计算开始年份到结束年份的差值
    NSDateComponents *components = [YZXCalendarHelper.helper.calendar components:NSCalendarUnitMonth fromDate:startDate toDate:endDate options:NSCalendarWrapComponents];
    //每年的月份数组
    NSMutableArray *months = [NSMutableArray array];
    //记录上一年份信息
    NSString *lastYear = @"";
    //循环遍历，计算开始年份到结束年份中的所有年份
    for (int i = 0; i<=components.month; i++) {
        NSDateComponents *monthComponents = [[NSDateComponents alloc] init];
        monthComponents.month = -i;//年份倒叙排列
        NSDate *textDate = [YZXCalendarHelper.helper.calendar dateByAddingComponents:monthComponents toDate:endDate options:0];
        NSString *text = [formatter stringFromDate:textDate];
        //截取年份
        NSString *yearString = [text substringWithRange:NSMakeRange(0, 5)];
        //截取月份
        NSString *monthString = [text substringWithRange:NSMakeRange(5, 3)];
        //初始化月份数组
        YZXMonthModel *monthModel = [[YZXMonthModel alloc] init];
        monthModel.month = monthString;
        //判断是否为当前月份，是则将其isSelected置为YES
        if ([text isEqualToString:[formatter stringFromDate:[NSDate date]]]) {
            monthModel.isSelected = YES;
        }
        if (![yearString isEqualToString:lastYear]) {
            //初始化年份数组
            YZXDateModel *model = [[YZXDateModel alloc] init];
            model.year = lastYear;
            //判断是否为当前年份，是则将其isSelected置为YES
            if ([lastYear isEqualToString:[[formatter stringFromDate:[NSDate date]] substringWithRange:NSMakeRange(0, 5)]]) {
                model.isSelected = YES;
            }
            //第一次循环时不用添加months
            if (![lastYear isEqualToString:@""]) {
                //当遍历到第二个年份时保存前一年份的月份信息（因最后一个年份没有第二年份，需要特殊处理）
                model.months = [months copy];
                //将完成年份信息存入数组
                [modelArray addObject:model];
                //移除前一年的月份信息
                [months removeAllObjects];
            }
        }
        //将同一年份的月份信息存入数组
        [months addObject:monthModel];
        //当循环到最后一个元素时，直接保存其年份
        if (i == components.month) {
            YZXDateModel *model = [[YZXDateModel alloc] init];
            model.year = yearString;
            //判断是否为当前年份，是则将其isSelected置为YES
            if ([yearString isEqualToString:[[formatter stringFromDate:[NSDate date]] substringWithRange:NSMakeRange(0, 5)]]) {
                model.isSelected = YES;
            }
            model.months = [months copy];
            [modelArray addObject:model];
        }
        
        lastYear = yearString;
    }
    return [modelArray copy];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@,%@",self.year,self.months];
}

@end
