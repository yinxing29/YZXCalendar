//
//  ViewController.m
//  YZXCalendar
//
//  Created by 尹星 on 2017/6/27.
//  Copyright © 2017年 尹星. All rights reserved.
//

#import "ViewController.h"
#import "YZXCalendarView.h"
#import "YZXSelectDateViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (nonatomic, strong) YZXCalendarView             *calendarView;

@property (nonatomic, assign) YZXTimeToChooseType         selectedType;
@property (nonatomic, copy) NSString             *startDate;
@property (nonatomic, copy) NSString             *endDate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.calendarView];
    
}

- (IBAction)buttonPressed:(UIButton *)sender {
    YZXSelectDateViewController *VC = [[YZXSelectDateViewController alloc] init];
    __weak typeof(self) weak_self = self;
    VC.confirmTheDateBlock = ^(NSString *startDate, NSString *endDate, YZXTimeToChooseType selectedType) {
        weak_self.selectedType = selectedType;
        weak_self.startDate = startDate;
        weak_self.endDate = endDate;
        weak_self.dateLabel.text = [NSString stringWithFormat:@"%@ - %@",startDate,endDate];
    };
    VC.selectedType = self.selectedType;
    VC.startDate    = self.startDate;
    VC.endDate      = self.endDate;
    [self presentViewController:VC animated:YES completion:nil];
}

@end
