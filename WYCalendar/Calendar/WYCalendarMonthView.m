//
//  WYCalendarMonthView.m
//  CalendarDemo
//
//  Created by 王勇 on 2018/5/26.
//  Copyright © 2018年 王勇. All rights reserved.
//

#import "WYCalendarMonthView.h"
#import "WYCalendarTool.h"
#import "UIView+WYCategory.h"
@implementation WYCalendarMonthView
{
    UILabel * _titleLabel;
    
    dispatch_block_t _leftBlock;        //点击左按钮的回调
    
    dispatch_block_t _rightBlock;       //点击右按钮的回调
    
    /**
     styles
     */
    UIColor * _monthColor;              //月份文字颜色
    
    CGFloat _monthFontSize;             //月份文字尺寸
    
    CGFloat _monthButtonWidth;          //月份左右箭头按钮的宽度
    
    CGFloat _monthSpace;                //月份左右箭头与边界的间距
    
    BOOL _isEnglishMonth;               //是否显示英文月份
}
#pragma mark - public
+ (instancetype)monthViewWithFrame:(CGRect)frame leftButtonBlock:(dispatch_block_t)leftButtonBlock rightButtonBlock:(dispatch_block_t)rightButtonBlock
{
    WYCalendarMonthView * monthView = [[WYCalendarMonthView alloc] initWithFrame:frame];
    
    monthView ->_leftBlock = leftButtonBlock;
    
    monthView ->_rightBlock = rightButtonBlock;
    
    [monthView setDefaultData];
    
    return monthView;
}

- (void)setUpMonthStyle:(void(^)(UIColor ** monthColor,CGFloat *monthFontSize,CGFloat *monthButtonWidth,CGFloat *monthSpace,BOOL *isEnglishMonth))monthSettingBlock
{
    
    UIColor * monthColor = _monthColor;                 //月份文字颜色
    
    CGFloat monthFontSize = _monthFontSize;             //月份文字尺寸
    
    CGFloat monthButtonWidth = _monthButtonWidth;       //月份左右箭头按钮的宽度
    
    CGFloat monthSpace = _monthSpace;                   //月份左右箭头与边界的间距
    
    BOOL isEnglishMonth = _isEnglishMonth;              //是否显示英文月份
    
    if (monthSettingBlock) {
        
        monthSettingBlock(&monthColor,&monthFontSize,&monthButtonWidth,&monthSpace,&isEnglishMonth);
        
        _monthColor = monthColor;
        
        _monthFontSize = monthFontSize;
        
        _monthButtonWidth = monthButtonWidth;
        
        _monthSpace = monthSpace;
        
        _isEnglishMonth = isEnglishMonth;
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
    _monthColor = WYUIColorFromRGB(0x000000);
    
    _monthFontSize = 10;
    
    _monthButtonWidth = 16;
    
    _monthSpace = 6;
    
    _isEnglishMonth = YES;
}

- (void)setUpViews
{
    WYWS(weakSelf)
    
    UIButton * leftButton = [UIButton initWithFrame:CGRectMake(_monthSpace, self.Height/2 - _monthButtonWidth/2, _monthButtonWidth, _monthButtonWidth) title:nil fontSize:0 buttonAction:^(id sender) {
        
        WYST(strongSelf)
        
        if (strongSelf->_leftBlock) strongSelf->_leftBlock();
        
    } color:nil];
    
    [leftButton setImage:[UIImage imageNamed:@"arrow_left" inBundle:[NSBundle bundleWithPath:[[[NSBundle bundleForClass:[WYCalendarTool class]] resourcePath] stringByAppendingPathComponent:@"WYIcons.bundle"]] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    
    UIButton * rightButton = [UIButton initWithFrame:CGRectMake(self.Width - _monthButtonWidth - _monthSpace, self.Height/2 - _monthButtonWidth/2, _monthButtonWidth, _monthButtonWidth) title:nil fontSize:0 buttonAction:^(id sender) {
        
        WYST(strongSelf)
        
        if (strongSelf->_rightBlock) strongSelf->_rightBlock();
        
    } color:nil];
    
    [rightButton setImage:[UIImage imageNamed:@"arrow_right" inBundle:[NSBundle bundleWithPath:[[[NSBundle bundleForClass:[WYCalendarTool class]] resourcePath] stringByAppendingPathComponent:@"WYIcons.bundle"]] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    
    _titleLabel = [WYCalendarTool initLabelWithFrame:self.bounds text:@"" fontSize:_monthFontSize textColor:_monthColor aliment:NSTextAlignmentCenter];
    
    [self addSubview:_titleLabel];
    
    [self addSubview:leftButton];
    
    [self addSubview:rightButton];
}
- (void)setModel:(WYCalendarModel *)model
{
    _titleLabel.text = _isEnglishMonth ? [NSString stringWithFormat:@"%@ %zd",model.EnglishMonth,model.year] : [NSString stringWithFormat:@"%zd年%zd月",model.year,model.month];
}
@end
