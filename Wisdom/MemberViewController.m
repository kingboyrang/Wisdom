//
//  MemberViewController.m
//  Wisdom
//
//  Created by aJia on 2013/11/1.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "MemberViewController.h"
#import "MemberCell.h"
@interface MemberViewController ()

@end

@implementation MemberViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topbg.png"] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置背景
    CGRect r=self.view.bounds;
    r.size.height-=44;
    UIImage *bgImage=[UIImage imageNamed:@"bglogreg.png"];
    UIImageView *bgImageView=[[UIImageView alloc] initWithFrame:r];
    [bgImageView setImage:bgImage];
    [self.view addSubview:bgImageView];
    [bgImageView release];
    
    CGRect rect=self.view.bounds;
    rect.size.height-=54+44;
    UICollectionViewFlowLayout *flowlayout=[[UICollectionViewFlowLayout alloc] init];
    CGFloat h=136;
    flowlayout.itemSize=CGSizeMake(DeviceWidth/3.0, h);
    flowlayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    flowlayout.sectionInset=UIEdgeInsetsMake(10, 0, 10, 0);
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
    
    [_collectionView registerClass:[MemberCell class] forCellWithReuseIdentifier:@"memberCell"];
    [self.view addSubview:_collectionView];
    [flowlayout release];
    
    NSMutableArray *source1=[NSMutableArray array];
    for (int i=10; i<18; i++) {
        [source1 addObject:[NSString stringWithFormat:@"ico_0%d.png",i]];
    }
    NSMutableArray *source2=[NSMutableArray arrayWithObjects:@"个人资料",@"二维码",@"旅记",@"修改密码",@"我的消息",@"下载中心",@"注销用户",@"优惠信息", nil];
    NSMutableArray *result=[NSMutableArray array];
    [result addObject:source1];
    [result addObject:source2];
    self.sourceData=result;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSMutableArray *source1 = [self.sourceData objectAtIndex:0];
    return [source1 count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableArray *source1 = [self.sourceData objectAtIndex:0];
    NSMutableArray *source2 = [self.sourceData objectAtIndex:1];
    static NSString *cellIdentifier = @"memberCell";
    MemberCell *cell = (MemberCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell.imageView setImage:[UIImage imageNamed:[source1 objectAtIndex:indexPath.row]]];
    cell.labTitle.text=[source2 objectAtIndex:indexPath.row];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //页面执行
    NSLog(@"index=%d",indexPath.row);
}
@end
