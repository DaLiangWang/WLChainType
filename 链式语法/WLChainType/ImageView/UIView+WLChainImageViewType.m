//
//  UIView+WLChainImageViewType.m
//  链式语法
//
//  Created by 王亮 on 2018/8/14.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import "UIView+WLChainImageViewType.h"
#import "UIImageView+WLGetImageUrl.h"

@implementation UIView (WLChainImageViewType)
/** 图片 */
- (UIImageView *(^)(UIImage *img)) wl_imageView_image{
    return ^id (UIImage *img){
        if ([self isKindOfClass:UIImageView.class]) {
            [(UIImageView *)self setImage:img];
        }
        return self;
    };
}
/** 图片布局 */
- (UIImageView *(^)(UIViewContentMode mode)) wl_imageView_contentMode{
    return ^id (UIViewContentMode mode){
        if ([self isKindOfClass:UIImageView.class]) {
            [(UIImageView *)self setContentMode:mode];
        }
        return self;
    };
}
/** 图片加载 */
- (UIImageView *(^)(NSString *imageUrl)) wl_imageView_imageUrl{
    return ^id (NSString *imageUrl){
        if ([self isKindOfClass:UIImageView.class]) {
            [(UIImageView *)self wl_getImageUrl:imageUrl];
        }
        return self;
    };
}
@end
