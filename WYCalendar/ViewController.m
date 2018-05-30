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
    
    [self initCalendarView];
    
}

- (void)initCalendarView
{
    
    WYWS(weakSelf)
    
    WYCalendarView * view = [WYCalendarView calenderViewWithCalenderFrame:CGRectMake(110, 100, self.view.frame.size.width - 220, 0) confirmBlock:^(NSArray<WYCalendarModel *> *selectArray) {
        
        for (WYCalendarModel * model in selectArray) {
            
            NSLog(@"%04zd.%02zd.%02zd",model.year,model.month,model.day);
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [weakSelf initCalendarView];
        });
    }];
    
    //    [view setUpDisplayStyle:^(__autoreleasing dispatch_block_t *cancelBlock, UIColor *__autoreleasing *backColor, WeekTitleType *weekTitleType, NSArray *__autoreleasing *footerTitleArray, CGFloat *footerViewHeight, CGFloat *footerButtonWidth, CGFloat *footerButtonFontSize, UIColor *__autoreleasing *footerButtonColor, BOOL *isShowCalendarShadow, BOOL *isShowSwipeAnimation, BOOL *isOnlyShowCurrentMonth, BOOL *isShowHeaderView, BOOL *isShowFooterView, WYSelectType *selectType) {
    //        *cancelBlock = ^{
    //
    //            NSLog(@"cancel");
    //
    //            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //
    //                [weakSelf initCalendarView];
    //            });
    //        };
    //
    //        *isShowSwipeAnimation = NO;
    //    }];
    //
    //    [view setUpHeaderStyle:^(NSArray *__autoreleasing *titleArray, WeekTitleType *weekTitleType, BOOL *isEnglishMonth, UIColor *__autoreleasing *backColor, UIColor *__autoreleasing *titleColor, UIColor *__autoreleasing *yearColor, UIColor *__autoreleasing *dayColor, CGFloat *leftSpaceX, CGFloat *topSpaceY, CGFloat *titleHeight, CGFloat *yearHeight, CGFloat *dayHegiht, CGFloat *titleFontSize, CGFloat *yearFontSize, CGFloat *dayFontSize) {
    //
    ////        *backColor = [UIColor redColor];
    //
    //        *weekTitleType = WeekTitleTypeChineseShort;
    ////
    ////        *isEnglishMonth = NO;
    //
    //        *titleArray = @[@"开始日期",@"结束日期"];
    //    }];
    //
    //    [view setUpMonthStyle:^(UIColor *__autoreleasing *monthColor, CGFloat *monthFontSize, CGFloat *monthButtonWidth, CGFloat *monthSpace, BOOL *isEnglishMonth) {
    //
    //        *isEnglishMonth = NO;
    //    }];
    //
    //    [view setUpDayCellStyle:^(UIColor *__autoreleasing *currentMonthTitleColor, UIColor *__autoreleasing *todayTitleColor, UIColor *__autoreleasing *notCurrentMonthTitleColor, UIColor *__autoreleasing *selectTitleColor, UIColor *__autoreleasing *selectBackColor, UIColor *__autoreleasing *endSelectBackColor, CGFloat *dayFontSize, CGFloat *dayLabelSize, BOOL *showAnimation) {
    //
    //        *endSelectBackColor = [UIColor orangeColor];
    //    }];
    
    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
