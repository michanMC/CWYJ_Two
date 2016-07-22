//
//  RechargeViewController.m
//  MCCWYJ
//
//  Created by MC on 16/5/27.
//  Copyright © 2016年 MC. All rights reserved.
//
#define NUMBERS @"0123456789.\n"

#import "RechargeViewController.h"
#import "RechargeTableViewCell.h"
#import "RechargeSuccViewController.h"
@interface RechargeViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    
    
    UITableView *_tableView;
    UILabel *_caidianLbl;
    NSString * _cellidex;
    NSString * _jieStr;

}

@end

@implementation RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值";
    _cellidex = @"0";
    //监听数据的刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didZFpayObj:) name:@"RechargeViewObjNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didwxpayObj:) name:@"WXRechargeViewObjNotification" object:nil];

     _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = AppMCBgCOLOR;

    [self prepareHeaderView];
    [self prepareFooerView];
    // Do any additional setup after loading the view.
}
#pragma mark-监听支付包
- (void)didZFpayObj:(NSNotification *)notication{
    NSDictionary * resultDic =notication.object;
    //9000:支付成功   6001:支付失败/放弃支付
    if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
        
        [self showAllTextDialog:@"充值成功"];
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MyIntegralViewObjNotification" object:@""];
        CGFloat ss = [_rechargeIntegral floatValue] + [_jieStr floatValue];
        NSString * sss = [NSString stringWithFormat:@"%.2f",ss];
        _caidianLbl.text = sss;//@"23333";
        
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            RechargeSuccViewController * ctl = [[RechargeSuccViewController alloc]init];
            ctl.title = @"充值";
            ctl.titleStr = @"充值成功";
            ctl.subtitleStr = [NSString stringWithFormat:@"你已经成功充值%@采点",_jieStr ];//@"你已经成功充值233采点";
            [self pushNewViewController:ctl];
            
        });
        
        
        
        
        
    }else{
        [self showAllTextDialog:@"充值失败"];
        
        
        
    }
    
    
}
#pragma mark-监听微信支付
- (void)didwxpayObj:(NSNotification *)notication{
    
    NSLog(@">>>%@",notication);
    if ([notication.object isEqualToString:@"Fail"] ) {//失败
        
        [self showAllTextDialog:@"充值失败"];
        
        
    }
    else  if ([notication.object isEqualToString:@"Cancel"] ) {//失败
        
        [self showAllTextDialog:@"充值已取消"];
        
        
    }
    
    else if ([notication.object isEqualToString:@"success"] ){
        
        [self showAllTextDialog:@"充值成功"];
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MyIntegralViewObjNotification" object:@""];
        CGFloat ss = [_rechargeIntegral floatValue] + [_jieStr floatValue];
        NSString * sss = [NSString stringWithFormat:@"%.2f",ss];
        _caidianLbl.text = sss;//@"23333";
        
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            RechargeSuccViewController * ctl = [[RechargeSuccViewController alloc]init];
            ctl.title = @"充值";
            ctl.titleStr = @"充值成功";
            ctl.subtitleStr = [NSString stringWithFormat:@"你已经成功充值%@采点",_jieStr ];//@"你已经成功充值233采点";
            [self pushNewViewController:ctl];
            
        });
        
        
        
        
    }
}


-(void)prepareFooerView{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 120)];
    view.backgroundColor = AppMCBgCOLOR;//[UIColor groupTableViewBackgroundColor];
    _tableView.tableFooterView = view;
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(40, 40, Main_Screen_Width - 80, 40)];
    btn.backgroundColor = AppRegTextCOLOR;
    ViewRadius(btn, 5);
    [btn setTitle:@"充值" forState:0];
    btn.titleLabel.font  = AppFont;
    [btn addTarget:self action:@selector(actionchongzhi) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    [view addSubview:btn];
    
    
    
    
}

