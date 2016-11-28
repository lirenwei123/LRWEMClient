//
//  LRWContactMSGsendVC.m
//  LRWEM
//
//  Created by rwli on 16/11/27.
//  Copyright © 2016年 companyName. All rights reserved.
//

#define ConversationID @"1024"

#import "LRWContactMSGsendVC.h"
#import "Header.h"
#import "LRWChartTableViewCell.h"
#import "LRWChartTableViewCellModel.h"
#import "LRWContavtDetailController.h"
#import "LRWChartFrameModel.h"
#import "LRWTabbarController.h"


@interface LRWContactMSGsendVC ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,EMChatManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *inputTF;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;
@property (weak, nonatomic) IBOutlet UIButton *magicBtn;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong,nonatomic)NSMutableArray <LRWChartFrameModel*>*modelArry;
@end

@implementation LRWContactMSGsendVC
+(instancetype)lrw_ContactMSGsendVC{
    return [[UIStoryboard storyboardWithName:NSStringFromClass([self class]) bundle:nil]instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.tabBarController.tabBar.hidden=YES;
    [self setUI];
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.tabBarController.tabBar.hidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 已经在xib里面设置好了代理

    //自动滚到最后一行
//    UITableViewScrollPositionNone,
//    UITableViewScrollPositionTop,
//    UITableViewScrollPositionMiddle,
//    UITableViewScrollPositionBottom
//    [self.tableview selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.modelArry.count-1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionBottom];
    if (self.modelArry.count!=0) {
        [self.tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.modelArry.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
        //弹出键盘时监听输入框frame
    [[NSNotificationCenter defaultCenter]addObserverForName:UIKeyboardWillChangeFrameNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
//        NSLog(@"%@",note);
//        userInfo = {
//            UIKeyboardAnimationDurationUserInfoKey = "0.25";
//            UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {414, 226}}";
//            UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 736}, {414, 226}}";
//            UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 510}, {414, 226}}";
        
        CGFloat endy=[note.userInfo [UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
        CGFloat duration =[note.userInfo [UIKeyboardAnimationDurationUserInfoKey] floatValue];
        CGFloat h =self.bottomView.bounds.size.height;
        [UIView animateWithDuration:duration animations:^{
              self.bottomView.frame=CGRectMake(0, endy-h, kScreenWidth, h);
            [self.view layoutIfNeeded];
        }];
   }];
}
- (IBAction)chatWithVioce:(UIButton *)sender {
    NSLog(@"发送语音");
}
- (IBAction)sendMagic:(UIButton *)sender {
    NSLog(@"发送表情");
}
- (IBAction)senMore:(UIButton *)sender {
    NSLog(@"发送其他更多类型，如红包");
}
-(void)setUI{
    self.voiceBtn.layer.cornerRadius=self.voiceBtn.frame.size.width*0.5;
    self.magicBtn.layer.cornerRadius=self.magicBtn.frame.size.width*0.5;
    self.moreBtn.layer.cornerRadius =self.moreBtn.frame.size.width*0.5;
    //tableview配置
    self.tableview.backgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"4.jpg"]];
    self.tableview.alpha=0.75;
    self.tableview.showsVerticalScrollIndicator=NO;
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
   
    }

#pragma mark --tableview代理
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   LRWChartFrameModel *model=self.modelArry[indexPath.row];
    return model.cellHeight;
    }
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArry.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LRWChartTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (!cell) {
        cell=[[LRWChartTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
//              if (indexPath.row%2){
//                  cell.type=lrw_TypeRight;
//            LRWChartFrameModel *model=self.modelArry[indexPath.row];
//            model.type=TypeRight;
//            [model configFramesForCellWithchartmodel];
//        }
        cell.backgroundColor=kRGBAlpha(.99, 0.99, .99, 0.05);
       
        //model
        cell.frameModel=self.modelArry[indexPath.row];
        //.长按
        UILongPressGestureRecognizer *longp =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longpclick)];
        longp.minimumPressDuration=.5;
        [cell.iconBtn addGestureRecognizer:longp];
        
        //tap
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnclick)];
        [cell.iconBtn addGestureRecognizer:tap];
    }
    return cell;
}


