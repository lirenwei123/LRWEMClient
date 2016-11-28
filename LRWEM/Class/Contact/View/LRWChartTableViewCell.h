//
//  LRWChartTableViewCell.h
//  LRWEM
//
//  Created by rwli on 16/11/27.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LRWChartTableViewCellModel.h"
#import "LRWChartFrameModel.h"




@interface LRWChartTableViewCell : UITableViewCell

@property (strong,nonatomic)LRWChartFrameModel *frameModel;

@property (strong,nonatomic)UIButton *iconBtn;
@property (strong,nonatomic)UILabel *timeLable;
@end
