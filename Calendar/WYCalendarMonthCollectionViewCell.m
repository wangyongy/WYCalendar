//
//  WYCalendarMonthCollectionViewCell.m
//  WYCalendar
//
//  Created by 王勇 on 2019/7/17.
//  Copyright © 2019 王勇. All rights reserved.
//

#import "WYCalendarMonthCollectionViewCell.h"
#import "WYCalendarCollectionViewCell.h"
#import "WYCalendarTool.h"
#import "UIView+WYCategory.h"
@interface WYCalendarMonthCollectionViewCell ()


@end
@implementation WYCalendarMonthCollectionViewCell
{
    CGFloat  _cellWidth;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _cellWidth = frame.size.width/7;
        
        [self.contentView addSubview:self.collectionView];
    }
    return self;
}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        
        flowLayout.minimumInteritemSpacing = 0.0f;
        
        flowLayout.minimumLineSpacing = 0.0f;
        
        flowLayout.itemSize = CGSizeMake(_cellWidth, _cellWidth);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:self.contentView.bounds collectionViewLayout:flowLayout];
        
        _collectionView.backgroundColor = self.contentView.backgroundColor;
        
        _collectionView.delegate = (id<UICollectionViewDelegate>)self;
        
        _collectionView.dataSource = (id<UICollectionViewDataSource>)self;
        
        _collectionView.showsVerticalScrollIndicator = NO;
        
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [_collectionView registerClass:[WYCalendarCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
 
    return _collectionView;
}
- (void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = [NSMutableArray arrayWithArray:dataArray];
    
    [_collectionView reloadData];
}
#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIndentifier = @"cell";
    
    WYCalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifier forIndexPath:indexPath];
    
    if (!cell) {
        
        cell = [[WYCalendarCollectionViewCell alloc] init];
    }
    
    [cell setUpDayCellStyle:[self.calendarView valueForKey:@"_daySettingBlock"]];
    
    cell.model = self.dataArray[indexPath.row];
    
    
    void(^setCustomCellBlock)(UICollectionViewCell *cell,NSDate * date) = [self.calendarView valueForKey:@"_setCustomCellBlock"];//自定义cell
    
    if (setCustomCellBlock) {

        setCustomCellBlock(cell,cell.model.date);
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectBlock) {
        
        self.selectBlock(indexPath);
    }
}
@end
