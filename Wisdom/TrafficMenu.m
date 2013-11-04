//
//  TrafficMenu.m
//  Wisdom
//
//  Created by aJia on 2013/11/4.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "TrafficMenu.h"
#import "UIColor+TPCategory.h"
#import "UIImage+TPCategory.h"
@interface TrafficMenu ()
-(void)addButtonWithTitle:(NSString*)title frame:(CGRect)frame tag:(int)index;
-(void)buttonMenuItem:(id*)sender;
@end

@implementation TrafficMenu
@synthesize controller;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *image=[UIImage imageNamed:@"bg_002.png"];
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [imageView setImage:image];
        [self addSubview:imageView];
        [imageView release];
        
       
        
        CGFloat w=(frame.size.width-20)/4,h=frame.size.height-2,topX=10;
        
        UIImage *leftImage=[UIImage imageNamed:@"bg_003.png"];
        UIEdgeInsets leftInsets = UIEdgeInsetsMake(5,10, 5, 10);
        leftImage=[leftImage resizableImageWithCapInsets:leftInsets resizingMode:UIImageResizingModeStretch];
        _silderImage=[[UIImageView alloc] initWithFrame:CGRectMake(topX, frame.size.height-h, w, h)];
        [_silderImage setImage:leftImage];
        [self addSubview:_silderImage];
    
        [self addButtonWithTitle:@"路况" frame:CGRectMake(topX, frame.size.height-h, w, h) tag:100];
        topX+=w;
        [self addButtonWithTitle:@"公交" frame:CGRectMake(topX, frame.size.height-h, w, h) tag:101];
        topX+=w;
        [self addButtonWithTitle:@"出租车" frame:CGRectMake(topX, frame.size.height-h, w, h) tag:102];
        topX+=w;
        [self addButtonWithTitle:@"航班" frame:CGRectMake(topX, frame.size.height-h, w, h) tag:103];
    }
    return self;
}
-(void)addButtonWithTitle:(NSString*)title frame:(CGRect)frame tag:(int)index{
    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitleColor:[UIColor colorFromHexRGB:@"c94018"] forState:UIControlStateNormal];
    btn1.titleLabel.font=[UIFont boldSystemFontOfSize:14];
    [btn1 setTitle:title forState:UIControlStateNormal];
    btn1.frame=frame;
    btn1.tag=index;
    [btn1 addTarget:self action:@selector(buttonMenuItem:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn1];
}
-(void)buttonMenuItem:(id*)sender{
    UIButton *btn=(UIButton*)sender;
    int index=btn.tag-100;
    CGFloat w=(self.bounds.size.width-20)/4;
    CGRect r=_silderImage.frame;
    r.origin.x=10+w*index;
    _silderImage.frame=r;
    if (self.controller&&[self.controller respondsToSelector:@selector(loadWebView:)]) {
        [self.controller performSelector:@selector(loadWebView:) withObject:(id)index];
    }
}
@end
