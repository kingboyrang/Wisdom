//
//  TKLoginButtonCell.m
//  Wisdom
//
//  Created by aJia on 2013/10/29.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "TKLoginButtonCell.h"

@implementation TKLoginButtonCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    UIImage *leftImage=[UIImage imageNamed:@"btnbg01.png"];
    UIEdgeInsets leftInsets = UIEdgeInsetsMake(3,1, 3, 1);
    leftImage=[leftImage resizableImageWithCapInsets:leftInsets resizingMode:UIImageResizingModeStretch];
    _button = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, self.bounds.size.width-20, 32)];
    [_button setBackgroundImage:leftImage forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _button.titleLabel.font=[UIFont boldSystemFontOfSize:16.0];
	[self.contentView addSubview:_button];
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}


- (void) layoutSubviews {
    [super layoutSubviews];
	CGRect r = CGRectInset(self.contentView.bounds, 10, 4.5);
    r.origin.y=15;
	_button.frame=r;
}

@end
