//
//  UIViewController+Tracking.m
//  runtimeExample
//
//  Created by lyl on 2017/3/27.
//  Copyright © 2017年 lyl. All rights reserved.
//

#import "UIViewController+Tracking.h"
#import <objc/runtime.h>

@implementation UIViewController (Tracking)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class = [self class];
    
        SEL originalSel = @selector(viewWillAppear:);
        SEL newSel      = @selector(unKnown_viewWillAppear:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSel);
        Method newMethod      = class_getInstanceMethod(class, newSel);
        
        BOOL addMethod = class_addMethod(class,
                                         originalSel,
                                         method_getImplementation(newMethod),
                                         method_getTypeEncoding(newMethod));
        
        if (addMethod) {
            class_replaceMethod(class,
                                newSel,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        }else {
            method_exchangeImplementations(originalMethod, newMethod);
        }
        
    });
    
}

- (void)unKnown_viewWillAppear:(BOOL)animated {
    
    NSLog(@"\n\n----当前出现控制器类名: %@ ----- \n\n", NSStringFromClass([self class]));
    [self unKnown_viewWillAppear:animated];
}

@end
