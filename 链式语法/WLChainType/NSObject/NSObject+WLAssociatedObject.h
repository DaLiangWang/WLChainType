//
//  NSObject+WLAssociatedObject.h
//  链式语法
//
//  Created by 王亮 on 2018/8/14.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (WLAssociatedObject)



/** 将Stong对象附加到另一个对象上 */
- (id (^)(id sf,const void *key))  wl_addStongToObject;
/** 将weak对象附加到另一个对象上 */
- (id (^)(id sf,const void *key))  wl_addWeakToObject;

/** 根据附加对象的key取出附加对象 */
- (id (^)(const void *key))  wl_getValue;
/** 根据附加对象的key取出附加对象 */
- (void (^)(void))  wl_removeValue;

@end
