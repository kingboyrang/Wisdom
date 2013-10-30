//
//  AdView.m
//  stockmarket_infomation
//
//  Created by 神奇的小黄子 QQ:438172 on 12-12-10.
//  Copyright (c) 2012年 kernelnr. All rights reserved.
//

#import "AdView.h"
#import "AdModel.h"
@implementation MyUIScrollView
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.dragging)
    {
        [[self nextResponder] touchesBegan:touches withEvent:event];
    }
    [super touchesBegan:touches withEvent:event];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.dragging)
    {
        [[self nextResponder] touchesMoved:touches withEvent:event];
    }
    [super touchesMoved:touches withEvent:event];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.dragging)
    {
        [[self nextResponder] touchesEnded:touches withEvent:event];
    }
    [super touchesEnded:touches withEvent:event];
}
@end

@implementation AdView

#define ADIMG_INDEX 888
#define ADTITLE_INDEX   889
#define AD_BOTTOM_HEIGHT    0

#pragma mark - ----- init frame
- (id)initWithFrame:(CGRect)frame :(NSMutableArray *)arr
{
    self = [super initWithFrame:frame];
    
    
    if (nil != self)
    {
        // init...
        [self setFrame:frame];
        [self setBackgroundColor:[UIColor clearColor]];
        
    }
    
    return self;
}

/* ad loading... */
- (void)adLoad
{
    /* set timer(图片轮播)*/
    [NSTimer scheduledTimerWithTimeInterval:4.5f target:self selector:@selector(changedAdTimer:) userInfo:nil repeats:YES];
    
    
    sv_Ad = [[MyUIScrollView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height-AD_BOTTOM_HEIGHT)];
    [sv_Ad setDelegate:self];   // set delegate
    [sv_Ad setScrollEnabled:YES];
    [sv_Ad setPagingEnabled:YES];
    [sv_Ad setShowsHorizontalScrollIndicator:NO];
    [sv_Ad setShowsVerticalScrollIndicator:NO];
    [sv_Ad setAlwaysBounceVertical:NO];
    [sv_Ad setContentSize:CGSizeMake(DeviceWidth*([_ads count]>0?[_ads count]:0), sv_Ad.frame.size.height)];
    [self addSubview:sv_Ad];
    
    
    
    /* infomation */
    UIImageView *img_info = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, self.frame.size.height-24.f-AD_BOTTOM_HEIGHT+6, self.frame.size.width, 18.f)];
    [img_info setBackgroundColor:[UIColor blackColor]];
    [img_info setAlpha:.3f];
    [self addSubview:img_info];
    
    int i=0;
    for (AdModel *adModel in _ads) {
        if(i==0){
            /* intro */
            lbl_Info = [[UILabel alloc] initWithFrame:CGRectMake(6, self.frame.size.height-24+3, DeviceWidth-100, 24.f)];
            [lbl_Info setTag:ADTITLE_INDEX];
            [lbl_Info setBackgroundColor:[UIColor clearColor]];
            lbl_Info.shadowColor = [UIColor grayColor];
            lbl_Info.shadowOffset = CGSizeMake(0.3, 0.3);
            [lbl_Info setTextColor:[UIColor whiteColor]];
            [lbl_Info setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13.f]];
            [lbl_Info setText:adModel.advertName];
            [lbl_Info setTextAlignment:NSTextAlignmentLeft];
            [lbl_Info setLineBreakMode:NSLineBreakByWordWrapping|NSLineBreakByTruncatingTail];
            [self addSubview:lbl_Info];
        }
        i++;
    }
    
    
    int y=0;
    for (AdModel *adModel in _ads)
    {
        
        UIImageView *img_Ad = [[UIImageView alloc] initWithFrame:CGRectMake(DeviceWidth*y, 0, DeviceWidth, self.frame.size.height)];
        [img_Ad setTag:y];
        //[img_Ad setImageWithURL:[NSURL URLWithString:adModel.thumb]];
        [img_Ad setImage:[UIImage imageWithContentsOfFile:adModel.thumb]];
        [img_Ad setUserInteractionEnabled:YES];
        [sv_Ad addSubview:img_Ad];
        y++;
        
    }
    
    /* page ctrl */
    pc_AdPage = [[UIPageControl alloc] initWithFrame:CGRectMake(0.f, 0.f, 64.f, 8.f)];
    [pc_AdPage setCenter:CGPointMake(sv_Ad.frame.size.width-70.f/2.f, self.frame.size.height+3-AD_BOTTOM_HEIGHT-24.f/2.f)];
    [pc_AdPage setUserInteractionEnabled:YES];
    [pc_AdPage setAutoresizesSubviews:YES];
    [pc_AdPage setAlpha:1.f];
    [pc_AdPage setCurrentPage:0];
    
    [pc_AdPage setNumberOfPages:([_ads count]>0?[_ads count]:0)];
    [self addSubview:pc_AdPage];
    
}

#pragma mark - ----- -> 自动切换广告
static int cur_count = -1;
- (void)changedAdTimer:(NSTimer *)timer
{
    cur_count = pc_AdPage.currentPage;
    ++cur_count;
    pc_AdPage.currentPage = (cur_count%[_ads count]);
    
    AdModel *adModel=[[AdModel alloc] init];
    adModel=[_ads objectAtIndex:pc_AdPage.currentPage];
    
    [UIView animateWithDuration:.7f animations:^{
        [lbl_Info setText:adModel.advertName];
        sv_Ad.contentOffset = CGPointMake(pc_AdPage.currentPage*DeviceWidth,0);
    }];
}




#pragma mark - ----- -> 点击广告
- (void)OpenAd:(int)iTag
{
    //WebViewController *webVC = [[WebViewController alloc] initWithUrl:@"http://baidu.com"];
    //[self.viewController.navigationController pushViewController:webVC  animated:YES];
    
}

#pragma mark - ----- -> scrollView opt
enum _jmpFalg { NORMAL = 0, LAST = -1, FIRST = 1 };
BOOL bJmp = NORMAL;
static float maxLoc = 0.f, minLoc = 0.f;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    maxLoc = (maxLoc>scrollView.contentOffset.x)?maxLoc:scrollView.contentOffset.x;
    minLoc = (minLoc<scrollView.contentOffset.x)?minLoc:scrollView.contentOffset.x;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    do
    {
        if (maxLoc > ([_ads count]-1)*320.f)
        {
            bJmp = FIRST;
            break;
        }
        else if (minLoc < 0*320.f)
        {
            bJmp = LAST;
            break;
        }
        else
        {
            bJmp = NORMAL;
            break;
        }
    } while (TRUE);
    
    switch (bJmp)
    {
        case FIRST:
        {
            pc_AdPage.currentPage = 0;
        }
            break;
        case LAST:
        {
            pc_AdPage.currentPage = ([_ads count]>0?[_ads count]:0);
        }
            break;
        case NORMAL:
        {
            [pc_AdPage setCurrentPage:scrollView.contentOffset.x/320.f];
        }
            break;
        default:
            break;
    }
    AdModel *adModel=[[AdModel alloc] init];
    adModel=[_ads objectAtIndex:pc_AdPage.currentPage];
    
    [UIView animateWithDuration:.7f animations:^{
        [lbl_Info setText:adModel.advertName];
        sv_Ad.contentOffset = CGPointMake((pc_AdPage.currentPage%[_ads count])*320.f, 0.f);
    }];
    maxLoc = minLoc = sv_Ad.contentOffset.x;
}

#pragma mark ----- -> touches opt

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UIView *touchedView = [touches.anyObject view];
    [self.delegate openAd:self adModel:_ads[touchedView.tag]];
 
}

@end