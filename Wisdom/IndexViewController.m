//
//  IndexViewController.m
//  Wisdom
//
//  Created by aJia on 2013/10/29.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "IndexViewController.h"

#import "IndexMenu.h"
#import "MaitreyaViewController.h"
#import "ViewViewController.h"
#import "HotelViewController.h"
#import "FoodViewController.h"
#import "TrafficViewController.h"
#import "WebViewController.h"
#import "IntrouduceViewController.h"
@interface IndexViewController ()
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
- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.view.backgroundColor=[UIColor whiteColor];
    
    AdView *ad_view=[[AdView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 141)];
    ad_view.delegate=self;
    ad_view.ads=[AdModel sourceModels];
    [self.view addSubview:ad_view];
    [ad_view adLoad];
    [ad_view release];
    
    IndexMenu *menu=[[IndexMenu alloc] initWithFrame:CGRectMake(0, 141, DeviceWidth, self.view.bounds.size.height-141-[self topHeight]-54)];
    menu.controler=self;
    [self.view addSubview:menu];
    [menu release];
    
}
- (void)openAd: (AdView *)controller adModel: (AdModel *)adModel{
    WebViewController *web=[[WebViewController alloc] init];
    web.webURL=adModel.webURl;
    [self.navigationController pushViewController:web animated:YES];
    [web release];
}
-(void)buttonMenuItemIndex:(NSString*)index{
    /***
    if ([index isEqualToString:@"0"]) {
        MaitreyaViewController *controller=[[MaitreyaViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
    }
    if ([index isEqualToString:@"1"]) {
        ViewViewController *controller=[[ViewViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
    }
    if ([index isEqualToString:@"3"]) {
        HotelViewController *controller=[[HotelViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
    }
    if ([index isEqualToString:@"4"]) {
        FoodViewController *controller=[[FoodViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
    }
    ***/
    if ([index isEqualToString:@"2"]) {
        TrafficViewController *controller=[[TrafficViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
    }else{
        IntrouduceViewController *controller=[[IntrouduceViewController alloc] init];
        controller.introduceType=index;
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
