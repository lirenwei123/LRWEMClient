//
//  LRWContavtDetailController.h
//  LRWEM
//
//  Created by rwli on 16/11/26.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LRWContactDertailModel.h"
@interface LRWContavtDetailController : UITableViewController


@property (strong,nonatomic)LRWContactDertailModel *model;
+(instancetype)lrw_ContavtDetailController;

@end
