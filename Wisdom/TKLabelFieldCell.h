//
//  TKLabelFieldCell.h
//  Wisdom
//
//  Created by aJia on 2013/11/1.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "TKLabelCell.h"
#import "EMKeyboardBarTextField.h"
@interface TKLabelFieldCell : TKLabelCell<UITextFieldDelegate>
@property(nonatomic,strong) UITextField *field;
@property(nonatomic,readonly) BOOL hasValue;
@end
