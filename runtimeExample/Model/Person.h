//
//  Person.h
//  runtimeExample
//
//  Created by lyl on 2017/2/20.
//  Copyright © 2017年 lyl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSCoding>

@property (nonatomic, copy)   NSString *name;
@property (nonatomic, copy)   NSString *phone;
@property (nonatomic, assign) NSInteger age;

-(NSString *)func1;
-(NSString *)func2;

@end
