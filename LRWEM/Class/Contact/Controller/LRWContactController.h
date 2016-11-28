//
//  LRWContactController.h
//  LRWEM
//
//  Created by rwli on 16/11/25.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LRWContacModel.h"
#import "LRWContactDertailModel.h"

@interface LRWContactController : UITableViewController
//共外部调用刷新data
@property (strong,nonatomic)NSMutableArray<LRWContacModel*> *friendArry;
@property (strong,nonatomic)NSMutableArray <LRWContactDertailModel*>*detailModelArry;
@end
