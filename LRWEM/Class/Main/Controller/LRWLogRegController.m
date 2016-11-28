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
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.userName.delegate=self;
    self.pwd.delegate=self;

    if (self.lrwusername) {
        self.userName.text=self.lrwusername;
    }
    
}

#pragma mark --login
-(void)loginFunctionWith:(NSString *)username pwd:(NSString*)pwd{
    if (username.length*pwd.length==0) {
        return;
    }
    [SVProgressHUD showWithStatus:@"正在登录"];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        <#code#>
//    })
    [[EMClient sharedClient]asyncLoginWithUsername:username password:pwd
                                           success:^{
          [JDStatusBarNotification showWithStatus:@"登录成功" dismissAfter:2 styleName:JDStatusBarStyleSuccess];
                                               NSLog(@"登录成功");
        [SVProgressHUD dismiss];
      
        //进行跳转内容控制器
        [UIApplication sharedApplication].keyWindow.rootViewController =[LRWTabbarController TabbarController];
        //只要登录成功就设置为自动登录
        [[EMClient sharedClient].options setIsAutoLogin:YES];
       
    } failure:^(EMError *aError) {
        NSLog(@"%@",aError.code);
        [SVProgressHUD dismiss];
          NSLog(@"登录失败");
        [JDStatusBarNotification showWithStatus:@"登录失败" dismissAfter:2 styleName:JDStatusBarStyleError];
    }];
  
}
#pragma mark --logup
-(void)logUpFunction{
    
    if (self.userName.text.length*self.pwd.text.length==0) {
        return;
    }
    [SVProgressHUD showWithStatus:@"正在注册..."];
    [[EMClient sharedClient]asyncRegisterWithUsername:self.userName.text password:self.pwd.text success:^{
        NSLog(@"注册成功");
        [SVProgressHUD dismiss];
        [JDStatusBarNotification showWithStatus:@"注册成功" dismissAfter:2 styleName:JDStatusBarStyleSuccess];
    } failure:^(EMError *aError) {
        NSLog(@"注册失败");
        NSLog(@"%@",aError.code);
        [SVProgressHUD dismiss];
        [JDStatusBarNotification showWithStatus:@"注册失败" dismissAfter:2 styleName:JDStatusBarStyleWarning];
    }];

}

-(void)save_username_pwd{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    [ud setValue:self.userName.text forKey:@"username"];
    [ud setValue:self.pwd.text forKey:@"pwd"];
    [ud synchronize];
        NSLog(@"保存成功");
    
}

- (IBAction)LogInBtn:(UIButton *)sender {
    [self loginFunctionWith:self.userName.text pwd:self.pwd.text];
   [self save_username_pwd];
}
- (IBAction)LogUPBtn:(UIButton *)sender {
    [self logUpFunction];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==self.userName) {
        [self.userName resignFirstResponder];
        [self.pwd becomeFirstResponder];
    }else if(textField==self.pwd){
        [textField resignFirstResponder];
        [self loginFunctionWith:self.userName.text pwd:self.pwd.text];
    }
    return YES;
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