-(void)longpclick{
    NSString *str=[NSString stringWithFormat:@"@%@",self.title];
    self.inputTF.textColor=[UIColor blueColor];
    self.inputTF.text=str;
}
-(void)btnclick{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
#pragma mark --textfiled代理
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    //在这里给好友发送消息的代码
    [self lrw_magSendwithTF:textField];
    
    [textField resignFirstResponder];
    textField.text=nil;
    return YES;
}
-(void)lrw_magSendwithTF:(UITextField*)lrw_textfield{
    
    [self addLrwframeModelWithTF:lrw_textfield];
    
    EMTextMessageBody *body=[[EMTextMessageBody alloc]initWithText:lrw_textfield.text];
    NSString *from =[[EMClient sharedClient]currentUsername];
    EMMessage *message =[[EMMessage alloc]initWithConversationID:self.title from:from to:self.title body:body ext:@{@"test":@"test"}];
    message.chatType =EMChatTypeChat;
    [[EMClient sharedClient].chatManager asyncSendMessage:message progress:^(int progress) {
        [JDStatusBarNotification showProgress:(CGFloat)progress];
    } completion:^(EMMessage *message, EMError *error) {
         [JDStatusBarNotification dismiss];
        if (!error) {
            [JDStatusBarNotification showWithStatus:@"MSG send success" dismissAfter:3 styleName:JDStatusBarStyleSuccess];
          
        }
       
    }];

}
//发送消息。增加一个model
-(void)addLrwframeModelWithTF:(UITextField*)TF {
    
    LRWChartTableViewCellModel *chartmodel =[[LRWChartTableViewCellModel alloc]init];
    chartmodel.timeStr=[[NSDate date]description];
    chartmodel.iconUrl=@"20";
    chartmodel.content=TF.text;
    LRWChartFrameModel *frameModel =[[LRWChartFrameModel alloc]init];
        frameModel.type=TypeRight;
        frameModel.chartModel=chartmodel;
    [frameModel configFramesForCellWithchartmodel];
    [self.modelArry addObject:frameModel];
    [self.tableview reloadData];
}

//接受到一个消息，增加一个model
-(LRWChartFrameModel*)addLrwframeModelWithMessage:(EMMessage*)message{
    LRWChartTableViewCellModel *chartmodel =[[LRWChartTableViewCellModel alloc]init];
     LRWChartFrameModel *frameModel =[[LRWChartFrameModel alloc]init];
    switch (message.chatType) {
        case EMChatTypeChat:
        {   EMTextMessageBody *body =message.body;
            chartmodel.timeStr= [NSString stringWithFormat:@"ll",message.localTime] ;
            chartmodel.iconUrl=@"0";
            chartmodel.content=body.text;
            frameModel.type=TypeLeft;
            frameModel.chartModel=chartmodel;
            [frameModel configFramesForCellWithchartmodel];
                   }
            break;
            
        default:
            break;
    }

    return frameModel;
}

-(NSMutableArray *)modelArry{
    if (!_modelArry) {
       
        _modelArry=[self lrw_getAllConversationsMakeFrameModelsArry];
//        _modelArry =@[].mutableCopy;
//       
//        [_modelArry addObject: [self lrw_getsingelFrameModelWithconversationId: self.title]];
    }
          return _modelArry;
}
#pragma mark===根据某个置顶的conversationid来获取会话，默认获取10条 .

//有bug
-(NSMutableArray*)lrw_getMessagesFromAconversationID:(NSString*)conversationID{
    NSMutableArray *arry =@[].mutableCopy;
    EMConversation *conversation= [[EMClient sharedClient].chatManager  getConversation:conversationID type:EMConversationTypeChat createIfNotExist:YES];
    [conversation loadMessagesStartFromId:self.title count:10 searchDirection:EMMessageSearchDirectionUp completion:^(NSArray *aMessages, EMError *aError) {
        
        if (aMessages&&aMessages.count ) {
            [aMessages enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[EMMessage class]]) {
                    EMMessage *msg =obj;
                    EMTextMessageBody *msgBody =msg.body;
                    LRWChartTableViewCellModel *cellModel =[[LRWChartTableViewCellModel alloc]init];
                    LRWChartFrameModel *frameModel =[[LRWChartFrameModel alloc]init];
                    cellModel.content=msgBody.text;
                    cellModel.iconUrl=@"0";
                    NSDateFormatter *form =[[NSDateFormatter alloc]init];
                    form.dateFormat=@"yy-MM-dd hh:MM:ss";
                   cellModel.timeStr= [form stringFromDate:[NSDate dateWithTimeIntervalInMilliSecondSince1970:(double)(msg.localTime)]];
                    frameModel.chartModel=cellModel;
                    if ([msg.from isEqualToString:[EMClient sharedClient].currentUsername]) {
                        frameModel.type=TypeRight;
                    }else{
                        frameModel.type=TypeLeft;
                    }
                    [frameModel configFramesForCellWithchartmodel];
                    [arry addObject:frameModel];
                }
            }];
        }
    }];
    
    return arry;

}

