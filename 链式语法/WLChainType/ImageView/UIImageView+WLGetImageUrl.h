//
//  UIImageView+WLGetImageUrl.h
//  链式语法
//
//  Created by 王亮 on 2018/8/14.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WLGetImageUrl)
-(void)wl_getImageUrl:(NSString *)imageUrl;
-(void)wl_getImageUrl:(NSString *)imageUrl defaultImage:(UIImage *)image;
@end
