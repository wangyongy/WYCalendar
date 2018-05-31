//
//  WYCalendarHeaderView.m
//  CalendarDemo
//
//  Created by 王勇 on 2018/5/26.
//  Copyright © 2018年 王勇. All rights reserved.
//

#import "WYCalendarHeaderView.h"
#import "WYCalendarTool.h"
#import "UIView+WYCategory.h"
@implementation WYCalendarHeaderView
{
    UILabel * _titleLabel;
    
    UILabel * _yearLabel;
    
    UILabel * _dayLabel;

    /**
     styles
     */
    NSArray * _titleArray;                              //标题数组，如(start date,end date)
    
    WeekTitleType _weekTitleType;                       //星期显示类型
    
    BOOL      _isEnglishMonth;                          //是否是英文月份
    
    UIColor * _backColor;                               //头部背景色
    
    UIColor * _titleColor;                              //标题颜色
    
    UIColor * _yearColor;                               //年份颜色
    
    UIColor * _dayColor;                                //日期颜色
    
    CGFloat   _leftSpaceX;                              //label与左边的间距
    
    CGFloat   _topSpaceY;                               //标题与上方的间距
    
    CGFloat   _titleHeight;                             //标题高度
    
    CGFloat   _yearHeight;                              //年份高度
    
    CGFloat   _dayHegiht;                               //日期高度
    
    CGFloat   _titleFontSize;                           //标题文字尺寸
    
    CGFloat   _yearFontSize;                            //年份文字尺寸
    
    CGFloat   _dayFontSize;                             //日期文字尺寸
}

#pragma mark - public
+ (instancetype)headerViewWithFrame:(CGRect)frame isStartDate:(BOOL)isStartDate
{
    WYCalendarHeaderView * haederView = [[WYCalendarHeaderView alloc] initWithFrame:frame];
    
    haederView ->_isStartDate = isStartDate;
    
    [haederView setDefaultData];
    
    return haederView;
}
- (void)setUpHeaderStyle:(void(^)(NSArray **titleArray,WeekTitleType *weekTitleType,BOOL      *isEnglishMonth,UIColor **backColor,UIColor **titleColor,UIColor **yearColor,UIColor **dayColor,CGFloat *leftSpaceX,CGFloat *topSpaceY,CGFloat *titleHeight,CGFloat *yearHeight,CGFloat *dayHegiht,CGFloat *titleFontSize,CGFloat *yearFontSize,CGFloat *dayFontSize))headerSettingBlock
{
    NSArray * titleArray = @[@"Start Date",@"End Date"];    //标题数组，如(start date,end date)
    
    WeekTitleType weekTitleType = _weekTitleType;           //星期显示类型
    
    BOOL      isEnglishMonth = _isEnglishMonth;             //是否是英文月份
    
    UIColor *backColor = _backColor;                        //头部背景色
    
    UIColor *titleColor = _titleColor;                      //标题颜色
    
    UIColor *yearColor = _yearColor;                        //年份颜色
    
    UIColor *dayColor = _dayColor;                          //日期颜色
    
    CGFloat  leftSpaceX = _leftSpaceX;                      //label与左边的间距
    
    CGFloat  topSpaceY = _topSpaceY;                        //标题与上方的间距
    
    CGFloat  titleHeight = _titleHeight;                    //标题高度
    
    CGFloat  yearHeight = _yearHeight;                      //年份高度
    
    CGFloat  dayHegiht = _dayHegiht;                        //日期高度
    
    CGFloat  titleFontSize = _titleFontSize;                //标题文字尺寸
    
    CGFloat  yearFontSize = _yearFontSize;                  //年份文字尺寸
    
    CGFloat  dayFontSize = _dayFontSize;                    //日期文字尺寸
    
    if (headerSettingBlock) {
        
        headerSettingBlock(&titleArray,&weekTitleType,&isEnglishMonth,&backColor,&titleColor,&yearColor,&dayColor,&leftSpaceX,&topSpaceY,&titleHeight,&yearHeight,&dayHegiht,&titleFontSize,&yearFontSize,&dayFontSize);
        
        _titleArray = titleArray;
        
        _weekTitleType = weekTitleType;
        
        _isEnglishMonth = isEnglishMonth;
        
        _backColor = backColor;
        
        _titleColor = titleColor;
        
        _yearColor = yearColor;
        
        _dayColor = dayColor;
        
        _leftSpaceX = leftSpaceX;
        
        _topSpaceY = topSpaceY;
        
        _titleHeight = titleHeight;
        
        _yearHeight = yearHeight;
        
        _dayHegiht = dayHegiht;
        
        _titleFontSize = titleFontSize;
        
        _yearFontSize = yearFontSize;
        
        _dayFontSize = dayFontSize;
    }
}
#pragma mark - private
- (void)willMoveToSuperview:(UIView *)newSuperview{
    
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview) {
        
        [self setUpViews];
    }
}
- (void)setDefaultData
{
    _titleArray = @[@"Start Date",@"End Date"];
    
    _weekTitleType = WeekTitleTypeEnglish;
    
    _isEnglishMonth = YES;
    
    _backColor = WYUIColorFromRGB(0x0fc6a6);
    
    _titleColor = WYUIColorFromRGB(0xffffff);
    
    _yearColor = [WYUIColorFromRGB(0xffffff) colorWithAlphaComponent:0.7];
    
    _dayColor = WYUIColorFromRGB(0xffffff);
    
    _leftSpaceX = 12;
    
    _topSpaceY = 10;
    
    _titleHeight = 10;
    
    _yearHeight = 12;
    
    _dayHegiht = 24;
    
    _titleFontSize = 7;
    
    _yearFontSize = 8;
    
    _dayFontSize = 17;
}
- (void)setUpViews
{
    
    self.backgroundColor = _backColor;
    
    _titleLabel = [WYCalendarTool initLabelWithFrame:CGRectMake(_leftSpaceX, _topSpaceY, self.Width - _leftSpaceX*2, _titleHeight) text:_titleArray[!_isStartDate] fontSize:_titleFontSize textColor:_titleColor aliment:NSTextAlignmentLeft];
    
    _yearLabel = [WYCalendarTool initLabelWithFrame:CGRectMake(_leftSpaceX, _titleLabel.Bottom, self.Width - _leftSpaceX*2, _yearHeight) text:@"" fontSize:_yearFontSize textColor:_yearColor aliment:NSTextAlignmentLeft];
    
    _dayLabel = [WYCalendarTool initLabelWithFrame:CGRectMake(_leftSpaceX, _yearLabel.Bottom, self.Width - _leftSpaceX*2, _dayHegiht) text:@"" fontSize:_dayFontSize textColor:_dayColor aliment:NSTextAlignmentLeft];
    
    [self addSubview:_titleLabel];
    
    [self addSubview:_yearLabel];
    
    [self addSubview:_dayLabel];
}
- (void)setModel:(WYCalendarModel *)model
{
    _titleLabel.text = _titleArray[!_isStartDate];
    
    if (model == nil) {
        
        _yearLabel.text = _dayLabel.text = nil;
        
        return;
    }
    
    _yearLabel.text = [NSString stringWithFormat:@"%zd",model.year];

    NSArray * weekTitleArray = [WYCalendarTool getWeekTitleArrayWithType:_weekTitleType];
    
    _dayLabel.text =  [NSString stringWithFormat:@"%@,%@ %zd",weekTitleArray[model.week],_isEnglishMonth ?model.EnglishMonth : [NSString stringWithFormat:@"%zd月",model.month],model.day];
}
@end