#pragma mark--获取所有的会话转乘数组
-(NSMutableArray*)lrw_getAllConversationsMakeFrameModelsArry{
#if 1
    
    LRWChartFrameModel*(^getModels)(EMMessage* message)=^(EMMessage* message){
        
               EMTextMessageBody *body=message.body;
    
              LRWChartFrameModel *framemodel =[[LRWChartFrameModel alloc]init];
        LRWChartTableViewCellModel *model =[[LRWChartTableViewCellModel alloc]init];
        
        model.content=[NSString stringWithFormat:@"%@对%@说:\“%@ --conversationId=%@",message.from,message.to,body.text,message.conversationId];
        if (message.timestamp) {
            NSDateFormatter *form =[[NSDateFormatter alloc]init];
            form.dateFormat=@"YYYY-MM-dd hh:mm:ss";
            model.timeStr=[NSString stringWithFormat:@"%@", [form stringFromDate:[NSDate dateWithTimeIntervalSince1970:message.timestamp/1000.0]]];
        }else{
            model.timeStr=@"忘记时间";
        }
        model.iconUrl =@"0";
        framemodel.chartModel=model;
        
        if ([message.from isEqualToString:[[EMClient sharedClient]currentUsername]]) {
            framemodel.type=TypeRight;
        }else{
            framemodel.type=TypeLeft;
        }
        [framemodel configFramesForCellWithchartmodel];
           
        return framemodel;
            
      
    };

    
    
    NSArray *csArry= [[EMClient sharedClient].chatManager getAllConversations];
    NSMutableArray *arry=@[].mutableCopy;
    for (EMConversation *con in csArry) {
        EMMessage *message=con.latestMessage;
        if (([message.from isEqualToString:[[EMClient sharedClient]currentUsername]]||[message.from isEqualToString:self.title])) {
            if (([message.from isEqualToString:[[EMClient sharedClient]currentUsername]]||[message.from isEqualToString:self.title])) {
                [arry addObject:getModels(message)];
            }
        }
                  }
    
    
#endif
        //        [conversation loadMessagesStartFromId:nil count:10 searchDirection:EMMessageSearchDirectionDown completion:^(NSArray *aMessages, EMError *aError) {
        //          for (EMMessage *message in aMessages) {
        //              EMTextMessageBody *body=message.body;
        //              model.content=[NSString stringWithFormat:@"%@对%@说:\“%@",message.from,message.to,body.text];
        //              model.timeStr=[NSString stringWithFormat:@"%ll",message.timestamp] ;
        //
        //              model.iconUrl =@"20";
        //              framemodel.chartModel=model;
        //              [framemodel configFramesForCellWithchartmodel];
        //              [arry addObject:framemodel];
        //
        //          }
        //       }];

    return arry;
}

#pragma mark --获取一条消息转成model

    -(LRWChartFrameModel*)lrw_getsingelFrameModelWithconversationId:(NSString*)conversationId{
        LRWChartFrameModel *framemodel =[[LRWChartFrameModel alloc]init];
        LRWChartTableViewCellModel *model =[[LRWChartTableViewCellModel alloc]init];
        
        //             这是获取的最后一条
        EMConversation *conversation=[[EMClient sharedClient].chatManager getConversation:conversationId type:EMConversationTypeChat createIfNotExist:YES];
        EMTextMessageBody *body=conversation.latestMessage.body;
        model.content=body.text;
        EMMessage *message =conversation.latestMessage;
        model.content=[NSString stringWithFormat:@"%@对%@说:\“%@ --conversationId=%@",message.from,message.to,body.text,message.conversationId];
        NSDateFormatter *form =[[NSDateFormatter alloc]init];
            form.dateFormat=@"YYYY-MM-dd";
        model.timeStr=[NSString stringWithFormat:@"%@", [form stringFromDate:[NSDate dateWithTimeIntervalSince1970:message.localTime]]];
       model.iconUrl =@"0";
        framemodel.chartModel=model;
        if ([message.from isEqualToString:[[EMClient sharedClient]currentUsername]]) {
            framemodel.type=TypeRight;
        }else{
            framemodel.type=TypeLeft;
        }
        [framemodel configFramesForCellWithchartmodel];
        return framemodel;
    }
    

