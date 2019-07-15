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
    
    UIColor * _currentMonthChineseTitleColor;       //当前月份日期农历文字颜色
    
    UIColor * _todayTitleColor;                     //今天文字颜色
    
    UIColor * _notCurrentMonthTitleColor;           //非当前月份日期文字颜色
    
    UIColor * _selectTitleColor;                    //选中后文字颜色
    
    UIColor * _weekendTitleColor;                    //周末文字颜色
    
    UIColor * _backColor;                           //文字背景颜色
    
    UIColor * _selectBackColor;                     //选中后文字背景颜色
    
    UIColor * _endSelectBackColor;                  //结束日期选中后文字背景颜色
    
    CGFloat   _dayFontSize;                         //日期文字尺寸
    
    CGFloat   _dayLabelSize;                        //日期文本尺寸
    
    BOOL      _showAnimation;                       //选中后是否展示动画
    
    BOOL      _showChineseDate;                     //是否显示农历日期
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
    
        [self setDefaultData];

        _titleLabel = [WYCalendarTool initLabelWithFrame:CGRectZero text:nil fontSize:0 textColor:nil aliment:NSTextAlignmentCenter];
        
        _titleLabel.backgroundColor = WYUIColorFromRGB(0xaaaaaa);
        
        _titleLabel.numberOfLines = 0;
        
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

- (void)setUpDayCellStyle:(void(^)(UIColor ** currentMonthTitleColor,UIColor ** currentMonthChineseTitleColor,UIColor ** todayTitleColor,UIColor ** notCurrentMonthTitleColor,UIColor ** selectTitleColor,UIColor ** weekendTitleColor,UIColor ** selectBackColor,UIColor ** backColor,UIColor ** endSelectBackColor,CGFloat *dayFontSize,CGFloat *dayLabelSize,BOOL *showAnimation,BOOL *showChineseDate))daySettingBlock
{
    UIColor * currentMonthTitleColor =      _currentMonthTitleColor;              //当前月份日期文字颜色
    
    UIColor * currentMonthChineseTitleColor = _currentMonthChineseTitleColor;     //当前月份日期农历文字颜色
    
    UIColor * todayTitleColor =             _todayTitleColor;                     //今天文字颜色
    
    UIColor * notCurrentMonthTitleColor =   _notCurrentMonthTitleColor;           //非当前月份日期文字颜色
    
    UIColor * selectTitleColor =            _selectTitleColor;                    //选中后文字颜色
    
    UIColor * weekendTitleColor =            _weekendTitleColor;                   //周末文字颜色
    
    UIColor * selectBackColor =             _selectBackColor;                     //选中后文字背景颜色
    
    UIColor * backColor =                   _backColor;                           //选中后文字背景颜色
    
    UIColor * endSelectBackColor =          _endSelectBackColor;                  //结束日期选中后文字背景颜色
    
    CGFloat   dayFontSize =                 _dayFontSize;                         //日期文字尺寸
    
    CGFloat   dayLabelSize =                _dayLabelSize;                        //日期文本尺寸
    
    BOOL      showAnimation =               _showAnimation;                       //选中后是否展示动画
    
    BOOL      showChineseDate =             _showChineseDate;                     //是否显示农历日期
    
    if (daySettingBlock) {
    daySettingBlock(&currentMonthTitleColor,&currentMonthChineseTitleColor,&todayTitleColor,&notCurrentMonthTitleColor,&selectTitleColor,&weekendTitleColor,&selectBackColor,&backColor,&endSelectBackColor,&dayFontSize,&dayLabelSize,&showAnimation,&showChineseDate);
        
        _currentMonthTitleColor =           currentMonthTitleColor;
        
        _currentMonthChineseTitleColor =    currentMonthChineseTitleColor;
        
        _todayTitleColor =                  todayTitleColor;
        
        _notCurrentMonthTitleColor =        notCurrentMonthTitleColor;
        
        _selectTitleColor =                 selectTitleColor;
        
        _weekendTitleColor =                weekendTitleColor;
        
        _selectBackColor =                  selectBackColor;
        
        _backColor =                        backColor;
        
        _endSelectBackColor =               endSelectBackColor;
        
        _dayFontSize =                      dayFontSize;
        
        _dayLabelSize =                     dayLabelSize;
        
        _showAnimation =                    showAnimation;
        
        _showChineseDate =                  showChineseDate;
    }
}

