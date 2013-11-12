//
//  ScrollTraffice.m
//  Wisdom
//
//  Created by aJia on 2013/11/4.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "ScrollTraffice.h"
#import "ASIHTTPRequest.h"
#import "AnimateLoadView.h"
#import "WBErrorNoticeView.h"
#import "NetWorkConnection.h"
#import "WBInfoNoticeView.h"
#import "UIColor+TPCategory.h"
@interface ScrollTraffice ()
-(void)changeStatus:(BOOL)status index:(int)index;
-(BOOL)loadStatusWithIndex:(int)index;
-(void)showInfoWithTitle:(NSString*)title;
@end
@implementation ScrollTraffice
@synthesize controller;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView=[[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.pagingEnabled=NO;
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.showsVerticalScrollIndicator=NO;
        [_scrollView setContentSize:frame.size];
        [self addSubview:_scrollView];
        
        isRoadSuccess=NO;
        isBusSuccess=NO;
        isTaxiSuccess=NO;
        isFlightSuccess=NO;
    }
    return self;
}
-(void)showInfoWithTitle:(NSString*)title{
    WBInfoNoticeView *info=[WBInfoNoticeView infoNoticeInView:self title:title];
    [info show];
    info.gradientView.backgroundColor=[UIColor colorFromHexRGB:@"c94018"];
}
-(BOOL)loadStatusWithIndex:(int)index{
    if (index==0) {
        return isRoadSuccess;
    }
    if (index==1) {
        return isBusSuccess;
    }
    if (index==2) {
        return isTaxiSuccess;
    }
    return isFlightSuccess;
}
-(void)loadWebView:(int)index{
    [_scrollView setContentOffset:CGPointMake(index*self.bounds.size.width, 0)];//页面滑动
    if ([self loadStatusWithIndex:index]) {//是否已加载成功
        return;
    }
    if (![NetWorkConnection IsEnableConnection]) {
        WBErrorNoticeView *notice = [WBErrorNoticeView errorNoticeInView:self title:@"网络未连接" message:@"请检查您的网络连接."];
        [notice show];
        return;
    }
    NSString *webUrl=RoadIntroduceURL;
    if (index==1) {
        webUrl=BusIntroduceURL;
    }
    if (index==2) {
        webUrl=TaxiIntroduceURL;
    }
    if (index==3) {
        webUrl=FlightIntroduceURL;
    }

    __block AnimateLoadView *activityIndicator = nil;
    if (!activityIndicator)    {
        activityIndicator=[[AnimateLoadView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        activityIndicator.backgroundColor=[UIColor clearColor];
        activityIndicator.activityIndicatorView.activityIndicatorViewStyle=UIActivityIndicatorViewStyleGray;
        activityIndicator.labelTitle.text=@"正在加载,请稍后...";
        activityIndicator.labelTitle.textColor=[UIColor blackColor];
        CGFloat w=activityIndicator.labelTitle.frame.origin.x+activityIndicator.labelTitle.frame.size.width;
        CGRect r=activityIndicator.frame;
        r.size.width=w;
        r.origin.x=(self.bounds.size.width-w)/2.0;
        r.origin.y=(self.bounds.size.height-40)/2.0;
        activityIndicator.frame=r;
        [self addSubview:activityIndicator];
        [activityIndicator.activityIndicatorView startAnimating];
    }
    ASIHTTPRequest *reuqest=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:webUrl]];
    [reuqest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [reuqest setCompletionBlock:^{
        [activityIndicator removeFromSuperview];
        activityIndicator = nil;
        if (reuqest.responseStatusCode==200) {
            CGRect frame=CGRectMake(index*self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
            UIWebView *webView=[[[UIWebView alloc] initWithFrame:frame] autorelease];
            webView.scrollView.minimumZoomScale=1.0;
            webView.scrollView.maximumZoomScale=2.0;
            webView.scrollView.decelerationRate=1.0f;
            //webView.scalesPageToFit=YES;
            [webView loadHTMLString:reuqest.responseString baseURL:nil];
            [_scrollView addSubview:webView];
            [self changeStatus:YES index:index];
        }else{
            [self changeStatus:NO index:index];
            [self showInfoWithTitle:@"加载失败!"];
            if (self.controller&&[self.controller respondsToSelector:@selector(loadWebPageFailed)]) {
                [self.controller performSelector:@selector(loadWebPageFailed)];
            }
        }
        
    }];
    [reuqest setFailedBlock:^{
        [activityIndicator removeFromSuperview];
        activityIndicator = nil;
        [self changeStatus:NO index:index];
        [self showInfoWithTitle:@"加载失败!"];
        if (self.controller&&[self.controller respondsToSelector:@selector(loadWebPageFailed)]) {
            [self.controller performSelector:@selector(loadWebPageFailed)];
        }
    }];
    [reuqest startAsynchronous];
}
-(void)changeStatus:(BOOL)status index:(int)index{
    if (index==0) {isRoadSuccess=status;}
    if (index==1) {isBusSuccess=status;}
    if (index==2) {isTaxiSuccess=status;}
    if (index==3) {isFlightSuccess=status;}
}
@end
