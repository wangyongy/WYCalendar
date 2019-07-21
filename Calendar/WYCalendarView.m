//
//  WYCalendarView.m
//  CalendarDemo
//
//  Created by 王勇 on 2018/5/26.
//  Copyright © 2018年 王勇. All rights reserved.
//

#import "WYCalendarView.h"
#import "WYCalendarMonthView.h"
#import "WYCalendarHeaderView.h"
#import "UIView+WYCategory.h"
#import "WYCalendarCollectionViewCell.h"
#import "WYCalendarMonthCollectionViewCell.h"

@interface WYCalendarView ()

{
    CGFloat _cellWidth;                                                  //日期cell宽度
    
    id _headerSettingBlock;                                              //头部设置回调
    
    id _monthSettingBlock;                                               //月份设置回调
    
    id _daySettingBlock;                                                 //日期设置回调
    
    void(^_confirmBlock)(NSArray <WYCalendarModel *>*selectArray);       //确认结束日期的回调
    
    /**
     styles
     */
    dispatch_block_t _cancelBlock;                                       //取消的回调
    
    void(^_changeMonthBlock)(NSDate * monthDate) ;                       //切换月份的回调
    
    UIColor * _backColor;                                                //背景色
    
    WeekTitleType _weekTitleType;                                        //星期显示类型
    
    CGFloat _weekFontSize;                                               //星期显示文字尺寸
    
    UIColor * _weekTitleColor;                                           //星期显示文字颜色
    
    NSArray * _footerTitleArray;                                         //底部按钮文字数组
    
    CGFloat _footerViewHeight;                                           //底部视图高度
    
    CGFloat _footerButtonWidth;                                          //底部按钮宽度
    
    CGFloat _footerButtonFontSize;                                       //底部按钮文字尺寸
    
    UIColor * _footerButtonColor;                                        //底部按钮文字颜色
    
    BOOL _isAddUpDownGesture;                                            //是否添加上下滑动手势
    
    BOOL _isShowCalendarShadow;                                          //是否显示阴影
    
    BOOL _isShowSwipeAnimation;                                          //是否显示滑动动画
    
    BOOL _isOnlyShowCurrentMonth;                                        //只显示属于当前月份的日期
    
    BOOL _isShowHeaderView;                                              //是否显示头部视图
    
    BOOL _isShowMonthView;                                              //是否显示月份视图
    
    BOOL _isShowWeekView;                                               //是否显示周视图
    
    BOOL _isShowFooterView;                                              //是否显示底部视图
    
    WYSelectType _selectType;                                            //选择日期类型,默认为开始日期+结束日期
    
    void(^_setCustomCellBlock)(UICollectionViewCell *cell,NSDate * date);//自定义cell
}

#pragma mark --- UI

@property (nonatomic, strong)WYCalendarHeaderView *calendarHeaderView;   //头

@property (nonatomic, strong)UIView *calendarFooterView;                 //尾

@property (nonatomic, strong)WYCalendarMonthView *calendarMonthView;     //年-月

@property (nonatomic, strong)UIView *calendarWeekView;                   //周

//@property (nonatomic, strong)UICollectionView *mainCollectionView;           //总日历

@property (nonatomic, strong)UICollectionView *collectionView;           //每月日历

@property (nonatomic, strong)UIView *calendarBackView;                   //日历视图背景

#pragma mark --- data

@property(nonatomic,strong)NSDate *currentDate;                     //当月的日期

@property (nonatomic, strong)NSMutableArray <WYCalendarModel *>* dataArray;                 //数据数组

@property (nonatomic, strong)NSMutableArray <WYCalendarModel *>* previousDataArray;         //上个数据数组

@property (nonatomic, strong)NSMutableArray <WYCalendarModel *>* nextDataArray;             //下个数据数组

@property (nonatomic, strong)NSMutableArray <WYCalendarModel *>* selectArray;               //选中日期数组

@property(nonatomic,assign)BOOL showWeekData;                          //按周显示

@end

@implementation WYCalendarView

