//
//  LRWTabbarController.h
//  LRWEM
//
//  Created by rwli on 16/11/23.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRWTabbarController : UITabBarController
+(instancetype)TabbarController;
-(instancetype)init;
@property (strong,nonatomic)NSMutableArray *newMessages;
@end
