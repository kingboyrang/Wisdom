//
//  FoodViewController.m
//  Wisdom
//
//  Created by aJia on 2013/10/31.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "FoodViewController.h"
#import "ASIHTTPRequest.h"
#import "NetWorkConnection.h"
@interface FoodViewController ()

@end

@implementation FoodViewController

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
    [self editBackBarbuttonItem:@"美食"];
    self.view.backgroundColor=[UIColor whiteColor];
    if (![NetWorkConnection IsEnableConnection]) {
        [self showNoNetworkNotice:nil];
        return;
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
        r.origin.x=(self.view.bounds.size.width-w)/2.0;
        r.origin.y=(self.view.bounds.size.height-98-40)/2.0;
        activityIndicator.frame=r;
        [self.view addSubview:activityIndicator];
        [activityIndicator.activityIndicatorView startAnimating];
    }
    /***
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
     NSError *error=nil;
     NSString *html=[NSString stringWithContentsOfURL:[NSURL URLWithString:ViewIntroduceURL] encoding:NSUTF8StringEncoding error:&error];
     if (error==nil) {
     dispatch_async(dispatch_get_main_queue(), ^{
     [activityIndicator removeFromSuperview];
     activityIndicator = nil;
     UIWebView *webView=[[[UIWebView alloc] initWithFrame:self.view.bounds] autorelease];
     [webView loadHTMLString:html baseURL:nil];
     [self.view addSubview:webView];
     });
     }
     else {
     [activityIndicator removeFromSuperview];
     activityIndicator = nil;
     [self showErrorViewWithHide:^(AnimateErrorView *errorView) {
     errorView.labelTitle.text=@"加载失败!";
     } completed:nil];
     }
     });
     ***/
    
    ASIHTTPRequest *reuqest=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:FoodIntroduceURL]];
    [reuqest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [reuqest setCompletionBlock:^{
        [activityIndicator removeFromSuperview];
        activityIndicator = nil;
        if (reuqest.responseStatusCode==200) {
            UIWebView *webView=[[[UIWebView alloc] initWithFrame:self.view.bounds] autorelease];
            webView.scalesPageToFit=YES;
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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
