//
//  SkyViewController.m
//  Wisdom
//
//  Created by aJia on 2013/11/5.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "SkyViewController.h"
#import "WeatherCell.h"
#import "WeatherResult.h"
#import "NSString+TPCategory.h"
#import "UIColor+TPCategory.h"
#import "UIImageView+WebCache.h"
#import "ASIHTTPRequest.h"
#import "CurrentWeather.h"
#import "NetWorkConnection.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "Account.h"
@interface SkyViewController ()
-(void)loadHeaderControls;
@end

@implementation SkyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.showWeatherView=NO;
    NSArray *arr=self.navigationController.viewControllers;
    if (arr&&[arr count]>=2) {
        id v=[arr objectAtIndex:arr.count-2];
        if ([v isKindOfClass:[LoginViewController class]]||[v isKindOfClass:[RegisterViewController class]]) {
            Account *acc=[Account sharedInstance];
            if(!acc.isLogin){self.showRightBtnItem=NO;}
        }
    }
    [self loadHeaderControls];
    if(![NetWorkConnection IsEnableConnection]){
        self.sourceData=[NSArray array];
        [self showNoNetworkNotice:nil];
        return;
    }
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:WeatherWeekURL]];
    [request setCompletionBlock:^{
        if (request.responseStatusCode==200) {
            self.sourceData=[WeatherResult jsonStringToWeatherResults:request.responseData];
            [_collectionView reloadData];
        }else{
            self.sourceData=[NSArray array];
        }
    }];
    [request setFailedBlock:^{
        self.sourceData=[NSArray array];
    }];
    [request startAsynchronous];
}
-(void)loadHeaderControls{
    CGRect r=self.view.bounds;
    r.size.height-=44;
    UIImage *bgImage=[UIImage imageNamed:@"bglogreg.png"];
    UIImageView *bgImageView=[[UIImageView alloc] initWithFrame:r];
    [bgImageView setImage:bgImage];
    [self.view addSubview:bgImageView];
    [bgImageView release];
    
    
    NSString *title=@"弥勒市";
    CGSize size=[title textSize:[UIFont boldSystemFontOfSize:20] withWidth:DeviceWidth];
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(25, 30, size.width, size.height)];
    label.textColor=[UIColor colorFromHexRGB:@"919090"];
    label.font=[UIFont boldSystemFontOfSize:20];
    label.text=title;
    [self.view addSubview:label];
    
    
    UIImage *image=[UIImage imageNamed:@"line.png"];
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(10, label.frame.origin.y+size.height+3, DeviceWidth-20, image.size.height)];
    [imageView setImage:image];
    CGFloat topY=imageView.frame.origin.y+imageView.frame.size.height;
   
    [self.view addSubview:imageView];
    [imageView release];
    [label release];
    
   
    CurrentWeather *weatherV=[[CurrentWeather alloc] initWithNibName:@"CurrentWeather" bundle:nil];
    weatherV.view.frame=CGRectMake(0, topY, DeviceWidth, 167);
    weatherV.view.backgroundColor=[UIColor clearColor];
    [self.view addSubview:weatherV.view];
    topY=weatherV.view.frame.origin.y+weatherV.view.frame.size.height;
    [weatherV release];
    
    
    CGRect rect=self.view.bounds;
    rect.origin.x=(DeviceWidth-44*5-40)/2.0;
    rect.origin.y=topY;
    rect.size.height=121;
    UICollectionViewFlowLayout *flowlayout=[[UICollectionViewFlowLayout alloc] init];
    CGFloat h=106;
    flowlayout.itemSize=CGSizeMake(44, h);
    flowlayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    flowlayout.sectionInset=UIEdgeInsetsMake(5,10, 0, 0);
    flowlayout.minimumLineSpacing=0.0;
    flowlayout.minimumInteritemSpacing=0.0;
    _collectionView=[[UICollectionView alloc] initWithFrame:rect collectionViewLayout:flowlayout];
    _collectionView.backgroundColor=[UIColor clearColor];
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    _collectionView.bounces=NO;
    
    
    _collectionView.showsVerticalScrollIndicator=NO;
    //_collectionView.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [_collectionView setUserInteractionEnabled:YES];
    
    [_collectionView registerClass:[WeatherCell class] forCellWithReuseIdentifier:@"weatherCell"];
    [self.view addSubview:_collectionView];
    [flowlayout release];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.sourceData count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"weatherCell";
    WeatherCell *cell = (WeatherCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    WeatherResult *entity=self.sourceData[indexPath.row];
    cell.labSTemp.text=entity.startTemp;
    cell.labETemp.text=entity.endTemp;
    cell.labWeek.text=entity.dayMemo;
    [cell.imageView setImageWithURL:[NSURL URLWithString:entity.webImageURL] placeholderImage:[UIImage imageNamed:@"dplace.png"]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //页面执行
    NSLog(@"index=%d",indexPath.row);
}

@end
