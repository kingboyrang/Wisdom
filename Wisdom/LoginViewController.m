//
//  LoginViewController.m
//  Wisdom
//
//  Created by aJia on 2013/10/29.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "LoginViewController.h"
#import "TKLabelCell.h"
#import "TKTextFieldCell.h"
#import "TKRememberCell.h"
#import "TKRememberCell.h"
#import "TKLoginButtonCell.h"
#import "UIImage+TPCategory.h"
#import "Account.h"
#import "UIColor+TPCategory.h"
#import "NetWorkConnection.h"
@interface LoginViewController ()
-(void)buttonSubmit;
-(BOOL)formSubmit;
@end

@implementation LoginViewController
-(void)dealloc{
    [super dealloc];
    [_helper release],_helper=nil;
}
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
    self.showRightBtnItem=NO;
    _helper=[[ServiceHelper alloc] init];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbg.png"] forBarMetrics:UIBarMetricsDefault];
    [self editBackBarbuttonItem:@"会员登录"];
    //[self.navigationItem rightBarBtnItem:@"登录" target:self action:@selector(buttonSubmit)];
    
    //bg_002.png
    CGRect r=self.view.bounds;
    r.size.height-=44;
    UIImage *bgImage=[UIImage imageNamed:@"bglogreg.png"];
    UIImageView *bgImageView=[[UIImageView alloc] initWithFrame:r];
    [bgImageView setImage:bgImage];
    [self.view addSubview:bgImageView];
    [bgImageView release];
    
    
    r.origin.x=30;
    r.size.width=DeviceWidth-60;
    r.size.height=285;
    r.origin.y=(self.view.bounds.size.height-285-54-44)/2.0;
    
    CGFloat topY=r.origin.y+97;
    
    
    UIImage *image=[[UIImage imageNamed:@"loginbg.png"] imageByScalingToSize:r.size];
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:r];
    [imageView setImage:image];
    [self.view addSubview:imageView];
    [imageView release];
    
    r.origin.x=(self.view.bounds.size.width-250)/2;
    r.origin.y=topY;
    r.size.height=self.view.bounds.size.height-110;
    r.size.width=250;
    _tableView=[[UITableView alloc] initWithFrame:r style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.autoresizesSubviews=YES;
    _tableView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.bounces=NO;
    _tableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_tableView];
    
    
   
    TKTextFieldCell *cell1=[[[TKTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell1.field.placeholder=@"请输入手机号码";
    cell1.field.backgroundColor=[UIColor colorFromHexRGB:@"c6dfe5"];
    
    TKTextFieldCell *cell2=[[[TKTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell2.field.secureTextEntry=YES;
    cell2.field.backgroundColor=[UIColor colorFromHexRGB:@"c6dfe5"];
    cell2.field.placeholder=@"请输入密码";
    TKRememberCell *cell3=[[[TKRememberCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    
    TKLoginButtonCell *cell4=[[[TKLoginButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell4.button setTitle:@"登录" forState:UIControlStateNormal];
    [cell4.button addTarget:self action:@selector(buttonSubmit) forControlEvents:UIControlEventTouchUpInside];
    
    self.cells=[NSMutableArray arrayWithObjects:cell1,cell2,cell3,cell4, nil];
	// Do any additional setup after loading the view.
}
-(BOOL)formSubmit{
    for (id item in self.cells) {
        if ([item isKindOfClass:[TKTextFieldCell class]]) {
            TKTextFieldCell *cell=(TKTextFieldCell*)item;
            if (!cell.hasValue) {
                //[cell.field becomeFirstResponder];
                [cell.field shake];
                return NO;
            }
        }
    }
    return YES;
}
//提交
-(void)buttonSubmit{
    for (id item in self.cells) {
        if ([item isKindOfClass:[TKTextFieldCell class]]) {
            TKTextFieldCell *cell=(TKTextFieldCell*)item;
            [cell.field resignFirstResponder];
        }
    }
    if (![self formSubmit]) {
        return;
    }
    if(![NetWorkConnection IsEnableConnection]){
        [self showNoNetworkNotice:nil];
        return;
    }
    
    TKTextFieldCell *cell1=self.cells[0];
    TKTextFieldCell *cell2=self.cells[1];
    TKRememberCell *cell3=self.cells[2];
    
    NSMutableArray *params=[NSMutableArray array];
    [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:cell1.field.text,@"uid", nil]];
    [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:cell2.field.text,@"pwd", nil]];
    ServiceArgs *args=[[[ServiceArgs alloc] init] autorelease];
    args.methodName=@"Login";
    args.soapParams=params;
    [self showLoadingAnimated:^(AnimateLoadView *errorView) {
        errorView.labelTitle.text=@"正在登录...";
    }];
    [_helper asynService:args success:^(ServiceResult *result) {
        BOOL boo=NO;
        if ([result.xmlString length]>0) {
            NSString *xml=[result.xmlString stringByReplacingOccurrencesOfString:result.xmlnsAttr withString:@""];
            [result.xmlParse setDataSource:xml];
            XmlNode *node=[result.xmlParse soapXmlSelectSingleNode:@"//LoginResult"];
            if ([node.Value isEqualToString:@"true"]) {
                boo=YES;
                [Account accountLogin:cell1.field.text password:cell2.field.text login:cell3.check.hasRemember];
            }
        }
        if (boo) {
            [self hideLoadingViewAnimated:^(AnimateLoadView *hideView) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else{
            [self hideLoadingViewAnimated:^(AnimateLoadView *hideView) {
                [self showMessageWithTitle:@"登录失败！"];
            }];
        }
    } failed:^(NSError *error, NSDictionary *userInfo) {
        [self hideLoadingViewAnimated:^(AnimateLoadView *hideView) {
            [self showMessageWithTitle:@"登录失败！"];
        }];
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.cells count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=self.cells[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.cells[indexPath.row] isKindOfClass:[TKLoginButtonCell class]]) {
        return 50.0;
    }
    if ([self.cells[indexPath.row] isKindOfClass:[TKRememberCell class]]) {
        return 25.0;
    }
    return 44.0;
}
@end
