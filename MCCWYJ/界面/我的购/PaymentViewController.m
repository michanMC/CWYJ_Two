//
//  PaymentViewController.m
//  MCCWYJ
//
//  Created by MC on 16/6/22.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "PaymentViewController.h"
#import "ShoppingFillTableViewCell.h"
#import "MyIntegralModel.h"
#import "PayOfPickModel.h"
#import "LTAlertView.h"
#import "ShoppingQXViewController.h"
#import "BuyOrderViewController.h"
#import "verifyViewController.h"
@interface PaymentViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    
    UITableView *_tableView;
//    MyIntegralModel * _IntegralModel;
    
    NSInteger cell2index;
    NSInteger cell3index;

    NSString * cell2Str;
     CGFloat  counteract1;
    PayOfPickModel * _PickModel;
    NSString *_paymentStr;
    
    BOOL _isthirdpay;//需不需要第三方支付
    NSString *_payment;
    
    YJUserModel * _usermodel;

    
    
}
@end

@implementation PaymentViewController
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self Datadetail];
    
}
-(void)Datadetail{
    [self.requestManager postWithUrl:@"api/user/detail.json" refreshCache:NO params:nil IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        
        NSLog(@"查询资料resultDic == %@",resultDic);
        
        
        _usermodel  = [YJUserModel mj_objectWithKeyValues:resultDic[@"object"]];
        
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
    }];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    //监听数据的刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didwxpayObj:) name:@"WXPaymentObjNotification" object:nil];
    //监听数据的刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didZFpayObj:) name:@"zhifupayObjNotification" object:nil];
    if (!_typeIndex.length) {
        
    if ([_BuyModlel.type isEqualToString:@"sell"]) {
        _typeIndex = @"0";
    }
    else if ([_BuyModlel.type isEqualToString:@"pick"]){
        _typeIndex = @"1";

    }
    }
    
    if (!_typeIndex.length) {
        [self showHint:@"分不清代购还是售卖"];
        return;
    }
    if (!_buyIdStr.length) {
    
    if (_BuyModlel) {
        _buyIdStr = _BuyModlel.id;
    }
    }
    
    
    self.title = @"支付方式";
    cell2Str = @"可抵用0元";
    _paymentStr =@"你还需支付￥0.00";
    _payment = @"0.00";
    cell3index = 3;
    _isthirdpay = NO;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self fooerView];
self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(actionBack)];
    [self loadgetPurse];
    
    // Do any additional setup after loading the view.
}
#pragma mark-监听支付包
- (void)didZFpayObj:(NSNotification *)notication{
    NSDictionary * resultDic =notication.object;
    //9000:支付成功   6001:支付失败/放弃支付
    if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
        
        //                //刷新购物车的商品
        //                [MallUtils userDefaultsKey:@"ShoppingCartRefresh" Value:YES];
        
        [self showAllTextDialog:@"支付成功"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self BuyDetail];
        });
        
        
        
        
    }else{
        [self showAllTextDialog:@"支付失败"];
        
        
        
    }

    
}
#pragma mark-监听微信支付
- (void)didwxpayObj:(NSNotification *)notication{
    
    NSLog(@">>>%@",notication);
    if ([notication.object isEqualToString:@"Fail"] ) {//失败
        
        [self showAllTextDialog:@"支付失败"];
        

    }
  else  if ([notication.object isEqualToString:@"Cancel"] ) {//失败
        
        [self showAllTextDialog:@"支付已取消"];
        
        
    }

    else if ([notication.object isEqualToString:@"success"] ){
        
        [self showAllTextDialog:@"支付成功"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self BuyDetail];
        });

        
    }
}

