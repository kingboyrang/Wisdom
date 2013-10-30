//
//  TKTextFieldCell.m
//  Wisdom
//
//  Created by aJia on 2013/10/29.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "TKTextFieldCell.h"
#import "NSString+TPCategory.h"
@implementation TKTextFieldCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    _field = [[UITextField alloc] initWithFrame:CGRectZero];
    _field.font=[UIFont boldSystemFontOfSize:16.0];
    _field.textColor=[UIColor blackColor];
    _field.borderStyle=UITextBorderStyleRoundedRect;
    _field.delegate=self;
    _field.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;

	
	[self.contentView addSubview:_field];
    
    
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}
-(BOOL)hasValue{
    NSString *title=[_field.text Trim];
    if ([title length]>0) {
        return YES;
    }
    return NO;
}

- (void) layoutSubviews {
    [super layoutSubviews];
	CGRect r = CGRectInset(self.contentView.bounds, 10, 4);
	_field.frame = r;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
