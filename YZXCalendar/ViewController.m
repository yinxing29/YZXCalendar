//
//  ViewController.m
//  YZXCalendar
//
//  Created by 尹星 on 2017/6/27.
//  Copyright © 2017年 尹星. All rights reserved.
//

#import "ViewController.h"
#import "YZXCalendarView.h"
#import "YZXCalendarHelper.h"

@interface ViewController ()

@property (nonatomic, strong) YZXCalendarView             *calendarView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.calendarView];
    
}

#pragma mark - 懒加载
- (YZXCalendarView *)calendarView
{
    if (!_calendarView) {
        NSDateFormatter *formatter = [YZXCalendarHelper createFormatterWithDateFormat:@"yyyy年MM月dd日"];
        _calendarView = [[YZXCalendarView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)
                                           withStartDateString:@"2016年01月01日"
                                                 endDateString:[formatter stringFromDate:[NSDate date]]];
        _calendarView.customSelect = YES;
    }
    return _calendarView;
}


@end