-(void)BuyDetail{
    if (!_buyIdStr.length) {
        [self showHint:@"无效id"];
        return;
    }
    
    if ([_typeIndex isEqualToString:@"0"]) {//售
//        MCBuyModlel * modle = _dataAarray[indexPath.section];
//        BuyOrderViewController *ctl = [[BuyOrderViewController alloc]init];
//        ctl.BuyModlel = modle;
//        
//        
//        [_delegate pushNewViewController:ctl];
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didPurchaseViewObjNotification" object:@""];
        [self.navigationController popViewControllerAnimated:YES];
    
    
    }
    
  else  if ([_typeIndex isEqualToString:@"1"]) {//代购
        
    NSDictionary * Parameterdic = @{
                                    @"buyId":_buyIdStr
                                    
                                    };
    
    
    [self showLoading];
    [self.requestManager postWithUrl:@"api/buy/getBuyDetail.json" refreshCache:NO params:Parameterdic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        NSDictionary * dic = resultDic[@"object"];
        MCBuyModlel* Buy_Modlel = [MCBuyModlel mj_objectWithKeyValues:dic];
        NSString * imageUrl = dic[@"imageUrl"];
        id result = [self analysis:imageUrl];
        if ([result isKindOfClass:[NSArray class]]) {
            Buy_Modlel.imageUrl = result;
        }
        id json = [self analysis:Buy_Modlel.json];
        Buy_Modlel.Buyjson = [MCBuyjson mj_objectWithKeyValues:json];
        for (NSString * url in Buy_Modlel.imageUrl) {
            YJphotoModel*   photoModel =[[YJphotoModel alloc]init];
            photoModel.raw = url;
            [Buy_Modlel.YJphotos addObject:photoModel];
            
        }
        
        
        Buy_Modlel.MCdescription = dic[@"description"];
        Buy_Modlel.userModel = [YJUserModel mj_objectWithKeyValues:_BuyModlel.user];
     
        ShoppingQXViewController *ctl = [[ShoppingQXViewController alloc]init];
        NSMutableArray *dataAarray = [NSMutableArray array];
        [dataAarray addObject:Buy_Modlel];
        ctl.BuyModlel = Buy_Modlel;
        ctl.dataArray = dataAarray;
        ctl.index = 0;//indexPath.section;
        ctl.isback = YES;
        [self pushNewViewController:ctl];

        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];

        NSLog(@"失败");
    }];
    

    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 3333) {
        if (buttonIndex == 0) {
           
            verifyViewController * ctl = [[verifyViewController alloc]init];
                ctl.verifyStr = @"2";
                
            
            [self pushNewViewController:ctl];
  
            
            
        }
        return;
    }
    if (buttonIndex == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
 
    }
}
-(void)actionBack{
    
    if ([_typeIndex isEqualToString:@"0"]&&!_isBackRoot) {
        UIAlertView * al = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"订单将保存在我的售买单里" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [al show];
        
    }
    else
    [self.navigationController popViewControllerAnimated:YES];
    return;

    if (IOS8) {
            [self.navigationController popViewControllerAnimated:YES];
        
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"didmcbackObjNotification" object:@""];
  
    }
    else
    {
    NSArray * vcs =  self.navigationController.viewControllers;
    if (vcs.count>2) {
        [self.navigationController popToViewController:[vcs objectAtIndex:vcs.count - 3] animated:YES];

    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    }
    
    
    //[self.navigationController popViewControllerAnimated:YES];
}

