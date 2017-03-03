//
//  Person.m
//  runtimeExample
//
//  Created by lyl on 2017/2/20.
//  Copyright © 2017年 lyl. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person
{
    NSString * introduction;
}

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        introduction = @"Humorous man";
    }
    
    return self;
}

#pragma mark --- 实现归档操作
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int count = 0;
    Ivar  * ivars = class_copyIvarList([Person class], &count);
    
    for (int i =0; i< count; i++) {
        
        //取出i位置对应的成员变量
        Ivar ivar = ivars[i];
        
        //查看成员变量
        const char * name = ivar_getName(ivar);
        
        //归档
        NSString * key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
        
    }
    
    free(ivars);
}

#pragma mark --- 实现解档操作
-(id)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self = [super init]) {
        unsigned int count = 0 ;
        Ivar * ivars = class_copyIvarList([Person class], &count);
        
        for (int i = 0; i < count; i++) {
            
            //取出对应位置的成员变量
            Ivar ivar = ivars[i];
            
            //查看成员变量
            const char * name = ivar_getName(ivar);
            
            //解档
            NSString * key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            
            //设置到成员变量上
            [self setValue:value forKey:key];
            
        }
    }
    
    return self;
}



-(NSString *)func1
{
    return @"执行fun1方法";
}

-(NSString *)func2
{
    return @"执行fun2方法";
}

@end
