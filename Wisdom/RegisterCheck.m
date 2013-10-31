//
//  RegisterCheck.m
//  Wisdom
//
//  Created by aJia on 2013/10/31.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "RegisterCheck.h"
#import "NSString+TPCategory.h"
@interface RegisterCheck ()
-(void)loadControls:(CGRect)frame;
-(void)buttonClickTap:(id)sender;
-(void)addButton:(CGFloat)leftx height:(CGFloat)h index:(NSInteger)tag;
@end

@implementation RegisterCheck
@synthesize hasRemember=_hasRemember;
-(void)dealloc{
    [super dealloc];
    [_lightLabel release],_lightLabel=nil;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _hasRemember=NO;
        self.backgroundColor=[UIColor clearColor];
        [self loadControls:frame];
    }
    return self;
}
-(void)loadControls:(CGRect)frame{
    CGFloat leftx=0;
    if (!_lightLabel) {
        NSString *title=@"下次自动登录";
        CGSize size=[title textSize:[UIFont boldSystemFontOfSize:15.0] withWidth:frame.size.width-leftx];
        _lightLabel=[[UILabel alloc] initWithFrame:CGRectMake(leftx,(frame.size.height-size.height)/2.0,size.width, size.height)];
        _lightLabel.font=[UIFont boldSystemFontOfSize:15.0];
        _lightLabel.text=title;
        _lightLabel.backgroundColor=[UIColor clearColor];
        _lightLabel.textColor=[UIColor blackColor];
        //[UIColor colorWithRed:110/255.0 green:106/255.0 blue:97/255.0 alpha:1];
        leftx=_lightLabel.frame.size.width+5;
        UISwitch *switchItem=[[UISwitch alloc] initWithFrame:CGRectMake(leftx, (frame.size.height-30)/2, 40, 30)];
        switchItem.on=YES;
        [switchItem addTarget:self action:@selector(buttonClickTap:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:switchItem];
        [switchItem release];
    }
    //[self addButton:leftx height:frame.size.height index:100];
    //leftx+=20+1;
    [self addSubview:_lightLabel];
    
}
-(void)addButton:(CGFloat)leftx height:(CGFloat)h index:(NSInteger)tag{
    UIImage *image=[UIImage imageNamed:@"checkbox.png"];
    UIImage *imageSelect=[UIImage imageNamed:@"checkbox-checked.png"];
    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame=CGRectMake(leftx,(h-image.size.width)/2.0, image.size.width, image.size.height);
    btn1.tag=tag;
    [btn1 setImage:image forState:UIControlStateNormal];
    [btn1 setImage:imageSelect forState:UIControlStateSelected];
    [btn1 addTarget:self action:@selector(buttonClickTap:) forControlEvents:UIControlEventTouchUpInside];
    if (tag==101) {
        btn1.selected=YES;
    }
    [self addSubview:btn1];
}
-(void)buttonClickTap:(id)sender{
    UISwitch *btn=(UISwitch*)sender;
    _hasRemember=btn.on;
}
@end
