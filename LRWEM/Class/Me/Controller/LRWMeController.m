//
//  LRWMeController.m
//  LRWEM
//
//  Created by rwli on 16/11/23.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import "LRWMeController.h"
#import "Header.h"
#import "LRWLogRegController.h"

@interface LRWMeController ()
@property (weak, nonatomic) IBOutlet UILabel *labe;

@end

@implementation LRWMeController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.labe.attributedText =[[NSAttributedString alloc]initWithString: [EMClient sharedClient].currentUsername attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1],NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    
    
    
   }

-(void)awakeFromNib{
    [super awakeFromNib];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 5:
            //退出登录
            [[EMClient sharedClient]logout:YES completion:^(EMError *aError) {
                NSLog(@"退出登录成功");
            }];
            //跳转到登录跟控制器
            NSString *user =[[NSUserDefaults standardUserDefaults]valueForKey:@"username"];
            LRWLogRegController *logvc =[LRWLogRegController LogRegController];
            logvc.lrwusername =user;
            [UIApplication sharedApplication].keyWindow.rootViewController=logvc;
            break;
       
    }
}


@end
