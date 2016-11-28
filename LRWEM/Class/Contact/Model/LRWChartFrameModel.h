//
//  LRWChartFrameModel.h
//  LRWEM
//
//  Created by rwli on 16/11/27.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LRWChartTableViewCellModel.h"


typedef NS_ENUM(NSInteger,CellFrameType) {
    TypeLeft,
    TypeRight
};
@interface LRWChartFrameModel : NSObject
@property (assign,nonatomic)CGRect iconRect;
@property (assign,nonatomic)CGRect timeRect;
@property (assign,nonatomic)CGRect contentRect;
@property (assign,nonatomic)CGFloat cellHeight;
@property (assign,nonatomic)CellFrameType type;

@property (strong,nonatomic)LRWChartTableViewCellModel *chartModel;
-(void)configFramesForCellWithchartmodel;

@end
