//
//  LRWChartTableViewCellModel.h
//  LRWEM
//
//  Created by rwli on 16/11/27.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LRWChartTableViewCellModel : NSObject

@property (strong,nonatomic)NSString *iconUrl;
@property (strong,nonatomic)NSString *timeStr;
@property (strong,nonatomic)NSString *content;


+(instancetype)modelWithDic:(NSDictionary*)Dic;
-(instancetype)initModelWithdic:(NSDictionary*)DiC;


@end
