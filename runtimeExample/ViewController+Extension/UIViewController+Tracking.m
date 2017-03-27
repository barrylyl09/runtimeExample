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
        
        SEL originSel = @selector(viewWillAppear:);
        SEL newSel    = @selector(unKnown_viewWillAppear:);
        
        Method originMethod = class_getInstanceMethod(class, originSel);
        Method newMethod    = class_getInstanceMethod(class, newSel);
        
        method_exchangeImplementations(originMethod, newMethod);
        
        
        /* 更为安全
         
        BOOL didAddMethod =
        class_addMethod(class,
                        originSel,
                        method_getImplementation(newMethod),
                        method_getTypeEncoding(newMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                newSel,
                                method_getImplementation(originMethod),
                                method_getTypeEncoding(originMethod));
        } else {
            method_exchangeImplementations(originMethod, newMethod);
        }
        */

        
    });
}

- (void)unKnown_viewWillAppear:(BOOL)animated {
    
    NSLog(@"\n\n----当前出现控制器类名: %@ ----- \n\n", NSStringFromClass([self class]));
    [self unKnown_viewWillAppear:animated];
}

@end
