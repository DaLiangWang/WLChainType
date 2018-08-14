//
//  CalculatorTools.h
//  链式语法
//
//  Created by 王亮 on 2018/8/13.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CalculatorTools;

typedef CalculatorTools *(^toolsBlock)(NSInteger sender);

@interface CalculatorTools : NSObject

// 计算结果
@property (nonatomic, assign) NSInteger result;
@property (nonatomic, copy) toolsBlock block;

// 加法
- (toolsBlock) add;
// 减法
- (toolsBlock) minus;
// 乘法
- (toolsBlock) multiply;
// 除法
- (toolsBlock) divide;

@end
