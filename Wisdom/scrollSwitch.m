//
//  scrollSwitch.m
//  Wisdom
//
//  Created by aJia on 2013/11/4.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "scrollSwitch.h"
#import "UIColor+TPCategory.h"

@interface scrollSwitch ()
-(void)buttonMyInfoClick:(id)sender;
-(void)buttonComInfoClick:(id)sender;
@end

@implementation scrollSwitch
@synthesize controler;
-(void)dealloc{
    [super dealloc];
    [imageView release],imageView=nil;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        imageView=[[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2, 0, frame.size.width/2, frame.size.height)];
        UIImage *leftImage=[UIImage imageNamed:@"switchBtn.png"];
        UIEdgeInsets leftInsets = UIEdgeInsetsMake(5,5, 5, 5);
        leftImage=[leftImage resizableImageWithCapInsets:leftInsets resizingMode:UIImageResizingModeStretch];
        [imageView setImage:leftImage];
        [self addSubview:imageView];
        
        UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame=CGRectMake(0, 0, frame.size.width/2, frame.size.height);
        btn1.tag=100;
        [btn1 setTitleColor:[UIColor colorFromHexRGB:@"919293"] forState:UIControlStateNormal];
        btn1.titleLabel.font=[UIFont boldSystemFontOfSize:16];
        [btn1 setTitle:@"我的信息" forState:UIControlStateNormal];
        btn1.showsTouchWhenHighlighted = YES;  //指定按钮被按下时发光
        [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [btn1 addTarget:self action:@selector(buttonMyInfoClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn1];
        
        UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame=CGRectMake(frame.size.width/2, 0, frame.size.width/2, frame.size.height);
        btn2.tag=101;
        [btn2 setTitleColor:[UIColor colorFromHexRGB:@"919293"] forState:UIControlStateNormal];
        btn2.titleLabel.font=[UIFont boldSystemFontOfSize:16];
        btn2.showsTouchWhenHighlighted = YES;  //指定按钮被按下时发光
        [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn2 setTitle:@"公共信息" forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(buttonComInfoClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn2];
        
        self.backgroundColor=[UIColor colorFromHexRGB:@"f9f6f7"];
        
    }
    return self;
}
-(void)buttonMyInfoClick:(id)sender{
    UIButton *btn=(UIButton*)sender;
    UIButton *btn1=(UIButton*)[self viewWithTag:101];
    
    [btn setTitleColor:[UIColor colorFromHexRGB:@"919293"] forState:UIControlStateNormal];//此时选中
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//此时未被选中
    
    [UIView beginAnimations:nil context:nil];//动画开始
    [UIView setAnimationDuration:0.3];
    
    imageView.frame=CGRectMake(self.bounds.size.width/2, 0, self.bounds.size.width/2, self.bounds.size.height);
    //[nibScrollView setContentOffset:CGPointMake(self.view.bounds.size.width*0, 0)];//页面滑动
    if (self.controler&&[self.controler respondsToSelector:@selector(pageScrollLeft)]) {
        [self.controler performSelector:@selector(pageScrollLeft)];
    }
    [UIView commitAnimations];
    
}
-(void)buttonComInfoClick:(id)sender{
    UIButton *btn=(UIButton*)sender;
    UIButton *btn1=(UIButton*)[self viewWithTag:100];
    [btn setTitleColor:[UIColor colorFromHexRGB:@"919293"] forState:UIControlStateNormal];//此时选中
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//此时未被选中
    
    [UIView beginAnimations:nil context:nil];//动画开始
    [UIView setAnimationDuration:0.3];
    
    imageView.frame=CGRectMake(0, 0, self.bounds.size.width/2, self.bounds.size.height);
    if (self.controler&&[self.controler respondsToSelector:@selector(pageScrollRight)]) {
        [self.controler performSelector:@selector(pageScrollRight)];
    }
    [UIView commitAnimations];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
