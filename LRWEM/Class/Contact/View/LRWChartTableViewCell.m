//
//  LRWChartTableViewCell.m
//  LRWEM
//
//  Created by rwli on 16/11/27.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import "LRWChartTableViewCell.h"
#import "Masonry.h"
#import "Header.h"

#define timetextFont  10
#define contentFont    15


@interface LRWChartTableViewCell()


@property (strong,nonatomic)UILabel *contentLable;
@end

@implementation LRWChartTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
   self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *time=[[UILabel alloc]init];
        time.backgroundColor=kLightGrayColor;
        UILabel *contect=[[UILabel alloc]init];
        contect.numberOfLines=0;
        UIButton *icon =[UIButton buttonWithType:UIButtonTypeSystem];
        icon.backgroundColor=kYellowColor;
                         [self.contentView addSubview:time];
                         [self.contentView addSubview:contect];
                         [self.contentView addSubview:icon];
        self.timeLable =time;
        self.contentLable=contect;
        self.iconBtn=icon;
        self.timeLable.font=[UIFont systemFontOfSize:timetextFont];
        self.contentLable.font=[UIFont systemFontOfSize:contentFont];
        self.backgroundColor=kRGBAlpha(242/255.0, 242/255.0, 242/255.0, 0.8);
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.contentLable.layer.cornerRadius=8;
        self.timeLable.layer.cornerRadius=3;
        self.timeLable.layer.masksToBounds=YES;
        self.contentLable.layer.masksToBounds=YES;
        
                  }
    return self;
}

-(void)setFrameModel:(LRWChartFrameModel *)frameModel{
    _frameModel=frameModel;
    
    
    if (self.frameModel.type==TypeLeft) {
      
        self.contentLable.backgroundColor=kWhiteColor;
        self.contentLable.textAlignment=NSTextAlignmentLeft;
    }else{
        
        self.contentLable.backgroundColor=kGreenColor;
        self.contentLable.textAlignment=NSTextAlignmentRight;
    }

    
    self.timeLable.text=frameModel.chartModel.timeStr;
    [self.iconBtn setImage:[[UIImage imageNamed:frameModel.chartModel.iconUrl]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    self.contentLable.text=frameModel.chartModel.content;
    self.contentLable.layer.cornerRadius=5;
    self.contentLable.layer.masksToBounds=YES;
    
    self.iconBtn.frame =frameModel.iconRect;
    self.timeLable.frame=frameModel.timeRect;
    self.contentLable.frame=frameModel.contentRect;
    
   

    [self layoutIfNeeded];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//    NSLog(@"做点什么动画呢");
//    self.layer.transform=CATransform3DRotate(self.layer.transform, 0.75, 1, 1, 1);
//     Configure the view for the selected state
}



@end
