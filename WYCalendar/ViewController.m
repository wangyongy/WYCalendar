//
//  ViewController.m
//  WYCalendar
//
//  Created by 王勇 on 2018/5/30.
//  Copyright © 2018年 王勇. All rights reserved.
//

#import "ViewController.h"
#import "WYCalendarView.h"
#define ScreenWidth     [[UIScreen mainScreen] bounds].size.width   //屏幕宽度
#define UIColorFromRGB(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0] //rgb颜色
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WYUIColorFromRGB(0xf0f0f0);
    
    [self initCalendarView];
    
}

- (void)initCalendarView
{
    
    self.title = [NSString stringWithFormat:@"%zd年%zd月",[NSDate date].dateYear,[NSDate date].dateMonth];
    
    WYCalendarView * view =  [WYCalendarView calenderViewWithCalenderFrame:CGRectMake(40, 100 + 20, ScreenWidth - 80, 0) selectDateArray:@[[WYCalendarModel modelWithDate:[NSDate date]]] confirmBlock:^(NSArray<WYCalendarModel *> *selectArray) {
        
        
    }];
    
    [view setUpDisplayStyle:^(__autoreleasing dispatch_block_t *cancelBlock, void (^__autoreleasing *changeMonthBlock)(NSDate *__strong), UIColor *__autoreleasing *backColor, WeekTitleType *weekTitleType, CGFloat *weekFontSize, UIColor *__autoreleasing *weekTitleColor, NSArray *__autoreleasing *footerTitleArray, CGFloat *footerViewHeight, CGFloat *footerButtonWidth, CGFloat *footerButtonFontSize, UIColor *__autoreleasing *footerButtonColor, BOOL *isShowCalendarShadow, BOOL *isAddUpDownGesture, BOOL *isShowSwipeAnimation, BOOL *isOnlyShowCurrentMonth, BOOL *isShowHeaderView, BOOL *isShowFooterView, BOOL *isShowMonthView, BOOL *isShowWeekView, WYSelectType *selectType, void (^__autoreleasing *setCustomCellBlock)(UICollectionViewCell *__strong, NSDate *__strong)) {
        
        *isAddUpDownGesture = NO;
        
        *backColor = [UIColor whiteColor];
        
        *weekFontSize = 12;
        
        *weekTitleColor = WYUIColorFromRGB(0x333333);
        
        *selectType = WYSelectTypeOne;
        
        *weekTitleType = WeekTitleTypeChineseShort;
        
        *footerButtonWidth = ScreenWidth/3;
        
        *footerViewHeight = 100;
        
        *footerButtonFontSize = 14;
        
        *footerButtonColor = UIColorFromRGB(0x3A9AD1);
    }];
    
    [view setUpHeaderStyle:^(NSArray *__autoreleasing *titleArray, WeekTitleType *weekTitleType, BOOL *isEnglishMonth, UIColor *__autoreleasing *backColor, UIColor *__autoreleasing *titleColor, UIColor *__autoreleasing *yearColor, UIColor *__autoreleasing *dayColor, CGFloat *leftSpaceX, CGFloat *topSpaceY, CGFloat *titleHeight, CGFloat *yearHeight, CGFloat *dayHegiht, CGFloat *titleFontSize, CGFloat *yearFontSize, CGFloat *dayFontSize) {
        
        
        *dayFontSize = 14;
        
        *weekTitleType = WeekTitleTypeChinese;
        
        *isEnglishMonth = NO;
        
        *yearFontSize = 14;
        
        *yearColor = UIColorFromRGB(0xeeeeee);
        
        *backColor = UIColorFromRGB(0x3A9AD1);
    }];
    
    [view setUpDayCellStyle:^(UIColor *__autoreleasing *currentMonthTitleColor, UIColor *__autoreleasing *currentMonthChineseTitleColor, UIColor *__autoreleasing *todayTitleColor, UIColor *__autoreleasing *notCurrentMonthTitleColor, UIColor *__autoreleasing *selectTitleColor, UIColor *__autoreleasing *weekendTitleColor, UIColor *__autoreleasing *selectBackColor, UIColor *__autoreleasing *backColor, UIColor *__autoreleasing *endSelectBackColor, CGFloat *dayFontSize, CGFloat *dayLabelSize, BOOL *showAnimation, BOOL *showChineseDate) {
        
        *currentMonthChineseTitleColor = UIColorFromRGB(0xaaaaaa);
        
        *notCurrentMonthTitleColor = UIColorFromRGB(0xcccccc);
        
        *selectBackColor = UIColorFromRGB(0x3A9AD1);
        
        *dayFontSize = 14;
        
        *currentMonthTitleColor = [UIColor blackColor];
        
        *weekendTitleColor = [UIColor blackColor];
        
        *showChineseDate = NO;
        
    }];
    
    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
