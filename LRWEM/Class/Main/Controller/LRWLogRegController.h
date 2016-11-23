//
//  LRWMainController.h
//  LRWEM
//
//  Created by rwli on 16/11/22.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRWLogRegController : UIViewController

@property (strong,nonatomic)NSString *lrwusername;

+(instancetype)LogRegController;
-(instancetype)init;

-(void)loginFunctionWith:(NSString *)username pwd:(NSString*)pwd;
-(void)logUpFunction;

@end
