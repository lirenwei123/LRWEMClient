//
//  LRWChartFrameModel.m
//  LRWEM
//
//  Created by rwli on 16/11/27.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import "LRWChartFrameModel.h"
#import "Header.h"

#define timetextFont  10
#define contentFont    15
#define iconHW    50
#define magin 10
#define contentMAX_w kScreenWidth-iconHW *3

@implementation LRWChartFrameModel


-(void)configFramesForCellWithchartmodel{
       
    //时间布局
    //动态计算timelable的长度
    if (!self.chartModel) {
        NSLog(@"chartmodel不存在，无法配置布局");
        return;
    }
    CGFloat w=[self.chartModel.timeStr boundingRectWithSize:CGSizeMake(MAXFLOAT, timetextFont*1.5) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:timetextFont]} context:nil].size.width;
    CGFloat x=(kScreenWidth-w)*0.5;
    CGFloat h =timetextFont*1.5;
        self.timeRect =CGRectMake(x, 0, w, h);
        
    //内容布局
    //先计算宽度小于最大宽度的时候
    CGFloat lastW,lastH,lasty;
    
    CGFloat contentW= [self.chartModel.content boundingRectWithSize:CGSizeMake(MAXFLOAT,contentFont*1.5 ) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:contentFont]} context:nil].size.width;
    
    if (contentW<=contentMAX_w) {
        lastW=contentW;
        lastH=contentFont*1.5;
       
    }else{
        //根据长度算高度；
        CGFloat contentH = [self.chartModel.content boundingRectWithSize:CGSizeMake(contentMAX_w, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:contentFont]} context:nil].size.height;
        lastW =contentMAX_w;
        lastH=contentH*1.2;
    }
    
    if (lastH<iconHW) {
        lasty=(iconHW-lastH)*0.5+CGRectGetMaxY(self.timeRect)+2;
    }else{
        lasty=CGRectGetMaxY(self.timeRect)+2;
    }
    
    
    if (self.type==TypeLeft) {
        //头像布局
        self.iconRect =CGRectMake(magin, CGRectGetMaxY(self.timeRect)+2, iconHW, iconHW);
        self.contentRect =CGRectMake(magin+CGRectGetMaxX(self.iconRect),lasty, lastW, lastH);
    }else{
        //头像布局
        self.iconRect =CGRectMake(kScreenWidth-magin-iconHW, CGRectGetMaxY(self.timeRect)+2, iconHW, iconHW);
        self.contentRect=CGRectMake(kScreenWidth-2*magin-iconHW-lastW, lasty, lastW, lastH);
        
           }
    CGFloat a=CGRectGetMaxY(self.iconRect);
    CGFloat b=CGRectGetMaxY(self.contentRect);
    self.cellHeight =(a>b?a:b)+magin;
}
@end
