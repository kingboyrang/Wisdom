//
//  IntrouduceViewController.h
//  Wisdom
//
//  Created by aJia on 2013/11/14.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntrouduceViewController : BasicViewController<UIWebViewDelegate>
@property(nonatomic,copy) NSString *introduceType;
@property(nonatomic,copy) NSString *webURL;
-(BOOL)backWebViewPage;
@end
