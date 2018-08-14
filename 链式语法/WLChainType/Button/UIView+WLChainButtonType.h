//
//  UIView+WLChainButtonType.h
//  链式语法
//
//  Created by 王亮 on 2018/8/13.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLButton.h"

@interface UIView (WLChainButtonType)

/** 文字 */
- (UIButton *(^)(NSString *sender ,UIControlState state))       wl_button_title;
/** 图片 */
- (UIButton *(^)(UIImage *sender ,UIControlState state))        wl_button_image;
/** 背景图片 */
- (UIButton *(^)(UIImage *sender ,UIControlState state))        wl_button_backgroundImage;
/** 添加点击 */
- (UIButton *(^)(id sf ,SEL sel ,UIControlEvents event))        wl_button_addTarget;
/** 文字大小 */
- (UIButton *(^)(NSInteger sender ,UIFontWeight weight))        wl_button_textSize;

/** 布局 图片方向
 UIViewContentModeTop,
 UIViewContentModeBottom,
 UIViewContentModeLeft,
 UIViewContentModeRight,
 */
- (UIButton *(^)(UIViewContentMode sender, CGFloat spacing))    wl_button_layout;
@end
