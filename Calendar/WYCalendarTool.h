//
//  WYCalendarTool.h
//  CalendarDemo
//
//  Created by 王勇 on 2018/5/26.
//  Copyright © 2018年 王勇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WYCalendarModel.h"
typedef NS_ENUM(NSUInteger, WeekTitleType) {
    
    WeekTitleTypeEnglishShort,                                       //星期显示英文缩写
    
    WeekTitleTypeEnglish,                                            //星期显示英文
    
    WeekTitleTypeChineseShort,                                       //星期显示中文缩写
    
    WeekTitleTypeChinese,                                            //星期显示中文
};

typedef NS_ENUM(NSUInteger, WYSelectType) {
    
    WYSelectTypeOne,                                                  //单选日期
    
    WYSelectTypeTwo,                                                  //开始日期，结束日期
    
    WYSelectTypeMulti,                                                //多选日期
};

#define WYScreenWidth     [[UIScreen mainScreen] bounds].size.width   //屏幕宽度

#define WYScreenHeight    [[UIScreen mainScreen] bounds].size.height  //屏幕高度

#define WYUIColorFromRGB(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0] //rgb颜色

#define WYWS(weakSelf)            __weak __typeof(&*self)weakSelf = self; // 弱引用

#define WYST(strongSelf)          __strong __typeof(&*self)strongSelf = weakSelf; //使用这个要先声明weakSelf

@interface WYCalendarTool : NSObject

/**
 初始化UILabel
 
 @param frame       label显示位置
 @param text        显示文字
 @param fontSize    文字大小
 @param color       文字颜色
 @param aliment     文字显示位置
 @return            label对象
 */
+ (UILabel *)initLabelWithFrame:(CGRect)frame text:(NSString *)text fontSize:(NSInteger)fontSize textColor:(UIColor *)color aliment:(NSTextAlignment)aliment;
/**
 根据类型返回星期显示文字数组
 
 @param type        星期显示类型
 @return            星期显示文字数组
 */
+ (NSArray *)getWeekTitleArrayWithType:(WeekTitleType)type;
/**
 按日期从小到大排序
 
 @param array       日期模型数组
 */
+ (void)sortCaledarModelArray:(NSMutableArray <WYCalendarModel*>*)array;

@end
@interface NSDate (Chinese)

- (NSString *)ChineseDate;

@end
@interface NSDate (WYCalendar)

/**
 *  获得当前 NSDate 对象对应的日子
 */
- (NSInteger)dateDay;

/**
 *  获得当前 NSDate 对象对应的月份
 */
- (NSInteger)dateMonth;

/**
 *  获得当前 NSDate 对象对应的年份
 */
- (NSInteger)dateYear;
/**
 *  获得当前 NSDate 对象对应的星期,周日为1，周一为2，周二为3...以此类推
 */
- (NSInteger)dateWeek;
/**
 *  获得当前 NSDate 对象的上个月的某一天（此处定为15号）的 NSDate 对象
 */
- (NSDate *)previousMonthDate;

/**
 *  获得当前 NSDate 对象的下个月的某一天（此处定为15号）的 NSDate 对象
 */
- (NSDate *)nextMonthDate;

/**
 *  获得当前 NSDate 对象对应的月份的总天数
 */
- (NSInteger)totalDaysInMonth;

/**
 *  获得当前 NSDate 对象对应月份当月第一天的所属星期
 */
- (NSInteger)firstWeekDayInMonth;

@end
