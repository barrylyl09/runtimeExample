//
//  Person+personCategory.h
//  runtimeExample
//
//  Created by lyl on 2017/2/20.
//  Copyright © 2017年 lyl. All rights reserved.
//

#import "Person.h"

@interface Person (personCategory)

@property (nonatomic, copy) NSString *gender;

-(void)setGender:(NSString *)gender;

-(NSString *)getGender;

@end
