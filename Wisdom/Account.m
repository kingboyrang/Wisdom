//
//  Account.m
//  Wisdom
//
//  Created by aJia on 2013/10/30.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "Account.h"

@interface Account ()
-(void)initloadValue;
@end

@implementation Account
- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.userAcc forKey:@"userAcc"];
    [encoder encodeObject:self.userPwd forKey:@"userPwd"];
    [encoder encodeBool:self.isRemember forKey:@"isRemember"];
    [encoder encodeBool:self.isLogin forKey:@"isLogin"];
    [encoder encodeObject:self.appId forKey:@"appId"];
    [encoder encodeObject:self.userId forKey:@"userId"];
    [encoder encodeObject:self.channelId forKey:@"channelId"];
    [encoder encodeObject:self.appToken forKey:@"appToken"];
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        self.userAcc=[aDecoder decodeObjectForKey:@"userAcc"];
        self.userPwd=[aDecoder decodeObjectForKey:@"userPwd"];
        self.isRemember=[aDecoder decodeBoolForKey:@"isRemember"];
        self.isLogin=[aDecoder decodeBoolForKey:@"isLogin"];
        self.appId=[aDecoder decodeObjectForKey:@"appId"];
        self.userId=[aDecoder decodeObjectForKey:@"userId"];
        self.channelId=[aDecoder decodeObjectForKey:@"channelId"];
        self.appToken=[aDecoder decodeObjectForKey:@"appToken"];
    }
    return self;
}
+ (Account *)sharedInstance{
    static dispatch_once_t  onceToken;
    static Account * sSharedInstance;
    
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[Account alloc] init];
    });
    return sSharedInstance;
}
-(void)save{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:@"saveEncodeAccount"];
    [defaults synchronize];
}
+(void)accountLogin:(NSString*)user password:(NSString*)pwd login:(BOOL)login{
    Account *acc=[Account sharedInstance];
    acc.userAcc=user;
    acc.userPwd=pwd;
    acc.isRemember=login;
    acc.isLogin=YES;
    [acc save];
}
+(void)exitAccount{
    Account *acc=[Account sharedInstance];
    if (!acc.isRemember) {
        acc.userAcc=@"";
        acc.userPwd=@"";
    }
    acc.isLogin=NO;
    [acc save];
}
#pragma mark -
#pragma mark 私有方法
-(void)initloadValue{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"saveEncodeAccount"];
    if (data) {
        Account *obj = (Account*)[NSKeyedUnarchiver unarchiveObjectWithData: data];
        self.userAcc=obj.userAcc;
        self.userPwd=obj.userPwd;
        self.isRemember=obj.isRemember;
        self.isLogin=obj.isLogin;
        self.appId=obj.appId;
        self.userId=obj.userId;
        self.channelId=obj.channelId;
        self.appToken=obj.appToken;
    }else{
        self.userAcc=@"";
        self.userPwd=@"";
        self.isRemember=NO;
        self.isLogin=NO;
        self.appId=@"";
        self.userId=@"";
        self.channelId=@"";
        self.appToken=@"";
    }
}
@end
