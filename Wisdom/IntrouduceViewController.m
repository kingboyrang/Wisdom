//
//  IntrouduceViewController.m
//  Wisdom
//
//  Created by aJia on 2013/11/14.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "IntrouduceViewController.h"
#import "ASIHTTPRequest.h"
#import "NetWorkConnection.h"
#define IntrouduceArray [NSArray arrayWithObjects:@"弥勒介绍",@"景点",@"交通",@"住宿",@"美食", nil]
@interface IntrouduceViewController (){
    AnimateLoadView *activityIndicator;
}
-(NSString*)barButtonTitle;
@end

@implementation IntrouduceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self editBackBarbuttonItem:[self barButtonTitle]];
    self.view.backgroundColor=[UIColor whiteColor];
    if (![NetWorkConnection IsEnableConnection]) {
        [self showNoNetworkNotice:nil];
        return;
    }
    
    //添加UIWebView
    NSURL *webURL=[NSURL URLWithString:self.webURL];
    NSURLRequest *request=[NSURLRequest requestWithURL:webURL];
    
    CGRect rect=self.view.bounds;
    rect.size.height-=54+44;
    UIWebView *webView=[[[UIWebView alloc] initWithFrame:rect] autorelease];
    webView.tag=100;
    webView.allowsInlineMediaPlayback=YES;
    webView.mediaPlaybackRequiresUserAction=YES;
    webView.mediaPlaybackAllowsAirPlay=YES;
    //webView.suppressesIncrementalRendering=YES;
    webView.keyboardDisplayRequiresUserAction=YES;
    webView.delegate=self;
    [self.view addSubview:webView];
    
    activityIndicator=[[AnimateLoadView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    activityIndicator.backgroundColor=[UIColor clearColor];
    activityIndicator.activityIndicatorView.activityIndicatorViewStyle=UIActivityIndicatorViewStyleGray;
    activityIndicator.labelTitle.text=@"正在加载,请稍后...";
    activityIndicator.labelTitle.textColor=[UIColor blackColor];
    CGFloat w=activityIndicator.labelTitle.frame.origin.x+activityIndicator.labelTitle.frame.size.width;
    CGRect r=activityIndicator.frame;
    r.size.width=w;
    r.origin.x=(self.view.bounds.size.width-w)/2.0;
    r.origin.y=(self.view.bounds.size.height-98-40)/2.0;
    activityIndicator.frame=r;
    [self.view addSubview:activityIndicator];
    [activityIndicator.activityIndicatorView startAnimating];
    
    [webView loadRequest:request];
    
    /***
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
        r.origin.x=(self.view.bounds.size.width-w)/2.0;
        r.origin.y=(self.view.bounds.size.height-98-40)/2.0;
        activityIndicator.frame=r;
        [self.view addSubview:activityIndicator];
        [activityIndicator.activityIndicatorView startAnimating];
    }
    ASIHTTPRequest *reuqest=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:self.webURL]];
    [reuqest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [reuqest setCompletionBlock:^{
        [activityIndicator removeFromSuperview];
        activityIndicator = nil;
        if (reuqest.responseStatusCode==200) {
            UIWebView *webView=[[[UIWebView alloc] initWithFrame:self.view.bounds] autorelease];
            webView.tag=100;
            webView.allowsInlineMediaPlayback=YES;
            webView.mediaPlaybackRequiresUserAction=YES;
            webView.mediaPlaybackAllowsAirPlay=YES;
            webView.suppressesIncrementalRendering=YES;
            webView.keyboardDisplayRequiresUserAction=YES;
            [webView loadHTMLString:reuqest.responseString baseURL:nil];
            [self.view addSubview:webView];
            return;
        }
        [self showMessageWithTitle:@"加载失败!"];
    }];
    [reuqest setFailedBlock:^{
        [activityIndicator removeFromSuperview];
        activityIndicator = nil;
        [self showMessageWithTitle:@"加载失败!"];
    }];
    [reuqest startAsynchronous];
     ***/
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [activityIndicator removeFromSuperview];
    activityIndicator = nil;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [activityIndicator removeFromSuperview];
    activityIndicator = nil;
    [self showMessageWithTitle:@"加载失败!"];
}
-(NSString*)barButtonTitle{
    if ([self.introduceType isEqualToString:@"0"]) {
        self.webURL=MaitreyaURL;
    }
    if ([self.introduceType isEqualToString:@"1"]) {
        self.webURL=ViewIntroduceURL;
    }
    if ([self.introduceType isEqualToString:@"3"]) {
        self.webURL=HotelIntroduceURL;
    }
    if ([self.introduceType isEqualToString:@"4"]) {
        self.webURL=FoodIntroduceURL;
    }
    int index=[self.introduceType intValue];
    return [IntrouduceArray objectAtIndex:index];
}
-(BOOL)backWebViewPage{
    id v=[self.view viewWithTag:100];
    if ([v isKindOfClass:[UIWebView class]]) {
        UIWebView *web=(UIWebView*)v;
        if (web.canGoBack) {
            [web goBack];
            return NO;
        }
    }
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
