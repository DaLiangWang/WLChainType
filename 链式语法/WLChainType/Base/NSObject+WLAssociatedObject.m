//
//  NSObject+WLAssociatedObject.m
//  链式语法
//
//  Created by 王亮 on 2018/8/14.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import "NSObject+WLAssociatedObject.h"
#import  <objc/runtime.h>

@implementation NSObject (WLAssociatedObject)

/** 附加一个stong对象 */
- (id (^)(id sf,const void *key)) wl_addStongObject{
    return ^id (id sf,const void *key) {
        objc_setAssociatedObject(sf, key, self, OBJC_ASSOCIATION_RETAIN);
        return self;
    };
}
/** 附加一个weak对象 */
- (id (^)(id sf,const void *key)) wl_addWeakObject{
    return ^id (id sf,const void *key){
        objc_setAssociatedObject(sf, key, self, OBJC_ASSOCIATION_ASSIGN);
        return self;
    };
}
/** 根据附加对象的key取出附加对象 */
- (id (^)(const void *key)) wl_getValue{
    return ^id (const void *key){
        id obj = objc_getAssociatedObject(self, key);
        NSAssert(obj, @"没有获取到绑定的对象");
        return obj;
    };
}
/** 根据附加对象的key取出附加对象 */
- (void (^)(void)) wl_removeValue{
    return ^ (){
        objc_removeAssociatedObjects(self);
    };
}
@end
