//
//  AdView.h
//  stockmarket_infomation
//
//  Created by 神奇的小黄子 QQ:438172 on 12-12-10.
//  Copyright (c) 2012年 kernelnr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdModel.h"
@class AdView;
@protocol AdViewDelegate <NSObject>

- (void)openAd: (AdView *)controller adModel: (AdModel *)adModel;

@end

@interface MyUIScrollView : UIScrollView
@end

@interface AdView : UIView<UIScrollViewDelegate, UIPageViewControllerDelegate>
{
    MyUIScrollView  *sv_Ad; // 广告
    UIPageControl   *pc_AdPage; // 广告页码
    UILabel *lbl_Info;  // 广告标题
}
@property (nonatomic, strong) id<AdViewDelegate> delegate;
@property (nonatomic,retain) NSMutableArray *ads;
- (void)adLoad;
- (void)changedAdTimer:(NSTimer *)timer;
@end
