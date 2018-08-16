//
//  UIView+WLChainType.h
//  链式语法
//
//  Created by 王亮 on 2018/8/13.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WLChainViewType)
/** 初始化 */
+ (UIView *(^)(void))                   wl_init;

/** 大小 */
- (UIView *(^)(CGRect sender))          wl_size;
/** 背景颜色 */
- (UIView *(^)(UIColor *sender))        wl_backgroundColor;

/** 添加圆边 */
- (UIView *(^)(CGFloat cornerRadius))   wl_cornerRound;
/** 添加边框 */
- (UIView *(^)(CGFloat borderWidth))    wl_borderWidth;
/** 添加边框色 */
- (UIView *(^)(UIColor *borderColor))   wl_borderColor;


/** 添加tap手势 */
- (UIView *(^)(id sf ,SEL sel))         wl_addTap;
/** 添加长按手势 */
- (UIView *(^)(id sf ,SEL sel))         wl_addLongPress;

/** 结束 */
- (id)wl_end;
@end
