//
//  IndexMenu.m
//  Wisdom
//
//  Created by aJia on 2013/10/30.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "IndexMenu.h"
#import "UIImage+TPCategory.h"
@interface IndexMenu ()
-(void)buttonMenuClick:(UIButton*)button;
@end

@implementation IndexMenu
@synthesize controler;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *image=[UIImage imageNamed:@"bgView.png"];
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
        [imageView setImage:image];
        [self addSubview:imageView];
        [imageView release];
        
        CGFloat h=(frame.size.height-15)/2,w=DeviceWidth/2-5,leftX=5,topY=5;
        CGSize imageSize=CGSizeMake(w, h);
        //弥勒介绍
        UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame=CGRectMake(leftX, topY, w, h);
        btn1.tag=100;
        [btn1 setBackgroundImage:[[UIImage imageNamed:@"ico_001.png"] imageByScalingToSize:imageSize] forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(buttonMenuClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn1];
        topY+=5+h;
        //景点
        UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame=CGRectMake(leftX, topY, w, h);
        btn2.tag=101;
        [btn2 setBackgroundImage:[[UIImage imageNamed:@"ico_002.png"] imageByScalingToSize:imageSize] forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(buttonMenuClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn2];
        
        h=(frame.size.height-20)/3;
        w=DeviceWidth/2-10;
        leftX=DeviceWidth/2+5;
        topY=5;
        imageSize=CGSizeMake(w, h);
        //交通
        UIButton *btn3=[UIButton buttonWithType:UIButtonTypeCustom];
        btn3.frame=CGRectMake(leftX, topY, w, h);
        btn3.tag=102;
        [btn3 setBackgroundImage:[[UIImage imageNamed:@"ico_003.png"] imageByScalingToSize:imageSize] forState:UIControlStateNormal];
        [btn3 addTarget:self action:@selector(buttonMenuClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn3];
        topY+=5+h;
        //住宿
        UIButton *btn4=[UIButton buttonWithType:UIButtonTypeCustom];
        btn4.frame=CGRectMake(leftX, topY, w, h);
        btn4.tag=103;
        [btn4 setBackgroundImage:[[UIImage imageNamed:@"ico_004.png"] imageByScalingToSize:imageSize] forState:UIControlStateNormal];
        [btn4 addTarget:self action:@selector(buttonMenuClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn4];
        topY+=5+h;
        //美食
        UIButton *btn5=[UIButton buttonWithType:UIButtonTypeCustom];
        btn5.frame=CGRectMake(leftX, topY, w, h);
        btn5.tag=104;
        [btn5 setBackgroundImage:[[UIImage imageNamed:@"ico_005.png"] imageByScalingToSize:imageSize] forState:UIControlStateNormal];
        [btn5 addTarget:self action:@selector(buttonMenuClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn5];
        
    }
    return self;
}
-(void)buttonMenuClick:(UIButton*)button{
    NSString *index=[NSString stringWithFormat:@"%d",button.tag-100];
    if (self.controler&&[self.controler respondsToSelector:@selector(buttonMenuItemIndex:)]) {
        [self.controler performSelector:@selector(buttonMenuItemIndex:) withObject:index];
    }
}
@end
