//
//  CurrentWeather.h
//  Wisdom
//
//  Created by aJia on 2013/11/5.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceHelper.h"
@interface CurrentWeather : UIViewController{
    ServiceHelper *_helper;
}
@property (retain, nonatomic) IBOutlet UIImageView *imageView;

@property (retain, nonatomic) IBOutlet UILabel *labCurTemp;

@property (retain, nonatomic) IBOutlet UILabel *labSTemp;
@property (retain, nonatomic) IBOutlet UILabel *labETemp;
@property (retain, nonatomic) IBOutlet UILabel *labMemo;
@property (retain, nonatomic) IBOutlet UILabel *labTemp;
@property (retain, nonatomic) IBOutlet UILabel *labSpeed;

@end
