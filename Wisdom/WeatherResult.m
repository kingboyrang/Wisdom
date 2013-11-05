//
//  WeatherResult.m
//  Wisdom
//
//  Created by aJia on 2013/11/5.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "WeatherResult.h"
#import "NSDate+TPCategory.h"
@interface WeatherResult ()
+(NSString*)dayToString:(int)day;
@end

@implementation WeatherResult
-(NSString*)webImageURL{
    if (_imageURL&&[_imageURL length]>0) {
        return [NSString stringWithFormat:@"http://www.weather.com.cn/m/i/weatherpic/29x20/d%@.gif",_imageURL];
    }
    return @"";
}
-(NSString*)startTemp{
    if (_Temperature&&[_Temperature length]>0) {
        NSArray *arr=[_Temperature componentsSeparatedByString:@"~"];
        if (arr&&[arr count]>0) {
            return [[arr objectAtIndex:0] stringByReplacingOccurrencesOfString:@"℃" withString:@"°"];
        }
    }
    return @"";
}
-(NSString*)endTemp{
    if (_Temperature&&[_Temperature length]>0) {
        NSArray *arr=[_Temperature componentsSeparatedByString:@"~"];
        if (arr&&[arr count]>=2) {
            return [[arr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"℃" withString:@"°"];
        }
    }
    return @"";
}
+(NSArray*)jsonStringToWeatherResults:(NSData*)json{
   NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:nil];
   NSDictionary *obj=[dic objectForKey:@"weatherinfo"];
   NSMutableArray *arr=[NSMutableArray array];
    for (int i=1; i<6; i++) {
        WeatherResult *item=[[WeatherResult alloc] init];
        item.dayMemo=[self dayToString:i];
        item.imageURL=[obj objectForKey:[NSString stringWithFormat:@"img%d",i*2+1]];
        item.Memo=[obj objectForKey:[NSString stringWithFormat:@"img_title%d",i*2+1]];
        item.Temperature=[obj objectForKey:[NSString stringWithFormat:@"temp%d",i+1]];
        [arr addObject:item];
        [item release];
    }
    return arr;
}
+(NSString*)dayToString:(int)day{
    NSDate *date=[[NSDate date] dateByAddingDays:day];
    if([date dayOfWeek]==1)return @"周一";
    if([date dayOfWeek]==2)return @"周二";
    if([date dayOfWeek]==3)return @"周三";
    if([date dayOfWeek]==4)return @"周四";
    if([date dayOfWeek]==5)return @"周五";
    if([date dayOfWeek]==6)return @"周六";
    return @"周日";
}
@end
