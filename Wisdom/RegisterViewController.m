//
//  RegisterViewController.m
//  Wisdom
//
//  Created by aJia on 2013/10/29.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "RegisterViewController.h"
#import "TKLabelCell.h"
#import "TKTextFieldCell.h"
#import "TKLoginButtonCell.h"
#import "UIImage+TPCategory.h"
#import "Account.h"
#import "TKRegisterCheckCell.h"
#import "TKLabelFieldCell.h"
#import "UIColor+TPCategory.h"
#import "TKRegisterButtonCell.h"
#import "NetWorkConnection.h"
#import "AlertHelper.h"
@interface RegisterViewController ()
-(void)buttonSubmit;
-(BOOL)formSubmit;
-(void)moveView:(UITextField *)textField leaveView:(BOOL)leave;
@end

@implementation RegisterViewController
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
    self.view.backgroundColor=[UIColor whiteColor];
    
    
   
    CGFloat h=self.view.bounds.size.height-54-44;
    UIScrollView *scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth,h)];
    scrollView.backgroundColor=[UIColor clearColor];
    scrollView.pagingEnabled=YES;
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.showsVerticalScrollIndicator=NO;
    scrollView.tag=800;
    [scrollView setContentSize:CGSizeMake(DeviceWidth, scrollView.frame.size.height)];
    //[self.navigationItem rightBarBtnItem:@"确认" target:self action:@selector(buttonSubmit)];
    
    CGRect r=self.view.bounds;
    r.size.height=2*h;
    UIImage *bgImage=[UIImage imageNamed:@"bglogreg.png"];
    UIImageView *bgImageView=[[UIImageView alloc] initWithFrame:r];
    [bgImageView setImage:bgImage];
    [scrollView addSubview:bgImageView];
    [bgImageView release];
    
    r.origin.x=20;
    r.origin.y=(self.view.bounds.size.height-300-54-44)/2.0;
    r.size.width=DeviceWidth-40;
    r.size.height=300;
    
    CGFloat topY=r.origin.y+79;
    
    UIImage *image=[[UIImage imageNamed:@"registerbg.png"] imageByScalingToSize:r.size];
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:r];
    [imageView setImage:image];
    [scrollView addSubview:imageView];
    [imageView release];
    
    r.origin.x=(self.view.bounds.size.width-260)/2;
    r.origin.y=topY;
    r.size.height=self.view.bounds.size.height-90;
    r.size.width=260;
    
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
    
    TKLabelFieldCell *cell1=[[[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell1.label.text=@"用户帐号:";
    cell1.field.placeholder=@"请输入用户帐号";
    cell1.field.backgroundColor=[UIColor colorFromHexRGB:@"c6dfe5"];
    cell1.field.delegate=self;
    
    TKLabelFieldCell *cell2=[[[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell2.label.text=@"输入密码:";
    cell2.field.secureTextEntry=YES;
    cell2.field.placeholder=@"请输入密码";
    cell2.field.backgroundColor=[UIColor colorFromHexRGB:@"c6dfe5"];
    cell2.field.delegate=self;
    
    TKLabelFieldCell *cell3=[[[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell3.label.text=@"确认密码:";
    cell3.field.secureTextEntry=YES;
    cell3.field.placeholder=@"请输入确认密码";
    cell3.field.backgroundColor=[UIColor colorFromHexRGB:@"c6dfe5"];
    cell3.field.delegate=self;
    
    TKRegisterButtonCell *cell4=[[[TKRegisterButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell4.button setTitle:@"确定" forState:UIControlStateNormal];
    [cell4.button addTarget:self action:@selector(buttonSubmit) forControlEvents:UIControlEventTouchUpInside];
    
    TKRegisterCheckCell *cell5=[[[TKRegisterCheckCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    
    self.cells=[NSMutableArray arrayWithObjects:cell1,cell2,cell3,cell4,cell5, nil];
}
- (void)moveView:(UITextField *)textField leaveView:(BOOL)leave
{
    UIScrollView *scrollview=(UIScrollView*)[self.view viewWithTag:800];
    if (!leave) {
        CGRect r=scrollview.frame;
        r.origin.y=-100;
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
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self moveView:textField leaveView:NO];
}

- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    [self moveView:textField leaveView:YES];
}
#pragma mark UITextFieldDelegate Methods
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // return NO to not change text
    TKLabelFieldCell *cell=self.cells[0];
    if (cell.field==textField) {
        if(strlen([textField.text UTF8String]) >= 11 && range.length != 1)
            return NO;
    }else{
        if(strlen([textField.text UTF8String]) >= 12 && range.length != 1)
            return NO;
        
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    TKLabelFieldCell *cell=self.cells[0];
    if (textField==cell.field) {
        
    }else{
        if(strlen([textField.text UTF8String]) <6)
        {
            [AlertHelper initWithTitle:@"提示" message:@"密码不能少于6位！"];
            return NO;
        }
    }
    // return NO to not change text
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)formSubmit{
    TKLabelFieldCell *cell=self.cells[0];
    if (!cell.hasValue) {
        [AlertHelper initWithTitle:@"提示" message:@"用户帐号不为空!"];
        [cell.field becomeFirstResponder];
        return NO;
    }
    TKLabelFieldCell *cell1=self.cells[1];
    if (!cell1.hasValue) {
        [AlertHelper initWithTitle:@"提示" message:@"输入密码不为空!"];
        [cell1.field becomeFirstResponder];
        return NO;
    }
    if(strlen([cell1.field.text UTF8String])<6)
    {
        [AlertHelper initWithTitle:@"提示" message:@"密码不能少于6位大于12位！"];
        [cell1.field becomeFirstResponder];
        return NO;
    }
    TKLabelFieldCell *cell2=self.cells[2];
    if (!cell2.hasValue) {
        [AlertHelper initWithTitle:@"提示" message:@"确认密码不为空!"];
        [cell2.field becomeFirstResponder];
        return NO;
    }
    if (![cell1.field.text isEqualToString:cell2.field.text]) {
        [AlertHelper initWithTitle:@"提示" message:@"输入密码与确认密码不一致!"];
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
        if ([item isKindOfClass:[TKLabelFieldCell class]]) {
            TKLabelFieldCell *cell=(TKLabelFieldCell*)item;
            [cell.field resignFirstResponder];
        }
    }
    if(![NetWorkConnection IsEnableConnection]){
        [self showNoNetworkNotice:nil];
        return;
    }
    TKLabelFieldCell *cell1=self.cells[0];
    TKLabelFieldCell *cell2=self.cells[1];
    TKRegisterCheckCell *cell3=self.cells[4];
    
    
    Account *acc=[Account sharedInstance];
    NSString *uid=@"";
    if(acc.userId&&[acc.userId length]>0){
        uid=acc.userId;
    }
    NSString *chanelId=@"";
    if(acc.channelId&&[acc.channelId length]>0){
        chanelId=acc.channelId;
    }
    NSMutableArray *params=[NSMutableArray array];
    [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:cell1.field.text,@"uid", nil]];
    [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:cell2.field.text,@"pwd", nil]];
    [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:uid,@"userId", nil]];
    [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:chanelId,@"channelId",nil]];
    ServiceArgs *args=[[[ServiceArgs alloc] init] autorelease];
    args.methodName=@"Register";
    args.soapParams=params;
    [self showLoadingAnimated:^(AnimateLoadView *errorView) {
        errorView.labelTitle.text=@"正在注册...";
    }];
    [_helper asynService:args success:^(ServiceResult *result) {
        BOOL boo=NO;
        if ([result.xmlString length]>0) {
            NSString *xml=[result.xmlString stringByReplacingOccurrencesOfString:result.xmlnsAttr withString:@""];
            [result.xmlParse setDataSource:xml];
            XmlNode *node=[result.xmlParse soapXmlSelectSingleNode:@"//RegisterResult"];
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
                [self showMessageWithTitle:@"帐号已存在或网络连线失败！"];
            }];
        }
    } failed:^(NSError *error, NSDictionary *userInfo) {
        [self hideLoadingViewAnimated:^(AnimateLoadView *hideView) {
            [self showMessageWithTitle:@"帐号已存在或网络连线失败！"];
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
    if ([self.cells[indexPath.row] isKindOfClass:[TKRegisterButtonCell class]]) {
        return 37.0;
    }
    if ([self.cells[indexPath.row] isKindOfClass:[TKRegisterCheckCell class]]) {
        return 40.0;
    }
    return 44.0;
}
@end
