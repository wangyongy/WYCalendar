//
//  WYCalendarTool.m
//  CalendarDemo
//
//  Created by 王勇 on 2019/7/12.
//  Copyright © 2018年 王勇. All rights reserved.
//  

#import "WYCalendarTool.h"

@implementation WYCalendarTool
+ (UILabel *)initLabelWithFrame:(CGRect)frame text:(NSString *)text fontSize:(NSInteger)fontSize textColor:(UIColor *)color aliment:(NSTextAlignment)aliment
{
    UILabel * label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textColor = color;
    label.textAlignment = aliment;
    label.font = [UIFont systemFontOfSize:fontSize];
    return label;
}
+ (NSArray *)getWeekTitleArrayWithType:(WeekTitleType)type
{
    NSArray * weekTitleArray;
    
    switch (type) {
        case WeekTitleTypeEnglish:
            weekTitleArray = @[@"Sun",@"Mon",@"Tues",@"Wed",@"Thur",@"Fri",@"Sat"];
            break;
        case WeekTitleTypeEnglishShort:
            weekTitleArray = @[@"S",@"M",@"T",@"W",@"T",@"F",@"S"];
            break;
        case WeekTitleTypeChinese:
            weekTitleArray = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
            break;
        case WeekTitleTypeChineseShort:
            weekTitleArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
            break;
            
        default:
            break;
    }
    
    return weekTitleArray;
}
+ (void)sortCaledarModelArray:(NSMutableArray <WYCalendarModel*>*)array
{
    [array sortUsingComparator:^NSComparisonResult(WYCalendarModel*  _Nonnull obj1, WYCalendarModel*  _Nonnull obj2) {
        
        NSInteger date1 = obj1.year*10000 + obj1.month*100 + obj1.day;
        
        NSInteger date2 = obj2.year*10000 + obj2.month*100 + obj2.day;
        
        if (date1 >= date2)
        {
            return NSOrderedDescending;
        }
        else
        {
            return NSOrderedAscending;
        }
    }];
}
@end
@implementation NSDate (WYCalendar)

- (NSInteger)dateDay
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitDay fromDate:self];
    
    return components.day;
}

- (NSInteger)dateMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth fromDate:self];
    
    return components.month;
}

- (NSInteger)dateYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:self];
    
    return components.year;
}
- (NSInteger)dateWeek
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *weekdayComponents = [calendar components:NSCalendarUnitWeekday fromDate:self];
    
    return [weekdayComponents weekday] >= 7 ? 6 : [weekdayComponents weekday];
}
- (NSDate *)previousMonthDate
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    
    components.day = 15; // 定位到当月中间日子
    
    if (components.month == 1) {
        
        components.month = 12;
        
        components.year -= 1;
        
    } else {
        
        components.month -= 1;
    }
    
    NSDate *previousDate = [calendar dateFromComponents:components];
    
    return previousDate;
}

- (NSDate *)nextMonthDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    
    components.day = 15; // 定位到当月中间日子
    
    if (components.month == 12) {
        
        components.month = 1;
        
        components.year += 1;
        
    } else {
        
        components.month += 1;
    }
    
    NSDate *nextDate = [calendar dateFromComponents:components];
    
    return nextDate;
}

- (NSInteger)totalDaysInMonth
{
    NSInteger totalDays = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
    
    return totalDays;
}

- (NSInteger)firstWeekDayInMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    
    components.day = 1; // 定位到当月第一天
    
    NSDate *firstDay = [calendar dateFromComponents:components];
    
    // 默认一周第一天序号为 1 ，而日历中约定为 0 ，故需要减一
    NSInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDay] - 1;
    
    return firstWeekday;
}

@end
