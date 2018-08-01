//
//  WYCalendarView.h
//  CalendarDemo
//
//  Created by 王勇 on 2018/5/26.
//  Copyright © 2018年 王勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYCalendarTool.h"

@interface WYCalendarView : UIView
/**
 初始化
 
 @param frame                   日历视图位置。背景图默认是全屏显示,日历视图高度不用设置，内部会自适应高度
 @param confirmBlock            点击日历或者确认键时的回调,selectArray为日历模型数组,内部已按日期从小到大排序
 
 @return                        返回日历对象
 */
+ (instancetype)calenderViewWithCalenderFrame:(CGRect)frame selectDateArray:(NSArray *)selectDateArray confirmBlock:(void(^)(NSArray <WYCalendarModel *>*selectArray))confirmBlock;
#pragma mark - 设置一些属性，如果有需要，需在将日历对象addSubview前调用这些方法
/**
 头部视图设置,在这里选择性地设置头部视图中的属性

 *cancelBlock;                  取消的回调
 *backColor;                    基础背景色
 *weekTitleType;                星期显示类型
 *weekFontSize;                 星期显示尺寸
 *footerTitleArray;             底部按钮文字数组
 *footerViewHeight;             底部视图高度
 *footerButtonWidth;            底部按钮宽度
 *footerButtonFontSize;         底部按钮文字尺寸
 *footerButtonColor;            底部按钮文字颜色
 *isShowCalendarShadow;         是否显示阴影
 *isShowSwipeAnimation;         是否显示滑动动画
 *isOnlyShowCurrentMonth;       只显示属于当前月份的日期
 *isShowHeaderView;             是否显示头部视图
 *isShowFooterView;             是否显示底部视图
 *selectType;                   选择日期类型

 @param BaseSettingBlock        设置基础属性
 */
- (void)setUpDisplayStyle:(void(^)(dispatch_block_t *cancelBlock,UIColor ** backColor,WeekTitleType *weekTitleType,CGFloat *weekFontSize,NSArray ** footerTitleArray,CGFloat *footerViewHeight,CGFloat *footerButtonWidth,CGFloat *footerButtonFontSize,UIColor ** footerButtonColor,BOOL *isShowCalendarShadow,BOOL *isShowSwipeAnimation,BOOL *isOnlyShowCurrentMonth,BOOL *isShowHeaderView,BOOL *isShowFooterView,WYSelectType *selectType))BaseSettingBlock;

/**
 头部视图设置,在这里选择性地设置头部视图中的属性
 
 *titleArray;                   头部标题数组，如(start date,end date)
 *weekTitleType;                头部星期显示类型
 *isEnglishMonth;               头部是否是英文月份
 *backColor;                    头部背景色
 *titleColor;                   头部标题颜色
 *yearColor;                    头部年份颜色
 *dayColor;                     头部日期颜色
 *leftSpaceX;                   头部label与左边的间距
 *topSpaceY;                    头部标题与上方的间距
 *titleHeight;                  头部标题高度
 *yearHeight;                   头部年份高度
 *dayHegiht;                    头部日期高度
 *titleFontSize;                头部标题文字尺寸
 *yearFontSize;                 头部年份文字尺寸
 *dayFontSize;                  头部日期文字尺寸
 
 @param headerSettingBlock      设置头部视图属性
 */

- (void)setUpHeaderStyle:(void(^)(NSArray **titleArray,WeekTitleType *weekTitleType,BOOL      *isEnglishMonth,UIColor **backColor,UIColor **titleColor,UIColor **yearColor,UIColor **dayColor,CGFloat *leftSpaceX,CGFloat *topSpaceY,CGFloat *titleHeight,CGFloat *yearHeight,CGFloat *dayHegiht,CGFloat *titleFontSize,CGFloat *yearFontSize,CGFloat *dayFontSize))headerSettingBlock;
/**
 月份视图设置,在这里选择性地设置月份视图中的属性
 
 *monthColor;                   月份文字颜色
 *monthFontSize;                月份文字尺寸
 *monthButtonWidth;             月份左右箭头按钮的宽度
 *monthSpace;                   月份左右箭头与边界的间距
 
 @param monthSettingBlock       设置月份视图属性
 */
- (void)setUpMonthStyle:(void(^)(UIColor ** monthColor,CGFloat *monthFontSize,CGFloat *monthButtonWidth,CGFloat *monthSpace,BOOL *isEnglishMonth))monthSettingBlock;
/**
 日期视图设置,在这里选择性地设置日期视图中的属性
 
 *currentMonthTitleColor;       当前月份日期文字颜色
 *todayTitleColor;              今天文字颜色
 *notCurrentMonthTitleColor;    非当前月份日期文字颜色
 *selectTitleColor;             选中后文字颜色
 *selectBackColor;              选中后文字背景颜色
 *selectBackColor;              结束选中后文字背景颜色
 *selectBackColor;              文字背景颜色
 *dayFontSize;                  日期文字尺寸
 *dayLabelSize;                 日期文本尺寸
 *showAnimation;                选中后是否展示动画
 
 @param daySettingBlock         设置日期视图属性
 */
- (void)setUpDayCellStyle:(void(^)(UIColor ** currentMonthTitleColor,UIColor ** todayTitleColor,UIColor ** notCurrentMonthTitleColor,UIColor ** selectTitleColor,UIColor ** selectBackColor,UIColor ** backColor,UIColor ** endSelectBackColor,CGFloat *dayFontSize,CGFloat *dayLabelSize,BOOL *showAnimation))daySettingBlock;

@end


