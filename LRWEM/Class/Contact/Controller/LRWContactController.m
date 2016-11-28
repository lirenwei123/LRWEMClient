//
//  LRWContactController.m
//  LRWEM
//
//  Created by rwli on 16/11/25.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import "LRWContactController.h"
#import "Header.h"
#import "LRWContactTableCell.h"
#import "LRWContavtDetailController.h"
#import "LRWContactCellHeader.h"


@interface LRWContactController ()<EMContactManagerDelegate>


@end

@implementation LRWContactController

- (void)viewDidLoad {
    [super viewDidLoad];
    //监听添加好友请求
        [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    UINib *cellnib=[UINib nibWithNibName:NSStringFromClass([LRWContactTableCell class]) bundle:nil];
    [self.tableView registerNib:cellnib forCellReuseIdentifier:NSStringFromClass([self class])];
    self.tableView.rowHeight=80;
    
    //加表头
    LRWContactCellHeader *header=[LRWContactCellHeader lrw_contactCellHeader:CGRectMake(0, 0, 414, 176)];
    self.tableView.tableHeaderView=header;
}

#pragma mark --添加好友
- (IBAction)addFriend:(UIBarButtonItem *)sender {
    UIAlertController *alertC=[UIAlertController alertControllerWithTitle:@"添加好友申请" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.borderStyle= UITextBorderStyleRoundedRect;
        textField.backgroundColor=kGreenColor;
        textField.placeholder=@"你要添加who？";
    }];
    [alertC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.borderStyle= UITextBorderStyleRoundedRect;
        textField.backgroundColor=kBlueColor;
        textField.placeholder=@"请输入添加说明";
    }];
    [alertC addAction:[UIAlertAction actionWithTitle:@"添加" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        EMError *error =nil;
        error=[[EMClient sharedClient].contactManager addContact:alertC.textFields.firstObject.text message:alertC.textFields.lastObject.text];
        if (!error) {
            NSLog(@"添加好友申请发送成功");
        }
    }]];
    [alertC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertC animated:YES completion:nil];
}

#pragma mark--获取好友列表
-(NSMutableArray *)friendArry{
    if (!_friendArry) {
        NSArray *arry =[[EMClient sharedClient].contactManager getContacts];
        _friendArry =[NSMutableArray array];
        for (NSString *str in arry) {
            LRWContacModel *model =[[LRWContacModel alloc]init];
            model.title=str;
            model.imgUrl =@"http://pic33.nipic.com/20130916/3420027_192919547000_2.jpg";
            [_friendArry addObject:model];
        }
    }
    return _friendArry;
}

#pragma mark --获取好友信息详情列表的懒加载
-(NSMutableArray<LRWContactDertailModel *> *)detailModelArry{
    if (!_detailModelArry) {
        _detailModelArry=[NSMutableArray array];
        NSString *fp=[[NSBundle mainBundle]pathForResource:@"DetailContactFriendList" ofType:@"plist"];
       NSArray *arry= [NSDictionary dictionaryWithContentsOfFile:fp][@"data"];
      
        for (NSDictionary *dic in arry) {
            LRWContactDertailModel *model=[LRWContactDertailModel modelWithDic:dic];
            [_detailModelArry addObject:model];
        }
    }
    return _detailModelArry;
}



#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.friendArry.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LRWContactTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
    cell.model=self.friendArry[indexPath.section];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
#if 1
    LRWContactTableCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    NSString *str=[NSString stringWithFormat:@"删除%@",cell.titleLable.text];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertController *alertc =[UIAlertController alertControllerWithTitle:@"确认操作选项" message:str  preferredStyle:UIAlertControllerStyleAlert];
        [alertc addAction:[UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //进行删除
            [[EMClient sharedClient].contactManager deleteContact:cell.titleLable.text completion:^(NSString *aUsername, EMError *aError) {
                if(!aError){
                    [SVProgressHUD showWithStatus:@"删除成功"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        _friendArry=nil;
                        [tableView reloadData];
                        
                        [SVProgressHUD dismiss];
                        
                    });
                }
            }];
            
        }]];
        [alertc addAction:[UIAlertAction actionWithTitle:@"取消删除" style:UIAlertActionStyleCancel handler:nil]];
        
        [self presentViewController:alertc animated:YES completion:nil];
    }
#endif;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LRWContavtDetailController *detailVC=[LRWContavtDetailController lrw_ContavtDetailController];
    LRWContactTableCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    detailVC.title=cell.titleLable.text;
    detailVC.model=self.detailModelArry[indexPath.row];
    detailVC.model.name=cell.titleLable.text;
    [self.navigationController pushViewController:detailVC animated:NO];

}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"%c",65+section];
}
#pragma mark --监听好友请求回调
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[EMClient sharedClient].contactManager removeDelegate:self];
        }
   


                       

                       @end
