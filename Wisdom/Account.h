//
//  Account.h
//  Wisdom
//
//  Created by aJia on 2013/10/30.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject<NSCoding>
@property(nonatomic,copy) NSString *userAcc;
@property(nonatomic,copy) NSString *userPwd;
@property(nonatomic,assign) BOOL isRemember;
@property(nonatomic,assign) BOOL isLogin;
@property(nonatomic,copy) NSString *userId;
@property(nonatomic,copy) NSString *channelId;
@property(nonatomic,copy) NSString *appToken;
//单例模式
+ (Account *)sharedInstance;
-(void)save;
+(void)exitAccount;
+(void)accountLogin:(NSString*)user password:(NSString*)pwd login:(BOOL)login;
@end
