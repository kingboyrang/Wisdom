//
//  PushViewController.m
//  Wisdom
//
//  Created by aJia on 2013/11/4.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "PushViewController.h"
#import "scrollSwitch.h"
#import "PushView.h"
@interface PushViewController ()

@end

@implementation PushViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topbg.png"] forBarMetrics:UIBarMetricsDefault];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadWetherTitleView];
    
    self.view.backgroundColor=[UIColor whiteColor];
    scrollSwitch *switchItem=[[scrollSwitch alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 40)];
    switchItem.controler=self;
    [self.view addSubview:switchItem];
    [switchItem release];
    
    CGFloat h=self.view.bounds.size.height-44-54-40;
    _scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, DeviceWidth, h)];
    _scrollView.pagingEnabled=NO;
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.showsVerticalScrollIndicator=NO;
    [_scrollView setContentSize:CGSizeMake(DeviceWidth, h)];
    [self.view addSubview:_scrollView];
    
    PushView *view1=[[[PushView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, h)] autorelease];
    view1.infoType=1;
    view1.tag=100;
    [_scrollView addSubview:view1];
    [view1 loadingSourceData];
    
    PushView *view2=[[PushView alloc] initWithFrame:CGRectMake(DeviceWidth, 0, DeviceWidth, h)];
    view2.tag=101;
    view2.infoType=2;
    [_scrollView addSubview:view2];
    [view2 release];
    
        
}
-(void)pageScrollLeft{
    PushView *view=(PushView*)[_scrollView viewWithTag:100];
    view.infoType=1;
    [view loadingSourceData];
    [self.scrollView setContentOffset:CGPointMake(0, 0)];//页面滑动
}
-(void)pageScrollRight{
    PushView *view=(PushView*)[_scrollView viewWithTag:101];
    view.infoType=2;
    [view loadingSourceData];
    [self.scrollView setContentOffset:CGPointMake(DeviceWidth, 0)];//页面滑动
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
