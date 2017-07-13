//
//  YZXDaysMenuView.m
//  YZXCalendar
//
//  Created by 尹星 on 2017/6/27.
//  Copyright © 2017年 尹星. All rights reserved.
//

#import "YZXDaysMenuView.h"
#import "YZXCalendarCollectionViewCell.h"
#import "YZXPlainFlowLayout.h"
#import "YZXCalendarHelper.h"
#import "YZXCalendarModel.h"
#import "YZXCalendarCollectionViewHeaderView.h"

#define self_width self.bounds.size.width
#define dayView_width self_width / 7.f

static const CGFloat dayView_Height = 40.0;
static const CGFloat collectionView_headerHeight = 40.0;

@interface YZXDaysMenuView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView           *collectionView;
//collectionView数据
@property (nonatomic, copy) NSArray <YZXCalendarModel *> *collectionViewData;
//manager
@property (nonatomic, strong) YZXCalendarHelper         *calendarHelper;
//数据
@property (nonatomic, strong) YZXCalendarModel           *model;
//用于记录点击的cell
@property (nonatomic, strong) NSMutableArray <NSIndexPath *>            *selectedArray;

@end

static NSString *collectionViewCellIdentify = @"calendarCell";
static NSString *collectionViewHeaderIdentify = @"calendarHeader";

@implementation YZXDaysMenuView {
    NSString *_startDateString;
    NSString *_endDateString;
}

- (instancetype)initWithFrame:(CGRect)frame withStartDateString:(NSString *)startDateString endDateString:(NSString *)endDateString
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _startDateString = startDateString;
        _endDateString = endDateString;
        [self p_initData];
        [self p_initView];
    }
    return self;
}

- (void)p_initData
{
    self.calendarHelper = [[YZXCalendarHelper alloc] init];
    
    self.model = [[YZXCalendarModel alloc] init];
    
    self.selectedArray = [NSMutableArray array];
    
    NSDateFormatter *formatter = [[YZXCalendarHelper new] formatter];
    NSDate *startDate = [formatter dateFromString:_startDateString];
    NSDate *endDate = [formatter dateFromString:_endDateString];
    
    self.collectionViewData = [self.model achieveCalendarModelWithData:startDate toDate:endDate];
}

- (void)p_initView
{
    [self.collectionView registerNib:[UINib nibWithNibName:@"YZXCalendarCollectionViewHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionViewHeaderIdentify];
    [self.collectionView registerNib:[UINib nibWithNibName:@"YZXCalendarCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:collectionViewCellIdentify];
    
    [self addSubview:self.collectionView];
}

- (BOOL)date:(NSDate *)dateA isTheSameDayThan:(NSDate *)dateB
{
    NSDateComponents *componentsA = [self.calendarHelper.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:dateA];
    NSDateComponents *componentsB = [self.calendarHelper.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:dateB];
    
    return componentsA.year == componentsB.year && componentsA.month == componentsB.month && componentsA.day == componentsB.day;
}

#pragma mark - <UICollectionViewDelegate,UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.collectionViewData.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionViewData[section].sectionRow * 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YZXCalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellIdentify forIndexPath:indexPath];
    [cell layoutContentViewOfCollectionViewCellWithCellIndxePath:indexPath model:self.collectionViewData[indexPath.section]];
    
    if ([YZXCalendarHelper.helper determineWhetherForTodayWithIndexPaht:indexPath model:self.collectionViewData[indexPath.section]] == WWTDateEqualToToday && !self.customSelect) {
        [_selectedArray addObject:indexPath];
    }
    
    if (self.selectedArray.count == 2 && [indexPath compare:self.selectedArray.firstObject] == NSOrderedDescending && [indexPath compare:self.selectedArray.lastObject] == NSOrderedAscending) {
        [cell changeContentViewBackgroundColor:[UIColor colorWithRed:255 / 255.0 green:230 / 255.0 blue:230 / 255.0 alpha:1]];
        [cell changeDayTextColor:[UIColor redColor]];
    }
    
    //将选中的按钮改变样式
    [self.selectedArray enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj == indexPath) {
            [cell changeContentViewBackgroundColor:[UIColor redColor]];
            [cell changeDayTextColor:[UIColor whiteColor]];
        }
    }];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //自定义选择
    if (self.customSelect) {
        switch (self.selectedArray.count) {
            case 0:
            {
                //设置点击的cell的样式
                [self p_changeTheSelectedCellStyleWithIndexPath:indexPath];
                
                //记录当前点击的cell
                [self.selectedArray addObject:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
            }
                break;
            case 1:
            {
                if (self.selectedArray.firstObject == indexPath) {
                    [self p_recoveryIsNotSelectedWithIndexPath:self.selectedArray.firstObject];
                    [self.selectedArray removeAllObjects];
                    return;
                }
                //设置点击的cell的样式
                [self p_changeTheSelectedCellStyleWithIndexPath:indexPath];

                //记录当前点击的cell
                [self.selectedArray addObject:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
                
                //对selectedArray进行排序，小的在前，大的在后
                [self p_sortingTheSelectedArray];
                //时间选择完毕，刷新界面
                [self.collectionView reloadData];
            }
                break;
            case 2:
            {
                //重新选择时，将之前点击的cell恢复成为点击状态，并移除数组中所有对象
                [self.selectedArray enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [self p_recoveryIsNotSelectedWithIndexPath:obj];
                }];
                [self.selectedArray removeAllObjects];
                
                //设置点击的cell的样式
                [self p_changeTheSelectedCellStyleWithIndexPath:indexPath];
                
                //记录当前点击的cell
                [self.selectedArray addObject:indexPath];
                
                [self.collectionView reloadData];
            }
                break;
            default:
                break;
        }
    }else {//非自定义选择
        //已经选择
        if (self.selectedArray.count > 0) {
            NSMutableArray <NSIndexPath *> *selectedArray = [NSMutableArray array];
            [self.selectedArray enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                //恢复成为未选中状态
                [self p_recoveryIsNotSelectedWithIndexPath:obj];
                [selectedArray addObject:obj];
            }];
            //移除已恢复的cell
            [self.selectedArray removeObjectsInArray:[selectedArray copy]];
        }
        //设置点击的cell的样式
        [self p_changeTheSelectedCellStyleWithIndexPath:indexPath];
        
        //记录当前点击的按钮
        [self.selectedArray addObject:indexPath];
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        YZXCalendarCollectionViewHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionViewHeaderIdentify forIndexPath:indexPath];
        headerView.textLabel.text = self.collectionViewData[indexPath.section].headerTitle;
        return headerView;
    }
    return nil;
}

