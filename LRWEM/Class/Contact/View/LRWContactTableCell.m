//
//  LRWContactTableCell.m
//  LRWEM
//
//  Created by rwli on 16/11/26.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import "LRWContactTableCell.h"
#import "Header.h"

@implementation LRWContactTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(LRWContacModel *)model{
    _model=model;
    self.titleLable.text=model.title;
   
    [self.imgv sd_setImageWithURL:model.imgUrl placeholderImage:[UIImage imageNamed:@"2"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
