//
//  UIBarButtonItem+TPCategory.m
//  Wisdom
//
//  Created by aJia on 2013/10/29.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "UIBarButtonItem+TPCategory.h"
#import "UIButton+TPCategory.h"
@implementation UIBarButtonItem (TPCategory)
+(id)backgroundButtonItem:(NSString*)title target:(id)sender action:(SEL)sel{
    UIButton *btn=[UIButton buttonWithBackgroundTitle:title target:sender action:sel];
    UIBarButtonItem *rightBtn=[[UIBarButtonItem alloc] initWithCustomView:btn];
    return [rightBtn autorelease];
}
@end
