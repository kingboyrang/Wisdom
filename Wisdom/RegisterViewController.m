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
@interface RegisterViewController ()
-(void)buttonSubmit;
-(BOOL)formSubmit;
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
    _helper=[[ServiceHelper alloc] init];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbg.png"] forBarMetrics:UIBarMetricsDefault];
    [self editBackBarbuttonItem:@"注册"];
    //[self.navigationItem rightBarBtnItem:@"确认" target:self action:@selector(buttonSubmit)];
    
    CGRect r=self.view.bounds;
    r.size.height-=54+44;
    UIImage *image=[[UIImage imageNamed:@"registerbg.png"] imageByScalingToSize:r.size];
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:r];
    [imageView setImage:image];
    [self.view addSubview:imageView];
    [imageView release];
    
    r.origin.x=(self.view.bounds.size.width-250)/2;
    r.origin.y=90;
    r.size.height=self.view.bounds.size.height-90;
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
    
    TKLabelCell *cell1=[[[TKLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell1.label.text=@"手机号码";
    TKTextFieldCell *cell2=[[[TKTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    //cell2.field.keyboardType=UIKeyboardTypePhonePad;
    cell2.field.placeholder=@"请输入手机号码";
    TKLabelCell *cell3=[[[TKLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell3.label.text=@"密       码";
    TKTextFieldCell *cell4=[[[TKTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell4.field.secureTextEntry=YES;
    cell4.field.placeholder=@"请输入密码";
    
    TKRegisterCheckCell *cell5=[[[TKRegisterCheckCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];

    
    TKLoginButtonCell *cell6=[[[TKLoginButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell6.button setTitle:@"确认" forState:UIControlStateNormal];
    [cell6.button addTarget:self action:@selector(buttonSubmit) forControlEvents:UIControlEventTouchUpInside];
    
    self.cells=[NSMutableArray arrayWithObjects:cell1,cell2,cell3,cell4,cell5,cell6, nil];
}
-(BOOL)formSubmit{
    for (id item in self.cells) {
        if ([item isKindOfClass:[TKTextFieldCell class]]) {
            TKTextFieldCell *cell=(TKTextFieldCell*)item;
            if (!cell.hasValue) {
                [cell.field becomeFirstResponder];
                [cell.field shake];
                return NO;
            }
        }
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
    TKTextFieldCell *cell1=self.cells[1];
    TKTextFieldCell *cell2=self.cells[3];
    TKRegisterCheckCell *cell3=self.cells[4];
    
    NSMutableArray *params=[NSMutableArray array];
    [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:cell1.field.text,@"uid", nil]];
    [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:cell2.field.text,@"pwd", nil]];
    [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"userId", nil]];
    [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"channelId", nil]];
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
            [self hideLoadingFailedWithTitle:@"注册失败！" completed:nil];
        }
    } failed:^(NSError *error, NSDictionary *userInfo) {
        [self hideLoadingFailedWithTitle:@"注册失败！" completed:nil];
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
        return 55.0;
    }
    if ([self.cells[indexPath.row] isKindOfClass:[TKRegisterCheckCell class]]) {
        return 30.0;
    }
    if (indexPath.row%2==0) {
        return 30;
    }
    return 44.0;
}
@end
