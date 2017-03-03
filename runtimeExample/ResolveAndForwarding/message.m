//
//  message.m
//  runtimeExample
//
//  Created by lyl on 2017/2/20.
//  Copyright © 2017年 lyl. All rights reserved.
//

#import "message.h"
#import "MessageForwarding.h"
#import <objc/runtime.h>

@implementation message

#pragma mark --- 普通的函数实现
// -(NSString *)sendMessage:(NSString *)word
// {
// return [NSString stringWithFormat:@"normal way : send message : %@",word];
// 
// }

#pragma mark --- 拦截调用就是，在找不到调用的方法程序崩溃之前，你有机会通过重写NSObject的以下方法来实现

#pragma mark --- Method Resolution
/*
 + (BOOL)resolveClassMethod:(SEL)sel;
 + (BOOL)resolveInstanceMethod:(SEL)sel;
 当你调用一个不存在的类方法/实例方法的时候，会调用这个方法，默认返回NO，你可以加上自己的处理(可以动态添加方法)然后返回YES。
 由于Method Resolution不能像消息转发那样可以交给其他对象来处理，所以只适用于在原来的类中代替掉。
 */

/*
 +(BOOL)resolveInstanceMethod:(SEL)sel
 {
 if (sel == @selector(sendMessage:)) {
 
 //动态添加方法方式一
 class_addMethod([self class], sel, imp_implementationWithBlock(^(id self,NSString * word){
 return [NSString stringWithFormat:@"method resolution way : send message : %@",word];
 }), "v@*");
 //动态添加方法方式二
 //class_addMethod([self class], sel, (IMP)runAddMethod, "v@*");
 }
 
 return YES;
 }
 
 //被添加的方法
 NSString * runAddMethod(id self, SEL _cmd, NSString *word){
 return [NSString stringWithFormat:@"method resolution second way : send message : %@",word];
 }
 */

#pragma mark --- Fast Forwarding
/*
 - (id)forwardingTargetForSelector:(SEL)aSelector;
 这个方法是将你调用的不存在的方法重定向到一个其他声明了这个方法的类，只需要你返回一个有这个方法的target。
 Fast Forwarding可以将消息处理转发给其他对象，使用范围更广，不只是限于原来的对象。
 */
/*
 -(id)forwardingTargetForSelector:(SEL)aSelector
 {
 if (aSelector == @selector(sendMessage:)) {
 return [MessageForwarding new];
 }
 
 return nil;
 }
 */

#pragma mark --- Normal forwarding
/*
 - (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
 - (void)forwardInvocation:(NSInvocation *)anInvocation;
 Normal forwarding首先调用methodSignatureForSelector:方法来获取函数的参数和返回值，如果返回为nil，程序会Crash掉，并抛出unrecognized selector sent to instance异常信息。如果返回一个函数签名，系统就会创建一个NSInvocation对象并调用-forwardInvocation:方法。
 Normal forwarding 能通过NSInvocation对象获取更多消息发送的信息，例如：target、selector、arguments和返回值等信息。
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *methodSignature = [super methodSignatureForSelector:aSelector];
    
    if (!methodSignature) {
        methodSignature = [NSMethodSignature signatureWithObjCTypes:"v@:*"];
    }
    
    return methodSignature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    MessageForwarding *messageForwarding = [MessageForwarding new];
    
    if ([messageForwarding respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:messageForwarding];
    }
}


@end
