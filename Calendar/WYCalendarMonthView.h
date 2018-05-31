//
//  WYCalendarMonthView.h
//  CalendarDemo
//
//  Created by 王勇 on 2018/5/26.
//  Copyright © 2018年 王勇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYCalendarModel;
@interface WYCalendarMonthView : UIView

/*日历模型*/
@property(nonatomic,strong)WYCalendarModel *model;

/**
 月份视图初始化方法
 @param frame               显示位置
 @param leftButtonBlock     点击左按钮的回调
 @param rightButtonBlock    点击右按钮的回调
 @return 月份视图对象
 */
+ (instancetype)monthViewWithFrame:(CGRect)frame leftButtonBlock:(dispatch_block_t)leftButtonBlock rightButtonBlock:(dispatch_block_t)rightButtonBlock;

- (void)setUpMonthStyle:(void(^)(UIColor ** monthColor,CGFloat *monthFontSize,CGFloat *monthButtonWidth,CGFloat *monthSpace,BOOL *isEnglishMonth))monthSettingBlock;

@end
