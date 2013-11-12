//
//  TKLabelFieldCell.m
//  Wisdom
//
//  Created by aJia on 2013/11/1.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "TKLabelFieldCell.h"
#import "NSString+TPCategory.h"
@implementation TKLabelFieldCell

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
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
    r.origin.x=self.label.frame.origin.x+self.label.frame.size.width+2;
    r.size.width -= self.label.frame.size.width + 4;
	_field.frame = r;
}

@end
