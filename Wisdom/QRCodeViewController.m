//
//  QRCodeViewController.m
//  Wisdom
//
//  Created by aJia on 2013/11/5.
//  Copyright (c) 2013年 lz. All rights reserved.
//

#import "QRCodeViewController.h"
#import "NSString+TPCategory.h"
#import "UIImage+TPCategory.h"
@interface QRCodeViewController ()

@end

@implementation QRCodeViewController
-(void)dealloc{
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void) viewDidAppear:(BOOL)animated
{
    // run the reader when the view is visible
    [super viewDidAppear:animated];
    ZBarReaderViewController * reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    ZBarImageScanner * scanner = reader.scanner;
    [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
    reader.showsZBarControls = YES;
    [self presentViewController:reader animated:YES completion:nil];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbg.png"] forBarMetrics:UIBarMetricsDefault];
    [self editBackBarbuttonItem:@"二维码"];
    self.view.backgroundColor=[UIColor blackColor];
    CGRect r=self.view.bounds;
    r.size.height+=54+44;
    UITextView *textView=[[UITextView alloc] initWithFrame:r];
    textView.tag=100;
    textView.editable=NO;
    [self.view addSubview:textView];
    [textView release];
    
    
    
    /***
    UIImage *image=[[UIImage imageNamed:@"code.png"] imageByScalingProportionallyToSize:CGSizeMake(280, 280*446/450)];
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake((DeviceWidth-image.size.width)/2, 20, image.size.width, image.size.height)];
    [imageView setImage:image];
    [self.view addSubview:imageView];
    [imageView release];
	
    NSString *title=@"将二维码放入框内，即可自动扫描";
    CGSize size=[title textSize:[UIFont boldSystemFontOfSize:16] withWidth:DeviceWidth];
    CGFloat topY=self.view.bounds.size.height-54-44-size.height-30;
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, topY, DeviceWidth, size.height)];
    label.text=title;
    label.textColor=[UIColor whiteColor];
    label.textAlignment=NSTextAlignmentCenter;
    label.backgroundColor=[UIColor clearColor];
    [self.view addSubview:label];
    [label release];
     ***/
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    id results = [info objectForKey:ZBarReaderControllerResults];
    ZBarSymbol * symbol;
    for(symbol in results)
        break;
    //_imageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    UITextView *tv=(UITextView*)[self.view viewWithTag:100];
    tv.text = symbol.data;
}

- (void) readerView: (ZBarReaderView*) view
     didReadSymbols: (ZBarSymbolSet*) syms
          fromImage: (UIImage*) img
{
    // do something useful with results
    for(ZBarSymbol *sym in syms) {
        UITextView *tv=(UITextView*)[self.view viewWithTag:100];
        tv.text=sym.data;
        break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