-(void)prepareHeaderView{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 70)];
    view.backgroundColor = [UIColor whiteColor];
    _tableView.tableHeaderView = view;
    CGFloat x = 10;
    CGFloat y = 10;
    CGFloat w = 50;
    CGFloat h = w;
    UIImageView * imgview = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    imgview.image = [UIImage imageNamed:@"icon_money"];
    [view addSubview:imgview];
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(70, 0, 70, 70)];
    lbl.textColor = AppTextCOLOR;
    lbl.text = @"我的采点";
    lbl.font = [UIFont systemFontOfSize:16];
    [view addSubview:lbl];
    
    _caidianLbl = [[UILabel alloc]initWithFrame:CGRectMake(70 + 70 + 5, 0, Main_Screen_Width - 140 - 60, 70)];
    _caidianLbl.textColor = AppCOLOR;
    _caidianLbl.text = _rechargeIntegral;//@"23333";
    _caidianLbl.font = [UIFont systemFontOfSize:16];
    [view addSubview:_caidianLbl];
    
    
    
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width - 10 - 70, 0, 70, 70)];
    lbl.textColor = [UIColor lightGrayColor];
    lbl.textAlignment = NSTextAlignmentRight;
    lbl.text = @"1采点=1元";
    lbl.font = [UIFont systemFontOfSize:14];
    [view addSubview:lbl];


    
    
    
    
    
    
}
-(void)actionchongzhi{
    
    UITextField * text = [self.view viewWithTag:500];
    [text resignFirstResponder];
    NSInteger index = 0;
    NSString * urlStr = @"";
    
    if ([_cellidex isEqualToString:@"1"]) {//支付宝
        index = 1;
        urlStr = @"api/purse/genOrderInfo.json";
        
    }
    else if ([_cellidex isEqualToString:@"2"]){
        //微信
        index = 2;
        urlStr = @"api/purse/genPrepayId.json";
    }
    if (!index) {
        [self showHint:@"请选择充值方式"];
        return;
    }
    if (!_jieStr.length) {
        [self showHint:@"请输入充值金额"];
        return;
    }
    
        [self showLoading];
    NSDictionary * dic = @{
                         @"amount":_jieStr
                           };
    [self.requestManager postWithUrl:urlStr refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
        
        if (index == 1) {//支付宝充值
            [self alipay:resultDic];

        }
        else if (index == 2){//微信
            
            [self wxpay:resultDic[@"object"]];

        }
        
        
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
    }];

    
    
    
    
    
    
    
}
#pragma mark-调器微信

-(void)wxpay:(NSDictionary*)dic{
    /*
     resultDic ==={
     message = 操作成功;
     object = {
     partner = 1362624302;商户号
     prepenId = wx20160713101401b24b6f87180142193992; 预支付订单
     payKey = ak132132ak132132ak132132Ak132132;商户号支付key值
     }
     */
    //已安装较新版本的微信
    if([WXApi isWXAppInstalled] == YES && [WXApi isWXAppSupportApi] == YES)
    {
        NSString    *time_stamp, *nonce_str1;
        //设置支付参数
        time_t now;
        time(&now);
        time_stamp  = [NSString stringWithFormat:@"%ld", now];
        nonce_str1	= [CommonUtil md5:time_stamp];
        
        PayReq *request = [[PayReq alloc] init];
        //注册秘钥
        request.openID = @"wx4b6f3cac7fa9e6f2";//dic[@"payKey"];
        //商户号
        request.partnerId = dic[@"partner"];
        //预支付订单ID
        request.prepayId = dic[@"prepenId"];
        //商家 财付通签名 这个是固定写死
        request.package = @"Sign=WXPay";
        //随机串
        request.nonceStr = nonce_str1;
        //请求时间
        request.timeStamp = [time_stamp intValue];
        //商家 微信开发平台签名 64F0562166BFA93EC49F05C70E587ABB 9C6819BB8D3D88DDD4FF7A0927FB7315
        // 构造参数列表
        //nonce_str = [WXUtil md5:[MallUtils get_req_time]];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@"wx4b6f3cac7fa9e6f2" forKey:@"appid"];//注册秘钥
        [params setObject:nonce_str1 forKey:@"noncestr"];
        [params setObject:@"Sign=WXPay" forKey:@"package"];
        [params setObject:dic[@"partner"] forKey:@"partnerid"];//商户号
        [params setObject:time_stamp forKey:@"timestamp"];
        [params setObject:dic[@"prepenId"] forKey:@"prepayid"];//预支付订单ID
        
        request.sign = [CommonUtil createMd5Sign:params Key:dic[@"payKey"]];
        
        
        //   NSLog(@"\n注册信息:%@\n商户号:%@\n预支付订单ID:%@\n商家签名:%@\n随机字符串:%@\n请求时间:%d\nSign签名:%@",appid,request.partnerId,request.prepayId,request.package,request.nonceStr,request.timeStamp,request.sign);
        
        /*! @brief 发送请求到微信，等待微信返回onResp
         *
         * 函数调用后，会切换到微信的界面。第三方应用程序等待微信返回onResp。微信在异步处理完成后一定会调用onResp。支持以下类型
         * SendAuthReq、SendMessageToWXReq、PayReq等。
         * @param req 具体的发送请求，在调用函数后，请自己释放。
         * @return 成功返回YES，失败返回NO。
         */
        [self stopshowLoading];
        
        [WXApi sendReq:request];
        
        
    }
    else
    {
        [self stopshowLoading];
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:[WXApi isWXAppInstalled] == NO ?@"检测到你的手机还没有安装微信，是否现在安装 ?" : [WXApi isWXAppSupportApi] == NO ? @"请升级最新版本微信 !" : @"检测微信失败 !"
                                                           delegate:nil
                                                  cancelButtonTitle:@"取消"
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles:@"立即前往下载",nil];
        [sheet showInView:self.view withCompletionHandler:^(NSInteger buttonIndex)
         {
             NSLog(@"buttonIndex = %ld",buttonIndex);
             if (buttonIndex==0)
             {
                 NSString *string=[WXApi getWXAppInstallUrl];
                 NSURL *url=[NSURL URLWithString:string];
                 [[UIApplication sharedApplication] openURL:url];
                 //                 [self.navigationController popToRootViewControllerAnimated:YES];
                 
             }else if (buttonIndex==1)
             {
                 
                 [self showAllTextDialog:@"已取消"];
             }
         }];
        
    }
    
}

