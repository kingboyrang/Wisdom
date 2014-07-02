//
//  EditPwdViewController.m
//  Wisdom
//
//  Created by aJia on 2013/11/5.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "EditPwdViewController.h"
#import "TKLabelFieldCell.h"
#import "UIColor+TPCategory.h"
#import "TKRegisterButtonCell.h"
#import "Account.h"
#import "NetWorkConnection.h"
#import "UIImage+TPCategory.h"
#import "AlertHelper.h"
#import "NSString+TPCategory.h"
@interface EditPwdViewController ()
-(void)buttonSubmit;
-(BOOL)formSubmit;
- (void)moveView:(UITextField *)textField leaveView:(BOOL)leave;
@end

@implementation EditPwdViewController

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
    
    CGFloat h=self.view.bounds.size.height-54-[self topHeight];
    UIScrollView *scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth,h)];
    scrollView.backgroundColor=[UIColor clearColor];
    scrollView.pagingEnabled=YES;
    scrollView.bounces=NO;
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.showsVerticalScrollIndicator=NO;
    scrollView.tag=800;
    [scrollView setContentSize:CGSizeMake(DeviceWidth, scrollView.frame.size.height)];
    
    
    CGRect r=self.view.bounds;
    r.size.height-=44;
    UIImage *bgImage=[UIImage imageNamed:@"bglogreg.png"];
    UIImageView *bgImageView=[[UIImageView alloc] initWithFrame:r];
    [bgImageView setImage:bgImage];
    [scrollView addSubview:bgImageView];
    [bgImageView release];
    
    r.origin.x=20;
    r.origin.y=(self.view.bounds.size.height-300-54-[self topHeight])/2.0;
    r.size.width=DeviceWidth-40;
    r.size.height=300;
    
    CGFloat topY=r.origin.y+79;
    
    UIImage *image=[[UIImage imageNamed:@"changepwdbg.png"] imageByScalingToSize:r.size];
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
    cell1.label.text=@"输入旧密码:";
    cell1.field.placeholder=@"请输入旧密码";
    cell1.field.backgroundColor=[UIColor colorFromHexRGB:@"c6dfe5"];
    cell1.field.delegate=self;
    cell1.field.secureTextEntry=YES;
    cell1.field.keyboardType=UIKeyboardTypeASCIICapable;
    
    
    TKLabelFieldCell *cell2=[[[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell2.label.text=@"输入新密码:";
    cell2.field.secureTextEntry=YES;
    cell2.field.placeholder=@"请输入新密码";
    cell2.field.backgroundColor=[UIColor colorFromHexRGB:@"c6dfe5"];
    cell2.field.delegate=self;
    cell2.field.secureTextEntry=YES;
    cell2.field.keyboardType=UIKeyboardTypeASCIICapable;
    
    TKLabelFieldCell *cell3=[[[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell3.label.text=@"确认新密码:";
    cell3.field.secureTextEntry=YES;
    cell3.field.placeholder=@"请输入确认新密码";
    cell3.field.backgroundColor=[UIColor colorFromHexRGB:@"c6dfe5"];
    cell3.field.delegate=self;
    cell3.field.secureTextEntry=YES;
    cell3.field.keyboardType=UIKeyboardTypeASCIICapable;
    
    TKRegisterButtonCell *cell4=[[[TKRegisterButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell4.button setTitle:@"确定" forState:UIControlStateNormal];
    [cell4.button addTarget:self action:@selector(buttonSubmit) forControlEvents:UIControlEventTouchUpInside];
    
    self.cells=[NSMutableArray arrayWithObjects:cell1,cell2,cell3,cell4, nil];
	
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
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self moveView:textField leaveView:NO];
}

- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    [self moveView:textField leaveView:YES];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // return NO to not change text
    if(strlen([textField.text UTF8String]) >= 12 && range.length != 1)
        return NO;
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    TKLabelFieldCell *cell=self.cells[0];
    if(cell.field==textField){
    
    }else{
        TKLabelFieldCell *cell1=self.cells[2];
        NSString *memo=@"新密码不能少于6位!";
        if(cell1.field==textField){memo=@"确认密码不能少于6位!";}
        if(strlen([textField.text UTF8String]) <6)
        {
            [AlertHelper initWithTitle:@"提示" message:memo];
            return NO;
        }
    }
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)formSubmit{
    TKLabelFieldCell *cell1=self.cells[0];
    if(!cell1.hasValue){
        [AlertHelper initWithTitle:@"提示" message:@"旧密码不为空!"];
        [cell1.field becomeFirstResponder];
        return NO;
    }
    Account *acc=[Account sharedInstance];
    if (![acc.userPwd isEqualToString:cell1.field.text]) {
        [AlertHelper initWithTitle:@"提示" message:@"旧密码错误,请重新确认!"];
        [cell1.field becomeFirstResponder];
        return NO;
    }
    TKLabelFieldCell *cell2=self.cells[1];
    if(!cell2.hasValue){
        [AlertHelper initWithTitle:@"提示" message:@"新密码不为空!"];
        [cell2.field becomeFirstResponder];
        return NO;
    }
    if ([cell2.field.text containsChinese]) {
        [AlertHelper initWithTitle:@"提示" message:@"新密码不能包含汉字!"];
        [cell2.field becomeFirstResponder];
        return NO;
    }
    if(strlen([cell2.field.text UTF8String]) <6)
    {
        [AlertHelper initWithTitle:@"提示" message:@"新密码不能少于6位大于12位！"];
        [cell2.field becomeFirstResponder];
        return NO;
    }
    TKLabelFieldCell *cell3=self.cells[2];
    if(!cell3.hasValue){
        [AlertHelper initWithTitle:@"提示" message:@"确认密码不为空!"];
        [cell3.field becomeFirstResponder];
        return NO;
    }
    if ([cell3.field.text containsChinese]) {
        [AlertHelper initWithTitle:@"提示" message:@"确认密码不能包含汉字!"];
        [cell3.field becomeFirstResponder];
        return NO;
    }
    if(strlen([cell3.field.text UTF8String]) <6)
    {
        [AlertHelper initWithTitle:@"提示" message:@"确认密码不能少于6位大于12位！"];
        [cell3.field becomeFirstResponder];
        return NO;
    }
    if (![cell2.field.text isEqualToString:cell3.field.text]) {
        [AlertHelper initWithTitle:@"提示" message:@"新密码与确认密码不一致!"];
        [cell3.field becomeFirstResponder];
        return NO;
    }
    return YES;
}
//提交
-(void)buttonSubmit{
    for (id item in self.cells) {
        if ([item isKindOfClass:[TKLabelFieldCell class]]) {
            TKLabelFieldCell *cell=(TKLabelFieldCell*)item;
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
    
    TKLabelFieldCell *cell1=self.cells[0];//旧密码
    TKLabelFieldCell *cell2=self.cells[1];//新密码
    Account *acc=[Account sharedInstance];
    NSMutableArray *params=[NSMutableArray array];
    [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:acc.userAcc,@"uid", nil]];
    [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:cell2.field.text,@"newpwd", nil]];
    [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:cell1.field.text,@"oldpwd", nil]];
    ServiceArgs *args=[[[ServiceArgs alloc] init] autorelease];
    args.methodName=@"ChangePwd";
    args.soapParams=params;
    [self showLoadingAnimated:^(AnimateLoadView *errorView) {
        errorView.labelTitle.text=@"正在修改...";
    }];
    [_helper asynService:args success:^(ServiceResult *result) {
        BOOL boo=NO;
        if ([result.xmlString length]>0) {
            NSString *xml=[result.xmlString stringByReplacingOccurrencesOfString:result.xmlnsAttr withString:@""];
            [result.xmlParse setDataSource:xml];
            XmlNode *node=[result.xmlParse soapXmlSelectSingleNode:@"//ChangePwdResult"];
            if ([node.Value isEqualToString:@"true"]) {
                boo=YES;
                acc.userPwd=cell2.field.text;
                [acc save];
            }
        }
        if (boo) {
            [self hideLoadingSuccessWithTitle:@"修改成功!" completed:^(AnimateErrorView *errorView) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else{
            [self hideLoadingViewAnimated:^(AnimateLoadView *hideView) {
                [self showMessageWithTitle:@"密码不正确或网络连线失败！"];
            }];
        }
    } failed:^(NSError *error, NSDictionary *userInfo) {
        [self hideLoadingViewAnimated:^(AnimateLoadView *hideView) {
            [self showMessageWithTitle:@"密码不正确或网络连线失败！"];
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
    return 44.0;
}
@end
