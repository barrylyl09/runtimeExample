//
//  ArchiverAndUnArchiverViewController.m
//  runtimeExample
//
//  Created by lyl on 2017/2/20.
//  Copyright © 2017年 lyl. All rights reserved.
//

#import "ArchiverAndUnArchiverViewController.h"
#import "Person.h"

@interface ArchiverAndUnArchiverViewController ()

@property (nonatomic, strong) UILabel *noticeLabel;

@end

@implementation ArchiverAndUnArchiverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super configShowHeaderBarOrNot:YES andLeftBtnShow:YES andRightBtnShow:NO andTitle:@"自动归档与解档"];
    [super setLeftBtnBgNormal:nil andHighlight:nil andTitle:@"Back"];
    
    [self selectBtnForWhichVC:@"ArchiveAndUnArchiveVC"];
    
    _noticeLabel = [self creatLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- 归档(真机和模拟器归档要注意路径问题)
- (void)archiver {
    
    Person * person = [[Person alloc] init];
    person.name     = @"barrylyl";
    person.age      = 20;
    person.phone    = @"15851920909";
    
    #if TARGET_IPHONE_SIMULATOR
    NSString *localPath = @"person.archive";
    
    #elif TARGET_OS_IPHONE
    NSString *localPath = @"/Documents/person.archive";
    
    #endif
    
    //归档Documents
    NSString * filePath = [NSHomeDirectory() stringByAppendingString:localPath];
    NSLog(@"%@",filePath);
    BOOL success = [NSKeyedArchiver archiveRootObject:person toFile:filePath];
    
    if (success) {
        _noticeLabel.text = @"归档成功";
    }
}

#pragma mark --- 解档
- (void)unArchiver {
    
    //解档
    #if TARGET_IPHONE_SIMULATOR
        NSString *localPath = @"person.archive";
        
    #elif TARGET_OS_IPHONE
        NSString *localPath = @"/Documents/person.archive";
        
    #endif

    NSString * filePath = [NSHomeDirectory() stringByAppendingString:localPath];
    if (filePath) {
        Person * person = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        _noticeLabel.text = [NSString stringWithFormat:@"姓名:%@  年龄%ld\n电话:%@",person.name, person.age, person.phone];
    }
    
}

-(void)selectBtnClick:(id)sender
{
    NSInteger idx = ((UIButton *)sender).tag;
    switch (idx) {
        case 0:{
            [self archiver];
            break;
        }
        case 1:{
            [self unArchiver];
            break;
        }
        default:
            break;
    }
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
