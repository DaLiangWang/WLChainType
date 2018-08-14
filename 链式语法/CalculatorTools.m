//
//  CalculatorTools.m
//  链式语法
//
//  Created by 王亮 on 2018/8/13.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import "CalculatorTools.h"

@implementation CalculatorTools
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.result = 0;
        
    }
    return self;
}

- (toolsBlock) add
{
    return ^id(NSInteger num){
        self.result += num;
        NSLog(@"加%ld等于%ld",(long)num,(long)self.result);
        return self;
    };
}

- (toolsBlock) minus
{
    return ^id(NSInteger num){
        self.result -= num;
        NSLog(@"减%ld等于%ld",(long)num,(long)self.result);
        return self;
    };
}

- (toolsBlock) multiply
{
    return ^id(NSInteger num){
        self.result *= num;
        NSLog(@"乘%ld等于%ld",(long)num,(long)self.result);
        return self;
    };
}

- (toolsBlock) divide
{
    return ^id(NSInteger num){
        // 使用断言NSAssert()调试程序错误
        NSAssert(num != 0, @"除数不能为零");
        self.result /= num;
        NSLog(@"除%ld等于%ld",(long)num,(long)self.result);
        return self;
    };
}

@end
