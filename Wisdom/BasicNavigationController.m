//
//  BasicNavigationController.m
//  Wisdom
//
//  Created by aJia on 2013/10/29.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "BasicNavigationController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "MainViewController.h"
@interface BasicNavigationController ()
-(void)popself;
-(UIBarButtonItem*)customLeftBackButton;
-(UIBarButtonItem*)loadLogoImage;
@end

@implementation BasicNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)popself
{
    NSArray *arr=self.viewControllers;
    id v=[arr objectAtIndex:arr.count-1];
    if ([v isKindOfClass:[LoginViewController class]]||[v isKindOfClass:[RegisterViewController class]]) {
        [self popToRootViewControllerAnimated:YES];
        //[self.navigationBar popNavigationItemAnimated:NO];
        NSLog(@"popToRootViewControllerAnimated");
        MainViewController *main=(MainViewController*)self.tabBarController;
        [main setSelectedItemIndex:0];
    }else{
        NSLog(@"popViewController");
        [self popViewControllerAnimated:YES];
    }
}

-(UIBarButtonItem*)customLeftBackButton{
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
    return  [leftBtn autorelease];
}
-(UIBarButtonItem*)loadLogoImage{
    UIImage *image1=[UIImage imageNamed:@"titletext.png"];
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0,(44-image1.size.height)/2,image1.size.width, image1.size.height)];
    [imageView setImage:image1];
    
    UIBarButtonItem *leftBtn=[[UIBarButtonItem alloc] initWithCustomView:imageView];
    [imageView release];
    return  [leftBtn autorelease];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (![self.topViewController isKindOfClass:[viewController class]]) {
        [super pushViewController:viewController animated:animated];
    }
    /***
    if ([self.viewControllers count]==1){
        viewController.navigationItem.leftBarButtonItem =[self loadLogoImage];
    }else{
        viewController.navigationItem.leftBarButtonItem =[self customLeftBackButton];
    }  
     ***/
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
