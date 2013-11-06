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
@interface EditPwdViewController ()
-(void)buttonSubmit;
-(BOOL)formSubmit;
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self navigationItemWithBack];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadRightWetherView];
    _helper=[[ServiceHelper alloc] init];
    
    CGRect r=self.view.bounds;
    r.size.height-=44;
    UIImage *bgImage=[UIImage imageNamed:@"bglogreg.png"];
    UIImageView *bgImageView=[[UIImageView alloc] initWithFrame:r];
    [bgImageView setImage:bgImage];
    [self.view addSubview:bgImageView];
    [bgImageView release];
    
    r.origin.x=(self.view.bounds.size.width-260)/2;
    r.origin.y=110;
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
    [self.view addSubview:_tableView];

    TKLabelFieldCell *cell1=[[[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell1.label.text=@"原始密码:";
    cell1.field.placeholder=@"请输入原始密码";
    cell1.field.backgroundColor=[UIColor colorFromHexRGB:@"c6dfe5"];
    
    TKLabelFieldCell *cell2=[[[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell2.label.text=@"输入密码:";
    cell2.field.secureTextEntry=YES;
    cell2.field.placeholder=@"请输入密码";
    cell2.field.backgroundColor=[UIColor colorFromHexRGB:@"c6dfe5"];
    
    TKLabelFieldCell *cell3=[[[TKLabelFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell3.label.text=@"确认密码:";
    cell3.field.secureTextEntry=YES;
    cell3.field.placeholder=@"请输入确认密码";
    cell3.field.backgroundColor=[UIColor colorFromHexRGB:@"c6dfe5"];
    
    TKRegisterButtonCell *cell4=[[[TKRegisterButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell4.button setTitle:@"确定" forState:UIControlStateNormal];
    [cell4.button addTarget:self action:@selector(buttonSubmit) forControlEvents:UIControlEventTouchUpInside];
    
    self.cells=[NSMutableArray arrayWithObjects:cell1,cell2,cell3,cell4, nil];
	
}
-(BOOL)formSubmit{
    
    for (id item in self.cells) {
        if ([item isKindOfClass:[TKLabelFieldCell class]]) {
            TKLabelFieldCell *cell=(TKLabelFieldCell*)item;
            if (!cell.hasValue) {
                //[cell.field becomeFirstResponder];
                [cell.field shake];
                return NO;
            }
        }
    }
    Account *acc=[Account sharedInstance];
    TKLabelFieldCell *cell=self.cells[0];
    if (![acc.userPwd isEqualToString:cell.field.text]) {
        [cell.field shake];
        return NO;
    }
    
    TKLabelFieldCell *cell1=self.cells[1];
    TKLabelFieldCell *cell2=self.cells[2];
    if (![cell1.field.text isEqualToString:cell2.field.text]) {
        [cell2.field shake];
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
            [self hideLoadingViewAnimated:^(AnimateLoadView *hideView) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else{
            [self hideLoadingViewAnimated:^(AnimateLoadView *hideView) {
                [self showMessageWithTitle:@"修改失败！"];
            }];
        }
    } failed:^(NSError *error, NSDictionary *userInfo) {
        [self hideLoadingViewAnimated:^(AnimateLoadView *hideView) {
            [self showMessageWithTitle:@"修改失败！"];
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
