//
//  homePageViewController.m
//  runtimeExample
//
//  Created by lyl on 2017/2/19.
//  Copyright © 2017年 lyl. All rights reserved.
//

#import "homePageViewController.h"
#import "BasicFeatureViewController.h"
#import "OtherFeatureViewController.h"
#import "ArchiverAndUnArchiverViewController.h"
#import "ResolutionAndForwardViewController.h"

@interface homePageViewController ()

@end

@implementation homePageViewController
{
    NSArray *arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super configShowHeaderBarOrNot:YES andLeftBtnShow:NO andRightBtnShow:NO andTitle:@"Runtime知识梳理总结"];
    
    [self selectBtnForWhichVC:@"homePageVC"];
    
}

-(void)selectBtnClick:(id)sender
{
    NSInteger idx = ((UIButton *)sender).tag;
    switch (idx) {
        case 0:{
            BasicFeatureViewController *VC = [[BasicFeatureViewController alloc] init];
            [self.navigationController pushViewController:VC animated:NO];
            break;
        }
        case 1:{
            OtherFeatureViewController *VC = [[OtherFeatureViewController alloc] init];
            [self.navigationController pushViewController:VC animated:NO];
            break;
        }
        case 2:{
            ArchiverAndUnArchiverViewController *VC = [[ArchiverAndUnArchiverViewController alloc] init];
            [self.navigationController pushViewController:VC animated:NO];
            break;
        }
        case 3:{
            ResolutionAndForwardViewController *VC = [[ResolutionAndForwardViewController alloc] init];
            [self.navigationController pushViewController:VC animated:NO];
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
