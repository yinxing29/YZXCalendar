//
//  YZXCustomDateBottomView.h
//  Replenishment
//
//  Created by 尹星 on 2017/7/19.
//  Copyright © 2017年 ruwang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ConfirmBlock) (NSString *startTime,NSString *endTime);

@interface YZXCustomDateBottomView : UIView

@property (nonatomic, copy) NSString             *startTime;
@property (nonatomic, copy) NSString             *endTime;

@property (nonatomic, copy) ConfirmBlock             confirmBlock;

@end
