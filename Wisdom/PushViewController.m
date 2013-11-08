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
#import "PushDetail.h"
#import "Account.h"
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
    switchItem.tag=900;
    switchItem.controler=self;
    [self.view addSubview:switchItem];
   
    
    CGFloat h=self.view.bounds.size.height-44-54-40;
    _scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, DeviceWidth, h)];
    _scrollView.delegate=self;
    _scrollView.pagingEnabled=YES;
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.showsVerticalScrollIndicator=NO;
    [_scrollView setContentSize:CGSizeMake(DeviceWidth*2, h)];
    [self.view addSubview:_scrollView];
    
     /***
    PushDetail *detail=[[PushDetail alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 77)];
    detail.labDate.text=@"2012.10.08";
    detail.labMessage.text=@"test all 15:33";
    [_scrollView addSubview:detail];
    [detail release];
   ***/
    
    PushView *view1=[[[PushView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, h)] autorelease];
    view1.infoType=1;
    view1.tag=100;
    [_scrollView addSubview:view1];
    
    
    PushView *view2=[[[PushView alloc] initWithFrame:CGRectMake(DeviceWidth, 0, DeviceWidth, h)] autorelease];
    view2.tag=101;
    view2.infoType=2;
    [_scrollView addSubview:view2];
 
    Account *acc=[Account sharedInstance];
    if(acc.isLogin){
      [view1 loadingSourceData];
    }else{
       [switchItem scrollerToRight];
    }
    [switchItem release];  
}
#pragma mark -
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //更新UIPageControl的当前页
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    int page=offset.x / bounds.size.width;
    
    scrollSwitch *item=(scrollSwitch*)[self.view viewWithTag:900];
    if(page==0){
        [item scrollerToLeft];
    }else{
        [item scrollerToRight];
    }
    
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
