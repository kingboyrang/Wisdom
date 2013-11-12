//
//  PushView.h
//  Wisdom
//
//  Created by aJia on 2013/11/4.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullingRefreshTableView.h"
#import "ServiceHelper.h"
@interface PushView : UIView<PullingRefreshTableViewDelegate,UITableViewDataSource,UITableViewDelegate>{
@private
    PullingRefreshTableView *_tableView;
    ServiceHelper *_helper;
    int currentPage;
    int pageSize;
    int maxPage;
}
@property (nonatomic) BOOL refreshing;
@property (nonatomic) BOOL isReload;
@property (nonatomic,strong) NSMutableArray *list;
@property (nonatomic,strong) NSMutableArray *cells;
@property (nonatomic,assign) int infoType;
-(void)loadingSourceData;
-(void)reloadingSourceData;
-(void)initParams;
@end
