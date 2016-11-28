//
//  LRWChartTableViewCellModel.m
//  LRWEM
//
//  Created by rwli on 16/11/27.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import "LRWChartTableViewCellModel.h"
NSString *const icon =@"iconUrl";
NSString *const timee =@"timeStr";
NSString *const contentr=@"contect";

@implementation LRWChartTableViewCellModel
-(instancetype)initModelWithdic:(NSDictionary *)DiC{
    self=[super init];
    if (self&&[DiC isKindOfClass:[NSDictionary class]]) {
        self.iconUrl=[self objectforKey:icon fromdic:DiC];
        self.timeStr=[self objectforKey:timee fromdic:DiC];
        self.content =[self objectforKey:contentr fromdic:DiC];
    }
    return self;
}
+(instancetype)modelWithDic:(NSDictionary *)Dic{
    return [[self alloc]initModelWithdic:Dic];
}

-(id)objectforKey:(NSString*)key fromdic:(NSDictionary*)dic{
    NSObject *ob=[dic objectForKey:key];
    return [ob isEqual:[NSNull null]]?nil:ob;
}

-(NSMutableDictionary*)reademe{
    NSMutableDictionary *dic =[NSMutableDictionary dictionary];
    [dic setValue:self.iconUrl forKey:icon];
    [dic setValue:self.timeStr forKey:timee];
    [dic setValue:self.content forKey:contentr];
    return dic;
}
-(NSString *)description{
    return [NSString stringWithFormat:@"%@",[self reademe]];
}

@end
