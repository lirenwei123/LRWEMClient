//
//  LRWContacModel.m
//  LRWEM
//
//  Created by rwli on 16/11/26.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import "LRWContacModel.h"
//title
//imgUrl
NSString *const modeltitle=@"title";
NSString *const modelimgurl=@"imgUrl";
@implementation LRWContacModel



-(instancetype)initModelWithdic:(NSDictionary *)DiC{
    self=[super init];
    if (self&&[DiC isKindOfClass:[NSDictionary class]]) {
        self.title=[self objectforKey:modeltitle fromdic:DiC];
        self.imgUrl=[self objectforKey:modelimgurl fromdic:DiC];
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
    [dic setValue:self.title forKey:modeltitle];
    [dic setValue:self.imgUrl forKey:modelimgurl];
    return dic;
}
-(NSString *)description{
    return [NSString stringWithFormat:@"%@",[self reademe]];
}
@end
