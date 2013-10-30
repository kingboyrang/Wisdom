//
//  LoginViewController.h
//  Wisdom
//
//  Created by aJia on 2013/10/29.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceHelper.h"
@interface LoginViewController : BasicViewController<UITableViewDataSource,UITableViewDelegate>{
    ServiceHelper *_helper;
}
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *cells;
@end
