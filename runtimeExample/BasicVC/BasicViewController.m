//
//  BasicViewController.m
//  runtimeExample
//
//  Created by lyl on 2017/2/19.
//  Copyright © 2017年 lyl. All rights reserved.
//

#import "BasicViewController.h"
#import "Interface_config.h"
#import "homePageViewController.h"
#import "BasicFeatureViewController.h"
#import "OtherFeatureViewController.h"
#import "ArchiverAndUnArchiverViewController.h"
#import "ResolutionAndForwardViewController.h"

@interface BasicViewController ()

@end

@implementation BasicViewController
{
    BOOL     isShowHeader;
    UIView   * headerView ;
    UIButton * leftButton ;
    UIButton * rightButton ;
    NSArray  * arr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark ---配置导航条/左侧按钮/右侧按钮
- (void)configShowHeaderBarOrNot:(BOOL)isShowOrNot andLeftBtnShow:(BOOL)leftShow andRightBtnShow:(BOOL)rightShow andTitle:(NSString *)title{
    isShowHeader = isShowOrNot ;
    [self.navigationController setNavigationBarHidden:YES];
    if (isShowHeader) {
        [self CommenHeaderBarWithLeftBtnShow:leftShow andRtghtBtnShow:rightShow andTitle:title];
    }
    else{
        //NSLog(@"NO HeaderBar");
    }
}

#pragma mark ---内部函数
- (void)CommenHeaderBarWithLeftBtnShow:(BOOL)isShowLeft andRtghtBtnShow:(BOOL)isShowRight andTitle:(NSString *)title
{
    headerView = [[UIView alloc] init];
    [headerView setFrame:CGRectMake(0, 0, ScreenWidth, NavBarHeight_Narmal + StatueBarHeight)];
    
    
    if (title) {
        UILabel * titleLabel = [[UILabel alloc] init];
        [titleLabel setFrame:CGRectMake(NavBarLeftBtn_Width, StatueBarHeight, ScreenWidth-2*NavBarLeftBtn_Width , NavBarHeight_Narmal)];
        
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = title ;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:18];
        titleLabel.textAlignment = NSTextAlignmentCenter ;
        [headerView addSubview:titleLabel];
    }
    
    if (isShowLeft) {
        leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [leftButton setFrame:CGRectMake(0, StatueBarHeight, NavBarLeftBtn_Width , NavBarHeight_Narmal)];
        
        [leftButton addTarget:self action:@selector(leftBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [leftButton setBackgroundColor:[UIColor whiteColor]];
        [headerView addSubview:leftButton];
    }
    if (isShowRight) {
        rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [rightButton setFrame:CGRectMake(ScreenWidth - NavBarRightBtn_Width, StatueBarHeight, NavBarRightBtn_Width, 44)];
        [rightButton setBackgroundColor:[UIColor whiteColor]];
        [rightButton addTarget:self action:@selector(rightBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:rightButton];
    }
    
    [self.view addSubview:headerView];
}

#pragma mark ---leftBtn
- (void)setLeftBtnBgNormal:(UIImage *)img_nor andHighlight:(UIImage *)img_hig andTitle:(NSString *)title
{
    
    if (img_nor) {
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30-12,(NavBarHeight_Narmal - 22)/2.0, 12, 22)];
        [leftButton addSubview:imageView];
        [imageView setImage:img_nor];
    }
    
    if (title) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 35, NavBarHeight_Narmal)];
        [leftButton addSubview:label];
        label.text  = title;
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:15.0];
        
    }
}

#pragma mark ---rightBtn
- (void)setRightBtnBgNormal:(UIImage *)img_nor andHighlight:(UIImage *)img_hig andTitle:(NSString *)title
{
    if (title) {
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [rightButton setTitle:title forState:UIControlStateNormal];
        [rightButton setTitle:title forState:UIControlStateHighlighted];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
        
    }
    [rightButton setImage:img_nor forState:UIControlStateNormal];
    [rightButton setImage:img_hig forState:UIControlStateHighlighted];
    
}

#pragma mark ---click
- (void)leftBtnTap:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark ---click
- (void)rightBtnTap:(id)sender
{
    
}

#pragma mark ---noticeLabel
- (UILabel *)creatLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth - 300) / 2.0, 300, 300, 300)];
    label.backgroundColor = [UIColor lightGrayColor];
    label.text = @"Runtime功能展示";
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    return label;
}

#pragma mark ---对应控制器创建Btn
- (void)selectBtnForWhichVC:(NSString *)VC
{
    
    [self judgeVCForBtn:VC];
    
    for (int i = 0; i < arr.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((ScreenWidth - 260) / 2.0,  topSpace + i*(space +btnHeight), 260, btnHeight)];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn.tag = i;
    }
}


- (void)selectBtnClick:(id)sender
{
    
}

- (NSArray *)judgeVCForBtn:(NSString *)VC
{
    if ([VC isEqualToString:@"homePageVC"]) {
        arr = [[NSArray alloc] initWithObjects:@"Runtime基本功能:获取类的信息", @"Runtime其他功能", @"实际应用:实现自动归档与解档", @"动态消息解析与转发", nil];
        return arr;
    }
    
    if ([VC isEqualToString:@"basicFeatureVC"]) {
        arr = [[NSArray alloc] initWithObjects:@"属性列表", @"方法列表", @"协议列表", @"成员变量列表", nil];
        return arr;
    }
    
    if ([VC isEqualToString:@"otherFeatureVC"]) {
        arr = [[NSArray alloc] initWithObjects:@"改变私有变量的值", @"为一个类增加新方法",@"为类的 category 增加新的属性", @"交换类的两个方法", @"系统类的方法实现部分替换", nil];
        return arr;
    }
    
    
    if ([VC isEqualToString:@"ArchiveAndUnArchiveVC"]) {
        arr = [[NSArray alloc] initWithObjects:@"自动归档", @"自动解档",nil];
        return arr;
    }
    
    if ([VC isEqualToString:@"ResolveAndForwardVC"]) {
        arr = [[NSArray alloc] initWithObjects:@"更改message类中方法查看不同", nil];
        return arr;
    }
    
    return arr;
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