//对选中的selectedArray中的数据排序
- (void)p_sortingTheSelectedArray
{
    if ([self.selectedArray.firstObject compare:self.selectedArray.lastObject] == NSOrderedDescending) {
        self.selectedArray = [[[[self.selectedArray copy] reverseObjectEnumerator] allObjects] mutableCopy];
    }
}

//改变选中cell的样式
- (void)p_changeTheSelectedCellStyleWithIndexPath:(NSIndexPath *)indexPath
{
    YZXCalendarCollectionViewCell *cell = (YZXCalendarCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    [cell changeContentViewBackgroundColor:[UIColor redColor]];
    [cell changeDayTextColor:[UIColor whiteColor]];
}

//恢复成为未选中状态
- (void)p_recoveryIsNotSelectedWithIndexPath:(NSIndexPath *)indexPath
{
    //回复之前选择的cell样式
    YZXCalendarCollectionViewCell *selectedCell = (YZXCalendarCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    [selectedCell changeContentViewBackgroundColor:[UIColor whiteColor]];
    
    //判断之前点击的是否为周末和当天
    if ([self p_judgepWeekendAndToday:indexPath]) {
        [selectedCell changeDayTextColor:[UIColor redColor]];
    }else {
        [selectedCell changeDayTextColor:[UIColor blackColor]];
    }

}

//判断是否为周末和当天
- (BOOL)p_judgepWeekendAndToday:(NSIndexPath *)indexPath
{
    BOOL todayFlag = ([YZXCalendarHelper.helper determineWhetherForTodayWithIndexPaht:indexPath model:self.collectionViewData[indexPath.section]] == WWTDateEqualToToday);
    return indexPath.item % 7 == 0 || indexPath.item % 7 == 6 || todayFlag;
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        YZXPlainFlowLayout *layout = [[YZXPlainFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(dayView_width, dayView_Height);
        layout.headerReferenceSize = CGSizeMake(self_width, collectionView_headerHeight);
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.naviHeight = collectionView_headerHeight;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self_width, self.bounds.size.height) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:(self.collectionViewData.lastObject.numberOfDaysOfTheMonth + self.collectionViewData.lastObject.firstDayOfTheMonth - 2) inSection:self.collectionViewData.count - 1] animated:YES scrollPosition:UICollectionViewScrollPositionBottom];
    };
    return _collectionView;
}

- (void)setCustomSelect:(BOOL)customSelect
{
    _customSelect = customSelect;
}

@end
