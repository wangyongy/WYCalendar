//
//  UIView+WYCategory.h
//  CalendarDemo
//
//  Created by 王勇 on 2018/5/27.
//  Copyright © 2018年 王勇. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^buttonBlock)(id sender);
@interface UIControl (WYBlock)

- (void)addBlock:(buttonBlock)block event:(UIControlEvents)event;

@end
@interface UIButton (WYBlock)
+ (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title fontSize:(NSInteger)fontSize action:(dispatch_block_t)action color:(UIColor *)color;
/**
 *  带参block
 */
+ (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title fontSize:(NSInteger)fontSize buttonAction:(buttonBlock)buttonAction color:(UIColor *)color;
@end

@interface UIGestureRecognizer (WYBlock)
+ (instancetype)initWithBlockAction:(void(^)(UIGestureRecognizer * sender))blockAction;
@end
@interface NSTimer (WYBlock)
+ (instancetype)homedScheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block;
@end
@interface UIView (WYCategory)

@property(nonatomic,assign)CGFloat Width;
@property(nonatomic,assign)CGFloat Height;
@property(nonatomic,assign)CGFloat X;
@property(nonatomic,assign)CGFloat Y;
@property(nonatomic,assign)CGFloat CenterX;
@property(nonatomic,assign)CGFloat CenterY;
@property(nonatomic,assign)CGSize  Size;
@property(nonatomic,assign)CGPoint Origin;
@property(nonatomic,assign)CGFloat Bottom;
@property(nonatomic,assign)CGFloat Right;

@end
