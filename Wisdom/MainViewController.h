//
//  MainViewController.h
//  active
//
//  Created by 徐 军 on 13-8-20.
//  Copyright (c) 2013年 chenjin. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface MainViewController : UITabBarController<UINavigationControllerDelegate>{
@private
    UIView *_tabbarView;
    int _prevSelectIndex;
    int _barButtonItemCount;
}
- (void)setSelectedItemIndex:(int)index;
@end
