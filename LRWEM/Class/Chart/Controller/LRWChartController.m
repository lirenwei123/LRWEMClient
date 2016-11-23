//
//  LRWChartController.m
//  LRWEM
//
//  Created by rwli on 16/11/24.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import "LRWChartController.h"
#import "Header.h"

@interface LRWChartController ()

@end

@implementation LRWChartController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeTileByNetStatus];

   }
#pragma mark--监听网络，改变控制器标题
-(void)changeTileByNetStatus{
    AFNetworkReachabilityManager *netmanger =[AFNetworkReachabilityManager sharedManager];
    [netmanger startMonitoring];
    __block NSString *str=@"微信";
    [netmanger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
                //                AFNetworkReachabilityStatusUnknown          = -1,
                //                AFNetworkReachabilityStatusNotReachable     = 0,
                //                AFNetworkReachabilityStatusReachableViaWWAN = 1,
                //                AFNetworkReachabilityStatusReachableViaWiFi = 2,
            case -1:
                str =[str stringByAppendingString:@"(未知网络来自地球)"];
                self.navigationItem.title=str;
                break;
            case 0:
                str =[str stringByAppendingString:@"(无连接)"];
               self.navigationItem.title=str;
                break;
            case 1:
                str =[str stringByAppendingString:@"(有线网络不怕断)"];
                self.navigationItem.title=str;
                break;
            case 2:
                str =[str stringByAppendingString:@"(有wifi不用愁)"];
                self.navigationItem.title=str;
                break;
            default:
                break;
        }
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return  UIStatusBarStyleLightContent;
}
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
