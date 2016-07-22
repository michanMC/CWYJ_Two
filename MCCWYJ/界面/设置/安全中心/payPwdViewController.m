//
//  payPwdViewController.m
//  MCCWYJ
//
//  Created by MC on 16/5/5.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "payPwdViewController.h"
#import "RegisterTableViewCell.h"
#import "ApplyViewController.h"
@interface payPwdViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    
    UITableView *_tableView;
    NSString * _pwd1Str;
    NSString * _pwd2Str;

}

@end

@implementation payPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    if ([_verifyStr isEqualToString:@"3"]) {
        self.title =  @"绑定手机号码";
    }
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = AppMCBgCOLOR;

    [self prepareFooer];

    // Do any additional setup after loading the view.
}
-(void)prepareFooer{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 100)];
    view.backgroundColor = [UIColor whiteColor];
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(40, 100 - 40 -20,Main_Screen_Width - 2* 40, 40)];
    [btn setTitle:@"完成" forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    btn.titleLabel.font = AppFont;
    btn.backgroundColor = AppRegTextCOLOR;//[UIColor redColor];
    [view addSubview:btn];
    ViewRadius(btn, 5);
    [btn addTarget:self action:@selector(okbtn) forControlEvents:UIControlEventTouchUpInside];
    _tableView.tableFooterView = view;
}
-(void)shoujianpan{
    UITextField * text1 = (UITextField*)[self.view viewWithTag:510];
    UITextField * text2 = (UITextField*)[self.view viewWithTag:511];
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self shoujianpan];
    return YES;
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 510) {
        _pwd1Str = textField.text;
    }
    else if(textField.tag == 511){
        _pwd2Str = textField.text;
        
    }
    //[_tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_verifyStr isEqualToString:@"3"]) {
        return 1;
    }
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid1 = @"RegisterTableViewCell";
        RegisterTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
        if (!cell) {
            cell = [[RegisterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid1];
            
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        
        cell.textField.placeholder = @"请输入密码";
        cell.textField.text = _pwd1Str;
        cell.textField.delegate = self;
        cell.textField.tag = 510;
        cell.textField.secureTextEntry = YES;
        
        return cell;
    }
    if (indexPath.row == 1) {
        
        cell.textField.placeholder = @"请再次输入密码";
        cell.textField.text = _pwd2Str;
        cell.textField.delegate = self;
        cell.textField.tag = 511;
        cell.textField.secureTextEntry = YES;
        
        return cell;
    }

    
    
    
    
    return [[UITableViewCell alloc]init];
}
-(void)okbtn{
    [self shoujianpan];

    
    
    
    if (!_pwd1Str.length) {
        [self showAllTextDialog:@"请输入密码"];
        return;
    }
    if (![_verifyStr isEqualToString:@"3"]) {

    if (!_pwd2Str.length) {
        [self showAllTextDialog:@"请输入确定密码"];
        return;
    }
    }
    if (_pwd1Str.length < 6 || _pwd1Str.length > 30 ) {
        [self showAllTextDialog:@"请输入6-30位的密码"];
        return;
        
    }
    if (![_verifyStr isEqualToString:@"3"]) {
        
    
    if (![_pwd1Str isEqualToString:_pwd2Str]) {
        [self showAllTextDialog:@"两次输入密码不一致"];
        return;
    }
    }
//    [self showLoading];

        [self showLoading];
    
    
    
    
    NSString *sign = [CommonUtil md5:_pwd1Str];

    NSDictionary * dic = @{
                         @"password":sign,
                         @"code":_cvvStr
                           };
    BOOL islogin = YES;
    NSString *url= @"";
    if ([_verifyStr isEqualToString:@"1"]) {
        dic = @{
                @"password":sign,
                @"mobile":_phoneStr,
                @"code":_cvvStr
                };
//        islogin = NO;
        url = @"api/user/changePassword.json";

    }
   else if ([_verifyStr isEqualToString:@"3"]) {
       islogin = YES;
       dic = @{
               @"password":sign,
               @"mobile":_phoneStr,
               @"Code":_cvvStr
               };
       //        islogin = NO;
       url = @"api/user/relateMobile.json";

       
       
   }
    else
    url = @"api/purse/payPassword.json";

    
    
    
    [self.requestManager postWithUrl:url refreshCache:NO params:dic IsNeedlogin:islogin success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
        if ([_verifyStr isEqualToString:@"1"]) {
//            [self showHint:@"密码成功"];

            [self logout];
            
            
        }
        else
        {
            [self showHint:@"密码设置成功"];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            
            for (UIViewController *vc in self.navigationController.viewControllers) {
                
                if ([vc isKindOfClass:objc_getClass("SettViewController")]) {
                    
                    [self.navigationController popToViewController:vc animated:YES];
                    
                    return;
                }
            }
            
            for (UIViewController *vc in self.navigationController.viewControllers) {
                
                if ([vc isKindOfClass:objc_getClass("PaymentViewController")]) {
                    
                    [self.navigationController popToViewController:vc animated:YES];
                    
                    return;
                }
            }


            
        });
        }
        
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        if (description.length > 30) {
            NSRange r = {17,9};
            NSString *ss = [description substringWithRange:r];
            description = ss;
            
        }
        [self stopshowLoading];
        [self showAllTextDialog:description];
    }];

    
    
    
    
}
#pragma mark-注销
-(void)logout{
    /*保存数据－－－－－－－－－－－－－－－－－begin*/
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject :@"" forKey:@"Pwd"];
    [defaults setObject :@"" forKey:@"uid"];
    
    [defaults setObject :@"" forKey:@"thumbnail"];
    
    [defaults setObject :@"" forKey:@"sessionId"];
    [defaults setObject :@"" forKey:@"nickname"];
    [defaults setObject :@"" forKey:@"mobile"];
    [defaults setObject :@"" forKey:@"id"];
    [defaults setObject :@"" forKey:@"password"];
    [defaults setObject:@"" forKey:@"isLogOut"];
    
    [self.requestManager.httpClient.requestSerializer setValue:@"" forHTTPHeaderField:@"user_session"];
    
    if ([[defaults objectForKey:@"type"]  isEqual: @(3)]) {
        
        [ShareSDK cancelAuthorize:SSDKPlatformTypeSinaWeibo];
        
    }
    if ([[defaults objectForKey:@"type"]  isEqual: @(1)]) {
        
        [ShareSDK cancelAuthorize:SSDKPlatformTypeWechat];
        
    }
    if ([[defaults objectForKey:@"type"]  isEqual: @(2)]) {
        
        [ShareSDK cancelAuthorize:SSDKPlatformTypeQQ];
        
    }
    //强制让数据立刻保存
    [defaults synchronize];
    __weak payPwdViewController *weakSelf = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        EMError *error = [[EMClient sharedClient] logout:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf stopshowLoading];
            //                if (error != nil) {
            //
            //                    [weakSelf showHint:error.errorDescription];
            //                }
            //                else{
            [self showAllTextDialog:@"修改成功，请重新登录"];
            
            
            [[ApplyViewController shareController] clear];
            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"didNewObjNotification" object:@""];
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"didMCMyshoppingObjNotification" object:@""];
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"disquery2ObjNotification" object:@""];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
                //发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"disCtlViewObjNotification" object:@"登录"];
                //                        [self.navigationController popViewControllerAnimated:YES];
                
                
            });
            
            //}
        });
    });
    
    return;
    [self showLoading];
    [self.requestManager postWithUrl:@"api/user/logout.json" refreshCache:NO params:nil IsNeedlogin:YES success:^(id resultDic) {
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
        NSLog(@"失败");
        
    }];
    
    
    
    
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
