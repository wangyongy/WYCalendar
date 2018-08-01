//
//  WYCalendarModel.h
//  CalendarDemo
//
//  Created by 王勇 on 2018/5/26.
//  Copyright © 2018年 王勇. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, WYCalendarStatus) {
    
    WYCalendarToday = 1 << 0,                                   //今天
    
    WYCalendarCurrentMonth = 1 << 1,                            //属于当月
    
    WYCalendarStartSelected = 1 << 2,                           //开始日期被选中
    
    WYCalendarEndSelected = 1 << 3,                             //结束日期被选中
};

@interface WYCalendarModel : NSObject

@property (nonatomic, assign, readonly) NSInteger firstWeekday; //第一天是星期几,0代表周日

@property (nonatomic, assign, readonly) NSInteger week;         //所属星期,0代表周日

@property (nonatomic, assign, readonly) NSInteger year;         //所属年份

@property (nonatomic, assign, readonly) NSInteger month;        //所属月份

@property (nonatomic, assign) NSInteger day;                    //所属天

@property(nonatomic,assign) WYCalendarStatus status;            //日期状态

/**
 用日期对象来初始化日历模型
 */
+ (instancetype)modelWithDate:(NSDate *)date;
/**
 当前月份的英文名
 */
- (NSString *)EnglishMonth;

/**
 当前日期字符串。格式:20180505
 */
- (NSString *)dateStr;
/**
 当前模型的日期
 */
- (NSDate *)date;
/**
 判断两个model是否是同一天
 */
- (BOOL)isEqual:(WYCalendarModel *)otherModel;
@end
