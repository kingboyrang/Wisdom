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
#import "MemberViewController.h"
#import "BasicNavigationController.h"
#import "AlertHelper.h"
#import "UINavigationItem+TPCategory.h"
#import "NSString+TPCategory.h"
@interface LoginViewController ()
-(void)buttonSubmit;
-(BOOL)formSubmit;
- (void)moveView:(UITextField *)textField leaveView:(BOOL)leave;
-(void)showDoneClick;
-(void)showDoneButton:(BOOL)show;
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    Account *acc=[Account sharedInstance];
    if(acc.isLogin){
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.showRightBtnItem=NO;
    _helper=[[ServiceHelper alloc] init];
    self.view.backgroundColor=[UIColor whiteColor];
    
   
    CGFloat h=self.view.bounds.size.height-54-44;
    UIScrollView *scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth,h)];
    scrollView.backgroundColor=[UIColor clearColor];
    scrollView.pagingEnabled=YES;
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.showsVerticalScrollIndicator=NO;
    scrollView.tag=800;
    [scrollView setContentSize:CGSizeMake(DeviceWidth, scrollView.frame.size.height)];
    
    //bg_002.png
    CGRect r=self.view.bounds;
    r.size.height=h*2;
    UIImage *bgImage=[UIImage imageNamed:@"bglogreg.png"];
    UIImageView *bgImageView=[[UIImageView alloc] initWithFrame:r];
    [bgImageView setImage:bgImage];
    [scrollView addSubview:bgImageView];
    [bgImageView release];
    
    
    r.origin.x=30;
    r.size.width=DeviceWidth-60;
    r.size.height=285;
    r.origin.y=(self.view.bounds.size.height-285-54-44)/2.0;
    
    CGFloat topY=r.origin.y+97;
    
    
    UIImage *image=[[UIImage imageNamed:@"loginbg.png"] imageByScalingToSize:r.size];
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:r];
    [imageView setImage:image];
    [scrollView addSubview:imageView];
    [imageView release];
    
    r.origin.x=(self.view.bounds.size.width-250)/2;
    r.origin.y=topY;
    r.size.height=h-topY;
    r.size.width=250;
    _tableView=[[UITableView alloc] initWithFrame:r style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.autoresizesSubviews=YES;
    _tableView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.bounces=NO;
    _tableView.backgroundColor=[UIColor clearColor];
    [scrollView addSubview:_tableView];
    
    [self.view addSubview:scrollView];
    [scrollView release];
    
   
    TKTextFieldCell *cell1=[[[TKTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell1.field.placeholder=@"请输入手机号码";
    cell1.field.backgroundColor=[UIColor colorFromHexRGB:@"c6dfe5"];
    cell1.field.delegate=self;
    cell1.field.keyboardType=UIKeyboardTypeASCIICapable;
    
    TKTextFieldCell *cell2=[[[TKTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell2.field.secureTextEntry=YES;
    cell2.field.backgroundColor=[UIColor colorFromHexRGB:@"c6dfe5"];
    cell2.field.placeholder=@"请输入密码";
    cell2.field.delegate=self;
    cell2.field.keyboardType=UIKeyboardTypeASCIICapable;
    TKRememberCell *cell3=[[[TKRememberCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    
    TKLoginButtonCell *cell4=[[[TKLoginButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell4.button setTitle:@"登录" forState:UIControlStateNormal];
    [cell4.button addTarget:self action:@selector(buttonSubmit) forControlEvents:UIControlEventTouchUpInside];
    
    self.cells=[NSMutableArray arrayWithObjects:cell1,cell2,cell3,cell4, nil];
	// Do any additional setup after loading the view.
}
-(void)showDoneClick{
    TKTextFieldCell *cell=self.cells[0];
    [cell.field resignFirstResponder];
}
-(void)showDoneButton:(BOOL)show{
    if (show) {
        [self.navigationItem rightBarBtnItem:@"Done" target:self action:@selector(showDoneClick)];
    }else{
        self.navigationItem.rightBarButtonItem=nil;
    }
}
#pragma mark UITextFieldDelegate Methods
- (void)moveView:(UITextField *)textField leaveView:(BOOL)leave
{
    UIScrollView *scrollview=(UIScrollView*)[self.view viewWithTag:800];
    if (!leave) {
        CGRect r=scrollview.frame;
        r.origin.y=-110;
        [UIView animateWithDuration:0.3 animations:^{
            scrollview.frame=r;
        }];
    }else{
        CGRect r=scrollview.frame;
        r.origin.y=0;
        [UIView animateWithDuration:0.3 animations:^{
            scrollview.frame=r;
        }];
    }
}
#pragma mark UITextFieldDelegate Methods
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // return NO to not change text
    TKTextFieldCell *cell=self.cells[0];
    if (cell.field==textField) {
        if(strlen([textField.text UTF8String]) >= 11 && range.length != 1)
            return NO;
    }else{
        if(strlen([textField.text UTF8String]) >= 12 && range.length != 1)
            return NO;
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self moveView:textField leaveView:NO];
}

- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    [self moveView:textField leaveView:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    TKTextFieldCell *cell=self.cells[1];
    if (textField==cell.field) {
        if(strlen([textField.text UTF8String]) <6)
        {
            [AlertHelper initWithTitle:@"提示" message:@"密码不能少于6位！"];
            return NO;
        }
    }
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)formSubmit{
    TKTextFieldCell *cell1=self.cells[0];
    if (!cell1.hasValue) {
        [AlertHelper initWithTitle:@"提示" message:@"手机号码不为空!"];
        [cell1.field becomeFirstResponder];
        return NO;
    }
    if (![cell1.field.text isNumberString]) {
        [AlertHelper initWithTitle:@"提示" message:@"手机号码只能为数字!"];
        [cell1.field becomeFirstResponder];
        return NO;
    }
    if(strlen([cell1.field.text UTF8String])<11)
    {
        [AlertHelper initWithTitle:@"提示" message:@"手机号码必须为11位！"];
        [cell1.field becomeFirstResponder];
        return NO;
    }
    TKTextFieldCell *cell2=self.cells[1];
    if (!cell2.hasValue) {
        [AlertHelper initWithTitle:@"提示" message:@"用户密码不为空!"];
        [cell2.field becomeFirstResponder];
        return NO;
    }
    if ([cell2.field.text containsChinese]) {
        [AlertHelper initWithTitle:@"提示" message:@"用户密码不能包含汉字!"];
        [cell2.field becomeFirstResponder];
        return NO;
    }
    if(strlen([cell2.field.text UTF8String])<6)
    {
        [AlertHelper initWithTitle:@"提示" message:@"用户密码不能少于6位大于12位！"];
        [cell2.field becomeFirstResponder];
        return NO;
    }
   
    return YES;
}

//提交
-(void)buttonSubmit{
    
    if (![self formSubmit]) {
        return;
    }
    for (id item in self.cells) {
        if ([item isKindOfClass:[TKTextFieldCell class]]) {
            TKTextFieldCell *cell=(TKTextFieldCell*)item;
            [cell.field resignFirstResponder];
        }
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
                [self showMessageWithTitle:@"帐号与密码不正确或网络连线失败！"];
            }];
        }
    } failed:^(NSError *error, NSDictionary *userInfo) {
        [self hideLoadingViewAnimated:^(AnimateLoadView *hideView) {
            [self showMessageWithTitle:@"帐号与密码不正确或网络连线失败！"];
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