#pragma mark --解析新消息
-(void)didReceiveMessages:(NSArray *)aMessages{
            for (EMMessage *message in aMessages) {
            EMMessageBody *msgBody = message.body;
            
            switch (msgBody.type) {
                case EMMessageBodyTypeText:
                {
                    // 收到的文字消息
                  LRWChartFrameModel *amodel=  [self addLrwframeModelWithMessage:message];
                    [self.modelArry addObject:amodel];
                }
                    break;
                case EMMessageBodyTypeImage:
                {
                    // 得到一个图片消息body
                    EMImageMessageBody *body = ((EMImageMessageBody *)msgBody);
                    NSLog(@"大图remote路径 -- %@"   ,body.remotePath);
                    NSLog(@"大图local路径 -- %@"    ,body.localPath); // // 需要使用sdk提供的下载方法后才会存在
                    NSLog(@"大图的secret -- %@"    ,body.secretKey);
                    NSLog(@"大图的W -- %f ,大图的H -- %f",body.size.width,body.size.height);
                    NSLog(@"大图的下载状态 -- %lu",body.downloadStatus);
                    
                    
                    // 缩略图sdk会自动下载
                    NSLog(@"小图remote路径 -- %@"   ,body.thumbnailRemotePath);
                    NSLog(@"小图local路径 -- %@"    ,body.thumbnailLocalPath);
                    NSLog(@"小图的secret -- %@"    ,body.thumbnailSecretKey);
                    NSLog(@"小图的W -- %f ,大图的H -- %f",body.thumbnailSize.width,body.thumbnailSize.height);
                    NSLog(@"小图的下载状态 -- %lu",body.thumbnailDownloadStatus);
                }
                    break;
                case EMMessageBodyTypeLocation:
                {
                    EMLocationMessageBody *body = (EMLocationMessageBody *)msgBody;
                    NSLog(@"纬度-- %f",body.latitude);
                    NSLog(@"经度-- %f",body.longitude);
                    NSLog(@"地址-- %@",body.address);
                }
                    break;
                case EMMessageBodyTypeVoice:
                {
                    // 音频sdk会自动下载
                    EMVoiceMessageBody *body = (EMVoiceMessageBody *)msgBody;
                    NSLog(@"音频remote路径 -- %@"      ,body.remotePath);
                    NSLog(@"音频local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在（音频会自动调用）
                    NSLog(@"音频的secret -- %@"        ,body.secretKey);
                    NSLog(@"音频文件大小 -- %lld"       ,body.fileLength);
                    NSLog(@"音频文件的下载状态 -- %lu"   ,body.downloadStatus);
                    NSLog(@"音频的时间长度 -- %lu"      ,body.duration);
                }
                    break;
                case EMMessageBodyTypeVideo:
                {
                    EMVideoMessageBody *body = (EMVideoMessageBody *)msgBody;
                    
                    NSLog(@"视频remote路径 -- %@"      ,body.remotePath);
                    NSLog(@"视频local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在
                    NSLog(@"视频的secret -- %@"        ,body.secretKey);
                    NSLog(@"视频文件大小 -- %lld"       ,body.fileLength);
                    NSLog(@"视频文件的下载状态 -- %lu"   ,body.downloadStatus);
                    NSLog(@"视频的时间长度 -- %lu"      ,body.duration);
                    NSLog(@"视频的W -- %f ,视频的H -- %f", body.thumbnailSize.width, body.thumbnailSize.height);
                    
                    // 缩略图sdk会自动下载
                    NSLog(@"缩略图的remote路径 -- %@"     ,body.thumbnailRemotePath);
                    NSLog(@"缩略图的local路径 -- %@"      ,body.thumbnailLocalPath);
                    NSLog(@"缩略图的secret -- %@"        ,body.thumbnailSecretKey);
                    NSLog(@"缩略图的下载状态 -- %lu"      ,body.thumbnailDownloadStatus);
                }
                    break;
                case EMMessageBodyTypeFile:
                {
                    EMFileMessageBody *body = (EMFileMessageBody *)msgBody;
                    NSLog(@"文件remote路径 -- %@"      ,body.remotePath);
                    NSLog(@"文件local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在
                    NSLog(@"文件的secret -- %@"        ,body.secretKey);
                    NSLog(@"文件文件大小 -- %lld"       ,body.fileLength);
                    NSLog(@"文件文件的下载状态 -- %lu"   ,body.downloadStatus);
                }
                    break;
                    
                default:
                    break;
            }
        }
    }


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