#pragma mark ---- public
+ (instancetype)calenderViewWithCalenderFrame:(CGRect)frame selectDateArray:(NSArray *)selectDateArray confirmBlock:(void(^)(NSArray <WYCalendarModel *>*selectArray))confirmBlock
{
    WYCalendarView * view = [[WYCalendarView alloc] initWithFrame:CGRectMake(0, 0, WYScreenWidth, WYScreenHeight)];
    
    [view showViewWithCalenderFrame:frame selectDateArray:selectDateArray confirmBlock:confirmBlock];
    
    return view;
}
- (void)setUpDisplayStyle:(void(^)(dispatch_block_t *cancelBlock,void(^*changeMonthBlock)(NSDate * monthDate) ,UIColor ** backColor,WeekTitleType *weekTitleType,CGFloat *weekFontSize,UIColor **weekTitleColor,NSArray ** footerTitleArray,CGFloat *footerViewHeight,CGFloat *footerButtonWidth,CGFloat *footerButtonFontSize,UIColor ** footerButtonColor,BOOL *isShowCalendarShadow,BOOL *isAddUpDownGesture,BOOL *isShowSwipeAnimation,BOOL *isOnlyShowCurrentMonth,BOOL *isShowHeaderView,BOOL *isShowFooterView,BOOL *isShowMonthView,BOOL *isShowWeekView,WYSelectType *selectType,void(^*setCustomCellBlock)(UICollectionViewCell *cell,NSDate * date)))BaseSettingBlock
{
    
    dispatch_block_t cancelBlock = _cancelBlock;                                            //取消的回调
    
    void(^changeMonthBlock)(NSDate * monthDate) = _changeMonthBlock;                        //切换月份的回调
    
    UIColor * backColor = _backColor;                                                       //基础背景色
    
    WeekTitleType weekTitleType = _weekTitleType;                                           //星期显示类型
    
    CGFloat weekFontSize = _weekFontSize;                                                   //星期显示文字尺寸
    
    UIColor *weekTitleColor = _weekTitleColor;                                              //星期显示文字颜色
    
    NSArray * footerTitleArray = _footerTitleArray;                                         //底部按钮文字数组
    
    CGFloat footerViewHeight = _footerViewHeight;                                           //底部视图高度
    
    CGFloat footerButtonWidth = _footerButtonWidth;                                         //底部按钮宽度
    
    CGFloat footerButtonFontSize = _footerButtonFontSize;                                   //底部按钮文字尺寸
    
    UIColor * footerButtonColor = _footerButtonColor;                                       //底部按钮文字颜色
    
    BOOL isShowCalendarShadow = _isShowCalendarShadow;                                      //是否显示阴影
    
    BOOL isAddUpDownGesture = _isAddUpDownGesture;                                          //是否添加上下滑动手势
    
    BOOL isShowSwipeAnimation = _isShowSwipeAnimation;                                      //是否显示滑动动画
    
    BOOL isOnlyShowCurrentMonth = _isOnlyShowCurrentMonth;                                  //只显示属于当前月份的日期
    
    BOOL isShowHeaderView = _isShowHeaderView;                                              //是否显示头部视图
    
    BOOL isShowFooterView = _isShowFooterView;                                              //是否显示底部视图
    
    BOOL isShowMonthView = _isShowMonthView;                                                //是否显示月份视图
    
    BOOL isShowWeekView = _isShowWeekView;                                                  //是否显示周视图
    
    WYSelectType selectType = _selectType;                                                  //选择日期类型
    
    void(^setCustomCellBlock)(UICollectionViewCell *cell,NSDate * date) = _setCustomCellBlock;//自定义cell
    
    if (BaseSettingBlock) {
        BaseSettingBlock(&cancelBlock,&changeMonthBlock,&backColor,&weekTitleType,&weekFontSize,&weekTitleColor,&footerTitleArray,&footerViewHeight,&footerButtonWidth,&footerButtonFontSize,&footerButtonColor,&isShowCalendarShadow,&isAddUpDownGesture,&isShowSwipeAnimation,&isOnlyShowCurrentMonth,&isShowHeaderView,&isShowFooterView,&isShowMonthView,&isShowWeekView,&selectType,&setCustomCellBlock);
        
        _cancelBlock = cancelBlock;
        
        _changeMonthBlock = changeMonthBlock;
        
        _backColor = backColor;
        
        _weekTitleType = weekTitleType;
        
        _weekFontSize = weekFontSize;
        
        _weekTitleColor = weekTitleColor;
        
        _footerTitleArray = footerTitleArray;
        
        _footerViewHeight = footerViewHeight;
        
        _footerButtonWidth = footerButtonWidth;
        
        _footerButtonFontSize = footerButtonFontSize;
        
        _footerButtonColor = footerButtonColor;
        
        _isShowCalendarShadow = isShowCalendarShadow;
        
        _isAddUpDownGesture = isAddUpDownGesture;
        
        _isShowSwipeAnimation = isShowSwipeAnimation;
        
        _isOnlyShowCurrentMonth = isOnlyShowCurrentMonth;
        
        _isShowHeaderView = isShowHeaderView;
        
        _isShowFooterView = isShowFooterView;
        
        _isShowMonthView = isShowMonthView;
        
        _isShowWeekView = isShowWeekView;
        
        _selectType = selectType;
        
        _setCustomCellBlock = setCustomCellBlock;
    }
}
- (void)setUpHeaderStyle:(void(^)(NSArray **titleArray,WeekTitleType *weekTitleType,BOOL      *isEnglishMonth,UIColor **backColor,UIColor **titleColor,UIColor **yearColor,UIColor **dayColor,CGFloat *leftSpaceX,CGFloat *topSpaceY,CGFloat *titleHeight,CGFloat *yearHeight,CGFloat *dayHegiht,CGFloat *titleFontSize,CGFloat *yearFontSize,CGFloat *dayFontSize))headerSettingBlock
{
    _headerSettingBlock = headerSettingBlock;
}
- (void)setUpMonthStyle:(void(^)(UIColor ** monthColor,CGFloat *monthFontSize,CGFloat *monthButtonWidth,CGFloat *monthSpace,BOOL *isEnglishMonth))monthSettingBlock
{
    _monthSettingBlock = monthSettingBlock;
}
- (void)setUpDayCellStyle:(void(^)(UIColor ** currentMonthTitleColor,UIColor ** currentMonthChineseTitleColor,UIColor ** todayTitleColor,UIColor ** notCurrentMonthTitleColor,UIColor ** selectTitleColor,UIColor ** weekendTitleColor,UIColor ** selectBackColor,UIColor ** backColor,UIColor ** endSelectBackColor,CGFloat *dayFontSize,CGFloat *dayLabelSize,BOOL *showAnimation,BOOL *showChineseDate))daySettingBlock
{
    _daySettingBlock = daySettingBlock;
}
#pragma mark -
#pragma mark ---- private

