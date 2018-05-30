//
//  UIView+WYCategory.m
//  CalendarDemo
//
//  Created by 王勇 on 2018/5/27.
//  Copyright © 2018年 王勇. All rights reserved.
//

#import "UIView+WYCategory.h"
#import <objc/runtime.h>
@implementation UIControl (WYBlock)
static char blockKey;
- (void)addBlock:(buttonBlock)block event:(UIControlEvents)event
{
    objc_setAssociatedObject(self, &blockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(callControlActionBlock:) forControlEvents:event];
}
- (void)callControlActionBlock:(id)sender {
    buttonBlock block = (buttonBlock)objc_getAssociatedObject(self, &blockKey);
    if (block) {
        block(sender);
    }
}
@end
@implementation UIGestureRecognizer (WYBlock)
static char blockKey;
+ (instancetype)initWithBlockAction:(void(^)(UIGestureRecognizer * sender))blockAction
{
    UIGestureRecognizer * gestureRecognizer = [[[self class] alloc] init];
    [gestureRecognizer addBlock:blockAction];
    return gestureRecognizer;
}
- (void)addBlock:(void(^)(UIGestureRecognizer * sender))block
{
    objc_setAssociatedObject(self, &blockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(gestureRecognizerAction:)];
}
- (void)gestureRecognizerAction:(UIGestureRecognizer *)sender
{
    buttonBlock block = (buttonBlock)objc_getAssociatedObject(self, &blockKey);
    if (block) {
        block(sender);
    }
}
@end
@implementation NSTimer (WYBlock)
static char blockKey;
+ (instancetype)homedScheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block
{
    /**
     *  带block的定时器要求ios10
     */
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
        return [NSTimer scheduledTimerWithTimeInterval:interval repeats:repeats block:block];
    }
    objc_setAssociatedObject(self, &blockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(timerAction:) userInfo:nil repeats:repeats];
}
+ (void)timerAction:(NSTimer *)timer
{
    void (^block)(NSTimer *timer)  = (void (^)(NSTimer *timer))objc_getAssociatedObject(self, &blockKey);
    if (block) {
        block(timer);
    }
}
@end
@implementation UIButton (WYBlock)
static char blockKey;
+ (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title fontSize:(NSInteger)fontSize action:(dispatch_block_t)action color:(UIColor *)color
{
    UIButton * btn = [[UIButton alloc] initWithFrame:frame];
    btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    if (action) {
        [btn addBlock:action];
    }
    return btn;
}

- (void)addBlock:(dispatch_block_t)block
{
    objc_setAssociatedObject(self, &blockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)callActionBlock:(id)sender {
    dispatch_block_t block = (dispatch_block_t)objc_getAssociatedObject(self, &blockKey);
    if (block) {
        block();
    }
}
/**
 *  带参block
 */
+ (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title fontSize:(NSInteger)fontSize buttonAction:(buttonBlock)buttonAction color:(UIColor *)color
{
    UIButton * btn = [[UIButton alloc] initWithFrame:frame];
    btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    if (buttonAction) {
        [btn addButtonBlock:buttonAction];
    }
    return btn;
}
- (void)addButtonBlock:(buttonBlock)block
{
    objc_setAssociatedObject(self, &blockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(callButtonActionBlock:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)callButtonActionBlock:(id)sender {
    buttonBlock block = (buttonBlock)objc_getAssociatedObject(self, &blockKey);
    if (block) {
        block(sender);
    }
}
@end

@implementation UIView (WYCategory)
#pragma mark - get
- (CGFloat)Width
{
    return self.frame.size.width;
}
- (CGFloat)Height
{
    return self.frame.size.height;
}
- (CGFloat)X
{
    return self.frame.origin.x;
}
- (CGFloat)Y
{
    return self.frame.origin.y;
}
- (CGFloat)CenterX
{
    return self.center.x;
}
- (CGFloat)CenterY
{
    return self.center.y;
}
- (CGSize)Size
{
    return self.frame.size;
}
- (CGPoint)Origin
{
    return self.frame.origin;
}
- (CGFloat)Bottom
{
    return self.Y + self.Height;
}
- (CGFloat)Right
{
    return self.X + self.Width;
}
#pragma mark - set
- (void)setWidth:(CGFloat)Width
{
    CGRect frame = self.frame;
    frame.size.width = Width;
    self.frame = frame;
}
- (void)setHeight:(CGFloat)Height
{
    CGRect frame = self.frame;
    frame.size.height = Height;
    self.frame = frame;
}
- (void)setX:(CGFloat)X
{
    CGRect frame = self.frame;
    frame.origin.x = X;
    self.frame = frame;
}
- (void)setY:(CGFloat)Y
{
    CGRect frame = self.frame;
    frame.origin.y = Y;
    self.frame = frame;
}
- (void)setCenterX:(CGFloat)CenterX
{
    CGPoint center = self.center;
    center.x = CenterX;
    self.center = center;
}
- (void)setCenterY:(CGFloat)CenterY
{
    CGPoint center = self.center;
    center.y = CenterY;
    self.center = center;
}
- (void)setSize:(CGSize)Size
{
    CGRect frame = self.frame;
    frame.size = Size;
    self.frame = frame;
}
- (void)setOrigin:(CGPoint)Origin
{
    CGRect frame = self.frame;
    frame.origin = Origin;
    self.frame = frame;
}
- (void)setBottom:(CGFloat)Bottom
{
    
}
- (void)setRight:(CGFloat)Right
{
    
}
@end
