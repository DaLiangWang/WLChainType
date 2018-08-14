//
//  UILabel+WLChainType.h
//  链式语法
//
//  Created by 王亮 on 2018/8/13.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WLChainLabelType)
/** 文字 */
- (UILabel *(^)(NSString *sender))                          wl_label_title;
/** 文字大小 */
- (UILabel *(^)(NSInteger sender , UIFontWeight weight))    wl_label_textSize;
/** 文字布局 */
- (UILabel *(^)(NSTextAlignment sender ))                   wl_label_alignment;



/** 倒计时设置时间 */
- (UILabel *(^)(NSInteger timeOut))                         wl_label_countDown_time;
/** 倒计时设置倒计时结束文字 */
- (UILabel *(^)(NSString *endTitle))                        wl_label_countDown_endTitle;
/** 倒计时中文字 */
- (UILabel *(^)(NSString *waitTittle))                      wl_label_countDown_waitTittle;
/** 倒计时开始 */
- (UILabel *(^)(id sf ,SEL sel))                            wl_label_countDown_begin;
@end
