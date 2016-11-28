//
//  LRWContactDertailModel.m
//  LRWEM
//
//  Created by rwli on 16/11/26.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import "LRWContactDertailModel.h"



NSString *const s1=@"iconImgUrl";
NSString *const s2=@"name";
NSString *const s3=@"weixinnumber";
NSString *const s4=@"chenghu";
NSString *const s5=@"lablemask";
NSString *const s6=@"img_1url";
NSString *const s7=@"img_2url";
NSString *const s8=@"img_3url";
NSString *const s9=@"address";




@implementation LRWContactDertailModel

-(instancetype)initModelWithdic:(NSDictionary *)DiC{
    self=[super init];
    if (self&&[DiC isKindOfClass:[NSDictionary class]]) {
        self.iconImgUrl=[self objectforKey:s1 fromdic:DiC];
        self.weixinnumber=[self objectforKey:s3 fromdic:DiC];
        self.chenghu=[self objectforKey:s4 fromdic:DiC];
        self.lablemask=[self objectforKey:s5 fromdic:DiC];
        self.img_1url=[self objectforKey:s6 fromdic:DiC];
        self.img_2url=[self objectforKey:s7 fromdic:DiC];
        self.img_3url=[self objectforKey:s8 fromdic:DiC];
        self.address=[self objectforKey:s9 fromdic:DiC];
        
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
    [dic setValue:self.iconImgUrl forKey:s1];
     [dic setValue:self.weixinnumber forKey:s3];
     [dic setValue:self.chenghu forKey:s4];
     [dic setValue:self.lablemask forKey:s5];
     [dic setValue:self.img_1url forKey:s6];
     [dic setValue:self.img_2url forKey:s7];
     [dic setValue:self.img_3url forKey:s8];
    [dic setValue:self.address forKey:s9];
   
    return dic;
}
-(NSString *)description{
    return [NSString stringWithFormat:@"%@",[self reademe]];
}

@end
