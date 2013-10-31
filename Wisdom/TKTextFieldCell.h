//
//  TKTextFieldCell.h
//  Wisdom
//
//  Created by aJia on 2013/10/29.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "UITextField+TPCategory.h"
#import "EMKeyboardBarTextField.h"
@interface TKTextFieldCell : UITableViewCell<UITextFieldDelegate>
@property(nonatomic,strong) EMKeyboardBarTextField *field;
@property(nonatomic,readonly) BOOL hasValue;
@end
