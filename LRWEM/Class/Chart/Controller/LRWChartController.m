//
//  LRWChartController.m
//  LRWEM
//
//  Created by rwli on 16/11/24.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import "LRWChartController.h"
#import "Header.h"

NSString *const LRWChartTitleNormal =@"微信";
NSString *const LRWChartTitleWillConnect =@"连接中...";
NSString *const LRWChartTitleDisConnect =@"未连接";
NSString *const LRWChartTitleRceiveMsg =@"收取中...";


@interface LRWChartController ()<EMClientDelegate>

@end

@implementation LRWChartController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    
   }
#pragma mark--监听网络，改变控制器标题
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --EMClientDelegate监听标题
-(void)connectionStateDidChange:(EMConnectionState)aConnectionState{
    switch (aConnectionState) {
        case EMConnectionConnected:
            self.title =LRWChartTitleNormal;
            break;
        case EMConnectionDisconnected:
            self.title =LRWChartTitleDisConnect;
            break;
        default:
            break;
    }
}
-(void)autoLoginDidCompleteWithError:(EMError *)aError{
    if (!aError) {
        self.title=LRWChartTitleNormal;
    }else{
        self.title=LRWChartTitleDisConnect;
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[EMClient sharedClient]removeDelegate:self];
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
