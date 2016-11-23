//
//  LRWMainController.m
//  LRWEM
//
//  Created by rwli on 16/11/22.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import "LRWLogRegController.h"
#import "Header.h"
#import "LRWTabbarController.h"

@interface LRWLogRegController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *pwd;

@end

@implementation LRWLogRegController


+(instancetype)LogRegController{
    return [[self alloc]init];
}

-(instancetype)init{
    if (self=[super init]) {
      UIStoryboard *board =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        self=[board instantiateViewControllerWithIdentifier:NSStringFromClass([LRWLogRegController class])];
    }
    return self;
}
-(void)setLrwusername:(NSString *)lrwusername{
    _lrwusername=lrwusername;
    self.userName.text =_lrwusername;
}

-(void)awakeFromNib{
    self.userName.delegate=self;
    self.pwd.delegate=self;
   

}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.lrwusername) {
        self.userName.text=self.lrwusername;
    }
    
}

#pragma mark --login
-(void)loginFunctionWith:(NSString *)username pwd:(NSString*)pwd{
    [SVProgressHUD showWithStatus:@"正在登录"];
    [[EMClient sharedClient]asyncLoginWithUsername:username password:pwd
                                           success:^{
        NSLog(@"登录成功");
        [SVProgressHUD dismiss];
        //进行跳转内容控制器
        [UIApplication sharedApplication].keyWindow.rootViewController =[LRWTabbarController TabbarController];
        //只要登录成功就设置为自动登录
        [[EMClient sharedClient].options setIsAutoLogin:YES];
       
    } failure:^(EMError *aError) {
        NSLog(@"登录失败");
        NSLog(@"%@",aError);
        [SVProgressHUD dismiss];
        [JDStatusBarNotification showWithStatus:@"登录失败" dismissAfter:2 styleName:JDStatusBarStyleDark];
    }];
  
}
#pragma mark --logup
-(void)logUpFunction{
    [SVProgressHUD showWithStatus:@"正在注册..."];
    if (self.userName.text.length*self.pwd.text.length==0) {
        return;
    }
    [[EMClient sharedClient]asyncRegisterWithUsername:self.userName.text password:self.pwd.text success:^{
        NSLog(@"注册成功");
        [SVProgressHUD dismiss];
        [JDStatusBarNotification showWithStatus:@"注册成功" dismissAfter:2 styleName:JDStatusBarStyleDark];
    } failure:^(EMError *aError) {
        NSLog(@"注册失败");
        NSLog(@"%@",aError);
        [SVProgressHUD dismiss];
        [JDStatusBarNotification showWithStatus:@"注册失败" dismissAfter:2 styleName:JDStatusBarStyleDark];
    }];

}

-(void)save_username_pwd{
    [[NSUserDefaults standardUserDefaults]setValue:self.userName.text forKey:@"username"];
    [[NSUserDefaults standardUserDefaults]setValue:self.pwd.text forKey:@"pwd"];
    
    NSLog(@"保存成功");
}

- (IBAction)LogInBtn:(UIButton *)sender {
    [self loginFunctionWith:self.userName.text pwd:self.pwd.text];
    BOOL lgin =[EMClient sharedClient].options.isAutoLogin;
    if( lgin){
         //如果自动登录设置为yes，说明登录成功过了，可以保存用户名和密码为下次登录准备
        [self save_username_pwd];
       
    }
}
- (IBAction)LogUPBtn:(UIButton *)sender {
    [self logUpFunction];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
   return  [textField resignFirstResponder];
   
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
