//
//  pickerImage.h
//  Wisdom
//
//  Created by aJia on 2013/11/6.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface pickerImage : NSObject<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,assign) UIViewController *controller;
-(void)openPhoto;
@end
