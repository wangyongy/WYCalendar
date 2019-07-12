//
//  WYCalendarCollectionViewCell.h
//  CalendarDemo
//
//  Created by 王勇 on 2018/5/26.
//  Copyright © 2018年 王勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WYCalendarModel;

@interface WYCalendarCollectionViewCell : UICollectionViewCell

/*日历模型*/
@property(nonatomic,strong)WYCalendarModel *model;

- (void)setUpDayCellStyle:(void(^)(UIColor ** currentMonthTitleColor,UIColor ** currentMonthChineseTitleColor,UIColor ** todayTitleColor,UIColor ** notCurrentMonthTitleColor,UIColor ** selectTitleColor,UIColor ** selectBackColor,UIColor ** backColor,UIColor ** endSelectBackColor,CGFloat *dayFontSize,CGFloat *dayLabelSize,BOOL *showAnimation,BOOL *showChineseDate))daySettingBlock;

@end
