//
//  SkyViewController.h
//  Wisdom
//
//  Created by aJia on 2013/11/5.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SkyViewController : BasicViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,retain) NSArray *sourceData;

@end
