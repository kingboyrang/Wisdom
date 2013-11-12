//
//  TrafficViewController.m
//  Wisdom
//
//  Created by aJia on 2013/11/4.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "TrafficViewController.h"
#import "TrafficMenu.h"
#import "NetWorkConnection.h"
#import "ScrollTraffice.h"
@interface TrafficViewController ()

@end

@implementation TrafficViewController

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
    [self editBackBarbuttonItem:@"交通"];
    self.view.backgroundColor=[UIColor whiteColor];
    
    CGFloat h=self.view.bounds.size.height-44-54-48;
    ScrollTraffice *traffice=[[ScrollTraffice alloc] initWithFrame:CGRectMake(0, 48, DeviceWidth,h)];
    traffice.controller=self;
    
    TrafficMenu *menu=[[TrafficMenu alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 48)];
    menu.controller=traffice;
    [self.view addSubview:menu];
    [menu release];
    [self.view addSubview:traffice];
    [traffice loadWebView:0];
    [traffice release];
	// Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
