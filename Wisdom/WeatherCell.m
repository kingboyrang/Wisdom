//
//  WeatherCell.m
//  Wisdom
//
//  Created by aJia on 2013/11/5.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "WeatherCell.h"

@implementation WeatherCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"WeatherCell" owner:self options: nil];
        if(arrayOfViews.count < 1){return nil;}
        if(![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]){
            return nil;
        }
        self = [arrayOfViews objectAtIndex:0];
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}
- (void)dealloc {
    [_labWeek release];
    [_imageView release];
    [_labSTemp release];
    [_labETemp release];
    [super dealloc];
}
@end
