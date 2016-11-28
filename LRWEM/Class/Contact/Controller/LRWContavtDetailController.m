//
//  LRWContavtDetailController.m
//  LRWEM
//
//  Created by rwli on 16/11/26.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import "LRWContavtDetailController.h"
#import "LRWContactMSGsendVC.h"
#import "Header.h"

@interface LRWContavtDetailController ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *weixinNumber;
@property (weak, nonatomic) IBOutlet UILabel *chenghu;
@property (weak, nonatomic) IBOutlet UILabel *labeMark;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UIImageView *imgv1;
@property (weak, nonatomic) IBOutlet UIImageView *imgv2;
@property (weak, nonatomic) IBOutlet UIImageView *imgv3;

@end

@implementation LRWContavtDetailController
@synthesize model;

+(instancetype)lrw_ContavtDetailController{
    return [[UIStoryboard storyboardWithName:NSStringFromClass([self class]) bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"tabbar_me"] style:UIBarButtonItemStylePlain target:self action:@selector(moremark)];
    self.navigationItem.rightBarButtonItem.tintColor=[UIColor whiteColor];
    [self useModel];
  }
-(void)moremark{
    NSLog(@"在这里做更多的事情");
}

- (IBAction)msgSendBtnClick:(UIButton *)sender {
    LRWContactMSGsendVC *msgVC=[LRWContactMSGsendVC lrw_ContactMSGsendVC];
    NSString *title =[NSString stringWithFormat:@"%@",self.title];
    msgVC.title=title;
    [self.navigationController pushViewController:msgVC animated:NO];
}
- (IBAction)vedioChartBtnClick:(UIButton *)sender {
    NSLog(@"大视频");
}

-(void)useModel{
   
    [self.iconImg sd_setImageWithURL:model.iconImgUrl placeholderImage:[UIImage imageNamed:@"1"]];
    self.name.text=model.name;
    self.weixinNumber.text=model.weixinnumber;
    self.chenghu.text=model.chenghu;
    self.labeMark.text=model.lablemask;
    self.address.text=model.address;
    [self.imgv1 sd_setImageWithURL:model.img_1url placeholderImage:[UIImage imageNamed:@"2"]];
    [self.imgv2 sd_setImageWithURL:model.img_2url placeholderImage:[UIImage imageNamed:@"2"]];
    [self.imgv3 sd_setImageWithURL:model.img_3url placeholderImage:[UIImage imageNamed:@"2"]];
    
}

#pragma mark - Table view data source


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
