//
//  CurrentWeather.m
//  Wisdom
//
//  Created by aJia on 2013/11/5.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "CurrentWeather.h"
#import "ASIHTTPRequest.h"
#import "UIImageView+WebCache.h"
@interface CurrentWeather ()
-(void)updateUIWithJson:(NSData*)data;
-(void)updateUIWeatherWithJson:(NSData*)data;
@end

@implementation CurrentWeather

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)updateUIWeatherWithJson:(NSData*)data{
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *obj=[dic objectForKey:@"weatherinfo"];
    self.labSTemp.text=[[obj objectForKey:@"temp1"] stringByReplacingOccurrencesOfString:@"℃" withString:@"°"];
    self.labETemp.text=[[obj objectForKey:@"temp2"] stringByReplacingOccurrencesOfString:@"℃" withString:@"°"];
    self.labMemo.text=[obj objectForKey:@"weather"];

    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\d]+"
                                                                           options:0
                                                                             error:&error];
    NSString *name=[obj objectForKey:@"img1"];
    name=[regex stringByReplacingMatchesInString:name options:0 range:NSMakeRange( 0, [name length]) withTemplate:@""];
    if ([name length]>0) {
        NSString *urlStr=[NSString stringWithFormat:@"http://m.weather.com.cn/img/b%@.gif",name];
        [self.imageView setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"weatherTemp.png"]];
    }
    //http://m.weather.com.cn/img/b2.gif
}
-(void)updateUIWithJson:(NSData*)data{
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *obj=[dic objectForKey:@"weatherinfo"];
    self.labCurTemp.text=[NSString stringWithFormat:@"%@°",[obj objectForKey:@"temp"]];
    self.labSpeed.text=[obj objectForKey:@"WS"];
    self.labTemp.text=[obj objectForKey:@"SD"];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _helper=[[ServiceHelper alloc] init];
    
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:WeatherDayURL]];
    [request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"day",@"name", nil]];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    [_helper addQueue:request];
    
    ASIHTTPRequest *request1=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:WeatherCityDayURL]];
    [request1 setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"city",@"name", nil]];
    [request1 setDefaultResponseEncoding:NSUTF8StringEncoding];
    [_helper addQueue:request1];
    
    [_helper startQueue:^(ServiceResult *result) {
        NSString *name=[result.request.userInfo objectForKey:@"name"];
        if ([name isEqualToString:@"day"]&&result.request.responseStatusCode==200) {
            [self performSelectorOnMainThread:@selector(updateUIWithJson:) withObject:result.request.responseData waitUntilDone:NO];
        }
        if ([name isEqualToString:@"city"]&&result.request.responseStatusCode==200) {
            [self performSelectorOnMainThread:@selector(updateUIWeatherWithJson:) withObject:result.request.responseData waitUntilDone:NO];
        }
    } failed:^(NSError *error, NSDictionary *userInfo) {
        
    } complete:^{
        
    }];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_imageView release];
    [_labCurTemp release];
    [_labSTemp release];
    [_labETemp release];
    [_labMemo release];
    [_labTemp release];
    [_labSpeed release];
    [_helper release],_helper=nil;
    [super dealloc];
}
@end
