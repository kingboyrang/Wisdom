//
//  MemberViewController.m
//  Wisdom
//
//  Created by aJia on 2013/11/1.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "MemberViewController.h"
#import "MemberCell.h"
#import "MainViewController.h"
#import "EditPwdViewController.h"
#import "Account.h"
#import "QRCodeViewController.h"
#import "BuildViewController.h"
#import "LoginViewController.h"
#import "AlertHelper.h"
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
   
    Account *acc=[Account sharedInstance];
    if(!acc.isLogin){
        LoginViewController *login=[[LoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:YES];
        [login release];
    }
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
    flowlayout.sectionInset=UIEdgeInsetsMake(10, 0, 5, 0);
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
    for (int i=10; i<20; i++) {
        [source1 addObject:[NSString stringWithFormat:@"ico_0%d.png",i]];
    }
    //NSMutableArray *source2=[NSMutableArray arrayWithObjects:@"个人资料",@"二维码",@"旅记",@"修改密码",@"我的消息",@"下载中心",@"注销用户",@"优惠信息", nil];
    self.sourceData=source1;
	
    
   
    
    
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
    
    NSString *path = [self.sourceData objectAtIndex:indexPath.row];
    static NSString *cellIdentifier = @"memberCell";
    MemberCell *cell = (MemberCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell.imageView setImage:[UIImage imageNamed:path]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==4) {//二维码
        QRCodeViewController *controller=[[QRCodeViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
    }
   else if (indexPath.row==8) {//修改密码
        Account *acc=[Account sharedInstance];
        if (acc.isLogin) {
           EditPwdViewController *controller=[[EditPwdViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
           [controller release];
        }else{
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                        message:@"当前未登录，无去修改密码!"
                                                                       delegate:nil
                                                             cancelButtonTitle:@"确定"
                                                              otherButtonTitles:nil];
                   [alertView show];
        }
    }
    else if (indexPath.row==6) {//我的信息
        MainViewController *main=(MainViewController*)self.tabBarController;
        [main setSelectedItemIndex:2];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"myInfo" object:nil];
    }else if(indexPath.row==9){//用户注销
        [AlertHelper initWithTitle:@"提示" message:@"确定是否注销？" cancelTitle:@"取消" cancelAction:nil confirmTitle:@"确定" confirmAction:^{
            [Account exitAccount];
            [self loadNoLoginBarButtonItem];
            LoginViewController *login=[[LoginViewController alloc] init];
            [self.navigationController pushViewController:login animated:YES];
            [login release];
        }];
    }
    else{
        BuildViewController *controller=[[BuildViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
    }
}
@end
