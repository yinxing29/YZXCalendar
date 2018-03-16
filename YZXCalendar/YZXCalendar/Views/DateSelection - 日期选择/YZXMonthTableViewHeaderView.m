//
//  YZXMonthTableViewHeaderView.m
//  Replenishment
//
//  Created by 尹星 on 2017/6/30.
//  Copyright © 2017年 ruwang. All rights reserved.
//

#import "YZXMonthTableViewHeaderView.h"

#define self_width self.bounds.size.width
#define self_height self.bounds.size.height

@implementation YZXMonthTableViewHeaderView{
    NSString *_text;
}

- (instancetype)initWithFrame:(CGRect)frame withText:(NSString *)text
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _text = text;
        [self p_initView];
    }
    return self;
}

- (void)p_initView
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self_width, self_height)];
    label.backgroundColor = CustomLineColor;
    label.text = _text;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:10.0];
    [self addSubview:label];
}

@end
