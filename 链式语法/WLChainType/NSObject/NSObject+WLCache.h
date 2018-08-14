//
//  NSObject+WLCache.h
//  xiacai
//
//  Created by 王亮 on 2017/12/27.
//  Copyright © 2017年 TBS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define save_wl_Keys(tag,key) [NSString stringWithFormat:@"%@%@",tag,key]

typedef enum : NSUInteger {
    imageData_wl,
    jsonData_wl,
} dataType_wl;
/** 缓存类型 */
typedef enum : NSUInteger {
    toDay_wl,
    otherDay_wl,
    noCache_wl,
} cacheType_wl;

@interface NSObject (WLCache)




/** 读取数据 */
+ (id)readKey_wl:(NSString *)keys
        dataType:(dataType_wl)type;
/** 获取缓存 返回数据日期 */
+ (void)readKey_wl:(NSString *)keys
          dataType:(dataType_wl)type
             block:(void(^)(cacheType_wl timeTyep,id data,NSDate *date))block;
/** 缓存数据 */
+ (BOOL)saveData_wl:(id)saveData
                key:(NSString *)keys
           dataType:(dataType_wl)type;

/** 清除 */
+ (BOOL)clearAllCache_wl;
@end
