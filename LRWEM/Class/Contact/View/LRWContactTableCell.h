//
//  LRWContactTableCell.h
//  LRWEM
//
//  Created by rwli on 16/11/26.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LRWContacModel.h"

@interface LRWContactTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgv;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (strong,nonatomic)LRWContacModel *model;
@end
