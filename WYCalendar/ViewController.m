//
//  ViewController.m
//  WYCalendar
//
//  Created by 王勇 on 2018/5/30.
//  Copyright © 2018年 王勇. All rights reserved.
//

#import "ViewController.h"
#import "WYCalendarView.h"
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
    
    WYCalendarView * view =  [WYCalendarView calenderViewWithCalenderFrame:CGRectMake(0, 64, self.view.frame.size.width, 0) selectDateArray:nil confirmBlock:^(NSArray<WYCalendarModel *> *selectArray) {
      
    
    }];
    [view setUpDisplayStyle:^(__autoreleasing dispatch_block_t *cancelBlock, void (^__autoreleasing *changeMonthBlock)(NSDate *__strong), UIColor *__autoreleasing *backColor, WeekTitleType *weekTitleType, CGFloat *weekFontSize, UIColor **weekTitleColor, NSArray *__autoreleasing *footerTitleArray, CGFloat *footerViewHeight, CGFloat *footerButtonWidth, CGFloat *footerButtonFontSize, UIColor *__autoreleasing *footerButtonColor, BOOL *isShowCalendarShadow, BOOL *isShowSwipeAnimation, BOOL *isOnlyShowCurrentMonth, BOOL *isShowHeaderView, BOOL *isShowFooterView, BOOL *isShowMonthView, BOOL *isShowWeekView, WYSelectType *selectType, void (^__autoreleasing *setCustomCellBlock)(UICollectionViewCell *__strong, NSDate *__strong)) {
        
        *backColor = [UIColor whiteColor];
        
        *weekFontSize = 14;
        
        *weekTitleColor = WYUIColorFromRGB(0x333333);
        
        *selectType = WYSelectTypeOne;
        
        *isShowHeaderView = NO;
        
        *isShowFooterView = NO;
        
        *isShowCalendarShadow = NO;
        
        *weekTitleType = WeekTitleTypeChineseShort;
        
        *isShowMonthView = NO;
        
        *changeMonthBlock = ^(NSDate *monthDate){
            
            self.title = [NSString stringWithFormat:@"%zd年%zd月",monthDate.dateYear,monthDate.dateMonth];
        };
        
        *setCustomCellBlock = ^(UICollectionViewCell *cell,NSDate * date){

            UIView * tmpView = [cell.contentView viewWithTag:1001];

            if (tmpView) [tmpView removeFromSuperview];

            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(cell.contentView.frame.size.width/2 - 15, cell.contentView.frame.size.height - 12, 30, 12)];

            label.font = [UIFont systemFontOfSize:8];

            label.text = @"上假";

            label.textColor = [UIColor greenColor];

            label.textAlignment = NSTextAlignmentCenter;

            label.tag = 1001;

            [cell.contentView addSubview:label];
        };
    }];
    
    [view setUpDayCellStyle:^(UIColor *__autoreleasing *currentMonthTitleColor, UIColor *__autoreleasing *currentMonthChineseTitleColor, UIColor *__autoreleasing *todayTitleColor, UIColor *__autoreleasing *notCurrentMonthTitleColor, UIColor *__autoreleasing *selectTitleColor, UIColor *__autoreleasing *weekendTitleColor, UIColor *__autoreleasing *selectBackColor, UIColor *__autoreleasing *backColor, UIColor *__autoreleasing *endSelectBackColor, CGFloat *dayFontSize, CGFloat *dayLabelSize, BOOL *showAnimation, BOOL *showChineseDate) {
        
        *dayFontSize = 17;
        
        *currentMonthTitleColor = [UIColor blackColor];
        
        *dayLabelSize = self.view.frame.size.width/7*0.95;
        
        *weekendTitleColor = [UIColor blueColor];
    }];
    
    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
