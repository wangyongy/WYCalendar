//
//  WYCalendarHeaderView.h
//  CalendarDemo
//
//  Created by 王勇 on 2018/5/26.
//  Copyright © 2018年 王勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYCalendarTool.h"
@interface WYCalendarHeaderView : UIView

/*日历模型*/
@property(nonatomic,strong)WYCalendarModel *model;
/*是否是起始日期*/
@property(nonatomic,assign)BOOL       isStartDate;

/**
 头部视图初始化方法
 @param frame               显示位置
 @param isStartDate         是否是起始日期
 @return 头部视图对象
 */
+ (instancetype)headerViewWithFrame:(CGRect)frame isStartDate:(BOOL)isStartDate;

- (void)setUpHeaderStyle:(void(^)(NSArray **titleArray,WeekTitleType *weekTitleType,BOOL      *isEnglishMonth,UIColor **backColor,UIColor **titleColor,UIColor **yearColor,UIColor **dayColor,CGFloat *leftSpaceX,CGFloat *topSpaceY,CGFloat *titleHeight,CGFloat *yearHeight,CGFloat *dayHegiht,CGFloat *titleFontSize,CGFloat *yearFontSize,CGFloat *dayFontSize))headerSettingBlock;
@end