- (void)setDefaultData
{
    _currentMonthTitleColor = WYUIColorFromRGB(0x111111);
    
    _currentMonthChineseTitleColor = WYUIColorFromRGB(0x999999);
    
    _selectBackColor = _todayTitleColor = WYUIColorFromRGB(0x0fc6a6);
    
    _endSelectBackColor = [UIColor redColor];
    
    _notCurrentMonthTitleColor = WYUIColorFromRGB(0x999999);
    
    _selectTitleColor = WYUIColorFromRGB(0xffffff);
    
    _weekendTitleColor = _currentMonthTitleColor;
    
    _backColor = WYUIColorFromRGB(0xffffff);
    
    _dayFontSize = 8;
    
    _dayLabelSize = self.contentView.Width*0.8;
    
    _showAnimation = YES;
    
    _showChineseDate = YES;
}

- (void)setModel:(WYCalendarModel *)model
{
    _model = model;
    
    CGFloat width = self.contentView.Width;

    _titleLabel.frame = CGRectMake((width/2 - _dayLabelSize/2), (width/2 - _dayLabelSize/2), (_dayLabelSize), (_dayLabelSize));
    
    UIColor * defaultColor = nil;
    
    UIColor * chineseColor = nil;
    
    if (model.status & WYCalendarCurrentMonth) {
        
        defaultColor = _currentMonthTitleColor;
        
        chineseColor = _currentMonthChineseTitleColor;
        
        if (model.status & WYCalendarToday) {
            
            defaultColor = _todayTitleColor;
            
            chineseColor = _todayTitleColor;
        }
        
        //周末
        if (model.date.dateWeek == 1 || model.date.dateWeek == 7) {
            
            defaultColor = _weekendTitleColor;
            
            chineseColor = _weekendTitleColor;
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

            defaultColor = _selectTitleColor;
            
            chineseColor = _selectTitleColor;

            _titleLabel.backgroundColor = (model.status & WYCalendarEndSelected) ? _endSelectBackColor : _selectBackColor;
            
        }else{
            
            _titleLabel.backgroundColor = _backColor;
            
            _titleLabel.layer.cornerRadius = 0;
        }
        
    }else{
        
        defaultColor = _notCurrentMonthTitleColor;
        
        chineseColor = _notCurrentMonthTitleColor;
        
        _titleLabel.backgroundColor = _backColor;
        
        _titleLabel.layer.cornerRadius = 0;
    }
    
    NSString * day = model.day > 0 ? [NSString stringWithFormat:@"%zd",model.day] : @"";
    
    if (_showChineseDate) day = [NSString stringWithFormat:@"%@\n%@",day,model.date.ChineseDate];
   
    NSDictionary* titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                         defaultColor, NSForegroundColorAttributeName,
                                         [UIFont boldSystemFontOfSize:_dayFontSize], NSFontAttributeName,
                                         nil];
    
    NSMutableAttributedString * attr = [[NSMutableAttributedString alloc] initWithString:day attributes:titleTextAttributes];
    
    NSRange range = [day rangeOfString:model.date.ChineseDate];
    
    titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                           chineseColor, NSForegroundColorAttributeName,
                           [UIFont systemFontOfSize:_dayFontSize - 6], NSFontAttributeName,
                           nil];
    
    [attr addAttributes:titleTextAttributes range:range];
    
    _titleLabel.attributedText = attr;
}

@end
