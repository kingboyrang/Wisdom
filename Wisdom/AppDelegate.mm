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
#import "BPush.h"
#import "Account.h"
#import "ZBarSDK.h"
#import "NSString+TPCategory.h"
@implementation AppDelegate
- (void)dealloc
{
    [_window release];
    [super dealloc];
    [_mapManager release];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [ZBarReaderView class];
    //fD8052pzVUNGQLMlLuNGMIvh 我的API key
    
    //6shoE9aDtgljrB0YYKdGhO7a
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"0E0006d6779b856330e93e877acbd7d1"  generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
   
       /***
        NSString *path2=[DocumentPath stringByAppendingPathComponent:@"changepwdbg.png"];
        UIImage *image2=[UIImage imageNamed:@"changepwdbg.png"];
        [image2 saveImage:path2];
        NSLog(@"path=%@\n",path2);
        
     NSString *path=[DocumentPath stringByAppendingPathComponent:@"login.png"];
     UIImage *image=[[UIImage imageNamed:@"login.png"] imageByScalingProportionallyToSize:CGSizeMake(80*35/49, 35)];
     [image saveImage:path];
     NSLog(@"path=%@\n",path);
    
    NSString *path3=[DocumentPath stringByAppendingPathComponent:@"search_select.png"];
    UIImage *image3=[[UIImage imageNamed:@"search_select.png"] imageByScalingProportionallyToSize:CGSizeMake(79, 55)];
    [image3 saveImage:path3];
    ***/
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    MainViewController *main=[[[MainViewController alloc] init] autorelease];
    self.window.rootViewController = main;
    [self.window makeKeyAndVisible];
    
    //注册推播
    [BPush setupChannel:launchOptions];
    [BPush setDelegate:self];
    
    [application setApplicationIconBadgeNumber:0];
    //注册推播
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound)];
    
    return YES;
}
//回首页
- (void)onGetNetworkState:(int)iError
{
    NSLog(@"onGetNetworkState %d",iError);
}
- (void)onGetPermissionState:(int)iError
{
    NSLog(@"onGetPermissionState %d",iError);
}
- (void) onMethod:(NSString*)method response:(NSDictionary*)data {
    NSDictionary* res = [[NSDictionary alloc] initWithDictionary:data];
    if ([BPushRequestMethod_Bind isEqualToString:method]) {
        NSString *appid = [res valueForKey:BPushRequestAppIdKey];
        NSString *userid = [res valueForKey:BPushRequestUserIdKey];
        NSString *channelid = [res valueForKey:BPushRequestChannelIdKey];
        //NSString *requestid = [res valueForKey:BPushRequestRequestIdKey];
        int returnCode = [[res valueForKey:BPushRequestErrorCodeKey] intValue];
        if (returnCode == BPushErrorCode_Success) {
            Account *acc=[Account sharedInstance];
            acc.appId=appid;
            acc.userId=userid;
            acc.channelId=channelid;
            [acc save];
        }
    } else if ([BPushRequestMethod_Unbind isEqualToString:method]) {
        int returnCode = [[res valueForKey:BPushRequestErrorCodeKey] intValue];
        if (returnCode == BPushErrorCode_Success) {
            Account *acc=[Account sharedInstance];
            acc.appId=@"";
            acc.userId=@"";
            acc.channelId=@"";
            [acc save];
        }
    }
    //self.viewController.textView.text = [[NSString alloc] initWithFormat: @"%@ return: \n%@", method, [data description]];
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
    Account *acc=[Account sharedInstance];
    if ([acc.appId length]==0) {
        [BPush bindChannel];
    }
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark - APNS 回傳結果
// 成功取得設備編號token
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSString *deviceId = [[deviceToken description]
                          substringWithRange:NSMakeRange(1, [[deviceToken description] length]-2)];
    deviceId = [deviceId stringByReplacingOccurrencesOfString:@" " withString:@""];
    deviceId = [deviceId stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    Account *acc=[Account sharedInstance];
    acc.appToken=deviceId;
    [acc save];
    [BPush registerDeviceToken: deviceToken];
    [BPush bindChannel];
    
}
#pragma mark - 接收推播信息
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    //NSString *alert = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    if (application.applicationState == UIApplicationStateActive) {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Did receive a Remote Notification"
//                                                            message:[NSString stringWithFormat:@"The application received this remote notification while it was running:\n%@", alert]
//                                                          delegate:self
//                                                  cancelButtonTitle:@"OK"
//                                                  otherButtonTitles:nil];
//        [alertView show];
    }
    [application setApplicationIconBadgeNumber:0];
    
    [BPush handleNotification:userInfo];
}
@end
