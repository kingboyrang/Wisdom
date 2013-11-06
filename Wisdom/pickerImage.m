//
//  pickerImage.m
//  Wisdom
//
//  Created by aJia on 2013/11/6.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "pickerImage.h"

@implementation pickerImage
-(void)openPhoto{
    UIImagePickerController *picker=[[UIImagePickerController alloc] init];
    picker.delegate=self;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary])
    {
        picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self.controller presentViewController:picker animated:YES completion:nil];
    [picker release];
}

#pragma mark -
#pragma mark UIImagePickerController  Delegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
	
	UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];
    if (self.controller&&[self.controller respondsToSelector:@selector(finishPickerImage:)]) {
        [self.controller performSelector:@selector(finishPickerImage:) withObject:image];
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
}
@end
