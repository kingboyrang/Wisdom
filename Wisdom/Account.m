//
//  Account.m
//  Wisdom
//
//  Created by aJia on 2013/10/30.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "Account.h"
#import "FileHelper.h"
@interface Account ()
-(void)initloadValue;
-(NSDictionary*)saveEntity;
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
-(id)copyWithZone:(NSZone *)zone
{
    Account *copy=[[[self class] allocWithZone:zone] init];
    
    copy.userAcc=[self.userAcc copyWithZone:zone];
    copy.userPwd=[self.userPwd copyWithZone:zone];
     copy.appId=[self.appId copyWithZone:zone];
    copy.userId=[self.userId copyWithZone:zone];
     copy.channelId=[self.channelId copyWithZone:zone];
   copy.appToken=[self.appToken copyWithZone:zone];
    return copy;
}
+ (Account *)sharedInstance{
    static dispatch_once_t  onceToken;
    static Account * sSharedInstance;
    
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[Account alloc] init];
    });
    return sSharedInstance;
}
-(id)init{
    if (self=[super init]) {
        [self initloadValue];
    }
    return self;
}
-(NSDictionary*)saveEntity{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:self.userAcc forKey:@"userAcc"];
    [dic setValue:self.userPwd forKey:@"userPwd"];
    [dic setValue:[NSNumber numberWithBool:self.isRemember] forKey:@"isRemember"];
    [dic setValue:[NSNumber numberWithBool:self.isLogin] forKey:@"isLogin"];
    
    [dic setValue:self.appId forKey:@"appId"];
    [dic setValue:self.userId forKey:@"userId"];
    [dic setValue:self.channelId forKey:@"channelId"];
    [dic setValue:self.appToken forKey:@"appToken"];
   
   
    
    return dic;
}
-(void)save{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[self saveEntity]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:@"localEncAccountSet"];
    [defaults synchronize];
    /***
    NSString *path=[DocumentPath stringByAppendingPathComponent:@"AccountSet"];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [data writeToFile:path atomically:YES];//持久化保存成物理文件
     ***/
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
    acc.userAcc=@"";
    acc.userPwd=@"";
    acc.isLogin=NO;
    acc.isRemember=NO;
    [acc save];
}
+(void)loadRememberPwdLogin{
    Account *acc=[Account sharedInstance];
    if (acc.isRemember) {
        acc.isLogin=YES;
        [acc save];
    }else{
        acc.isLogin=NO;
        [acc save];
    }
}
#pragma mark -
#pragma mark 私有方法
-(void)initloadValue{
    /***
   NSString *path=[DocumentPath stringByAppendingPathComponent:@"AccountSet"];
   NSData *data = [NSData dataWithContentsOfFile:path];//读取文件
    ***/
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"localEncAccountSet"];
    
   if(data&&[data length]>0){ //如果不存在
       NSDictionary *dic=[NSKeyedUnarchiver unarchiveObjectWithData:data];
        self.userAcc=[dic objectForKey:@"userAcc"];
        self.userPwd=[dic objectForKey:@"userPwd"];
       
       NSNumber *remberNum=[dic objectForKey:@"isRemember"];
       
        self.isRemember=[remberNum boolValue];
       NSNumber *rloginNum=[dic objectForKey:@"isLogin"];
        self.isLogin=[rloginNum boolValue];
        self.appId=[dic objectForKey:@"appId"];
        self.userId=[dic objectForKey:@"userId"];
        self.channelId=[dic objectForKey:@"channelId"];
        self.appToken=[dic objectForKey:@"appToken"];
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
