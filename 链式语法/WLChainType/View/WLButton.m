//
//  WLButton.m
//  链式语法
//
//  Created by 王亮 on 2018/8/13.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import "WLButton.h"

@implementation WLButton

-(void)layoutSubviews{
    [super layoutSubviews];

    if (self.imageView.image &&
        (self.wl_contentMode != UIViewContentModeTop ||
         self.wl_contentMode != UIViewContentModeBottom ||
         self.wl_contentMode != UIViewContentModeRight ||
         self.wl_contentMode != UIViewContentModeLeft)) {
        CGFloat maxW = self.frame.size.width;
        CGFloat maxH = self.frame.size.height;
        
//        CGFloat maxTitleW = self.titleLabel.frame.size.width;
        CGFloat maxTitleH = self.titleLabel.frame.size.height;
        
        CGFloat maxImageW = self.imageView.frame.size.width;
        CGFloat maxImageH = self.imageView.frame.size.height;
        
        CGFloat midX = maxW / 2;
        CGFloat midY = maxH / 2;
        
        if (self.wl_contentMode == UIViewContentModeTop) {
            self.titleLabel.center = CGPointMake(midX, midY + maxImageH/2-(self.wl_spacing/2));
            self.imageView.center = CGPointMake(midX, midY - maxTitleH/2+(self.wl_spacing/2));
        }
        if (self.wl_contentMode == UIViewContentModeBottom) {
            self.imageView.center = CGPointMake(midX, midY + maxTitleH/2+(self.wl_spacing/2));
            self.titleLabel.center = CGPointMake(midX, midY - maxImageH/2-(self.wl_spacing/2));
        }
        if (self.wl_contentMode == UIViewContentModeRight) {
            self.titleLabel.center = CGPointMake(midX - maxImageW/2 - (self.wl_spacing/2), midY);
            self.imageView.center = CGPointMake(CGRectGetMaxX(self.titleLabel.frame) + maxImageW/2 + (self.wl_spacing/2), midY);
        }
        if (self.wl_contentMode == UIViewContentModeLeft) {
            self.titleLabel.center = CGPointMake(self.titleLabel.center.x + (self.wl_spacing/2), midY);
            self.imageView.center = CGPointMake(self.imageView.center.x - (self.wl_spacing/2), midY);
        }
    }
    
}

@end