-(void)fooerView{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 100)];
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(40, 30, Main_Screen_Width - 80, 40)];
//    btn.backgroundColor = AppCOLOR;
    [btn setBackgroundImage:[UIImage imageNamed:@"login_red_btn"] forState:0];
    [btn setTitle:@"支付" forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    
    btn.titleLabel.font = AppFont;
    [view addSubview:btn];
    [btn addTarget:self action:@selector(actionnext) forControlEvents:UIControlEventTouchUpInside];
    _tableView.tableFooterView = view;
    
    
    
}
-(void)actionnext{
    
    NSLog(@"=========%zd",_isthirdpay);//1yao
    if (!_usermodel.hasPayPassword) {
        UIAlertView * al = [[UIAlertView alloc]initWithTitle:@"提示" message:@"你尚未设置支付密码，现在去设置?" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        
        al.tag  = 3333;
        [al show];
        return;
    }
    

    if (_isthirdpay) {
        if (cell3index == 3) {
            [self showHint:@"请选择支付方式"];
        }
       else if (cell3index == 0) {//支付宝
           [self ZFPrepyaIdOfPay];
           
           
        }
       else if (cell3index == 1) {//微信
           [self WXPrepyaIdOfPay:@""];
           
           
       }
        
        
        
        
        
    }
    else
    {
    
    __weak  PaymentViewController* swakSelf = self;
    [LTAlertView showConfigBlock:^(LTAlertView *alertView) {
        alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
    } Title:@"提示" message:@"请输入支付密码" ButtonTitles:@[@"确定",@"取消"] OnTapBlock:^(LTAlertView* alert,NSInteger num) {
        
        if (num==0) {
            
            NSString* str = [alert textFieldAtIndex:0].text;
            NSLog(@"输入的文字是%@,点击了第%d个按钮",str,num);
            
           // [swakSelf drawCash:str];
            
            [swakSelf apppay:str Type:[_typeIndex integerValue]];
            
        }
        
    }];

    }
    
    
}

#pragma mark-直接支付
-(void)apppay:(NSString *)str Type:(NSInteger)type{
    if (!_buyIdStr.length) {
        [self showHint:@"无效id"];
        return;
    }
    
    if (!_usermodel.hasPayPassword) {
        UIAlertView * al = [[UIAlertView alloc]initWithTitle:@"提示" message:@"你尚未设置支付密码，现在去设置?" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        
        al.tag  = 3333;
        [al show];
        return;
    }
    
    
    
    NSString *sign = [CommonUtil md5:str];

    [self showLoading];
    NSDictionary * dic = @{
                           @"type":@([_typeIndex intValue]),
                           @"orderId":_buyIdStr,
                           @"password":sign
                           };
    [self.requestManager postWithUrl:@"api/buy/pay.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
        [self showAllTextDialog:@"支付成功"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self BuyDetail];
        });

        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
    }];
    

    
}
#pragma mark-支付宝
-(void)ZFPrepyaIdOfPay{
    
    if (!_buyIdStr.length) {
        [self showHint:@"无效id"];
        return;
    }
    [self showLoading];
    NSDictionary * dic = @{
                           @"type":@([_typeIndex integerValue]),
                           @"orderId":_buyIdStr,
                           @"amount":_payment
                           
                           };
    [self.requestManager postWithUrl:@"api/buy/genOrderInfo.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
//        [self wxpay:resultDic[@"object"]];
        
        [self alipay:resultDic];
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
    }];
    

    
}
#pragma mark-微信
-(void)WXPrepyaIdOfPay:(NSString*)amount{
    
//    [_payment floatValue];
    if (!_buyIdStr.length) {
        [self showHint:@"无效id"];
        return;
    }
        [self showLoading];
    NSDictionary * dic = @{
                           @"type":@([_typeIndex integerValue]),
                           @"orderId":_buyIdStr,
                           @"amount":_payment

                           };
    [self.requestManager postWithUrl:@"api/buy/genPrepyaIdOfPay.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
        [self wxpay:resultDic[@"object"]];
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
    }];

    
    
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
        //            __weak typeof(GBOneBuyGoodModel*) weakmodel = _goodModel;
        //            __weak typeof(NSString*) weakonebuyorder_id = _onebuyorder_id;
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            
            //9000:支付成功   6001:支付失败/放弃支付
            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                
                //                //刷新购物车的商品
                //                [MallUtils userDefaultsKey:@"ShoppingCartRefresh" Value:YES];
                
                [weakSelf showAllTextDialog:@"支付成功"];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [weakSelf BuyDetail];
                });

                
                
                
            }else{
                [self showAllTextDialog:@"支付失败"];
                
                
                
            }
        }];
    }
 
    
    
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
-(void)loadgetPurse{
    
    if (!_buyIdStr.length) {
        [self showHint:@"无效id"];
        return;
    }
        [self showLoading];
    NSDictionary * dic;
    NSString * url;
    if ([_typeIndex isEqualToString:@"1"]) {
       dic = @{
            @"buyId":_buyIdStr
            };
        url = @"api/buy/getPayOfPick.json";
    }
    else if ([_typeIndex isEqualToString:@"0"]){
        dic = @{
                @"orderId":_buyIdStr
                };
 url = @"api/buy/getPayOfSell.json";
        
    }
    
    [self.requestManager postWithUrl:url refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
        /*
         userIntetral = 0;用户积分
         subSystemIntegral = 4;
         targetId = 194;
         totalPrice = 43;
         remainPrice = 39;
         systemIntegral = 55;
         subUserIntegral = 0;抵用积分（采点）

         */
         
        
        _PickModel = [PayOfPickModel mj_objectWithKeyValues:resultDic[@"object"]];
        
        
         NSString * str = [NSString stringWithFormat:@"你还需支付￥%.2f",[_PickModel.integralOfOther floatValue]];
        
        _paymentStr =str;//_PickModel.integralOfOther;
        
        
        _payment = _PickModel.integralOfOther;

        if ([_PickModel.integralOfOther floatValue]) {
            _isthirdpay = YES;
        }
        else
        {
            _isthirdpay = NO;

        }
        
        [_tableView reloadData];
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
    }];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_isthirdpay) {
        return 3;
 
    }
    else
    {
        return 2;
    }
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 3;
    }
    if (section == 2) {
        return 2;
    }
    
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return 40;
    }
    
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 44;
    }
    if (indexPath.section == 1&&indexPath.row == 2) {
        return 44;
    }
    if (indexPath.section == 1&& indexPath.row == 0) {
        return 60;
    }
    if (indexPath.section == 1&& indexPath.row == 1) {
        return 50;
    }

    return 60;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 40)];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 40)];
        lbl.textColor = AppTextCOLOR;
        lbl.text = @"请选择账号类型";
        lbl.font = AppFont;
        [view addSubview:lbl];
        return view;
    }
    return [[UIView alloc]init];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellid = @"ShoppingFillTableViewCell";
    ShoppingFillTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[ShoppingFillTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.BuyModlel = _BuyModlel;
    if (indexPath.section == 0) {
//        cell.countStr = _datadic[@"count"];
        [cell prepareUI2];
        NSString *ss2 = _datadic[@"caidianStr"];

        NSString * ss = [NSString stringWithFormat:@"￥%.2f",[_PickModel.totalPrice floatValue]];
        cell.priceLbl.text = ss;//@"￥233";

        return cell;
        
        
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.sytemIntegral = _PickModel.systemIntegral;

            [cell prepareUI6];
            
            
            cell.sytemminLbl.text = [NSString stringWithFormat:@"已抵用￥%.2f",[_PickModel.subSystemIntegral floatValue]];

            return cell;
        }
        else if (indexPath.row == 1)
        {
            cell.rechargeIntegral = _PickModel.userIntetral;

            [cell prepareUI7];
            cell.rechargeminLbl.text = [NSString stringWithFormat:@"可抵用￥%.2f",[_PickModel.subUserIntegral floatValue]];;
            
            
            
            cell.seleBtn.selected = cell2index;
            
            
            [cell.seleBtn addTarget:self action:@selector(actionSeleBtn:) forControlEvents:UIControlEventTouchUpInside];
            return cell;

        }
        else if (indexPath.row == 2)
        {
            
            [cell prepareUI8];
            
            NSString * str = _paymentStr;//[NSString stringWithFormat:@"你还需支付￥%.2f",[_PickModel.remainPrice floatValue]];
//            if (cell2index==0) {//不用
//               str = _paymentStr
//            }
//            else
//            {
//                
//            }
            
            
       NSMutableAttributedString * Attristr=     [CommonUtil formatString:str textColor:RGBCOLOR(127, 125, 147) font:16 textordinaryColor:RGBCOLOR(207, 0, 51) startNum:5 toNum:(str.length-5)];
            
            
            [cell.titleLbl setAttributedText:Attristr];
            
//            cell.titleLbl.text = [NSString stringWithFormat:@"你还需支付￥%.2f",s];
            
            return cell;
            
        }

    }
    if (indexPath.section == 2) {
        [cell prepareUI9];
        if (indexPath.row == 0) {
            cell.imgview.image = [UIImage imageNamed:@"支付宝"];
            cell.titleLbl.text = @"支付宝";
            if (cell3index == 0) {
                cell.seleBtn.selected = YES;
            }
            else{
                cell.seleBtn.selected = NO;
            }

            return  cell;

        }
        else
        {
            cell.imgview.image = [UIImage imageNamed:@"微信1"];
            cell.titleLbl.text = @"微信";

            if (cell3index == 1) {
                cell.seleBtn.selected = YES;
            }
            else{
                cell.seleBtn.selected = NO;
            }

            return  cell;

        }
        
        
    }

    
    
    
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        if (cell3index == indexPath.row) {
            cell3index = 3;
        }
        else
        {
            cell3index = indexPath.row;
 
        }
        [_tableView reloadData];
            }
}
-(void)actionSeleBtn:(UIButton*)btn{
    
    
    
    if (btn.selected) {
        btn.selected = NO;
        cell2index = 0;
        NSString * str = [NSString stringWithFormat:@"你还需支付￥%.2f",[_PickModel.integralOfOther floatValue]];
        
        _paymentStr =str;
        
        _payment = _PickModel.integralOfOther;

        
        
        if ([_PickModel.integralOfOther floatValue]) {
            _isthirdpay = YES;
        }
        else
        {
            _isthirdpay = NO;
            
        }

        
        
    }
    else
    {
        btn.selected = YES;
        cell2index = 1;
        
        NSString * str = [NSString stringWithFormat:@"你还需支付￥%.2f",[_PickModel.remainPrice floatValue]];
        
        _paymentStr =str;
        
        _payment = _PickModel.remainPrice;
        
        
        
        if ([_PickModel.remainPrice floatValue]) {
            _isthirdpay = YES;
        }
        else
        {
            _isthirdpay = NO;
            
        }
        

    }
    
    [_tableView reloadData];
    
}

-(void)showthirdpay{
    
    [_tableView reloadData];
    
    
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
