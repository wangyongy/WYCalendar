//
//  WYCalendarCollectionViewCell.m
//  CalendarDemo
//
//  Created by 王勇 on 2018/5/26.
//  Copyright © 2018年 王勇. All rights reserved.
//

#import "WYCalendarCollectionViewCell.h"
#import "WYCalendarTool.h"
#import "UIView+WYCategory.h"
@implementation WYCalendarCollectionViewCell
{
    UILabel * _titleLabel;

    /**
     styles
     */
    UIColor * _currentMonthTitleColor;              //当前月份日期文字颜色
    
    UIColor * _todayTitleColor;                     //今天文字颜色
    
    UIColor * _notCurrentMonthTitleColor;           //非当前月份日期文字颜色
    
    UIColor * _selectTitleColor;                    //选中后文字颜色
    
    UIColor * _selectBackColor;                     //选中后文字背景颜色
    
    UIColor * _endSelectBackColor;                  //结束日期选中后文字背景颜色
    
    CGFloat   _dayFontSize;                         //日期文字尺寸
    
    CGFloat   _dayLabelSize;                        //日期文本尺寸
    
    BOOL      _showAnimation;                       //选中后是否展示动画
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
    
        [self setDefaultData];
        
        CGFloat width = self.contentView.Width;

        _titleLabel = [WYCalendarTool initLabelWithFrame:CGRectMake((NSInteger)(width/2 - _dayLabelSize/2), (NSInteger)(width/2 - _dayLabelSize/2), (NSInteger)(_dayLabelSize), (NSInteger)(_dayLabelSize)) text:nil fontSize:_dayFontSize textColor:nil aliment:NSTextAlignmentCenter];
        
        _titleLabel.backgroundColor = WYUIColorFromRGB(0xffffff);
        
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

- (void)setUpDayCellStyle:(void(^)(UIColor ** currentMonthTitleColor,UIColor ** todayTitleColor,UIColor ** notCurrentMonthTitleColor,UIColor ** selectTitleColor,UIColor ** selectBackColor,UIColor ** endSelectBackColor,CGFloat *dayFontSize,CGFloat *dayLabelSize,BOOL *showAnimation))daySettingBlock
{
    UIColor * currentMonthTitleColor =      _currentMonthTitleColor;              //当前月份日期文字颜色
    
    UIColor * todayTitleColor =             _todayTitleColor;                     //今天文字颜色
    
    UIColor * notCurrentMonthTitleColor =   _notCurrentMonthTitleColor;           //非当前月份日期文字颜色
    
    UIColor * selectTitleColor =            _selectTitleColor;                    //选中后文字颜色
    
    UIColor * selectBackColor =             _selectBackColor;                     //选中后文字背景颜色
    
    UIColor * endSelectBackColor =          _endSelectBackColor;                  //结束日期选中后文字背景颜色
    
    CGFloat   dayFontSize =                 _dayFontSize;                         //日期文字尺寸
    
    CGFloat   dayLabelSize =                _dayLabelSize;                        //日期文本尺寸
    
    BOOL      showAnimation =               _showAnimation;                       //选中后是否展示动画
    
    if (daySettingBlock) {
    daySettingBlock(&currentMonthTitleColor,&todayTitleColor,&notCurrentMonthTitleColor,&selectTitleColor,&selectBackColor,&endSelectBackColor,&dayFontSize,&dayLabelSize,&showAnimation);
        
        _currentMonthTitleColor =           currentMonthTitleColor;
        
        _todayTitleColor =                  todayTitleColor;
        
        _notCurrentMonthTitleColor =        notCurrentMonthTitleColor;
        
        _selectTitleColor =                 selectTitleColor;
        
        _selectBackColor =                  selectBackColor;
        
        _endSelectBackColor =               endSelectBackColor;
        
        _dayFontSize =                      dayFontSize;
        
        _dayLabelSize =                     dayLabelSize;
        
        _showAnimation =                  showAnimation;
    }
}

- (void)setDefaultData
{
    _currentMonthTitleColor = WYUIColorFromRGB(0x111111);
    
    _selectBackColor = _todayTitleColor = WYUIColorFromRGB(0x0fc6a6);
    
    _endSelectBackColor = [UIColor redColor];
    
    _notCurrentMonthTitleColor = WYUIColorFromRGB(0x999999);
    
    _selectTitleColor = WYUIColorFromRGB(0xffffff);
    
    _dayFontSize = 8;
    
    _dayLabelSize = self.contentView.Width*0.8;
    
    _showAnimation = YES;
}

- (void)setModel:(WYCalendarModel *)model
{
    CGFloat width = self.contentView.Width;

    _titleLabel.frame = CGRectMake((NSInteger)(width/2 - _dayLabelSize/2), (NSInteger)(width/2 - _dayLabelSize/2), (NSInteger)(_dayLabelSize), (NSInteger)(_dayLabelSize));
    
    _titleLabel.font = [UIFont systemFontOfSize:_dayFontSize];
    
    _titleLabel.text = model.day > 0 ? [NSString stringWithFormat:@"%zd",model.day] : @"";
    
    if (model.status & WYCalendarCurrentMonth) {
        
        [_titleLabel setTextColor: _currentMonthTitleColor];
        
        if (model.status & WYCalendarToday) {
            
            [_titleLabel setTextColor: _todayTitleColor];
        }
        
        if ((model.status & WYCalendarStartSelected) || (model.status & WYCalendarEndSelected)) {

            _titleLabel.layer.cornerRadius = _titleLabel.Width/2;

            _titleLabel.layer.masksToBounds = YES;
            
            if (_showAnimation) {
                
                CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
                
                anim.values = @[@0.6,@1.2,@1.0];
                
                anim.keyPath = @"transform.scale";
                
                anim.calculationMode = kCAAnimationPaced;
                
                anim.duration = 0.25;
                
                [_titleLabel.layer addAnimation:anim forKey:nil];
            }

            [_titleLabel setTextColor: _selectTitleColor];

            _titleLabel.backgroundColor = (model.status & WYCalendarEndSelected) ? _endSelectBackColor : _selectBackColor;
            
        }else{
            
            _titleLabel.backgroundColor = WYUIColorFromRGB(0xffffff);
            
            _titleLabel.layer.cornerRadius = 0;
        }
        
    }else{
        
        [_titleLabel setTextColor: _notCurrentMonthTitleColor];
        
        _titleLabel.backgroundColor = WYUIColorFromRGB(0xffffff);
        
        _titleLabel.layer.cornerRadius = 0;
    }
}

@end
