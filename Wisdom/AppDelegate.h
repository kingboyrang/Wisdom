//
//  AppDelegate.h
//  Wisdom
//
//  Created by aJia on 2013/10/28.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMKMapManager.h"
#import "BMapKit.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>{
   BMKMapManager* _mapManager;
}

@property (strong, nonatomic) UIWindow *window;

@end