#pragma mark-调器支付宝
-(void)alipay:(NSDictionary*)dic{
    
    NSString *appScheme = @"ciwei";
    
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    NSString *signedString = dic[@"object"];//[signer signString:resultDic[@"object"]];
    NSLog(@"signedString = %@",signedString);
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = signedString;
        
        __weak typeof(self) weakSelf = self;
        
        
            __weak typeof(UILabel*) weaklbl = _caidianLbl;
        
        
                __weak typeof(NSString*) weak_jieStr = _jieStr;
        __weak typeof(NSString*) weak_rechargeIntegral = _rechargeIntegral;

        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            
            //9000:支付成功   6001:支付失败/放弃支付
            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                
                //                //刷新购物车的商品
                //                [MallUtils userDefaultsKey:@"ShoppingCartRefresh" Value:YES];
                
                [weakSelf showAllTextDialog:@"充值成功"];
                //发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"MyIntegralViewObjNotification" object:@""];
                
                
                CGFloat ss = [weak_rechargeIntegral floatValue] + [weak_jieStr floatValue];
                NSString * sss = [NSString stringWithFormat:@"%.2f",ss];
                weaklbl.text = sss;//@"23333";

                
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    RechargeSuccViewController * ctl = [[RechargeSuccViewController alloc]init];
                    ctl.title = @"充值";
                    ctl.titleStr = @"充值成功";
                    ctl.subtitleStr = [NSString stringWithFormat:@"你已经成功充值%@采点",weak_jieStr ];//@"你已经成功充值233采点";
                    [weakSelf pushNewViewController:ctl];

                    
//                    [weakSelf BuyDetail];
                });
                
                
                
                
            }else{
                [self showAllTextDialog:@"充值失败"];
                
                
                
            }
        }];
    }
    
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString * cellid = @"RechargeTableViewCell";
    RechargeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[RechargeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section== 0) {
        if (indexPath.row == 0) {
            [cell prepareUI1];
            return cell;
        }
        if (indexPath.row == 1) {
            [cell prepareUI2];
            cell.selectBtn.selected =[_cellidex isEqualToString:@"1"]?YES:NO;
            
            return cell;

            
            
        }
        if (indexPath.row == 2) {
            [cell prepareUI2];
            cell.imgview.image = [UIImage imageNamed:@"微信1"];
            cell.textField.text = @"微信充值";
            cell.selectBtn.selected =[_cellidex isEqualToString:@"2"]?YES:NO;

            return cell;
            
        }

    }
    else
    {
        [cell prepareUI3];
        
        cell.textField.delegate = self;
        cell.textField.tag = 500;
        cell.textField.text = _jieStr;
        

        return cell;

    }
    
    
    
    
    return [[UITableViewCell alloc]init];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0&&indexPath.row != 0) {
        
        if (indexPath.row == 1) {
            if ([_cellidex isEqualToString:@"1"]) {
                _cellidex = @"0";

            }
            else
            _cellidex = @"1";
            
        }
        else if (indexPath.row == 2){
            if ([_cellidex isEqualToString:@"2"]) {
                _cellidex = @"0";
                
            }
            else
            _cellidex = @"2";

        }
        [_tableView reloadData];
    }
    
    
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"textField1 ===%.2f",[textField.text floatValue]);
//    CGFloat max = [_priceStr floatValue];
//    
//    if ([textField.text floatValue]>max) {
//        textField.text = [NSString stringWithFormat:@"%.2f",max];
//    }
//    else if([textField.text floatValue]<1){
//        textField.text = @"";
//        
//    }
    NSLog(@"textField1 ===%.2f",[textField.text floatValue]);
    NSString *str1 = [NSString stringWithFormat:@"%.2f",[textField.text floatValue]];
    
    CGFloat str = [textField.text floatValue];
    
    _jieStr = str1;
    textField.text = _jieStr;
    NSLog(@"textField = %@",textField.text);
    
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSCharacterSet *cs;
    
    cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    
    if(!basicTest)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请输入数字"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        
        [alert show];
        return NO;
    }
    
    
    
    
    
    if ([string isEqualToString:@"\n"]){
        [textField resignFirstResponder];
        return NO;
    }
    NSString * aString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    
    if ([string isEqualToString:@"."]) {
        if([textField.text rangeOfString:@"."].location !=NSNotFound)//_roaldSearchText
        {
            
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"输入有误"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            
            [alert show];
            return NO;
            
        }
        else
        {
            
            
            
        }
    }
    
    
    NSLog(@"aString ===%.2f",[aString floatValue]);
    if([aString floatValue]<1){
        textField.text = @"1";
        
    }

    
    return YES;
    
    
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
