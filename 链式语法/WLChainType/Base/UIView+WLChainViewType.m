//
//  UIView+WLChainType.m
//  链式语法
//
//  Created by 王亮 on 2018/8/13.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import "UIView+WLChainViewType.h"
#import <objc/runtime.h>

static char kActionHandlerTapGestureKey;
static char kActionHandlerLongPressGestureKey;


@implementation UIView (WLChainViewType)
/** 初始化 */
+ (UIView *(^)(void)) wl_init{
    return ^id (){
        return [[self.class alloc] init];
    };
}
/** 大小 */
- (UIView *(^)(CGRect sender)) wl_size{
    return ^id (CGRect sender){
        self.frame = sender;
        return self;
    };
}
/** 背景颜色 */
- (UIView *(^)(UIColor *sender)) wl_backgroundColor{
    return ^id (UIColor *sender){
        [self setBackgroundColor:sender];
        return self;
    };
}
/** 添加圆边 */
- (UIView *(^)(CGFloat cornerRadius)) wl_cornerRound{
    return ^id (CGFloat cornerRadius){
        self.layer.cornerRadius = cornerRadius;
        self.clipsToBounds = YES;
        return self;
    };
}
/** 添加边框 */
- (UIView *(^)(CGFloat borderWidth)) wl_borderWidth{
    return ^id (CGFloat borderWidth){
        self.layer.borderWidth = borderWidth;
        return self;
    };
}
/** 添加边框色 */
- (UIView *(^)(UIColor *borderColor)) wl_borderColor{
    return ^id (UIColor *borderColor){
        self.layer.borderColor = [borderColor CGColor];
        return self;
    };
}

/** 添加tap手势 */
- (UIView *(^)(id sf,SEL sel)) wl_addTap{
    return ^id(id sf,SEL sel){
        UITapGestureRecognizer *gesture = objc_getAssociatedObject(sf, &kActionHandlerTapGestureKey);
        if (!gesture){
            gesture = [[UITapGestureRecognizer alloc] initWithTarget:sf action:sel];
            self.userInteractionEnabled = YES;
            [self addGestureRecognizer:gesture];
            objc_setAssociatedObject(sf, &kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
        }
        return self;
    };
}
/** 添加长按手势 */
- (UIView *(^)(id sf,SEL sel)) wl_addLongPress{
    return ^id(id sf,SEL sel){
        UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(sf, &kActionHandlerLongPressGestureKey);
        if (!gesture){
            gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:sf action:sel];
            self.userInteractionEnabled = YES;
            [self addGestureRecognizer:gesture];
            objc_setAssociatedObject(sf, &kActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
        }
        return self;
    };
}
/** 结束 */
- (id)wl_end{
    return self;
}
@end
