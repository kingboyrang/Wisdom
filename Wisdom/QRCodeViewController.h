//
//  QRCodeViewController.h
//  Wisdom
//
//  Created by aJia on 2013/11/5.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"
@interface QRCodeViewController : BasicViewController<ZBarReaderDelegate>
-(void)finishPickerImage:(UIImage*)image;
@end
