//
//  MapViewController.m
//  Wisdom
//
//  Created by aJia on 2013/11/1.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "MapViewController.h"
#import "BMapKit.h"
@interface MapViewController ()

@end

@implementation MapViewController
- (void)dealloc {
    [super dealloc];
    if (_mapView) {
        [_mapView release];
        _mapView = nil;
    }
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    

    [self cleanMap];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
}
-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.showRightBtnItem=NO;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topbg.png"] forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor=[UIColor whiteColor];
    /***
   UISegmentedControl *_segment=[[UISegmentedControl alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 44)];
    [_segment insertSegmentWithTitle:@"普通底图" atIndex:0 animated:YES];
    [_segment insertSegmentWithTitle:@"卫星图" atIndex:1 animated:YES];
    [_segment insertSegmentWithTitle:@"路况图" atIndex:2 animated:YES];
   [_segment insertSegmentWithTitle:@"路况卫星" atIndex:3 animated:YES];
    _segment.segmentedControlStyle=UISegmentedControlStyleBar;
    [_segment addTarget:self action:@selector(changeMapType:) forControlEvents:UIControlEventValueChanged];
    _segment.selectedSegmentIndex=0;
    [self.view addSubview:_segment];
    [_segment release];
     ***/
    
    CGRect r=self.view.bounds;
    r.origin.y=0;
    r.size.height-=54+44;
    _mapView= [[BMKMapView alloc]initWithFrame:r];
    [self.view addSubview:_mapView];
	// Do any additional setup after loading the view.
}
-(void)cleanMap
{
    [_mapView removeOverlays:_mapView.overlays];
    //[_mapView removeAnnotations:_mapView.annotations];
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
}
#pragma mark mapViewDelegate 代理方法
- (void)mapView:(BMKMapView *)mapView1 didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    BMKCoordinateRegion region;
    region.center.latitude  = userLocation.location.coordinate.latitude;
    region.center.longitude = userLocation.location.coordinate.longitude;
    region.span.latitudeDelta  = 0.2;
    region.span.longitudeDelta = 0.2;
    if (_mapView)
    {
        _mapView.region = region;
        //NSLog(@"当前的坐标是: %f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    }
    _mapView.showsUserLocation=NO;
}
//定位失败

-(void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    [mapView setShowsUserLocation:NO];
}
//定位停止
-(void)mapViewDidStopLocatingUser:(BMKMapView *)mapView{
    //添加圆形覆盖
    //BMKCircle* circle = [BMKCircle circleWithCenterCoordinate:mapView.centerCoordinate radius:1000];
    //[mapView addOverlay:circle];
    
   
     BMKPointAnnotation* item = [[BMKPointAnnotation alloc] init];
     item.coordinate = mapView.centerCoordinate;
     item.title=@"我的位置";
     [_mapView addAnnotation:item];
     [item release];
     
     /*
    //标记我的位置
    BMKUserLocation *userLocation = mapView.userLocation;
    userLocation.title = @"当前位置";
    [_mapView addAnnotation:userLocation];    
     */
    //poi检索  异步函数，返回结果在BMKSearchDelegate里的onGetPoiResult:searchType:errorCode:通知
}
#pragma mark 标注（应该就是大头针吧）
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    
    //if ([annotation isKindOfClass:[BMKUserLocation class]]) {
    //    return nil;
    //}
    
    //BMKAnnotationView *annotationView = [mapView viewForAnnotation:annotation];
    BMKPinAnnotationView *annotationView = (BMKPinAnnotationView*)[mapView viewForAnnotation:annotation];
    if (annotationView == nil)
    {
        
        NSString *AnnotationViewID = @"AnotainonTinl";
        
        /*
         if ([[annotation title] isEqualToString:@"我的位置"])
         {
         annotationView = [[[BMKPinAnnotationView alloc] initWithAnnotation:annotation
         reuseIdentifier:AnnotationViewID] autorelease];
         ((BMKPinAnnotationView*) annotationView).pinColor = BMKPinAnnotationColorPurple;
         annotationView.canShowCallout = TRUE;
         }
         else
         {*/
        annotationView = [[[BMKPinAnnotationView alloc] initWithAnnotation:annotation
                                                           reuseIdentifier:AnnotationViewID] autorelease];
        ((BMKPinAnnotationView*) annotationView).pinColor = BMKPinAnnotationColorRed;
        annotationView.canShowCallout = NO;//使用自定义bubble
        //}
        
        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;// 设置该标注点动画显示
        
        
        annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
        annotationView.annotation = annotation;
        annotationView.image = [UIImage imageNamed:@"IcoAddress.png"];   //把大头针换成别的图片
    }
    return annotationView ; 
}
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
   
    //CGPoint point = [mapView convertCoordinate:view.annotation.coordinate toPointToView:mapView];
    if ([view isKindOfClass:[BMKPinAnnotationView class]]) {
#ifdef Debug
        CGPoint point = [mapView convertCoordinate:selectedAV.annotation.coordinate toPointToView:selectedAV.superview];
        //CGRect rect = selectedAV.frame;
      
#endif
       
    }
    else {
        
    }
    [mapView setCenterCoordinate:view.annotation.coordinate animated:YES];
}

-(void)changeMapType:(id)sender{
    UISegmentedControl *segment=(UISegmentedControl*)sender;
    int index = segment.selectedSegmentIndex;
    switch (index) {
        case 0:
            _mapView.mapType = BMKMapTypeStandard;
            break;
        case 1:
            _mapView.mapType = BMKMapTypeSatellite;//卫星地图
            break;
        case 2:
            _mapView.mapType = BMKMapTypeTrafficOn;
            break;
        case 3:
            _mapView.mapType = BMKMapTypeTrafficAndSatellite;
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
