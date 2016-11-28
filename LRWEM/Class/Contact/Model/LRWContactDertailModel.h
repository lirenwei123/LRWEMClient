//
//  LRWContactDertailModel.h
//  LRWEM
//
//  Created by rwli on 16/11/26.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LRWContactDertailModel : NSObject


@property (copy,nonatomic)NSString *iconImgUrl;
@property (copy,nonatomic)NSString *name;
@property (copy,nonatomic)NSString *weixinnumber;
@property (copy,nonatomic)NSString *chenghu;
@property (copy,nonatomic)NSString *lablemask;
@property (copy,nonatomic)NSString *address;
@property (copy,nonatomic)NSString *img_1url;
@property (copy,nonatomic)NSString *img_2url;
@property (copy,nonatomic)NSString *img_3url;

+(instancetype)modelWithDic:(NSDictionary*)Dic;
-(instancetype)initModelWithdic:(NSDictionary*)DiC;


@end
