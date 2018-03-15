//
//  YZXCalendarCollectionViewCell.h
//  YZXCalendar
//
//  Created by 尹星 on 2017/6/28.
//  Copyright © 2017年 尹星. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YZXCalendarModel;

@interface YZXCalendarCollectionViewCell : UICollectionViewCell

- (void)layoutContentViewOfCollectionViewCellWithCellIndxePath:(NSIndexPath *)indexPath
                                                         model:(YZXCalendarModel *)model;

- (void)changeContentViewBackgroundColor:(UIColor *)backgroundColor;

- (void)changeDayTextColor:(UIColor *)textColor;

- (void)changeDayBackgroundColor:(UIColor *)backgroundColor;

- (NSString *)getTheCellDayText;

@end
