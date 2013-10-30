//
//  UINavigationItem+TPCategory.h
//  Wisdom
//
//  Created by aJia on 2013/10/29.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (TPCategory)
-(void)rightBarBtnItem:(NSString*)title target:(id)sender action:(SEL)sel;
-(void)backBarBtnItem:(NSString*)title target:(id)sender action:(SEL)sel;
@end
