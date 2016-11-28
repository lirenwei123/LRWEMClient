//
//  LRWTabbarController.m
//  LRWEM
//
//  Created by rwli on 16/11/23.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import "LRWTabbarController.h"
#import "LRWContactController.h"
#import "Header.h"
 int num=0;
@interface LRWTabbarController ()<EMContactManagerDelegate,EMChatManagerDelegate, UIAlertViewDelegate>
@property (strong,nonatomic)NSString *username;

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
    //添加代理方法监听如果友好友添加，将改变tabaritem的baduge
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    
    
    for (int i=0; i<self.tabBar.items.count; i++) {
        UITabBarItem *item =self.tabBar.items[i];
        [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
    }

//    [self.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:30]} forState:UIControlStateNormal];
    
    [JDStatusBarNotification showWithStatus:@"登录成功" dismissAfter:2.0 styleName:JDStatusBarStyleDark];
}

//监听如果友好友添加，将改变tabaritem的baduge
-(void)friendRequestDidReceiveFromUser:(NSString *)aUsername message:(NSString *)aMessage{
    num++;
   
    self.tabBar.items[1].badgeValue=[NSString stringWithFormat:@"%d",num];
    UIAlertView *alertv =[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"%@->想加你为好友",aUsername] message: aMessage delegate:self cancelButtonTitle:@"拒绝❌" otherButtonTitles:@"添加",nil];
    [alertv show];
    self.username=aUsername;
   
}
#pragma  mark --alertview的代理事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        EMError *error=nil;
        error= [[EMClient sharedClient].contactManager declineInvitationForUsername:self.username];
        if (!error) {
            NSLog(@"拒绝了❌");
        }else{
            NSLog(@"操作失败");
        }

    }else{
        EMError *error=nil;
        error= [[EMClient sharedClient].contactManager acceptInvitationForUsername:self.username];
        if (!error) {
            NSLog(@"添加好友成功");
            //跳转到联系人导航控制器
            if (self.selectedViewController!=self.viewControllers[1]) {
                self.selectedViewController =self.viewControllers[1];
            }else{
                //去reload data
              
                UINavigationController *contacnav=self.selectedViewController;
                LRWContactController *contacv=contacnav.viewControllers.firstObject;
                [contacv setFriendArry:nil];
                [contacv.tableView reloadData];
            }
        }else{
            NSLog(@"添加失败");
        }

    }
    
    num--;
    if (!num) {
        self.tabBar.items[1].badgeValue=nil;
    }else{
        self.tabBar.items[1].badgeValue=[NSString stringWithFormat:@"%d",num];
    }

}

#pragma mark--好友申请处理结果回调
-(void)friendRequestDidApproveByUser:(NSString *)aUsername{
    
    

    UIAlertController *alerc =[UIAlertController alertControllerWithTitle:aUsername message:@"已经是你的好友了，开始聊天吧😤" preferredStyle:UIAlertControllerStyleActionSheet];
    [alerc addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil]];
       
    [self presentViewController:alerc animated:YES completion:nil];
   }
-(void)friendRequestDidDeclineByUser:(NSString *)aUsername{
   

    UIAlertController *alerc =[UIAlertController alertControllerWithTitle:aUsername message:@"拒绝了你的还有请求" preferredStyle:UIAlertControllerStyleActionSheet];
    [alerc addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alerc animated:YES completion:nil];
}

-(NSMutableArray *)newMessages{
    if (!_newMessages) {
        _newMessages=@[].mutableCopy;
    }
    return _newMessages;
}

-(void)didReceiveMessages:(NSArray *)aMessages{
    [JDStatusBarNotification showWithStatus:[NSString stringWithFormat:@"有%ld条新消息",aMessages.count] dismissAfter:10 styleName:JDStatusBarStyleMatrix];
    self.tabBar.items[1].badgeValue=[NSString stringWithFormat:@"%ld",aMessages.count];
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
