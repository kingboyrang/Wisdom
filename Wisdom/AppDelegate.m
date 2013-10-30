//
//  AppDelegate.m
//  Wisdom
//
//  Created by aJia on 2013/10/28.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "UIImage+TPCategory.h"
@implementation AppDelegate
- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
   
    /***
     
     NSString *path1=[DocumentPath stringByAppendingPathComponent:@"ico_001.png"];
     UIImage *image1=[[UIImage imageNamed:@"ico_001.png"] imageByScalingProportionallyToSize:CGSizeMake(231*103/199, 103)];
     [image1 saveImage:path1];

    NSString *path2=[DocumentPath stringByAppendingPathComponent:@"message.png"];
    UIImage *image2=[[UIImage imageNamed:@"message.png"] imageAtRect:CGRectMake(0, 33, 80, 55)];
    [image2 saveImage:path2];

     NSString *path=[DocumentPath stringByAppendingPathComponent:@"login.png"];
     UIImage *image=[[UIImage imageNamed:@"login.png"] imageByScalingProportionallyToSize:CGSizeMake(80*35/49, 35)];
     [image saveImage:path];
     NSLog(@"path=%@\n",path);
    
    NSString *path3=[DocumentPath stringByAppendingPathComponent:@"search_select.png"];
    UIImage *image3=[[UIImage imageNamed:@"search_select.png"] imageByScalingProportionallyToSize:CGSizeMake(79, 55)];
    [image3 saveImage:path3];
    ***/

//    NSString *path3=[DocumentPath stringByAppendingPathComponent:@"search_select.png"];
//    UIImage *image3=[[UIImage imageNamed:@"search_select.gif"] imageAtRect:CGRectMake(0, 22, 80, 62)];
//    [image3 saveImage:path3];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    MainViewController *main=[[[MainViewController alloc] init] autorelease];
    self.window.rootViewController = main;
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
