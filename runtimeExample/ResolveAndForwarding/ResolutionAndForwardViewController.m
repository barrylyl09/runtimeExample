//
//  ResolutionAndForwardViewController.m
//  runtimeExample
//
//  Created by lyl on 2017/2/20.
//  Copyright © 2017年 lyl. All rights reserved.
//

/*
 方法调用：（object-c方法具体调用逻辑）
 如果用实例对象调用实例方法，会到实例的isa指针指向的对象（也就是类对象）操作。
 如果调用的是类方法，就会到类对象的isa指针指向的对象（也就是元类对象）中操作。
 
 首先，在相应操作的对象中的缓存方法列表中找调用的方法，如果找到，转向相应实现并执行。
 如果没找到，在相应操作的对象中的方法列表中找调用的方法，如果找到，转向相应实现执行
 如果没找到，去父类指针所指向的对象中执行1，2.
 以此类推，如果一直到根类还没找到，转向拦截调用。
 如果没有重写拦截调用的方法，程序报错。
 
 重写父类的方法，并没有覆盖掉父类的方法，只是在当前类对象中找到了这个方法后就不会再去父类中找了。
 如果想调用已经重写过的方法的父类的实现，只需使用super这个编译器标识，它会在运行时跳过在当前的类对象中寻找方法的过程。
 
 */


#import "ResolutionAndForwardViewController.h"
#import "message.h"

@interface ResolutionAndForwardViewController ()
@property (nonatomic, strong) UILabel *noticeLabel;
@end

@implementation ResolutionAndForwardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super configShowHeaderBarOrNot:YES andLeftBtnShow:YES andRightBtnShow:NO andTitle:@"动态方法解析和消息处理"];
    [super setLeftBtnBgNormal:nil andHighlight:nil andTitle:@"Back"];
    
    [self selectBtnForWhichVC:@"ResolveAndForwardVC"];
    
    _noticeLabel = [self creatLabel];
    
    message * content = [[message alloc] init];
    _noticeLabel.text = [content sendMessage:@"newWord"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
