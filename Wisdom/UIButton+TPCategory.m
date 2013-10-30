//
//  UIButton+TPCategory.m
//  Wisdom
//
//  Created by aJia on 2013/10/29.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "UIButton+TPCategory.h"

@implementation UIButton (TPCategory)
+(id)buttonWithBackgroundTitle:(NSString*)title target:(id)sender action:(SEL)sel{
    UIImage *image=[UIImage imageNamed:@"buttonbg.png"];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, image.size.width, image.size.height);
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn addTarget:sender action:sel forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:14];
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}
@end
