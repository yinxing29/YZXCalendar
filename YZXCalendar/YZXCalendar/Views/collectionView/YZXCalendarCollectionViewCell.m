//
//  YZXCalendarCollectionViewCell.m
//  YZXCalendar
//
//  Created by 尹星 on 2017/6/28.
//  Copyright © 2017年 尹星. All rights reserved.
//

#import "YZXCalendarCollectionViewCell.h"
#import "YZXCalendarModel.h"
#import "YZXCalendarHelper.h"

@interface YZXCalendarCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *day;

@end

@implementation YZXCalendarCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutContentViewOfCollectionViewCellWithCellIndxePath:(NSIndexPath *)indexPath model:(YZXCalendarModel *)model
{
    self.backgroundColor = [UIColor whiteColor];
    NSInteger firstDayInMonth = model.firstDayOfTheMonth;
    //从每月的第一天开始设置cell.day的值
    if (indexPath.item >= firstDayInMonth - 1 && indexPath.item <= firstDayInMonth + model.numberOfDaysOfTheMonth - 2) {
        self.day.text = [NSString stringWithFormat:@"%ld",indexPath.item - (firstDayInMonth - 2)];
        self.userInteractionEnabled = YES;
    }else {
        self.day.text = @"";
        self.userInteractionEnabled = NO;
    }
    //周末字体为红色
    if (indexPath.item % 7 == 0 || indexPath.item % 7 == 6) {
        self.day.textColor = [UIColor redColor];
    }else {
        self.day.textColor = [UIColor blackColor];
    }
    //今天
    if ([YZXCalendarHelper.helper determineWhetherForTodayWithIndexPaht:indexPath model:model] == WWTDateEqualToToday) {
        self.day.text = @"今天";
        self.day.textColor = [UIColor redColor];
    }else if ([YZXCalendarHelper.helper determineWhetherForTodayWithIndexPaht:indexPath model:model] == WWTDateLaterThanToday) {//判断日期是否超过今天
        self.day.textColor = [UIColor grayColor];
        self.userInteractionEnabled = NO;
    }
}

- (void)changeContentViewBackgroundColor:(UIColor *)backgroundColor
{
    self.backgroundColor = backgroundColor;
}

- (void)changeDayBackgroundColor:(UIColor *)backgroundColor
{
    self.day.backgroundColor = backgroundColor;
}

- (void)changeDayTextColor:(UIColor *)textColor
{
    self.day.textColor = textColor;
}

- (NSString *)getTheCellDayText
{
    return self.day.text;
}

@end
