//
//  SJPageNavigationView.m
//  SJPageNavigationView
//
//  Created by Sun Shijie on 2017/5/20.
//  Copyright © 2017年 Shijie. All rights reserved.
//

#import "SJPageNavigationView.h"
#import <JSBadgeView/JSBadgeView.h>

static const CGFloat indicatorLineHeight = 2;

@interface SJPageNavigationView()

@property (nonatomic, copy) NSArray *titleBtns;
@property (nonatomic, strong) UIView *indicatorLine;
@property (nonatomic, copy) NSArray *titles;

@property (nonatomic, strong) UIView             *topView;
@property (nonatomic, strong) UIView             *bottomView;

@end

@implementation SJPageNavigationView
{
    NSUInteger _preSelectedIndex;
    NSUInteger _titleCount;
    CGFloat _titleBtnWidth;
    CGFloat _titleBtnHeiht;
    UIFont *_titleFont;
    UIColor *_selectedTitleColor;
    UIColor *_unSelectedTitleColor;
    UIColor *_bgColor;
    NSArray *_badgeNumbers;
    BOOL _showBadge;
    BOOL _oneSection;
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray <NSString *>*)titles dataSource:(id<SJPageNavigationViewDataSource>)dataSource selectedIndex:(NSUInteger)originalIndex
{
    if (titles.count <= 0) {
        return nil;
    }
    
    if (titles.count == 1) {
        _oneSection = YES;
    }
    
    self = [super initWithFrame:frame];
    if (self) {        
        _preSelectedIndex = originalIndex;
        _titles = titles;
        _titleCount = titles.count;
        _titleBtnWidth = frame.size.width/_titleCount;
        _titleBtnHeiht = frame.size.height;
        
        self.backgroundColor = [UIColor whiteColor];
        
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 0.5, SCREEN_WIDTH, 0.5)];
        _bottomView.backgroundColor =[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
        [self addSubview:_bottomView];
        
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        _topView.backgroundColor =[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
        [self addSubview:_topView];
        
        [self configurationWidthDataSource:dataSource];
        [self createButtons];
        [self createIndicatorLine];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray <NSString *>*)titles dataSource:(id<SJPageNavigationViewDataSource>)dataSource
{
    return [self initWithFrame:frame titles:titles dataSource:dataSource selectedIndex:0];
}


- (void)configurationWidthDataSource:(id<SJPageNavigationViewDataSource>)dataSource
{
    _sjDataSource = dataSource;
    
    if ([_sjDataSource respondsToSelector:@selector(selectedTitleColor)] && [_sjDataSource selectedTitleColor]) {
        _selectedTitleColor = [_sjDataSource selectedTitleColor];
    }else{
        _selectedTitleColor = [UIColor redColor];
    }
    
    if ([_sjDataSource respondsToSelector:@selector(titleFont)] && [_sjDataSource titleFont]) {
        _titleFont = [_sjDataSource titleFont];
    }else{
        _titleFont = [UIFont systemFontOfSize:12];
    }
    
    if ( [_sjDataSource respondsToSelector:@selector(bgColor)] && [_sjDataSource bgColor]) {
        _bgColor = [_sjDataSource bgColor];
    }else{
        _bgColor = [UIColor whiteColor];
    }
    
    if ([_sjDataSource respondsToSelector:@selector(unSelectedTitleColor)] && [_sjDataSource unSelectedTitleColor]) {
        _unSelectedTitleColor = [_sjDataSource unSelectedTitleColor];
    }else{
        _unSelectedTitleColor = [UIColor blackColor];
    }
    
    if ([_sjDataSource respondsToSelector:@selector(badgeNumbers)]) {
        _badgeNumbers = [_sjDataSource  badgeNumbers];
        if (_badgeNumbers.count == _titleCount) {
            _showBadge = YES;
        }
    }
}

- (void)createButtons
{
    NSMutableArray *btnsArray = [[NSMutableArray alloc] initWithCapacity:2];
    
    
    for (NSUInteger index = 0; index < _titleCount; index++) {
        
        UIButton *button = [[UIButton alloc] init];
        if (index == _preSelectedIndex && (!_oneSection)) {
            [button setTitleColor:_selectedTitleColor forState:UIControlStateNormal];
        }else{
            [button setTitleColor:_unSelectedTitleColor forState:UIControlStateNormal];
        }
        button.titleLabel.font = _titleFont;
        button.tag = index;
        [button addTarget:self action:@selector(didSelectedButtonIndex:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(index * _titleBtnWidth, 0, _titleBtnWidth, _titleBtnHeiht);
        [button setTitle:_titles[index] forState:UIControlStateNormal];
        
        UILabel *label = button.titleLabel;
        if (_showBadge) {
            
            JSBadgeView *badgeView = [[JSBadgeView alloc] initWithParentView:label alignment:JSBadgeViewAlignmentCenterRight];
            badgeView.badgeTextFont = [UIFont systemFontOfSize:12];
            badgeView.badgeText = [NSString stringWithFormat:@"%@",_badgeNumbers[index]];
        }
        
        [btnsArray addObject:button];
        [self addSubview:button];
        
    }
    _titleBtns = [btnsArray copy];
}

- (void)createIndicatorLine
{
    if (!_oneSection) {
        UIView *indicatorLine = [[UIView alloc] initWithFrame:CGRectMake( _titleBtnWidth/4 + _preSelectedIndex * _titleBtnWidth , self.bounds.size.height - indicatorLineHeight, _titleBtnWidth/2, indicatorLineHeight)];
        indicatorLine.backgroundColor = _selectedTitleColor;
        self.indicatorLine = indicatorLine;
        [self addSubview:self.indicatorLine];
    }
}


- (void)didSelectedButtonIndex:(UIButton *)button
{
    [self setSelectedIndex:button.tag];
}

- (void)refreshWithTitles:(NSArray *)titles selectedIndex:(NSUInteger)index
{
    
}

#pragma mark - setter
- (void)setSelectedIndex:(NSUInteger)index
{
    if (index == _preSelectedIndex) {
        return;
    }
    
    if (_oneSection) {
        return;
    }
    
    [UIView animateWithDuration:0.15 animations:^{
        
        [_titleBtns enumerateObjectsUsingBlock:^(UIButton *titleBtn, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ( index == idx) {
                [titleBtn setTitleColor:_selectedTitleColor forState:UIControlStateNormal];
                
            }else{
                [titleBtn setTitleColor:_unSelectedTitleColor forState:UIControlStateNormal];
            }
        }];
        
        CGPoint center = self.indicatorLine.center;
        center.x = index * _titleBtnWidth + _titleBtnWidth/2;
        self.indicatorLine.center = center;
        
    } completion:^(BOOL finished) {
        
        _preSelectedIndex = index;
        if ([self.sjDelegate respondsToSelector:@selector(didSelectedIndex:)]) {
            [self.sjDelegate didSelectedIndex:index];
        }
        
    }];
}

- (void)setIsShowTopView:(BOOL)isShowTopView
{
    _isShowTopView = isShowTopView;
    _topView.hidden = !_isShowTopView;
}

- (void)setIsShowBottomView:(BOOL)isShowBottomView
{
    _isShowBottomView = isShowBottomView;
    _bottomView.hidden = !_isShowBottomView;
}

@end
