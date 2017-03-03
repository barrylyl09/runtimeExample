//
//  OtherFeatureViewController.m
//  runtimeExample
//
//  Created by lyl on 2017/2/20.
//  Copyright © 2017年 lyl. All rights reserved.
//

#import "OtherFeatureViewController.h"
#import "Person.h"
#import "Person+personCategory.h"
#import <objc/runtime.h>

@interface OtherFeatureViewController ()

@property (nonatomic, strong) UILabel *noticeLabel;

@end

@implementation OtherFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super configShowHeaderBarOrNot:YES andLeftBtnShow:YES andRightBtnShow:NO andTitle:@"Runtime其他功能"];
    [super setLeftBtnBgNormal:nil andHighlight:nil andTitle:@"Back"];
    
    [self selectBtnForWhichVC:@"otherFeatureVC"];
    _noticeLabel = [self creatLabel];
}


#pragma mark --- 改变 person 的 introduction成员变量
- (void)changeVariable {
    
    Person * person = [[Person alloc] init];
    
    unsigned int count = 0;
    Ivar * allList = class_copyIvarList([Person class], &count);
    
    Ivar introductionIvar = allList[0];
    
    NSString * oldValue = object_getIvar(person, introductionIvar);
    
    NSLog(@"%@",oldValue);
    
    //设置私有变量的值
    object_setIvar(person, introductionIvar, @"Isn't a serious man");
    
    NSString * newValue = object_getIvar(person, introductionIvar);
    
    _noticeLabel.text = [NSString stringWithFormat:@"改变person中私有变量introduction的值\n修改前的值：%@\n修改后的值：%@\n",oldValue,newValue];
}

#pragma mark --- 添加新的方法（等价于类添加category对方法进行扩展）
- (void)addMethod {
    
    /*
     动态添加方法：
     第一个参数表示Class cls类型；
     第二个参数表示调用的方法名称；
     第三个参数(IMP)myAddingFunction，IMP一个函数指针，这里表示指定具体实现方法
     第四个参数表示方法的参数，0代表没有参数 ,"i@:@" 代表一个参数，"i@:@@"代表两个参数，
     */
    
    Person * person = [[Person alloc] init];
    
    class_addMethod([person class], @selector(NewMethod), (IMP)myAddingFunction, 0);
    
    //调用方式 -隐式调用
    [person performSelector:@selector(NewMethod)];
    _noticeLabel.text = @"已新增方法:NewMethod";
}

/**
 具体实现 （方法的内部默认包含两个参数Class和SEL方法，被称为隐式参数）
 
 @一个参数写法：int cfunction(id self, SEL _cmd, NSString *str)
 @两个参数写法：int cfunctionA(id self, SEL _cmd, NSString *str, NSString *str1)
 */
int myAddingFunction(id self,SEL _cmd)
{
    NSLog(@"已新增方法:NewMethod");
    
    return 1;
}

#pragma mark --- 为类的 category 增加新的属性
- (void)addVariable {
    //runtime可以在不改动原类的前提下增加新的属性
    Person * person = [[Person alloc] init];
    person.gender   = @"male";   //给新属性gender赋值
    
    _noticeLabel.text   =   [NSString stringWithFormat:@"给Person添加了一个新的属性\n gender 值为:%@", [person getGender]];
}

#pragma mark --- 交换两个方法 （交换两个方法的实现一般写在类的load方法里面，因为load方法会在程序运行前加载一次）
- (void)replaceMethod {
    
    Method  method1 = class_getInstanceMethod([Person class], @selector(func1));
    Method  method2 = class_getInstanceMethod([Person class], @selector(func2));
    
    //交换两个方法的实现
    method_exchangeImplementations(method1, method2);
    
    Person * person = [[Person alloc] init];
    _noticeLabel.text = [NSString stringWithFormat:@"交换了两个方法的实现\n方法1的执行结果:\n%@", [person func1]];
}

#pragma mark ---自定义方法实现部分替换（和交换不能重复使用）
- (void)methodExchange {
    Method method1 = class_getInstanceMethod([Person class], @selector(func1));
    IMP imp1 = method_getImplementation(method1);
    
    //把方法二替换成方法一的实现
    Method method2 = class_getInstanceMethod([Person class], @selector(func2));
    method_setImplementation(method2, imp1);
    
    Person * person = [[Person alloc] init];
    _noticeLabel.text =[NSString stringWithFormat:@"把方法二替换成了方法一的实现:\n%@",[person func2]];
}


-(void)selectBtnClick:(id)sender
{
    NSInteger idx = ((UIButton *)sender).tag;
    switch (idx) {
        case 0:{
            [self changeVariable];
            break;
        }
        case 1:{
            [self addMethod];
            break;
        }
        case 2:{
            [self addVariable];
            break;
        }
        case 3:{
            [self replaceMethod];
            break;
        }
        case 4:{
            [self methodExchange];
            break;
        }
        default:
            break;
    }
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
