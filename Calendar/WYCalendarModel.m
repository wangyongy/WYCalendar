//
//  WYCalendarModel.m
//  CalendarDemo
//
//  Created by 王勇 on 2018/5/26.
//  Copyright © 2018年 王勇. All rights reserved.
//

#import "WYCalendarModel.h"
#import "WYCalendarTool.h"
@implementation WYCalendarModel

+ (instancetype)modelWithDate:(NSDate *)date
{
    return [[WYCalendarModel alloc] initWithDate:date];
}

- (instancetype)initWithDate:(NSDate *)date
{
    self = [super init];
    if (self) {
        
        _year = [date dateYear];
        
        _month = [date dateMonth];
        
        _day = [date dateDay];
        
        _firstWeekday = [date firstWeekDayInMonth];
    }
    return self;
}
- (NSInteger)week
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[NSDate date]];
    
    components.day = self.day;
    
    components.year = self.year;
    
    components.month = self.month;
    
    NSDate *selfDate = [calendar dateFromComponents:components];
    
    components = [calendar components:NSCalendarUnitWeekday fromDate:selfDate];
    
    return [components weekday] - 1;
}
- (WYCalendarStatus)status
{
    return _status | (self.day == [[NSDate date] dateDay] && self.month == [[NSDate date] dateMonth] && self.year == [[NSDate date] dateYear]);
}

- (NSString *)EnglishMonth
{
    if (self.month < 1 || self.month > 12) {
        
        return nil;
    }
    
    NSArray * monthStrArray = @[@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December"];
    
    return monthStrArray[self.month - 1];
}
@end
