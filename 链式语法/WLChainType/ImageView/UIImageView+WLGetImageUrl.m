//
//  UIImageView+WLGetImageUrl.m
//  链式语法
//
//  Created by 王亮 on 2018/8/14.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import "UIImageView+WLGetImageUrl.h"
#import "NSObject+WLCache.h"

#define wl_defaultImage @"beauty_no_paly_type"

@implementation UIImageView (WLGetImageUrl)
-(void)wl_getImageUrl:(NSString *)imageUrl{
    [self wl_getImageUrl:imageUrl defaultImage:[UIImage imageNamed:wl_defaultImage]];
}
-(void)wl_getImageUrl:(NSString *)imageUrl defaultImage:(UIImage *)image{
    UIImage *img = [NSObject readKey_wl:imageUrl dataType:imageData_wl];
    if (img) {
        self.image = img;
    } else{
        self.image = image;
    }
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock: ^{
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        [NSObject saveData_wl:imgData key:imageUrl dataType:imageData_wl];
        UIImage *image = [UIImage imageWithData:imgData];
        [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
            self.image = image;
        }];
    }];
}

@end
