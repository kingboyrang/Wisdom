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
#import "pickerImage.h"
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
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbg.png"] forBarMetrics:UIBarMetricsDefault];
    [self editBackBarbuttonItem:@"二维码"];
    
   ZBarReaderViewController *_readerController = [[ZBarReaderViewController new] retain];
    _readerController.readerDelegate = self;
    //非全屏
    _readerController.wantsFullScreenLayout = NO;
    //隐藏底部控制按钮
    _readerController.showsZBarControls = NO;
    //设置自己定义的界面
    [self setOverlayPickerView:_readerController];
    ZBarImageScanner *scanner = _readerController.scanner;
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    [self presentViewController:_readerController animated:YES completion:nil];
    
    
    
        
    
}
- (void)setOverlayPickerView:(ZBarReaderViewController *)reader

{
    //清除原有控件
    
    for (UIView *temp in [reader.view subviews]) {
        
        for (UIButton *button in [temp subviews]) {
            
            if ([button isKindOfClass:[UIButton class]]) {
                
                [button removeFromSuperview];
                
            }
        }
        
        for (UIToolbar *toolbar in [temp subviews]) {
            
            if ([toolbar isKindOfClass:[UIToolbar class]]) {
                
                [toolbar setHidden:YES];
                
                [toolbar removeFromSuperview];
                
            }
            
        }
        
    }
    
    //画中间的基准线
    UIView* line = [[UIView alloc] initWithFrame:CGRectMake(40, 220, 240, 1)];
    line.backgroundColor = [UIColor greenColor];
    [reader.view addSubview:line];
    [line release];
    //最上部view
    UIView* upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    upView.alpha = 0.3;
    upView.backgroundColor = [UIColor blackColor];
    [reader.view addSubview:upView];
    //用于说明的label
    UILabel * labIntroudction= [[UILabel alloc] init];
    labIntroudction.backgroundColor = [UIColor clearColor];
//    labIntroudction.frame=CGRectMake(15, 20, 290, 50);
    labIntroudction.frame=CGRectMake(15, 400, 290, 50);
    labIntroudction.numberOfLines=2;
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.text=@"将二维码图像置于矩形方框内，离手机摄像头10CM左右，系统会自动识别。";
    [upView addSubview:labIntroudction];
    [labIntroudction release];
    [upView release];
    //左侧的view
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, 20, 300)];
    
    leftView.alpha = 0.3;
    
    leftView.backgroundColor = [UIColor blackColor];
    
    [reader.view addSubview:leftView];
    
    [leftView release];
    
    //右侧的view
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(300, 80, 20, 300)];
    
    rightView.alpha = 0.3;
    
    rightView.backgroundColor = [UIColor blackColor];
    
    [reader.view addSubview:rightView];
    
    [rightView release];
    
    //底部view
    
    UIView * downView = [[UIView alloc] initWithFrame:CGRectMake(0, 380, 320, 200)];
    
    downView.alpha = 0.3;
    
    downView.backgroundColor = [UIColor blackColor];
    
    [reader.view addSubview:downView];
    
    [downView release];
    
    //用于取消操作的button
    /***
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelButton.alpha = 0.4;
    [cancelButton setFrame:CGRectMake(20, 390, 280, 40)];
    [cancelButton setTitle:@"图片" forState:UIControlStateNormal];
    [cancelButton.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [cancelButton addTarget:self action:@selector(dismissOverlayView:)forControlEvents:UIControlEventTouchUpInside];
    [reader.view addSubview:cancelButton];  
     ***/
    
}  
//取消button方法
- (void)dismissOverlayView:(id)sender{
    //pickerImage *picker=[[[pickerImage alloc] init] autorelease];
    //picker.controller=self.readerController;
    //[picker openPhoto];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    id results = [info objectForKey:ZBarReaderControllerResults];
    ZBarSymbol * symbol;
    for(symbol in results)
        break;
    //_imageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    //处理部分中文乱码问题
    NSString *result=symbol.data;
    if ([symbol.data canBeConvertedToEncoding:NSShiftJISStringEncoding])
    {
        
        //symbol.data= [NSString stringWithCString:[symbol.data cStringUsingEncoding: NSShiftJISStringEncoding] encoding:NSUTF8StringEncoding];
        result=[NSString stringWithCString:[symbol.data cStringUsingEncoding: NSShiftJISStringEncoding] encoding:NSUTF8StringEncoding];
    }
   
    
    [UIView transitionWithView:self.view
                      duration:1.5f
                       options:UIViewAnimationOptionTransitionCurlDown
                    animations:^{
                        CGRect r=self.view.bounds;
                        r.size.height+=54+44;
                        UITextView *textView=[[UITextView alloc] initWithFrame:r];
                        textView.tag=100;
                        textView.editable=NO;
                        textView.font=[UIFont boldSystemFontOfSize:16];
                        textView.text=result;
                        [self.view addSubview:textView];
                        [textView release];
                        
                    }
                    completion:NULL];
    
     //[reader dismissModalViewControllerAnimated: YES];
}
//读取失败
- (void) readerControllerDidFailToRead: (ZBarReaderController*) reader
                             withRetry: (BOOL) retry{

}
-(void)finishPickerImage:(UIImage*)image{
    /***
    ZBarImage *barImage=[[ZBarImage alloc] initWithCGImage:image.CGImage];
    [self.readerController.readerView.scanner scanImage:barImage];
    [barImage release];
     ***/
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
