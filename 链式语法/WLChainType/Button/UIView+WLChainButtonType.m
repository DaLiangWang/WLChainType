//
//  UIView+WLChainButtonType.m
//  链式语法
//
//  Created by 王亮 on 2018/8/13.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import "UIView+WLChainButtonType.h"

@implementation UIView (WLChainButtonType)

/** 文字 */
- (UIButton *(^)(NSString *sender,UIControlState state)) wl_button_title{
    return ^id (NSString *sender,UIControlState state){
        if ([self isKindOfClass:UIButton.class]) {
            [(UIButton *)self setTitle:sender forState:state];
        }
        return self;
    };
}
/** 图片 */
- (UIButton *(^)(UIImage *sender,UIControlState state)) wl_button_image{
    return ^id (UIImage *sender,UIControlState state){
        if ([self isKindOfClass:UIButton.class]) {
            [(UIButton *)self setImage:sender forState:state];
        }
        return self;
    };
}
/** 背景图片 */
- (UIButton *(^)(UIImage *sender,UIControlState state)) wl_button_backgroundImage{
    return ^id (UIImage *sender,UIControlState state){
        if ([self isKindOfClass:UIButton.class]) {
            [(UIButton *)self setBackgroundImage:sender forState:state];
        }
        return self;
    };
}
/** 添加点击 */
- (UIButton *(^)(id sf,SEL sel,UIControlEvents event)) wl_button_addTarget{
    return ^id (id sf,SEL sel,UIControlEvents event){
        if ([self isKindOfClass:UIButton.class]) {
            [(UIButton *)self addTarget:sf action:sel forControlEvents:event];
        }
        return self;
    };
}
/** 文字大小 */
- (UIButton *(^)(NSInteger sender,UIFontWeight weight)) wl_button_textSize{
    return ^id (NSInteger sender,UIFontWeight weight){
        if ([self isKindOfClass:UIButton.class]) {
            [(UIButton *)self titleLabel].font = [UIFont systemFontOfSize:sender weight:weight];
        }
        else if ([self isKindOfClass:UILabel.class]) {
            [(UILabel *)self setFont:[UIFont systemFontOfSize:sender weight:weight]];
        }
        return self;
    };
}
/** 布局 */
- (UIButton *(^)(UIViewContentMode sender,CGFloat spacing)) wl_button_layout{
    return ^id (UIViewContentMode sender,CGFloat spacing){
        if ([self isKindOfClass:WLButton.class]) {
            [(WLButton *)self setWl_contentMode:sender];
            [(WLButton *)self setWl_spacing:spacing];
        }
        else{
            NSLog(@"WLButton");
        }
        return self;
    };
}
@end
