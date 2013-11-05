//
//  WeatherCell.h
//  Wisdom
//
//  Created by aJia on 2013/11/5.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherCell : UICollectionViewCell

@property (retain, nonatomic) IBOutlet UILabel *labWeek;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) IBOutlet UILabel *labSTemp;
@property (retain, nonatomic) IBOutlet UILabel *labETemp;

@end
