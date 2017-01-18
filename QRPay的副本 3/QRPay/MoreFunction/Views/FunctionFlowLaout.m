//
//  FunctionFlowLaout.m
//  QRPay
//
//  Created by 黄露 on 2016/11/17.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "FunctionFlowLaout.h"

@interface FunctionFlowLaout () {
    NSInteger allRows;
}

@end

@implementation FunctionFlowLaout

- (void) prepareLayout {
    
    //collection 的frame
    CGRect collectionFrame = self.collectionView.frame;
    CGFloat collectionWidth = collectionFrame.size.width;
    
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    //每行的item 的宽度
    CGFloat itemWidth = (collectionWidth - (self.numsOfPerRow + 1) * _marginOfRow) / self.numsOfPerRow;
    
    CGFloat itemHeight = itemWidth + 15 * PPWidth;
    
    self.minimumLineSpacing = _marginOfRow;
    self.minimumInteritemSpacing = _marginOfCol;
    
    self.itemSize = CGSizeMake(itemWidth, itemHeight);
    
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
}



@end
