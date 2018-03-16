//
//  SJPageNavigationView.h
//  SJPageNavigationView
//
//  Created by Sun Shijie on 2017/5/20.
//  Copyright © 2017年 Shijie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SJPageNavigationViewDelegate <NSObject>

- (void)didSelectedIndex:(NSUInteger)index;

@end

@protocol SJPageNavigationViewDataSource <NSObject>

@required
- (UIColor *)selectedTitleColor;
- (UIFont *)titleFont;


@optional
- (UIColor *)unSelectedTitleColor;
- (UIColor *)bgColor;
- (NSArray *)badgeNumbers;

@end



@interface SJPageNavigationView : UIView

@property (nonatomic, weak) id<SJPageNavigationViewDelegate> sjDelegate;
@property (nonatomic, weak) id<SJPageNavigationViewDataSource> sjDataSource;

//指定初始化方法：可调整最开始时的index
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray <NSString *>*)titles dataSource:(id<SJPageNavigationViewDataSource>)dataSource selectedIndex:(NSUInteger)originalIndex;

//间接初始化方法：最开始时的index默认为0
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray <NSString *>*)titles dataSource:(id<SJPageNavigationViewDataSource>)dataSource;

//手动设定选型index
- (void)setSelectedIndex:(NSUInteger)index;

//是否显示底部分割线(默认显示)
@property (nonatomic, assign) BOOL         isShowBottomView;

//是否显示顶部分割线(默认显示)
@property (nonatomic, assign) BOOL         isShowTopView;

@end
