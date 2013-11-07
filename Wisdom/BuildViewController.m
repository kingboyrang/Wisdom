//
//  BuildViewController.m
//  Wisdom
//
//  Created by aJia on 2013/11/7.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "BuildViewController.h"

@interface BuildViewController ()

@end

@implementation BuildViewController

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
    [self navigationItemWithBack];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.showRightBtnItem=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    [self loadRightWetherView];
    
    UIImage *image=[UIImage imageNamed:@"build.png"];
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 309)];
    [imageView setImage:image];
    [self.view addSubview:imageView];
    [imageView release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
