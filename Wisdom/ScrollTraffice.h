//
//  ScrollTraffice.h
//  Wisdom
//
//  Created by aJia on 2013/11/4.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollTraffice : UIView<UIWebViewDelegate>{
    BOOL isRoadSuccess;
    BOOL isBusSuccess;
    BOOL isTaxiSuccess;
    BOOL isFlightSuccess;
    int curPage;
}
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,assign) id controller;
-(void)loadWebView:(int)index;
-(BOOL)goBackWebPage;
@end
