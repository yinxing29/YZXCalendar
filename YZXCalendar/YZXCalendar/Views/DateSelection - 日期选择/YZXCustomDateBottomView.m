//
//  YZXCustomDateBottomView.m
//  Replenishment
//
//  Created by 尹星 on 2017/7/19.
//  Copyright © 2017年 ruwang. All rights reserved.
//

#import "YZXCustomDateBottomView.h"

@interface YZXCustomDateBottomView ()

@property (nonatomic, strong) UILabel             *start;
@property (nonatomic, strong) UILabel             *end;

@property (nonatomic, strong) UIButton             *confirmButton;

@end

@implementation YZXCustomDateBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = CustomLineColor;
        [self p_initView];
    }
    return self;
}

- (void)p_initView
{
    //开始时间文本
    UILabel *startLabel = [[UILabel alloc] init];
    startLabel.text = @"开始时间:";
    startLabel.font = FONT12;
    startLabel.textColor = CustomBlackColor;
    [self addSubview:startLabel];
    
    [startLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@9);
        make.left.equalTo(@20);
    }];
    
    [self addSubview:self.start];
    
    [self.start mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(startLabel);
        make.left.equalTo(startLabel.mas_right).offset(3);
    }];
    
    //结束时间文本
    UILabel *endLabel = [[UILabel alloc] init];
    endLabel.text = @"结束时间:";
    endLabel.font = FONT12;
    endLabel.textColor = CustomBlackColor;
    [self addSubview:endLabel];
    
    [endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-9));
        make.left.equalTo(@20);
    }];
    
    [self addSubview:self.end];
    
    [self.end mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(endLabel);
        make.left.equalTo(endLabel.mas_right).offset(3);
    }];
    
    //确定按钮
    [self addSubview:self.confirmButton];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(@0);
        make.width.equalTo(@90);
        make.height.equalTo(@50);
    }];
}

- (void)buttonPressed
{
    if (_confirmBlock) {
        _confirmBlock(self.startTime,self.endTime);
    }
}

#pragma mark - setter
- (void)setStartTime:(NSString *)startTime
{
    _startTime = startTime;
    self.start.text = _startTime;
}

- (void)setEndTime:(NSString *)endTime
{
    _endTime = endTime;
    self.end.text = _endTime;
    if (_endTime) {
        self.confirmButton.backgroundColor = CustomRedColor;
        self.confirmButton.userInteractionEnabled = YES;
    }else {
        self.confirmButton.backgroundColor = RGBCOLOR(225.0,129.0,128.0,1);
        self.confirmButton.userInteractionEnabled = NO;
    }
}

#pragma mark - 懒加载
- (UILabel *)start
{
    if (!_start) {
        _start = [[UILabel alloc] init];
        _start.text = @"";
        _start.font = FONT12;
        _start.textColor = CustomBlackColor;
    }
    return _start;
}

- (UILabel *)end
{
    if (!_end) {
        _end = [[UILabel alloc] init];
        _end.text = @"";
        _end.font = FONT12;
        _end.textColor = CustomBlackColor;
    }
    return _end;
}

- (UIButton *)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmButton.backgroundColor = RGBCOLOR(225.0,129.0,128.0,1);
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = FONT15;
        [_confirmButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
        _confirmButton.userInteractionEnabled = NO;
    }
    return _confirmButton;
}

@end
