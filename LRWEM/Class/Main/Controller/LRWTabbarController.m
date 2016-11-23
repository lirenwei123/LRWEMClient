//
//  LRWTabbarController.m
//  LRWEM
//
//  Created by rwli on 16/11/23.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import "LRWTabbarController.h"
#import "Header.h"

@interface LRWTabbarController ()

@end

@implementation LRWTabbarController

-(instancetype)init{
    if (self=[super init]) {
        UIStoryboard *board =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        [board instantiateViewControllerWithIdentifier:NSStringFromClass([LRWTabbarController class])];
    }
    return self;
}
+(instancetype)TabbarController{
//return [[self alloc]init];
    UIStoryboard *board =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
  return   [board instantiateViewControllerWithIdentifier:NSStringFromClass([LRWTabbarController class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor=[UIColor greenColor];//选中时字体颜色
//    self.tabBar.barTintColor=[UIColor redColor];//tabar背景颜色
    
    for (int i=0; i<self.tabBar.items.count; i++) {
        UITabBarItem *item =self.tabBar.items[i];
        [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
    }

//    [self.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:30]} forState:UIControlStateNormal];
    
    [JDStatusBarNotification showWithStatus:@"登录成功" dismissAfter:2.0 styleName:JDStatusBarStyleDark];
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
