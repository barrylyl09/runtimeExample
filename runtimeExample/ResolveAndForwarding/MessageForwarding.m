//
//  MessageForwarding.m
//  runtimeExample
//
//  Created by lyl on 2017/2/20.
//  Copyright © 2017年 lyl. All rights reserved.
//

#import "MessageForwarding.h"

@implementation MessageForwarding

- (NSString *)sendMessage:(NSString *)word
{
    return [NSString stringWithFormat:@"fast forwarding way : send message = %@", word];
}

@end
