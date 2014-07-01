//
//  Global.h
//  Eland
//
//  Created by aJia on 13/9/27.
//  Copyright (c) 2013年 rang. All rights reserved.
//

//获取设备的物理大小
#define DeviceRect [UIScreen mainScreen].bounds
#define DeviceWidth [UIScreen mainScreen].bounds.size.width
#define DeviceHeight [UIScreen mainScreen].bounds.size.height
#define StatusBarHeight 20 //状态栏高度
//路径设置
#define DocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define TempPath NSTemporaryDirectory()
//设备
#define DeviceIsPad UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad
//通知post name
#define kPushNotificeName @"kPushNotificeNameInfo"
//推播中心WebService的URL地址
#define PushWebserviceURL @"http://60.251.51.217/Pushs.Admin/WebServices/Push.asmx"
#define PushNameSpace @"http://tempuri.org/"
//webservice
//#define DataWebserviceURL @"http://192.168.123.134/MiLe.Web/WebServices/Push.asmx"
#define DataWebserviceURL @"http://ibdcloud.com:8889/WebServices/Push.asmx"
#define DataNameSpace @"http://tempuri.org/"

//http://iBDCloud.com:8888/

//弥勒介绍
#define MaitreyaURL @"http://www.ibdcloud.com/app/main01.htm"
//景点
#define ViewIntroduceURL @"http://www.ibdcloud.com/app/main02.htm"
//住宿
#define HotelIntroduceURL @"http://www.ibdcloud.com/app/main04.htm"
//美食
#define FoodIntroduceURL @"http://www.ibdcloud.com/app/main05.htm"
//路况
#define RoadIntroduceURL @"http://www.ibdcloud.com/app/traffic01.htm"
//公交
#define BusIntroduceURL @"http://www.ibdcloud.com/app/traffic02.htm"
//出租车
#define TaxiIntroduceURL @"http://www.ibdcloud.com/app/traffic03.htm"
//航班
#define FlightIntroduceURL @"http://www.ibdcloud.com/app/traffic04.htm"

//天气（101030100为天津）
//取得一周天气
#define WeatherWeekURL @"http://m.weather.com.cn/data/101290304.html"
//取得今天天气
#define WeatherDayURL @"http://www.weather.com.cn/data/sk/101290304.html"
#define WeatherCityDayURL @"http://www.weather.com.cn/data/cityinfo/101290304.html"