#pragma mark - 初始化
- (void)showViewWithCalenderFrame:(CGRect)frame selectDateArray:(NSArray *)selectDateArray confirmBlock:(void(^)(NSArray <WYCalendarModel *>*selectArray))confirmBlock
{
    _selectArray = [NSMutableArray arrayWithArray:selectDateArray];
    
    for (WYCalendarModel * selectModel in _selectArray) {
        
        selectModel.status |= WYCalendarStartSelected;
        
    }
    _confirmBlock = confirmBlock;
    
    _cellWidth = frame.size.width/7;
    
    _calendarBackView = [[UIView alloc] initWithFrame:frame];
    
    _calendarBackView.backgroundColor = WYUIColorFromRGB(0xffffff);

    [self setDefaultData];
}
- (void)willMoveToSuperview:(UIView *)newSuperview{
    
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview) {
        
        [self setupViews];
        
        [self setUpGestures];
        
        [self reloadData];
        
        [self.collectionView reloadData];
    }
}
- (void)setupViews
{
    _calendarBackView.backgroundColor = _backColor;
    
    [_calendarBackView addSubview:self.calendarHeaderView];
    
    [_calendarBackView addSubview:self.calendarMonthView];
    
    [_calendarBackView addSubview:self.calendarWeekView];
    
    [_calendarBackView addSubview:self.collectionView];
    
    [_calendarBackView addSubview:self.calendarFooterView];
    
    _calendarBackView.Height = _calendarFooterView.Bottom;
    
    [self.collectionView setContentOffset:CGPointMake(self.collectionView.frame.size.width, 0) animated:NO];
    
    if (_isShowCalendarShadow) {
        /**
         阴影设置
         */
        _calendarBackView.layer.shadowColor = WYUIColorFromRGB(0x000000).CGColor;
        
        _calendarBackView.layer.shadowOpacity = 0.5f;
        
        _calendarBackView.layer.shadowRadius = 4.f;
        
        _calendarBackView.layer.shadowOffset = CGSizeMake(0, 4);
    }
    
    [self addSubview:_calendarBackView];
}
#pragma mark - data
- (void)setDefaultData
{
    if (!_selectArray) _selectArray = [NSMutableArray array];
    
    /**
     default styles
     */
    _weekTitleType = WeekTitleTypeEnglishShort;
    
    _weekFontSize = 10;
    
    _weekTitleColor = WYUIColorFromRGB(0x999999);
    
    _backColor = [WYUIColorFromRGB(0x000000) colorWithAlphaComponent:0.1];
    
    _footerTitleArray = @[@"取消",@"确认"];
    
    _footerButtonWidth = 32;
    
    _footerViewHeight = 18;
    
    _footerButtonFontSize = 7;
    
    _footerButtonColor = WYUIColorFromRGB(0x0fc6a6);
    
    _isShowCalendarShadow = YES;
    
    _isShowSwipeAnimation = YES;
    
    _isOnlyShowCurrentMonth = NO;
    
    _isShowHeaderView = YES;
    
    _isShowFooterView = YES;
    
    _isShowMonthView = YES;
    
    _isShowWeekView = YES;
    
    _selectType = WYSelectTypeTwo;
    
    _setCustomCellBlock = nil;
}
- (NSMutableArray *)loadWeekData:(NSDate *)weekDate
{
    NSMutableArray * dataArray = [NSMutableArray array];
    
    NSDate * date = weekDate.weekDate.zeroDayDate;
    
    for (NSInteger i = 0; i < 7; i++) {
        
        WYCalendarModel * model = [WYCalendarModel modelWithDate:date];
        
        date = date.nextDayDate;
        
        model.status |= WYCalendarCurrentMonth;
        
        for (WYCalendarModel * selectModel in _selectArray) {
            
            if ([model isEqual:selectModel] && (model.status & WYCalendarCurrentMonth)) {
                
                selectModel.status |= WYCalendarCurrentMonth;
                
                model.status = selectModel.status;
            }
        }
        
        [dataArray addObject:model];
    }
    
    return dataArray;
}
- (NSMutableArray *)loadMonthData:(NSDate *)monthDate
{
    NSMutableArray * dataArray = [NSMutableArray array];
    
    /**
     一共最多6x7=42个model
     */
    for (NSInteger i = 0; i < 42; i++) {
        
        /**
         以当前日期初始化日期模型，再重新为day属性赋值
         */
        WYCalendarModel * model = [WYCalendarModel modelWithDate:monthDate];
        
        //上个月的日期
        if (i < model.firstWeekday) {
            
            model.day = _isOnlyShowCurrentMonth ? 0 : ([monthDate.previousMonthDate totalDaysInMonth] - (model.firstWeekday - i) + 1);
            
            model.month = monthDate.previousMonthDate.dateMonth;
            
            model.year = monthDate.previousMonthDate.dateYear;
        }
        //当月的日期
        else if (i < (model.firstWeekday + [monthDate totalDaysInMonth])) {
            
            model.day = i - model.firstWeekday + 1;
            
            model.status |= WYCalendarCurrentMonth;
        }
        //下月的日期
        else {
            
            model.day = _isOnlyShowCurrentMonth ? 0 : (i - model.firstWeekday - [monthDate totalDaysInMonth] + 1);
            
            model.month = monthDate.nextMonthDate.dateMonth;
            
            model.year = monthDate.nextMonthDate.dateYear;
        }
        
        for (WYCalendarModel * selectModel in _selectArray) {
            
            if ([model isEqual:selectModel] && (model.status & WYCalendarCurrentMonth)) {
                
                selectModel.status |= WYCalendarCurrentMonth;
                
                model.status = selectModel.status;
            }
        }
        
        if (i == 35 && !(model.status & WYCalendarCurrentMonth)) {
            
            break;
        }
        
        [dataArray addObject:model];
    }
    
    return dataArray;
}
- (void)loadDataArray
{
    if (_showWeekData) {
        
        self.dataArray = [NSMutableArray arrayWithArray:[self loadWeekData:self.currentDate]];
        
        self.previousDataArray = [NSMutableArray arrayWithArray:[self loadWeekData:self.currentDate.previousWeekDate]];
        
        self.nextDataArray = [NSMutableArray arrayWithArray:[self loadWeekData:self.currentDate.nextWeekDate]];
        
        return;
    }
    
    self.dataArray = [NSMutableArray arrayWithArray:[self loadMonthData:self.currentDate]];
    
    self.previousDataArray = [NSMutableArray arrayWithArray:[self loadMonthData:self.currentDate.previousMonthDate]];
    
    self.nextDataArray = [NSMutableArray arrayWithArray:[self loadMonthData:self.currentDate.nextMonthDate]];
}
- (void)reloadData
{
    if (_selectType != WYSelectTypeOne) {
        
        [_selectArray removeAllObjects];
        
    }else if (_selectArray.count){
        
        WYCalendarModel * selectModel = _selectArray.firstObject;
        
        if (self.currentDate == nil) {
            
           self.currentDate = selectModel.date;
        }
    }
    
    if (self.currentDate == nil) {
        
        self.currentDate = [NSDate date];  //默认显示当前月份
    }
    
    [self loadDataArray];
    
    if (_selectType == WYSelectTypeOne && _selectArray.count) {
        
        WYCalendarModel * selectModel = _selectArray.firstObject;
        
        self.calendarHeaderView.model = selectModel;
    }
    
    self.calendarMonthView.model = [WYCalendarModel modelWithDate:self.currentDate];
}
#pragma mark - 手势、动画

