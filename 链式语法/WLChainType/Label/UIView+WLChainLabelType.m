//
//  UILabel+WLChainType.m
//  链式语法
//
//  Created by 王亮 on 2018/8/13.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import "UIView+WLChainLabelType.h"
#import <objc/runtime.h>

static char label_countDown_time;
static char label_countDown_endTitle;
static char label_countDown_waitTittle;

@implementation UIView (WLChainLabelType)
/** 文字 */
- (UILabel *(^)(NSString *sender)) wl_label_title{
    return ^id (NSString *sender){
        if ([self isKindOfClass:UILabel.class]) {
            [(UILabel *)self setText:sender];
        }
        return self;
    };
}
/** 文字大小 */
- (UILabel *(^)(NSInteger sender,UIFontWeight weight)) wl_label_textSize{
    return ^id (NSInteger sender,UIFontWeight weight){
        if ([self isKindOfClass:UILabel.class]) {
            [(UILabel *)self setFont:[UIFont systemFontOfSize:sender weight:weight]];
        }
        return self;
    };
}
/** 文字 布局 */
- (UILabel *(^)(NSTextAlignment sender )) wl_label_alignment{
    return ^id (NSTextAlignment sender){
        if ([self isKindOfClass:UILabel.class]) {
            [(UILabel *)self setTextAlignment:sender];
        }
        return self;
    };
}




/** 倒计时设置时间 */
- (UILabel *(^)(NSInteger timeOut)) wl_label_countDown_time{
    return ^id (NSInteger timeOut){
        if ([self isKindOfClass:UILabel.class]) {
            objc_setAssociatedObject(self, &label_countDown_time, @(timeOut), OBJC_ASSOCIATION_RETAIN);
        }
        return self;
    };
}
/** 倒计时设置倒计时结束文字 */
- (UILabel *(^)(NSString *endTitle)) wl_label_countDown_endTitle{
    return ^id (NSString *endTitle){
        if ([self isKindOfClass:UILabel.class]) {
            objc_setAssociatedObject(self, &label_countDown_endTitle, endTitle, OBJC_ASSOCIATION_RETAIN);
        }
        return self;
    };
}
/** 倒计时中文字 */
- (UILabel *(^)(NSString *waitTittle)) wl_label_countDown_waitTittle{
    return ^id (NSString *waitTittle){
        if ([self isKindOfClass:UILabel.class]) {
            objc_setAssociatedObject(self, &label_countDown_waitTittle, waitTittle, OBJC_ASSOCIATION_RETAIN);
        }
        return self;
    };
}
/** 倒计时开始 */
- (UILabel *(^)(id sf ,SEL sel)) wl_label_countDown_begin{
    return ^id (id sf ,SEL sel){
        if ([self isKindOfClass:UILabel.class]) {
            /** 倒计时时间 */
            __block NSInteger timeOut = [objc_getAssociatedObject(self, &label_countDown_time) integerValue];
            /** 结束文字 */
            NSString *titleEnd = objc_getAssociatedObject(self, &label_countDown_endTitle);
            __block NSString *endTitle = titleEnd?titleEnd:[(UILabel *)self text];
            /** 计时中文字 */
            NSString *titleWait = objc_getAssociatedObject(self, &label_countDown_waitTittle);
            __block NSString *waitTittle = titleWait?titleWait:@"s";
            
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeOut<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮显示 根据自己需求设置
                        [(UILabel *)self setNumberOfLines:2];
                        [(UILabel *)self setText:endTitle];
                        self.userInteractionEnabled = YES;
                        if (sf && sel) {
                            [sf performSelector:sel withObject:@(0)];
                        }
                    });
                }else{
                    int seconds = (int)timeOut;
                    NSString *strTime = [NSString stringWithFormat:@"%d", seconds];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮显示 根据自己需求设置
                        NSLog(@"____%@",strTime);
                        [(UILabel *)self setNumberOfLines:2];
                        [(UILabel *)self setText:[NSString stringWithFormat:@"%@%@",strTime,waitTittle]];
                        self.userInteractionEnabled = NO;
                    });
                    timeOut--;
                }
            });
            dispatch_resume(_timer);
            if (sf && sel) {
                [sf performSelector:sel withObject:@(1)];
            }
        }
        return self;
    };
}


@end
