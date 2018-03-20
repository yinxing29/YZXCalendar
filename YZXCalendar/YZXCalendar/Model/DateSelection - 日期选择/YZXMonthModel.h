//
//  YZXMonthModel.h
//  Replenishment
//
//  Created by 尹星 on 2017/7/20.
//  Copyright © 2017年 ruwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZXMonthModel : NSObject

@property (nonatomic, copy) NSString                  *month;
@property (nonatomic, assign) BOOL                    isSelected;
@property (nonatomic, strong) NSIndexPath             *indexPath;

@end
