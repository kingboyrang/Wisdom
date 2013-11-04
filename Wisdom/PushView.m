//
//  PushView.m
//  Wisdom
//
//  Created by aJia on 2013/11/4.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "PushView.h"
#import "PushDetail.h"
#import "Push.h"
#import "NSString+TPCategory.h"
#import "NetWorkConnection.h"
#import "WBInfoNoticeView.h"
#import "WBErrorNoticeView.h"
#import "Account.h"
#import "UIColor+TPCategory.h"
@interface PushView ()
-(void)loadData;
-(void)showInfoWithTitle:(NSString*)title;
@end

@implementation PushView
-(void)dealloc{
    [super dealloc];
    [_tableView release],_tableView=nil;
    if (_helper) {
        [_helper release];
        _helper=nil;
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _tableView =[[PullingRefreshTableView alloc] initWithFrame:self.bounds pullingDelegate:self];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor=[UIColor clearColor];
        [self addSubview:_tableView];
        _helper=[[ServiceHelper alloc] init];
        currentPage=0;
        pageSize=10;
        maxPage=0;
        self.infoType=1;
    }
    return self;
}
-(void)loadingSourceData{
    if (currentPage==0) {
        [_tableView launchRefreshing];
    }
}
-(void)showInfoWithTitle:(NSString*)title{
    WBInfoNoticeView *info=[WBInfoNoticeView infoNoticeInView:self title:title];
    [info show];
    info.gradientView.backgroundColor=[UIColor colorFromHexRGB:@"c94018"];
}
#pragma mark -
#pragma mark 加载数据
-(void)loadData{
    if (![NetWorkConnection IsEnableConnection]) {
        [_tableView tableViewDidFinishedLoading];
        _tableView.reachedTheEnd  = NO;
        WBErrorNoticeView *notice = [WBErrorNoticeView errorNoticeInView:self title:@"网络未连接" message:@"请检查您的网络连接."];
        [notice show];
        return;
    }
    Account *acc=[Account sharedInstance];
    if (self.infoType==1&&!acc.isLogin) {
        [_tableView tableViewDidFinishedLoading];
        _tableView.reachedTheEnd  = NO;
        [self showInfoWithTitle:@"当前未登陆,无法加载我的信息!"];
        return;
    }
    if (maxPage!=0&&currentPage>=maxPage) {
        currentPage=maxPage;
        [_tableView tableViewDidFinishedLoadingWithMessage:@"沒有了哦..."];
        _tableView.reachedTheEnd  = YES;
        return;
    }
    currentPage++;
    NSString *uid=self.infoType==1?acc.userAcc:@"";
    NSMutableArray *params=[NSMutableArray array];
    [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:uid,@"uid", nil]];
    [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",currentPage],@"start", nil]];
    [params addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",pageSize],@"size", nil]];
    
    ServiceArgs *args=[[[ServiceArgs alloc] init] autorelease];
    args.methodName=@"GetPushs";
    args.soapParams=params;
    [_helper asynService:args success:^(ServiceResult *result) {
        [_tableView tableViewDidFinishedLoading];
        _tableView.reachedTheEnd  = NO;
        if ([result.xmlString length]==0) {
            currentPage--;
            [self showInfoWithTitle:@"没有返回数据!"];
            return;
        }
        if (self.refreshing) {
            self.refreshing = NO;
        }
        NSString *xml=[result.xmlString stringByReplacingOccurrencesOfString:result.xmlnsAttr withString:@""];
        [result.xmlParse setDataSource:xml];
        XmlNode *node=[result.xmlParse soapXmlSelectSingleNode:@"//GetPushsResult"];
        NSArray *arr=[node.Value componentsSeparatedByString:@"<;>"];
        int totalCount=[[arr objectAtIndex:0] intValue];
        maxPage=totalCount%pageSize==0?totalCount/pageSize:totalCount/pageSize+1;
        
        xml=[[arr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"xmlns=\"Push[]\"" withString:@""];
        [result.xmlParse setDataSource:xml];
        NSArray *source=[result.xmlParse selectNodes:@"//Push" className:@"Push"];
        if (currentPage==1) {
            self.list=[NSMutableArray arrayWithArray:source];
            [_tableView reloadData];
        }else{
            NSMutableArray *insertIndexPaths = [NSMutableArray arrayWithCapacity:pageSize];
            for (int i=0; i<[source count]; i++) {
                [self.list addObject:[source objectAtIndex:i]];
                NSIndexPath *newPath=[NSIndexPath indexPathForRow:(currentPage-1)*pageSize+i inSection:0];
                [insertIndexPaths addObject:newPath];
            }
            //重新呼叫UITableView的方法, 來生成行.
            [_tableView beginUpdates];
            [_tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
            [_tableView endUpdates];
        }
        
        
    } failed:^(NSError *error, NSDictionary *userInfo) {
        currentPage--;
        self.refreshing = NO;
        [_tableView tableViewDidFinishedLoading];
        [self showInfoWithTitle:@"没有返回数据!"];
    }];
}
#pragma mark -
#pragma mark UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.list count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"CellCircularIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        PushDetail *detail=[[PushDetail alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 71)];
        detail.tag=100;
        [cell.contentView addSubview:detail];
        [detail release];
    }
    Push *entity=self.list[indexPath.row];
    PushDetail *detail=(PushDetail*)[cell.contentView viewWithTag:100];
    detail.labDate.text=entity.PubDate;
    detail.labMessage.text=entity.Subject;
    return cell;
    
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Push *entity=self.list[indexPath.row];
    CGSize size=[entity.Subject textSize:[UIFont boldSystemFontOfSize:14] withWidth:202];
    if (size.height>43){
        return 5+10+size.height+10+3+6;
    }
    return 71;
}

#pragma mark - PullingRefreshTableViewDelegate
//下拉加载
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    self.refreshing = YES;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.f];
}
//上拉加载
- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.f];
}
#pragma mark - Scroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_tableView tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_tableView tableViewDidEndDragging:scrollView];
}

@end
