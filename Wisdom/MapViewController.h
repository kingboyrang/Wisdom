//
//  MapViewController.h
//  Wisdom
//
//  Created by aJia on 2013/11/1.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
@interface MapViewController : BasicViewController<BMKMapViewDelegate>{
     BMKMapView* _mapView;
}
-(void)changeMapType:(id)sender;
-(void)cleanMap;
@end
