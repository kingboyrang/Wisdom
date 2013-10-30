//
//  IndexViewController.m
//  Wisdom
//
//  Created by aJia on 2013/10/29.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "IndexViewController.h"
#import "FXLabel.h"
#import "NSString+TPCategory.h"
#import "AdView.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "UIButton+TPCategory.h"
#import "IndexMenu.h"
@interface IndexViewController ()
-(void)buttonLogin;
-(void)buttonRegister;
-(void)buttonExit;
-(void)loadButtonControls;
-(void)loadLabelControls;
@end

@implementation IndexViewController

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
   
    self.view.backgroundColor=[UIColor whiteColor];
    [self loadButtonControls];
    AdView *ad_view=[[AdView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 141)];
    ad_view.ads=[AdModel sourceModels];
    [self.view addSubview:ad_view];
    [ad_view adLoad];
    [ad_view release];
    
    IndexMenu *menu=[[IndexMenu alloc] initWithFrame:CGRectMake(0, 141, DeviceWidth, self.view.bounds.size.height-141-44-54)];
    menu.controler=self;
    [self.view addSubview:menu];
    [menu release];
    
    //[self loadLabelControls];
}
-(void)buttonMenuItemIndex:(NSString*)index{
    NSLog(@"index=%@\n",index);
}
-(void)loadButtonControls{
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
-(void)loadLabelControls{
    UIView *rightView=[[UIView alloc] initWithFrame:CGRectZero];
    rightView.backgroundColor=[UIColor clearColor];
    
    NSString *title=@"黄小勇";
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
    
    
    title=@"退出";
    size=[title textSize:[UIFont fontWithName:@"Helvetica-Bold" size:16] withWidth:self.view.bounds.size.width];
    FXLabel *exitLabel = [[FXLabel alloc] init];
    exitLabel.frame = CGRectMake(secondLabel.frame.size.width+5,0, size.width, size.height);
    exitLabel.backgroundColor = [UIColor clearColor];
    exitLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    exitLabel.text = title;
    exitLabel.textAlignment=NSTextAlignmentCenter;
    exitLabel.textColor = [UIColor whiteColor];
    exitLabel.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.75f];
    exitLabel.shadowOffset = CGSizeMake(0.0f, 5.0f);
    exitLabel.shadowBlur = 5.0f;
    [rightView addSubview:exitLabel];
    
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor=[UIColor clearColor];
    btn.frame=exitLabel.frame;
    [btn addTarget:self action:@selector(buttonExit) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:btn];
    rightView.frame=CGRectMake(0, 0, btn.frame.size.width+btn.frame.origin.x, size.height);
    [secondLabel release];
    [exitLabel release];
    UIBarButtonItem *rightBtn=[[UIBarButtonItem alloc] initWithCustomView:rightView];
    [rightView release];
    self.navigationItem.rightBarButtonItem=rightBtn;
    [rightBtn release];
    
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
-(void)buttonExit{

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
