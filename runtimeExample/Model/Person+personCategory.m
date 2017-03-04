//
//  Person+personCategory.m
//  runtimeExample
//
//  Created by lyl on 2017/2/20.
//  Copyright © 2017年 lyl. All rights reserved.
//

#import "Person+personCategory.h"
#import <objc/runtime.h>

/*
 runtime使用对象关联的方法添加新的属性；
 */

const char * str = "genderKey"; //作为key，字符串常量 必须是c语言字符串；

@implementation Person (personCategory)

@dynamic gender;

- (void)setGender:(NSString *)gender
{
    /*
     第一个参数是需要添加属性的对象；
     第二个参数是属性的key；
     第三个参数是属性的值；
     第四个参数是使用的策略；
     */
    objc_setAssociatedObject(self, str, gender, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (NSString *)getGender
{
//    NSString * genderStr = objc_getAssociatedObject(self, str);
//    NSLog(@"%@",genderStr);
    return objc_getAssociatedObject(self, str);
}

@end
