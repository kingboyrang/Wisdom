//
//  WebViewController.m
//  Wisdom
//
//  Created by aJia on 2013/11/7.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "WebViewController.h"
#import "NetWorkConnection.h"
#import "ASIHTTPRequest.h"
@interface WebViewController ()

@end

@implementation WebViewController

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
        activityIndicator.labelTitle.text=@"加载中...";
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
            CGRect r=self.view.bounds;
            r.size.height-=[self topHeight]+54;
            UIWebView *webView=[[[UIWebView alloc] initWithFrame:r] autorelease];
            [webView loadHTMLString:reuqest.responseString baseURL:nil];
            [self.view addSubview:webView];
        }else{
            [self showMessageWithTitle:@"加载失败!"];
        }
    }];
    [reuqest setFailedBlock:^{
        [activityIndicator removeFromSuperview];
        activityIndicator = nil;
        [self showMessageWithTitle:@"加载失败!"];
    }];
    [reuqest startAsynchronous];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
