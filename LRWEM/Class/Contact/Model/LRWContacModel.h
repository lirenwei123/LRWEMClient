//
//  LRWContacModel.h
//  LRWEM
//
//  Created by rwli on 16/11/26.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LRWContacModel : NSObject
@property (strong,nonatomic)NSString *title;
@property (strong,nonatomic)NSString *imgUrl;
+(instancetype)modelWithDic:(NSDictionary*)Dic;
-(instancetype)initModelWithdic:(NSDictionary*)DiC;
@end