- (void)setUpGestures
{
    if (!_isAddUpDownGesture) {
        
        return;
    }
    
    //添加上滑下滑手势
    UISwipeGestureRecognizer * upSwipe = [UISwipeGestureRecognizer initWithBlockAction:^(UIGestureRecognizer *sender) {
        
        [self turnToUpOrDown:YES];
    }];
    
    UISwipeGestureRecognizer * downSwipe = [UISwipeGestureRecognizer initWithBlockAction:^(UIGestureRecognizer *sender) {
        
        [self turnToUpOrDown:NO];
    }];
    
    upSwipe.direction = UISwipeGestureRecognizerDirectionUp;
    
    downSwipe.direction = UISwipeGestureRecognizerDirectionDown;
    
    [self addGestureRecognizer:upSwipe];
    
    [self addGestureRecognizer:downSwipe];
}
- (void)turnToUpOrDown:(BOOL)up
{
    _showWeekData = up;
    
    if (!up) {
        
        NSLog(@"下滑");
        
        if (self.dataArray.count > 7) return;
        
        [self reloadData];
        
        [UIView animateWithDuration:0.5 animations:^{
            
            [self.collectionView reloadData];
        }];
        
        return;
    }
    
    NSLog(@"上滑");
    
    if (7 == self.dataArray.count) return;
    
    WYCalendarModel * selectModel = [self.selectArray firstObject];

    if (selectModel != nil) {
        
        NSInteger selectIndex = selectModel.firstWeekday + selectModel.day - 1;
        
        self.currentDate = self.dataArray[selectIndex].date;
    }
    
    [self reloadData];
    
    [UIView animateWithDuration: 0.5 animations:^{
        
        [self.collectionView reloadData];
    }];
}
/**
 左右切换
 
 @param left YES为向左滑动
 */
