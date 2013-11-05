//
//  WeatherResult.h
//  Wisdom
//
//  Created by aJia on 2013/11/5.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherResult : NSObject
@property(nonatomic,copy) NSString *dayMemo;
@property(nonatomic,copy) NSString *imageURL;
@property(nonatomic,copy) NSString *Memo;
@property(nonatomic,copy) NSString *Temperature;

@property(nonatomic,readonly) NSString *startTemp;
@property(nonatomic,readonly) NSString *endTemp;
@property(nonatomic,readonly) NSString *webImageURL;

+(NSArray*)jsonStringToWeatherResults:(NSData*)json;
@end
