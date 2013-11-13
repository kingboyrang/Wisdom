//
//  BasicViewController.m
//  Wisdom
//
//  Created by aJia on 2013/10/29.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "BasicViewController.h"
#import "FXLabel.h"
#import "UIColor+TPCategory.h"
#import "NSString+TPCategory.h"
#import "UIImage+TPCategory.h"
#import "Account.h"
#import "UIButton+TPCategory.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "WBErrorNoticeView.h"
#import "WBInfoNoticeView.h"
#import "SkyViewController.h"
#import "MemberViewController.h"
#import "MainViewController.h"
#import "AlertHelper.h"
@interface BasicViewController (){
    AnimateLoadView *_loadView;
    AnimateErrorView *_errorView;
    AnimateErrorView *_successView;
}
-(void)buttonLogin;
-(void)buttonRegister;
-(void)buttonWeatherClick;
-(void)buttonMemberClick;
-(void)loadLeftLogoImage;
-(void)loadLeftBackBarButtonItem;
-(void)popself;
@end

@implementation BasicViewController
@synthesize showRightBtnItem;
-(void)dealloc{
    [super dealloc];
    if(_loadView){
        [_loadView release],_loadView=nil;
    }
    if(_errorView){
        [_errorView release],_errorView=nil;
    }
    if(_successView){
        [_successView release],_successView=nil;
    }
}
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
    if (self.showRightBtnItem) {
        Account *acc=[Account sharedInstance];
        if (acc.isLogin) {
            [self loadLoginBarButtonItem];
        }else{
            [self loadNoLoginBarButtonItem];
        }
    }
    if (self.showWeatherView) {
        [self loadWetherTitleView];
    }
    
}
- (void)viewDidLoad
{
    self.showRightBtnItem=YES;
    self.showWeatherView=YES;
    [super viewDidLoad];
    
    if (self.navigationController.viewControllers.count>1) {
        [self loadLeftBackBarButtonItem];
    }else{
        [self loadLogoImage];
    }
    
}
-(void)popself
{
    NSArray *arr=self.navigationController.viewControllers;
    id v=[arr objectAtIndex:arr.count-1];
    if ([v isKindOfClass:[LoginViewController class]]||[v isKindOfClass:[RegisterViewController class]]) {
        MainViewController *main=(MainViewController*)self.tabBarController;
        [main setSelectedItemIndex:0];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)loadLeftLogoImage{
    UIImage *image1=[UIImage imageNamed:@"titletext1.png"];
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0,(44-image1.size.height)/2,image1.size.width, image1.size.height)];
    [imageView setImage:image1];
    
    UIBarButtonItem *leftBtn=[[UIBarButtonItem alloc] initWithCustomView:imageView];
    [imageView release];
    self.navigationItem.leftBarButtonItem=leftBtn;
    [leftBtn release];
}
-(void)loadLeftBackBarButtonItem{
    UIView *leftView=[[UIView alloc] initWithFrame:CGRectZero];
    leftView.backgroundColor=[UIColor clearColor];
    
    
    UIImage *image=[UIImage imageNamed:@"back1.png"];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, image.size.width, image.size.height);
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:btn];
    
    
    UIImage *image1=[UIImage imageNamed:@"titletext1.png"];
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(btn.frame.size.width,(image.size.height-image1.size.height)/2,image1.size.width, image1.size.height)];
    [imageView setImage:image1];
    [leftView addSubview:imageView];
    
    
    leftView.frame=CGRectMake(0, 0, imageView.frame.origin.x+imageView.frame.size.width, image.size.height);
    [imageView release];
    
    UIBarButtonItem *leftBtn=[[UIBarButtonItem alloc] initWithCustomView:leftView];
    [leftView release];
    self.navigationItem.leftBarButtonItem=leftBtn;
    [leftBtn release];
}
- (void) showMessageWithTitle:(NSString*)title{
    [self showMessageWithTitle:title innerView:self.view];
}
- (void) showMessageWithTitle:(NSString*)title innerView:(UIView*)view{
    WBInfoNoticeView *info=[WBInfoNoticeView infoNoticeInView:view title:title];
    [info show];
    info.gradientView.backgroundColor=[UIColor colorFromHexRGB:@"c94018"];
}
- (void) showNoNetworkNotice:(void (^)(void))dismissError{
    WBErrorNoticeView *notice = [WBErrorNoticeView errorNoticeInView:self.view title:@"网络未连接" message:@"请检查您的网络连接."];
    [notice setDismissalBlock:^(BOOL dismissedInteractively) {
        if (dismissError) {
            dismissError();
        }
    }];
    [notice show];
}
-(void)navigationItemWithBack{
    [self navigationItemWithBackTitle:nil];
}
-(void)navigationItemWithBackTitle:(NSString *)title{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_com.png"] forBarMetrics:UIBarMetricsDefault];
    [self editBackBarbuttonItem:title];
}
-(void)loadWetherTitleView{
    if (self.navigationItem.titleView!=nil) {
        return;
    }
    UIImage *image=[[UIImage imageNamed:@"ico_weather.png"] imageByScalingProportionallyToSize:CGSizeMake(62*35/44, 35)];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0,9/2, image.size.width, image.size.height);
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonWeatherClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView=btn;
}
-(void)buttonWeatherClick{
    SkyViewController *weather=[[SkyViewController alloc] init];
    [self.navigationController pushViewController:weather animated:YES];
    [weather release];
}
-(void)loadNoLoginBarButtonItem{
    UIView *rightView=[[UIView alloc] initWithFrame:CGRectZero];
    rightView.backgroundColor=[UIColor clearColor];
    UIButton *btn1=[UIButton buttonWithBackgroundTitle:@"登录" target:self action:@selector(buttonLogin)];
    [rightView addSubview:btn1];
    UIButton *btn2=[UIButton buttonWithBackgroundTitle:@"注册" target:self action:@selector(buttonRegister)];
    CGRect r=btn2.frame;
    r.origin.x=btn1.frame.size.width+5;
    btn2.frame=r;
    [rightView addSubview:btn2];
    rightView.frame=CGRectMake(0, 0, btn2.frame.size.width+btn2.frame.origin.x, 35);
    UIBarButtonItem *rightBtn=[[UIBarButtonItem alloc] initWithCustomView:rightView];
    [rightView release];
    self.navigationItem.rightBarButtonItem=rightBtn;
    [rightBtn release];
}
-(void)loadLoginBarButtonItem{
    Account *acc=[Account sharedInstance];
    
    UIView *rightView=[[UIView alloc] initWithFrame:CGRectZero];
    rightView.backgroundColor=[UIColor clearColor];
    
    NSString *title=acc.userAcc;
    CGSize size=[title textSize:[UIFont fontWithName:@"Helvetica-Bold" size:16] withWidth:self.view.bounds.size.width];
    
    FXLabel *secondLabel = [[FXLabel alloc] init];
    secondLabel.frame = CGRectMake(0,0, size.width, size.height);
    secondLabel.backgroundColor = [UIColor clearColor];
    secondLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    secondLabel.text = title;
    secondLabel.textAlignment=NSTextAlignmentCenter;
    secondLabel.textColor = [UIColor whiteColor];
    secondLabel.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.75f];
    secondLabel.shadowOffset = CGSizeMake(0.0f, 5.0f);
    secondLabel.shadowBlur = 5.0f;
    [rightView addSubview:secondLabel];
    
    
    UIImage *image=[[UIImage imageNamed:@"ico_login.png"] imageByScalingToSize:CGSizeMake(35, 35)];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(secondLabel.frame.size.width+secondLabel.frame.origin.x+2, -8, image.size.width, image.size.height);
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    //[btn addTarget:self action:@selector(buttonExitLogin) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:btn];
    rightView.frame=CGRectMake(0, 0, btn.frame.size.width+btn.frame.origin.x, size.height);
    [secondLabel release];
    
    UIBarButtonItem *rightBtn=[[UIBarButtonItem alloc] initWithCustomView:rightView];
    [rightView release];
    self.navigationItem.rightBarButtonItem=rightBtn;
    [rightBtn release];
}
-(void)loadLogoImage{
    UIImage *image1=[UIImage imageNamed:@"titletext.png"];
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0,(44-image1.size.height)/2,image1.size.width, image1.size.height)];
    [imageView setImage:image1];
    
    UIBarButtonItem *leftBtn=[[UIBarButtonItem alloc] initWithCustomView:imageView];
    [imageView release];
    self.navigationItem.leftBarButtonItem=leftBtn;
    [leftBtn release];
}
-(void)buttonMemberClick{
    MainViewController *main=(MainViewController*)self.tabBarController;
    [main setSelectedItemIndex:3];
    UINavigationController *nav=[main.viewControllers objectAtIndex:3];
    [nav popToRootViewControllerAnimated:YES];
}
#pragma mark login/register events
-(void)buttonLogin{
    LoginViewController *login=[[LoginViewController alloc] init];
    [self.navigationController pushViewController:login animated:YES];
    [login release];
}
-(void)buttonRegister{
    RegisterViewController *registerController=[[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerController animated:YES];
    [registerController release];
}
-(void)buttonExitLogin{
}
-(void)editBackBarbuttonItem:(NSString*)title{
    [self.navigationItem backBarBtnItem:title target:self action:@selector(buttonBackClick)];
}
-(void)buttonBackClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 动画提示
-(AnimateErrorView*) errorView {
    
    if (!_errorView) {
        _errorView=[[AnimateErrorView alloc] initWithFrame:CGRectMake(0, -40, DeviceWidth, 40)];
        _errorView.backgroundColor=[UIColor redColor];
        [_errorView setErrorImage:[UIImage imageNamed:@"notice_error_icon.png"]];
    }
    return _errorView;
}

-(AnimateLoadView*) loadingView {
    if (!_loadView) {
        _loadView=[[AnimateLoadView alloc] initWithFrame:CGRectMake(0, -40, DeviceWidth, 40)];
    }
    return _loadView;
}
-(AnimateErrorView*) successView {
    if (!_successView) {
        _successView=[[AnimateErrorView alloc] initWithFrame:CGRectMake(0, -40, DeviceWidth, 40)];
        _successView.backgroundColor=[UIColor colorFromHexRGB:@"ddd978"];
        [_successView setErrorImage:[UIImage imageNamed:@"notice_success_icon.png"]];
    }
    return _successView;
}

-(void) showLoadingAnimated:(void (^)(AnimateLoadView *errorView))process{
    AnimateLoadView *loadingView = [self loadingView];
    if (process) {
        process(loadingView);
    }
    [self.view addSubview:loadingView];
    [self.view bringSubviewToFront:loadingView];
    [loadingView.activityIndicatorView startAnimating];
    CGRect r=loadingView.frame;
    r.origin.y=2;
    [UIView animateWithDuration:0.5f animations:^{
        loadingView.frame=r;
    }];
}

-(void) hideLoadingViewAnimated:(void (^)(AnimateLoadView *hideView))complete{
    
    AnimateLoadView *loadingView = [self loadingView];
    CGRect r=loadingView.frame;
    r.origin.y=-r.size.height;
    [UIView animateWithDuration:0.5f animations:^{
        loadingView.frame=r;
    } completion:^(BOOL finished) {
        [loadingView.activityIndicatorView stopAnimating];
        [loadingView removeFromSuperview];
        if (complete) {
            complete(loadingView);
        }
    }];
}

-(void) showErrorViewAnimated:(void (^)(AnimateErrorView *errorView))process{
    AnimateErrorView *errorView = [self errorView];
    if (process) {
        process(errorView);
    }
    [self.view addSubview:errorView];
    [self.view bringSubviewToFront:errorView];
    CGRect r=errorView.frame;
    r.origin.y=2;
    [UIView animateWithDuration:0.5f animations:^{
        errorView.frame=r;
    }];
}
-(void) hideErrorViewAnimatedWithDuration:(NSTimeInterval)duration completed:(void (^)(AnimateErrorView *errorView))complete;{
    AnimateErrorView *errorView = [self errorView];
    CGRect r=errorView.frame;
    r.origin.y=-r.size.height;
    [UIView animateWithDuration:duration animations:^{
        errorView.frame=r;
    } completion:^(BOOL finished) {
        [errorView removeFromSuperview];
        if (complete) {
            complete(errorView);
        }
    }];
}
-(void) hideErrorViewAnimated:(void (^)(AnimateErrorView *errorView))complete{
    [self hideErrorViewAnimatedWithDuration:0.5f completed:complete];
}
-(void) showErrorViewWithHide:(void (^)(AnimateErrorView *errorView))process completed:(void (^)(AnimateErrorView *errorView))complete{
    [self showErrorViewAnimated:process];
    [self performSelector:@selector(hideErrorViewAnimated:) withObject:complete afterDelay:2.0f];
}
-(void) hideLoadingFailedWithTitle:(NSString*)title completed:(void (^)(AnimateErrorView *errorView))complete{
    [self hideLoadingViewAnimated:^(AnimateLoadView *hideView) {
        [self showErrorViewWithHide:^(AnimateErrorView *errorView) {
            errorView.labelTitle.text=title;
        } completed:complete];
    }];
}
-(void) showSuccessViewAnimated:(void (^)(AnimateErrorView *errorView))process{
    AnimateErrorView *errorView = [self successView];
    if (process) {
        process(errorView);
    }
    [self.view addSubview:errorView];
    [self.view bringSubviewToFront:errorView];
    CGRect r=errorView.frame;
    r.origin.y=2;
    [UIView animateWithDuration:0.5f animations:^{
        errorView.frame=r;
    }];
}
-(void) hideSuccessViewAnimated:(void (^)(AnimateErrorView *errorView))complete{
    AnimateErrorView *errorView = [self successView];
    CGRect r=errorView.frame;
    r.origin.y=-r.size.height;
    [UIView animateWithDuration:0.5f animations:^{
        errorView.frame=r;
    } completion:^(BOOL finished) {
        [errorView removeFromSuperview];
        if (complete) {
            complete(errorView);
        }
    }];
}
-(void) showSuccessViewWithHide:(void (^)(AnimateErrorView *errorView))process completed:(void (^)(AnimateErrorView *errorView))complete{
    [self showSuccessViewAnimated:process];
    [self performSelector:@selector(hideSuccessViewAnimated:) withObject:complete afterDelay:2.0f];
}
-(void) hideLoadingSuccessWithTitle:(NSString*)title completed:(void (^)(AnimateErrorView *errorView))complete{
    [self hideLoadingViewAnimated:^(AnimateLoadView *hideView) {
        [self showSuccessViewAnimated:^(AnimateErrorView *errorView) {
            errorView.labelTitle.text=title;
        }];
        [self performSelector:@selector(hideSuccessViewAnimated:) withObject:complete afterDelay:2.0f];
    }];
}
@end
