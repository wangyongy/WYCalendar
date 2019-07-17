//
//  WYCalendarMonthCollectionViewCell.h
//  WYCalendar
//
//  Created by 王勇 on 2019/7/17.
//  Copyright © 2019 王勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYCalendarView.h"
NS_ASSUME_NONNULL_BEGIN
@interface WYCalendarMonthCollectionViewCell : UICollectionViewCell

/*日历模型数组*/
@property(nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic, strong) WYCalendarView * calendarView;

@property (nonatomic, copy) void(^selectBlock)(NSIndexPath * indexPath);

@property (nonatomic, strong) UICollectionView * collectionView;

@end

NS_ASSUME_NONNULL_END
