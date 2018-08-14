//
//  NSObject+WLCache.m
//  xiacai
//
//  Created by 王亮 on 2017/12/27.
//  Copyright © 2017年 TBS. All rights reserved.
//

#import "NSObject+WLCache.h"
#import <CommonCrypto/CommonDigest.h>

#define wl_app_version [[UIDevice currentDevice] systemVersion]

@implementation NSObject (WLCache)
/** 读取数据 */
+ (id)readKey_wl:(NSString *)keys
        dataType:(dataType_wl)type{
//    //获取存档的版本号
//    NSString *name= [[NSUserDefaults standardUserDefaults] objectForKey:@"readKey_wl"];
//    //对比版本号 遇到新版本则清空缓存数据
//    if (![name isEqualToString:wl_app_version]){
//        [self clearAllCache_wl];
//        //更新版本号
//        [[NSUserDefaults standardUserDefaults] setObject:wl_app_version forKey:@"readKey_wl"];
//    }
    id cacheData = nil;
    NSString *key = [self md5_string:keys];
    if (!keys) {return nil;}
    /** 获取缓存目录 */
    NSString *directoryPath = cacheTypePath(type);
    /** 拼接文件路径 */
    NSString *path = [directoryPath stringByAppendingPathComponent:key];
    /** 创建 文件管理 */
    NSFileManager *fileManager = [NSFileManager defaultManager];
    /** 读取文件 数据 */
    NSData *data = [fileManager contentsAtPath:path];
    if (data) {
        cacheData = data;
        NSLog(@"读取缓存数据%@",path);
        switch (type) {
            case imageData_wl:
                return [UIImage imageWithData:cacheData];
                break;
            case jsonData_wl:
                return [NSJSONSerialization JSONObjectWithData:cacheData options:NSJSONReadingMutableLeaves error:nil];
                break;
            default:
                break;
        }
    }
    return nil;
}
/** 获取缓存 返回数据日期 */
+ (void)readKey_wl:(NSString *)keys
          dataType:(dataType_wl)type
             block:(void(^)(cacheType_wl timeTyep,id data,NSDate *date))block{
    NSString *key = [self md5_string:keys];
    if (!keys) {return;}
    /** 获取缓存目录 */
    NSString *directoryPath = cacheTypePath(type);
    /** 拼接文件路径 */
    NSString *path = [directoryPath stringByAppendingPathComponent:key];
    /** 创建 文件管理 */
    NSFileManager *fileManager = [NSFileManager defaultManager];
    /** 读取文件信息 */
    NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:path error:nil];
    /** 获取文件修改日期 */
    NSDate *fileModDate = [fileAttributes objectForKey:NSFileModificationDate];
    
    if (fileModDate) {
        if ([self isSameDay:fileModDate]) {//今天的缓存
            NSLog(@"今天");
            if (block) {
                block(toDay_wl,[self readKey_wl:keys dataType:type],fileModDate);
            }
        } else{//其他日期的缓存
            NSLog(@"不是今天");
            if (block) {
                block(otherDay_wl,[self readKey_wl:keys dataType:type],fileModDate);
            }
        }
    }
    else{
        NSLog(@"没有缓存");
        if (block) {
            block(noCache_wl,[self readKey_wl:keys dataType:type],fileModDate);
        }
    }
}
/** 缓存数据 */
+ (BOOL)saveData_wl:(id)saveData
                key:(NSString *)keys
           dataType:(dataType_wl)type{
//    判断是否有标示
    if (!keys) {NSLog(@"没有文件标示"); return NO;}
//    判断数据是否为空
    if (!saveData) {NSLog(@"没有缓存文件"); return NO;}
//    判断数据是否为空对象
    if ([saveData isKindOfClass:[NSNull class]]) {NSLog(@"缓存文件为空对象"); return NO;}
//    获取目录路径
    NSString *directoryPath = cacheTypePath(type);
    if (![[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:nil]) {
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:&error];
        if (error) {NSLog(@"创建缓存目录错误：%@",error); return NO;}
    }
//    获取缓存文件名
    NSString *key = [self md5_string:keys];
//    拼接文件完整路径
    NSString *path = [directoryPath stringByAppendingPathComponent:key];
//    创建空数据 开始处理数据
    NSData *data = nil;
//    基本区分数据
    switch (type) {
        case imageData_wl://图片数据
            if ([saveData isKindOfClass:[NSData class]]) {
                data = saveData;
            } else {
                data = UIImagePNGRepresentation(saveData);;
            }
            break;
        case jsonData_wl://json数据
            if ([saveData isKindOfClass:[NSData class]]) {
                data = saveData;
            } else {
                data = [self objToData:saveData];
            }
            break;
        default://默认数据 data 格式
            if ([saveData isKindOfClass:[NSData class]]) {
                data = data;
            }
            else{
                NSLog(@"请传入data数据！");
            }
            break;
    }
//    判断数据是否为空
    if (!data) {NSLog(@"缓存文件格式错误！"); return NO;}
//    保存数据
    BOOL isOk = [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
    if (isOk) {
        NSLog(@"保存成功");
        return YES;
    } else {
        NSLog(@"保存失败");
        return NO;
    }
    return NO;
}

/** 清除 */
+ (BOOL)clearAllCache_wl{
    NSString *directoryPath = cachePath();
    return [[NSFileManager defaultManager] removeItemAtPath:directoryPath error:nil];
}


















/** 对象转数据 */
-(NSData *)objToData:(id)dic{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        return nil;
    }
    return jsonData;
}
/** 基础路径 */
static inline NSString *cachePath() {
    return [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Library/Caches/%@",@"WLCache"]];
}
/** 缓存路径 */
static inline NSString *cacheTypePath(dataType_wl type) {
    NSString *path = cachePath();
    switch (type) {
        case imageData_wl:
            [path stringByAppendingPathComponent:@"image"];
            break;
        case jsonData_wl:
            [path stringByAppendingPathComponent:@"json"];
            break;
        default:
            [path stringByAppendingPathComponent:@"other"];
            break;
    }
    return path;
}
/** 是否为当天日期 */
- (BOOL)isSameDay:(NSDate *)anotherDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:[NSDate new]];
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:anotherDate];
    return ([components1 year] == [components2 year]
            && [components1 month] == [components2 month]
            && [components1 day] == [components2 day]);
}
/** md5加密 */
- (NSString *)md5_string:(NSString *)string{
    //    NSString *string = [self copy];
    if (string == nil || [string length] == 0) {
        return nil;
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([string UTF8String], (int)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }
    return [ms copy];
}
@end

