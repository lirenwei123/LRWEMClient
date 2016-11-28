//
//  LRWContactCellHeader.m
//  LRWEM
//
//  Created by rwli on 16/11/27.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import "LRWContactCellHeader.h"

@implementation LRWContactCellHeader
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UINib *nib=[UINib nibWithNibName:@"LRWContactcellHeaderView" bundle:nil];
        self =[nib instantiateWithOwner:nil options:nil].firstObject;
    }
    return self;
}

+(instancetype)lrw_contactCellHeader:(CGRect)rect{
    return [[self alloc]initWithFrame:rect];
}
@end