- (void)turnToLeftOrRight:(BOOL)left
{
    if (_isShowSwipeAnimation) {
        
        self.collectionView.clipsToBounds = YES;
        
        self.collectionView.layer.masksToBounds = YES;
        
        CATransition *catransition = [CATransition animation];
        
        catransition.duration = 0.5;
        
        [catransition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        
        catransition.type = kCATransitionPush;
        
        catransition.subtype = left ? kCATransitionFromLeft : kCATransitionFromRight;
        
        [self.collectionView.layer addAnimation:catransition forKey:nil];
    }
    
    self.currentDate = left ? _currentDate.previousMonthDate : _currentDate.nextMonthDate;
    
    [self reloadData];
    
    [self.collectionView reloadData];
    
    if (_changeMonthBlock) _changeMonthBlock(_currentDate);
}

#pragma mark - 懒加载
- (UIView *)calendarHeaderView
{
    if (!_calendarHeaderView) {
        
        _calendarHeaderView = [WYCalendarHeaderView headerViewWithFrame:CGRectMake(0, 0, _calendarBackView.Width, _selectType != WYSelectTypeTwo ? 50 : 60) isStartDate:_selectType != WYSelectTypeTwo ? YES : !_selectArray.count];
        
        if (!_isShowHeaderView) {
            
            _calendarHeaderView.Height = 0;
            
            _calendarHeaderView.hidden = YES;
        }
        
        if (_selectType != WYSelectTypeTwo) {
            
            [_calendarHeaderView setUpHeaderStyle:^(NSArray *__autoreleasing *titleArray, WeekTitleType *weekTitleType, BOOL *isEnglishMonth, UIColor *__autoreleasing *backColor, UIColor *__autoreleasing *titleColor, UIColor *__autoreleasing *yearColor, UIColor *__autoreleasing *dayColor, CGFloat *leftSpaceX, CGFloat *topSpaceY, CGFloat *titleHeight, CGFloat *yearHeight, CGFloat *dayHegiht, CGFloat *titleFontSize, CGFloat *yearFontSize, CGFloat *dayFontSize) {
                
                *titleHeight = *titleFontSize = 0;
            }];
        }
        
        [_calendarHeaderView setUpHeaderStyle:_headerSettingBlock];
    }
    
    return _calendarHeaderView;
}

- (WYCalendarMonthView *)calendarMonthView
{
    if (!_calendarMonthView) {
        
        WYWS(weakSelf)
        
        _calendarMonthView = [WYCalendarMonthView monthViewWithFrame:CGRectMake(0, _calendarHeaderView.Bottom, _calendarBackView.Width, _cellWidth) leftButtonBlock:^{;
            
            [weakSelf turnToLeftOrRight:YES];
            
        } rightButtonBlock:^{
            
            [weakSelf turnToLeftOrRight:NO];
        }];
        
        _calendarMonthView.model = [WYCalendarModel modelWithDate:[NSDate date]];
        
        [_calendarMonthView setUpMonthStyle:_monthSettingBlock];
    }
    
    if (!_isShowMonthView) {
        
        _calendarMonthView.Height = 0;
        
        _calendarMonthView.hidden = YES;
    }
    
    return _calendarMonthView;
}

- (UIView *)calendarWeekView{
    
    if (!_calendarWeekView) {
        
        _calendarWeekView = [[UIView alloc]initWithFrame:CGRectMake(0, _calendarMonthView.Bottom, _calendarBackView.Width, _cellWidth)];
        
        NSArray * weekTitleArray = [WYCalendarTool getWeekTitleArrayWithType:_weekTitleType];
        
        CGFloat width = _calendarBackView.Width/weekTitleArray.count;
        
        for (int i = 0; i < weekTitleArray.count; i++) {
            
            UILabel *weekLabel = [WYCalendarTool initLabelWithFrame:CGRectMake(i * width, 0, width, width) text:weekTitleArray[i] fontSize:_weekFontSize textColor:_weekTitleColor aliment:NSTextAlignmentCenter];
            
            [_calendarWeekView addSubview:weekLabel];
        }
    }
    
    if (!_isShowWeekView) {
        
        _calendarWeekView.Height = 0;
        
        _calendarWeekView.hidden = YES;
    }
    
    return _calendarWeekView;
}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {

        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];

        flowLayout.minimumInteritemSpacing = 0.0f;

        flowLayout.minimumLineSpacing = 0.0f;

        flowLayout.itemSize = CGSizeMake(_calendarBackView.Width, 6 * _cellWidth);
        
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.calendarWeekView.Bottom, _calendarBackView.Width, 6 * _cellWidth) collectionViewLayout:flowLayout];

        _collectionView.delegate = (id<UICollectionViewDelegate>)self;

        _collectionView.dataSource = (id<UICollectionViewDataSource>)self;

        _collectionView.showsVerticalScrollIndicator = NO;

        _collectionView.showsHorizontalScrollIndicator = NO;
        
        _collectionView.pagingEnabled = YES;
        
        [_collectionView registerClass:[WYCalendarMonthCollectionViewCell class] forCellWithReuseIdentifier:@"collecitonViewCell"];

        _collectionView.backgroundColor = _backColor;
    }

    return _collectionView;
}
- (UIView *)calendarFooterView
{
    if (!_calendarFooterView) {
        
        _calendarFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, _collectionView.Bottom, _calendarBackView.Width, _footerViewHeight)];
        
        WYWS(weakSelf)
        
        UIButton * confirmButton = [UIButton initWithFrame:CGRectMake(_calendarBackView.Width - _footerButtonWidth - 3, 0, _footerButtonWidth, _footerViewHeight) title:_footerTitleArray[1] fontSize:_footerButtonFontSize buttonAction:^(id sender) {
            
            WYST(strongSelf)
            
            if (strongSelf->_selectArray.count == 2 || (strongSelf->_selectArray.count > 0 && strongSelf->_selectType != WYSelectTypeTwo)) {
                
                if (strongSelf->_confirmBlock) {
                    
                    strongSelf->_confirmBlock(weakSelf.selectArray);
                }
                
            }else if (strongSelf->_selectArray.count == 1){
                
                weakSelf.calendarHeaderView.isStartDate = NO;
                
                weakSelf.calendarHeaderView.model = nil;
            }
            
        } color:_footerButtonColor];
        
        UIButton * cancelButton = [UIButton initWithFrame:CGRectMake(confirmButton.X - _footerButtonWidth - 3, 0, _footerButtonWidth, _footerViewHeight) title:_footerTitleArray[0] fontSize:_footerButtonFontSize buttonAction:^(id sender) {
            
            WYST(strongSelf)
            
            if (strongSelf->_cancelBlock) {
                
                strongSelf->_cancelBlock();
            }
            
        } color:_footerButtonColor];
        
        [_calendarFooterView addSubview:confirmButton];
        
        [_calendarFooterView addSubview:cancelButton];
        
        if (!_isShowFooterView) {
            
            _calendarFooterView.Height = 0;
            
            _calendarFooterView.hidden = YES;
        }
    }
    
    return _calendarFooterView;
}
- (NSMutableArray *)selectArray
{
    if (!_selectArray) {
        
        _selectArray = [NSMutableArray array];
    }
    
    if (_selectArray.count > 1) {
        
        [WYCalendarTool sortCaledarModelArray:_selectArray];
    }
    
    return _selectArray;
}
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return !CGRectContainsPoint(_calendarBackView.frame, [touch locationInView:self]);
}
#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 3;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIndentifier = @"collecitonViewCell";
    
    WYCalendarMonthCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifier forIndexPath:indexPath];
    
    if (!cell) {
        
        cell = [[WYCalendarMonthCollectionViewCell alloc] init];
    }
    
    cell.contentView.backgroundColor = cell.backgroundColor = _backColor;
    
    __weak UICollectionView * view = cell.collectionView;
    
    cell.selectBlock = ^(NSIndexPath * _Nonnull index) {
      
        [self daycollectionView:view didSelectItemAtIndexPath:index];
    };
    
    switch (indexPath.row) {
        case 0:
            cell.dataArray = self.previousDataArray;
            break;
        case 1:
            cell.dataArray = self.dataArray;
            break;
        case 2:
            cell.dataArray = self.nextDataArray;
            break;
            
        default:
            break;
    }
    
    cell.calendarView = self;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark - scrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [UIView performWithoutAnimation:^{
       
        if (self.collectionView.contentOffset.x < self.collectionView.frame.size.width || self.collectionView.contentOffset.x >= self.collectionView.frame.size.width*2) {
            
            if (self.collectionView.contentOffset.x < self.collectionView.frame.size.width) {
                
                self.currentDate = self.showWeekData ? self.currentDate.previousWeekDate : self.currentDate.previousMonthDate;
                
            }else{
             
                self.currentDate = self.showWeekData ? self.currentDate.nextWeekDate : self.currentDate.nextMonthDate;
            }
            
            if (self->_changeMonthBlock) self->_changeMonthBlock(self->_currentDate);
            
            [self reloadData];
            
            [self.collectionView reloadData];
            
            [self.collectionView setContentOffset:CGPointMake(self.collectionView.frame.size.width, 0) animated:NO];
        }
    }];
}
#pragma mark -
- (void)daycollectionView:(UICollectionView *)daycollectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= self.dataArray.count)return;
    
    WYCalendarModel *model = self.dataArray[indexPath.row];
    
    if (!(model.status & WYCalendarCurrentMonth)){
        
        BOOL isPrevious = model.month == _currentDate.previousMonthDate.dateMonth;
        
        [self turnToLeftOrRight:isPrevious];
        
        [self collectionView:daycollectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:isPrevious ? (self.dataArray.count - 7 + indexPath.row) : indexPath.row%7 inSection:0]];
        
        return;
    }
    
    if (_calendarHeaderView.isStartDate) {
        
        (model.status & WYCalendarStartSelected) ? (model.status -= WYCalendarStartSelected) : (model.status |= WYCalendarStartSelected);
        
    }else{
        
        (model.status & WYCalendarEndSelected) ? (model.status -= WYCalendarEndSelected) : (model.status |= WYCalendarEndSelected);
    }
    
    WYWS(weakSelf)
    
    NSMutableArray * reloadArray = [NSMutableArray arrayWithObject:indexPath];
    
    if (_selectType != WYSelectTypeMulti) {
        
        [self.dataArray enumerateObjectsUsingBlock:^(WYCalendarModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (obj != model) {
                
                if (weakSelf.calendarHeaderView.isStartDate) {
                    
                    if (obj.status & WYCalendarStartSelected) {
                        
                        obj.status -= WYCalendarStartSelected;
                        
                        [reloadArray addObject:[NSIndexPath indexPathForRow:[self.dataArray indexOfObject:obj] inSection:0]];
                    }
                    
                }else{
                    
                    if (obj.status & WYCalendarEndSelected) {
                        
                        obj.status -= WYCalendarEndSelected;
                        
                        [reloadArray addObject:[NSIndexPath indexPathForRow:[self.dataArray indexOfObject:obj] inSection:0]];
                    }
                }
            }
        }];
    }
    
    self.calendarHeaderView.model = model;
    
    [daycollectionView reloadItemsAtIndexPaths:reloadArray];
    
    for (WYCalendarModel * selectModel in _selectArray) {
        
        if ([model isEqual:selectModel] && selectModel.status == model.status && ((!(model.status & WYCalendarStartSelected) && self.calendarHeaderView.isStartDate) || (!(model.status & WYCalendarEndSelected) && !self.calendarHeaderView.isStartDate))) {
            
            [_selectArray removeObject:selectModel];
            
            self.calendarHeaderView.model = nil;
            
            return;
        }
    }
    
    if (!_selectArray.count || (_selectArray.count == 1 && !self.calendarHeaderView.isStartDate) || _selectType == WYSelectTypeMulti) {
        
        [_selectArray addObject:model];
        
    }else {
        
        [_selectArray replaceObjectAtIndex:_selectArray.count - 1 withObject:model];
    }
    
    if (!_isShowFooterView) {
        
        if (_confirmBlock) {
            _confirmBlock(self.selectArray);
        }
    }
}
@end
