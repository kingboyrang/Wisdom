//
//  MainViewController.m
//  active
//
//  Created by 徐 军 on 13-8-20.
//  Copyright (c) 2013年 chenjin. All rights reserved.
//

#import "MainViewController.h"
#import "UIColor+TPCategory.h"
#import "UIImage+TPCategory.h"
#import "IndexViewController.h"
#import "BasicNavigationController.h"
#import "MemberViewController.h"
#import "MapViewController.h"
//获取设备的物理高度
#define TabHeight 54 //工具栏高度
@interface MainViewController ()
-(void)updateSelectedStatus:(int)selectTag lastIndex:(int)prevIndex;
@end

@implementation MainViewController
-(void)dealloc{
    [super dealloc];
    [_tabbarView release];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
         [self.tabBar setHidden:YES];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [self _initViewController];//初始化子控制器
    [self _initTabbarView];//创建自定义tabBar
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UI
//初始化子控制器
- (void)_initViewController {
    
    IndexViewController *viewController1=[[[IndexViewController alloc] init] autorelease];
    BasicNavigationController *nav1=[[[BasicNavigationController alloc] initWithRootViewController:viewController1] autorelease];

   MapViewController *viewController2=[[[MapViewController alloc] init] autorelease];
    BasicNavigationController *nav2=[[[BasicNavigationController alloc] initWithRootViewController:viewController2] autorelease];
    
   UIViewController *viewController3=[[[UIViewController alloc] init] autorelease];
     viewController3.view.backgroundColor=[UIColor whiteColor];
    
   MemberViewController *viewController4=[[[MemberViewController alloc] init] autorelease];
    BasicNavigationController *nav4=[[[BasicNavigationController alloc] initWithRootViewController:viewController4] autorelease];
    
    self.viewControllers = [NSArray arrayWithObjects:nav1,nav2,viewController3,nav4, nil];
    
    //重设可见视图大小
    
    UIView *transitionView =[[self.view subviews] objectAtIndex:0];
    CGRect frame=transitionView.frame;
    frame.size.height=DeviceHeight-TabHeight;
    frame.size.width=DeviceWidth;
    transitionView.frame=frame;
}

//创建自定义tabBar
- (void)_initTabbarView {
    _tabbarView = [[UIView alloc] initWithFrame:CGRectMake(0, DeviceHeight-TabHeight, DeviceWidth, TabHeight)];
    _tabbarView.backgroundColor=[UIColor redColor];
    _tabbarView.autoresizesSubviews=YES;
    _tabbarView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:_tabbarView];
    NSArray *heightBackground = @[@"index.png",@"location.png",@"message.png",@"search.png"];
    NSArray *backgroud = @[@"index_select.png",@"location_select.png",@"message_select.png",@"search_select.png"];
    
       //总数
    _barButtonItemCount=[backgroud count];
    //
    _prevSelectIndex=0;
    
    for (int i=0; i<backgroud.count; i++) {
        NSString *backImage = backgroud[i];
        NSString *heightImage = heightBackground[i];
        UIImage *normal=[UIImage imageNamed:backImage];
        UIImage *hight=[UIImage imageNamed:heightImage];
        
        CGFloat leftX=i*normal.size.width;
        UIButton *button =[[UIButton alloc] initWithFrame:CGRectMake(leftX,TabHeight-normal.size.height, normal.size.width, normal.size.height)];
        [button setBackgroundImage:normal forState:UIControlStateNormal];
        [button setBackgroundImage:hight forState:UIControlStateSelected];
        button.tag = 100+i;
        if (i==0) {
            button.selected=YES;
        }
        [button addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        
       [_tabbarView addSubview:button];
        [button release];
    }
    
}

#pragma mark - actions
//tab 按钮的点击事件
- (void)selectedTab:(UIButton *)button {

    button.selected=YES;
    if (_prevSelectIndex!=button.tag-100) {
        UIButton *btn=(UIButton*)[_tabbarView viewWithTag:100+_prevSelectIndex];
        btn.selected=NO;
        _prevSelectIndex=button.tag-100;
    }
    self.selectedIndex = button.tag-100;
    
}
- (void)setSelectedItemIndex:(int)index{
    int pos=100+index;
    UIButton *btn=(UIButton*)[_tabbarView viewWithTag:pos];
    [self selectedTab:btn];
}
#pragma mark - UINavigationController delegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //viewController.hidesBottomBarWhenPushed=YES;
    //导航控制器子控制器的个数
    int count = navigationController.viewControllers.count;
    if (count == 1) {
        //[self showTabbar:YES];
    }else if (count == 2) {
        //[self showTabbar:NO];
    }
}
#pragma mark 私有方法
-(void)updateSelectedStatus:(int)selectTag lastIndex:(int)prevIndex{
    UIButton *btn=(UIButton*)[_tabbarView viewWithTag:100+prevIndex];
    btn.selected=NO;
    _prevSelectIndex=selectTag;
}
@end
