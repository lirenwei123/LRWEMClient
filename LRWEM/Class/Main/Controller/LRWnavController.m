//
//  LRWnavController.m
//  LRWEM
//
//  Created by rwli on 16/11/24.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import "LRWnavController.h"

@interface LRWnavController ()

@end

@implementation LRWnavController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UINavigationBar appearance]setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];//导航栏的title大小颜色
    [self.navigationBar setBarTintColor:[UIColor blackColor]];//导航栏颜色
    
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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
