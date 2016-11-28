//
//  AppDelegate.m
//  LRWEM
//
//  Created by rwli on 16/11/22.
//  Copyright © 2016年 companyName. All rights reserved.
//easemob-demo#no1
#define lrwappkey @"1100161122115833#lrw"

//#define lrwappkey @"easemob-demo#no1"
#import "AppDelegate.h"
#import "Header.h"
#import "LRWLogRegController.h"
@interface AppDelegate ()<EMClientDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   //注册
    
    
    
    
    EMOptions *opt=[EMOptions optionsWithAppkey:lrwappkey];
   
    [[EMClient sharedClient]initializeSDKWithOptions:opt];
    
    //判断是否设置自动登录，
    
    if ([EMClient sharedClient].options.isAutoLogin) {
        //进行自动登录
        NSString *str1 =[[NSUserDefaults standardUserDefaults]valueForKey:@"username"];
        NSString *str2 =[[NSUserDefaults standardUserDefaults]valueForKey:@"pwd"];
        NSLog(@"username =[%@]---pwd=[%@]",str1,str2);
        LRWLogRegController *logvc= [LRWLogRegController LogRegController];
        [logvc loginFunctionWith:str1 pwd:str2];
    }
    //添加监控自动登录
    [[EMClient sharedClient]addDelegate:self delegateQueue:nil];
    return YES;
}
#pragma mark --EMClientDelegate
-(void)autoLoginDidCompleteWithError:(EMError *)aError{
    if (!aError) {
        NSLog(@"自动登录成功");
    }else{
        NSLog(@"自动登录失败=errorcode=%@",aError.code);
    }
}
-(void)didLoginFromOtherDevice{
    NSLog(@"当前登录账号在其它设备登录");
}
-(void)didRemovedFromServer{
    NSLog(@"当前登录账号已经被从服务器端删除");
}




- (void)applicationWillResignActive:(UIApplication *)application {
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[EMClient sharedClient]applicationDidEnterBackground:application];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[EMClient sharedClient]applicationWillEnterForeground:application];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    [[EMClient sharedClient]logout:YES completion:nil];
}


@end
