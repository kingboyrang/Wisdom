//
//  UINavigationItem+TPCategory.m
//  Wisdom
//
//  Created by aJia on 2013/10/29.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "UINavigationItem+TPCategory.h"
#import "FXLabel.h"
#import "NSString+TPCategory.h"
#import "UIBarButtonItem+TPCategory.h"
@implementation UINavigationItem (TPCategory)
-(void)rightBarBtnItem:(NSString*)title target:(id)sender action:(SEL)sel{
    self.rightBarButtonItem=[UIBarButtonItem backgroundButtonItem:title target:sender action:sel];
    /***
    UIImage *image=[UIImage imageNamed:@"buttonbg.png"];
    UIView *bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    bgView.backgroundColor=[UIColor clearColor];
    //button
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, image.size.width, image.size.height);
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn addTarget:sender action:sel forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btn];
    //label
    FXLabel *label = [AppUI barButtonItemTitle:title frame:bgView.frame];
    CGRect r=label.frame;
    r.origin.x=(image.size.width-r.size.width)/2.0;
    r.origin.y=(image.size.height-r.size.height)/2.0;
    label.frame=r;
    [bgView addSubview:label];
    
    UIBarButtonItem *rightBtn=[[UIBarButtonItem alloc] initWithCustomView:bgView];
    [bgView release];
    self.rightBarButtonItem=rightBtn;
    [rightBtn release];
     ***/
}
-(void)backBarBtnItem:(NSString*)title target:(id)sender action:(SEL)sel{
    if (title&&[title length]>0) {
        UIView *leftView=[[UIView alloc] initWithFrame:CGRectZero];
        leftView.backgroundColor=[UIColor clearColor];
        UIImage *image=[UIImage imageNamed:@"back1.png"];
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(0, -3, image.size.width, image.size.height);
        [btn setBackgroundImage:image forState:UIControlStateNormal];
        [btn addTarget:sender action:sel forControlEvents:UIControlEventTouchUpInside];
        [leftView addSubview:btn];

        CGRect rect=CGRectMake(btn.frame.size.width+5, 0, DeviceWidth, 44);
        FXLabel *label=[AppUI showLabelTitle:title frame:rect];
        [leftView addSubview:label];
        leftView.frame=CGRectMake(0, 0, label.frame.origin.x+label.frame.size.width, label.frame.size.height);
        
        UIBarButtonItem *leftBtn=[[UIBarButtonItem alloc] initWithCustomView:leftView];
        [leftView release];
        self.leftBarButtonItem=leftBtn;
        [leftBtn release];
    }else{
        UIImage *image=[UIImage imageNamed:@"back1.png"];
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(0, -6.5, image.size.width, image.size.height);
        [btn setBackgroundImage:image forState:UIControlStateNormal];
        [btn addTarget:sender action:sel forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *rightBtn=[[UIBarButtonItem alloc] initWithCustomView:btn];
        self.leftBarButtonItem=rightBtn;
        [rightBtn release];
    }
}
@end
