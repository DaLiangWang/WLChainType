//
//  UIView+WLChainImageViewType.h
//  链式语法
//
//  Created by 王亮 on 2018/8/14.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WLChainImageViewType)
/** 图片 */
- (UIImageView *(^)(UIImage *img))              wl_imageView_image;
/** 图片布局 */
- (UIImageView *(^)(UIViewContentMode mode))    wl_imageView_contentMode;
/** 图片加载 */
- (UIImageView *(^)(NSString *imageUrl ,UIImage *defaultImage))        wl_imageView_imageUrl;
@end
