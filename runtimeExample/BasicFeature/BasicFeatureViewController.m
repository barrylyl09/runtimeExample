//
//  BasicFeatureViewController.m
//  runtimeExample
//
//  Created by lyl on 2017/2/20.
//  Copyright © 2017年 lyl. All rights reserved.
//

/**
     Method:
     Method是一个指向objc_method结构体指针，表示对类中的某个方法的描述。
     
     在API中的定义：typedef struct objc_method Method;
     而objc_method结构体如下：
     truct objc_method {
     SEL method_name OBJC2_UNAVAILABLE;
     char *method_types OBJC2_UNAVAILABLE;
     IMP method_imp OBJC2_UNAVAILABLE;
     }
     
     method_name :方法选择器@selector()，类型为SEL。 相同名字的方法下，即使在不同类中定义，它们的方法选择器也相同。
     method_types：方法类型，是个char指针，存储着方法的参数类型和返回值类型。
     method_imp：指向方法的具体实现的指针，数据类型为IMP，本质上是一个函数指针。
     
     获取 Method结构体->得到SEL选择器名称->得到对应的方法名
 */


#import "BasicFeatureViewController.h"
#import "Person.h"
#import <objc/runtime.h>

@interface BasicFeatureViewController ()
@property (nonatomic, strong) UILabel *noticeLabel;
@end

@implementation BasicFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super configShowHeaderBarOrNot:YES andLeftBtnShow:YES andRightBtnShow:NO andTitle:@"基本功能:获取类的信息"];
    [super setLeftBtnBgNormal:nil andHighlight:nil andTitle:@"Back"];
    
    [self selectBtnForWhichVC:@"basicFeatureVC"];
    
    _noticeLabel = [self creatLabel];
}

#pragma mark --- 获取属性列表
- (void)getPropertyListClick {
    
    NSMutableString * propertyStr = [[NSMutableString alloc] init];
    [propertyStr appendString:@"属性列表：\n"];
    //属性包含类的category中的添加的属性
    unsigned int count = 0;
    
    objc_property_t * allProperty = class_copyPropertyList([Person class], &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = allProperty[i];
        
        const char * propertyName = property_getName(property);
        [propertyStr appendString:[NSString stringWithUTF8String:propertyName]];
        [propertyStr appendString:@"\n"];
    }
    
    _noticeLabel.text = propertyStr;
}

#pragma mark --- 方法列表
- (void)getMethodListClick {
    
    NSMutableString * methodStr = [[NSMutableString alloc] init];
    [methodStr appendString:@"方法列表：\n"];
    
    unsigned int count = 0;
    
    //获取方法列表，所有在.m文件中显式实现的方法都会被找到，包括setter和getter；
    Method * allMethods = class_copyMethodList([Person class], &count);
    
    for (int i = 0; i < count; i++) {
        
        Method method = allMethods[i];
        
        //获取SEL : SEL类型，即可获得方法选择器@selector()
        SEL sel = method_getName(method);
        
        //得到sel的方法名：以字符串格式获取sel的name，也即@selector()中的方法名称
        const char * methodname = sel_getName(sel);
        
        [methodStr appendString:[NSString stringWithUTF8String:methodname]];
        [methodStr appendString:@"\n"];
    }
    
    _noticeLabel.text = methodStr;
}

#pragma mark --- 获取成员变量列表
- (void)getIvarListClick {
    
    NSMutableString * variables = [[NSMutableString alloc] init];
    [variables appendString:@"成员变量列表：\n"];
    
    unsigned int count = 0;
    
    Ivar * allVariables = class_copyIvarList([Person class], &count);
    
    for (int i = 0; i < count; i++) {
        Ivar ivar = allVariables[i];
        
        const char * ivarName = ivar_getName(ivar);
        [variables appendString:[NSString stringWithUTF8String:ivarName]];
        [variables appendString:@"\n"];
    }
    
    _noticeLabel.text = variables;
}

#pragma mark --- 遵守的协议方法列表
- (void)getProtocolListClick {
    NSMutableString * protocolStr = [[NSMutableString alloc] init];
    [protocolStr appendString:@"协议列表：\n"];
    
    unsigned int count = 0;
    
    __unsafe_unretained Protocol ** protocolList = class_copyProtocolList([Person class], &count);
    
    for (int i = 0; i < count; i++) {
        
        Protocol *protocol = protocolList[i];
        
        const char * protocolname = protocol_getName(protocol);
        
        [protocolStr appendString:[NSString stringWithUTF8String:protocolname]];
        [protocolStr appendString:@"\n"];
        
    }
    
    _noticeLabel.text = protocolStr;
}




-(void)selectBtnClick:(id)sender
{
    NSInteger idx = ((UIButton *)sender).tag;
    switch (idx) {
        case 0:{
            [self getPropertyListClick];
            break;
        }
        case 1:{
            [self getMethodListClick];
            break;
        }
        case 2:{
            [self getProtocolListClick];
            break;
        }
        case 3:{
            [self getIvarListClick];
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
