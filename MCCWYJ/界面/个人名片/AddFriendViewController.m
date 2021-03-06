//
//  AddFriendViewController.m
//  MCCWYJ
//
//  Created by MC on 16/5/24.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "AddFriendViewController.h"
#import "TextFildTableViewCell.h"
@interface AddFriendViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    
    UITableView * _tableView;
    
    
}

@end

@implementation AddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加好友";
     _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = AppMCBgCOLOR;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(actionsend)];
    // Do any additional setup after loading the view.
}
-(void)actionsend{
    UITextField * text = [self.view viewWithTag:500];
    [text resignFirstResponder];
    if (!_addHid.length) {
        _addHid = @"采点";
    }
    if (!_uid.length) {
        [self showHint:@"添加好友id无效"];
        return;
    }

    [self showHudInView:self.view hint:NSLocalizedString(@"friend.sendApply", @"sending application...")];

    NSDictionary *params = @{
                             @"destUid":_uid
                             };
    
    [self.requestManager postWithUrl:@"api/friends/add.json" refreshCache:NO params:params IsNeedlogin:YES success:^(id resultDic) {
        NSLog(@"resultDic =%@",resultDic);
        
        
        
        NSString *messageStr = @"";
        if (text.text.length) {
            messageStr = text.text;
        }
        NSString*  username = [MCUserDefaults objectForKey:@"nickname"]?[MCUserDefaults objectForKey:@"nickname"]:@"";
        
        
        NSDictionary * dic = @{
                               @"introduceStr":messageStr,
                               @"nickname":username
                               };
        
      NSString * JSONString =   [dic mj_JSONString];
        
        EMError *error = [[EMClient sharedClient].contactManager addContact:_addHid message:JSONString];
        [self stopshowLoading];
        
        if (error) {
            // [self showHint:error.errorDescription];
            [self showHint:NSLocalizedString(@"friend.sendApplyFail", @"send application fails, please operate again")];
        }
        else{
            [self showHint:NSLocalizedString(@"friend.sendApplySuccess", @"send successfully")];
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RecomFriendObjNotification" object:@""];
            

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];

                
            });

        }
        

        
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
       [self hideHud];
        [self stopshowLoading];
        if (description.length > 30) {
            NSRange r = {17,6};
            NSString *ss = [description substringWithRange:r];
            description = ss;
            
        }
        [self showHint:description];
        
        
        
    }];
    
    
    
    
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 30)];
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, Main_Screen_Width - 10, 30)];
    lbl.text = @"你需要发送验证申请，等待对方通过";
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:16];
    [view addSubview:lbl];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellid = @"TextFildTableViewCell";
    TextFildTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[TextFildTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        
    }
    
    
    cell.textField.tag = 500;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
