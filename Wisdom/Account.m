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
    [encoder encodeObject:self.userId forKey:@"userId"];
    [encoder encodeObject:self.channelId forKey:@"channelId"];
    [encoder encodeObject:self.appToken forKey:@"appToken"];
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        self.userAcc=[aDecoder decodeObjectForKey:@"userAcc"];
        self.userPwd=[aDecoder decodeObjectForKey:@"userPwd"];
        self.isRemember=[aDecoder decodeBoolForKey:@"isRemember"];
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
    [defaults setObject:data forKey:@"localEncodeAccount"];
    [defaults synchronize];
}
#pragma mark -
#pragma mark 私有方法
-(void)initloadValue{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"localEncodeAccount"];
    if (data) {
        Account *obj = (Account*)[NSKeyedUnarchiver unarchiveObjectWithData: data];
        self.userAcc=obj.userAcc;
        self.userPwd=obj.userPwd;
        self.isRemember=obj.isRemember;
        self.userId=obj.userId;
        self.channelId=obj.channelId;
        self.appToken=obj.appToken;
    }else{
        self.userAcc=@"";
        self.userPwd=@"";
        self.isRemember=NO;
        self.userId=@"";
        self.channelId=@"";
        self.appToken=@"";
    }
}
@end
