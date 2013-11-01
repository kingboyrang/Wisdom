//
//  TKRememberCell.m
//  Wisdom
//
//  Created by aJia on 2013/10/29.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "TKRememberCell.h"

@implementation TKRememberCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    _check = [[RememberCheck alloc] initWithFrame:CGRectMake(10, 1, self.bounds.size.width, 20)];
	[self.contentView addSubview:_check];
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}


- (void) layoutSubviews {
    [super layoutSubviews];
	CGRect r = CGRectInset(self.contentView.bounds, 10, 0);
    r.origin.y=5;
	_check.frame=r;
}
@end
