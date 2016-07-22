//
//  verifyViewController.m
//  MCCWYJ
//
//  Created by MC on 16/5/5.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "verifyViewController.h"
#import "RegisterTableViewCell.h"
#import "Register2TableViewCell.h"
#import "payPwdViewController.h"
@interface verifyViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    
    UITableView *_tableView;
    NSString * _phoneStr;
    NSString * _cvvStr;
    NSTimer *_gameTimer;
    NSDate   *_gameStartTime;

}

@end

@implementation verifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"验证身份";
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
    [btn setTitle:@"下一步" forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    btn.titleLabel.font = AppFont;
    btn.backgroundColor = AppRegTextCOLOR;//[UIColor redColor];
    [view addSubview:btn];
    ViewRadius(btn, 5);
    [btn addTarget:self action:@selector(okbtn) forControlEvents:UIControlEventTouchUpInside];
    _tableView.tableFooterView = view;
}




-(void)shoujianpan{
    UITextField * text1 = (UITextField*)[self.view viewWithTag:410];
    UITextField * text2 = (UITextField*)[self.view viewWithTag:411];
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
    if (textField.tag == 410) {
        _phoneStr = textField.text;
    }
    else if(textField.tag == 411){
        _cvvStr = textField.text;
        
    }
    //[_tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
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
    static NSString *cellid2 = @"Register2TableViewCell";
    if (indexPath.row == 1) {
        
        Register2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid2];
        if (!cell) {
            cell = [[Register2TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid2];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textField.text = _cvvStr;
        cell.textField.delegate = self;
        cell.textField.tag = 411;
        cell.cvvBtn.tag = 420;
        [cell.cvvBtn addTarget:self action:@selector(actionYanzhen:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
        
    }
    else
    {
        RegisterTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
        if (!cell) {
            cell = [[RegisterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid1];
            
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
            cell.textField.placeholder = @"请输入手机号码";
            cell.textField.text = _phoneStr;
            cell.textField.delegate = self;
            cell.textField.tag = 410;
            cell.textField.secureTextEntry = NO;
            
            return cell;
            
        }


    return [[UITableViewCell alloc]init];
}
-(void)actionYanzhen:(UIButton*)btn{
    _gameStartTime=[NSDate date];
    [self shoujianpan];
    
    if (!_phoneStr.length) {
        [self showAllTextDialog:@"请输入手机号码"];
        return;
    }
    if (![CommonUtil isMobile:_phoneStr]) {
        [self showAllTextDialog:@"请正确输入手机号码"];
        return;
    }

    
    NSDictionary * Parameterdic = @{
                                    @"phone":_phoneStr,
                                    @"type":@(2)
                                    };
    
    NSString * url = @"";
    if ([_verifyStr isEqualToString:@"1"]) {
        Parameterdic = @{
                         @"phone":_phoneStr,
                         @"type":@(1)
                         };
        
    }
    if ([_verifyStr isEqualToString:@"2"]) {
        Parameterdic = @{
                         @"phone":_phoneStr,
                         @"type":@(2)
                         };
        
    }
    if ([_verifyStr isEqualToString:@"3"]) {
        Parameterdic = @{
                         @"phone":_phoneStr,
                         @"type":@(3)
                         };
        
    }


    url = @"api/user/genCode.json";

    [self.requestManager postWithUrl:url refreshCache:NO params:Parameterdic IsNeedlogin:NO success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        [self showAllTextDialog:@"发送成功，请留意你的手机短信"];
        _gameTimer= [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        
        [self showAllTextDialog:description];
        
        NSLog(@"失败");
    }];
    
    
    
}
// 时钟触发执行的方法
- (void)updateTimer:(NSTimer *)sender
{
    UIButton * btn = (UIButton*)[self.view viewWithTag:420];
    NSInteger deltaTime = [sender.fireDate timeIntervalSinceDate:_gameStartTime];
    
    NSString *text = [NSString stringWithFormat:@"%ld",60 - deltaTime];
    
    if (deltaTime>60) {
        [btn setTitle:@"重新发送" forState:UIControlStateNormal];
        [btn setUserInteractionEnabled:YES];
        [_gameTimer invalidate];
        return;
    }else
    {
        [btn setTitle:text forState:UIControlStateNormal];
        [btn setUserInteractionEnabled:NO];
        
    }
    
}
-(void)okbtn{
    
    [self shoujianpan];
    if (!_phoneStr.length) {
        [self showAllTextDialog:@"请输入手机号码"];
        return;
    }
    
    
    if (!_cvvStr.length) {
        [self showAllTextDialog:@"请输入验证码"];
        return;
    }
    //[self showLoading];
    payPwdViewController * ctl = [[payPwdViewController alloc]init];
    ctl.verifyStr =  _verifyStr;
    ctl.phoneStr = _phoneStr;
    ctl.cvvStr = _cvvStr;
    [self pushNewViewController:ctl];

    /*
    NSDictionary * Parameterdic = @{
                                    @"mobile":_phoneStr,
                                    @"password":_pwd1Str,
                                    @"Code":_cvvStr
                                    };
    [self.requestManager postWithUrl:@"api/user/register.json" refreshCache:NO params:Parameterdic IsNeedlogin:NO success:^(id resultDic) {
        [self stopshowLoading];
        [self showAllTextDialog:@"注册成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
            //         [self.navigationController popToRootViewControllerAnimated:YES];
        });
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
        NSLog(@"失败");
        
        
    }];
    
    */
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
