//
//  BuyOrderViewController.m
//  MCCWYJ
//
//  Created by MC on 16/6/21.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "BuyOrderViewController.h"
#import "BuyOrderTableViewCell.h"
#import "PaymentViewController.h"
#import "MCDrawBackViewController.h"
#import "WNImagePicker.h"
#import "RefundXQViewController.h"
#import "ShoppingQXViewController.h"
@interface BuyOrderViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    
    UITableView * _tableView;
    
    UIView * _bgView;
    
}
@property(nonatomic,strong)UIButton *typeBtn;
@property(nonatomic,strong)UIButton *type2Btn;

@end

@implementation BuyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
     _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64-50) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = AppMCBgCOLOR;

    
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height - 50, Main_Screen_Width, 50)];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bgView];
    
    CGFloat w = [MCIucencyView heightforString:@"申请退款" andHeight:30 fontSize:14] + 10;
    CGFloat y = 10;

   CGFloat x = Main_Screen_Width - w - 10;
   CGFloat h = 30;
    
    _typeBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    
    x -= (w +10);
    
//    AppRegTextCOLOR
    [_typeBtn setTitleColor:RGBCOLOR(207, 0, 51) forState:0];
    [_typeBtn setTitle:@"申请退款" forState:0];
    _typeBtn.titleLabel.font = AppFont;
    ViewRadius(_typeBtn, 3);
    
    _typeBtn.layer.borderColor = RGBCOLOR(207, 0, 51).CGColor;
    _typeBtn.layer.borderWidth = 1;
    [_typeBtn addTarget:self action:@selector(actiontypeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:_typeBtn];
    
    _type2Btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [_type2Btn setTitleColor:RGBCOLOR(207, 0, 51) forState:0];
    [_type2Btn setTitle:@"确认收货" forState:0];
    _type2Btn.titleLabel.font = AppFont;
    ViewRadius(_type2Btn, 3);
    _type2Btn.layer.borderColor = RGBCOLOR(207, 0, 51).CGColor;
    _type2Btn.layer.borderWidth = 1;
    [_type2Btn addTarget:self action:@selector(actiontypeBtn:) forControlEvents:UIControlEventTouchUpInside];

    [_bgView addSubview:_type2Btn];
    
    
    
    _type2Btn.hidden = YES;
    
    _typeBtn.hidden = NO;
    
    if ([_BuyModlel.Buystatus isEqualToString:@"-1"]) {
        _type2Btn.hidden = NO;
        
        [_typeBtn setTitle:@"付款" forState:0];
        [_type2Btn setTitle:@"取消订单" forState:0];
        _type2Btn.layer.borderColor = [UIColor grayColor].CGColor;
        [_type2Btn setTitleColor:[UIColor grayColor] forState:0];
        
        
    }
    else
    {
        if ([_BuyModlel.Buystatus isEqualToString:@"0"]||[_BuyModlel.Buystatus isEqualToString:@"1"]) {
            _typeBtn.hidden = NO;
            
            
            if ([_BuyModlel.Buystatus isEqualToString:@"1"]) {
                _type2Btn.hidden = NO;
                [_type2Btn setTitle:@"确认收货" forState:0];
                
            }
            
        }
        else if ([_BuyModlel.Buystatus isEqualToString:@"2"]){
            _typeBtn.hidden = NO;
            [_typeBtn setTitle:@"晒单" forState:0];
            
        }
        else if ([_BuyModlel.Buystatus isEqualToString:@"5"]){
            _typeBtn.hidden = NO;
            [_typeBtn setTitle:@"退款详情" forState:0];
            _type2Btn.hidden = NO;
            
            [_type2Btn setTitle:@"取消退款" forState:0];
            
            
        }
        else if ([_BuyModlel.Buystatus isEqualToString:@"4"]||[_BuyModlel.Buystatus isEqualToString:@"6"]){
            _typeBtn.hidden = NO;
            [_typeBtn setTitle:@"退款详情" forState:0];
            
        }
        
        
        
    }
    
    if (_typeBtn.hidden) {
        _type2Btn.frame = _typeBtn.frame;
    }
    else
    {
        _type2Btn.frame = CGRectMake(x, y, w, h);
    }
    

    
    
    
    // Do any additional setup after loading the view.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if ([_BuyModlel.Buystatus isEqualToString:@"-1"]) {
            return 2;
        }
        else if ([_BuyModlel.Buystatus isEqualToString:@"0"]) {
            return 2;
        }

        if (!_BuyModlel.courierCompany.length) {
            return 2;
        }
        
        return 3;
    }
    if (section ==1) {
        return 2;
    }
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 1||indexPath.row == 2) {
            return 85;
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 44;
        }
        return 80;
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            return 10+20*3+10*3;
        }
        return 10 + 10 + 20*2 + 10;
    }


    return 44;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellid = @"mc1";
    
    BuyOrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[BuyOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    cell.BuyModlel = _BuyModlel;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [cell  prepareUI1];
            return cell;

        }
        else if (indexPath.row == 1){
            [cell  prepareUIadder];
            return cell;
 
        }
        else if (indexPath.row == 2){
            [cell  prepareUIwuliu];
            return cell;
            
        }

    }
    
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [cell  prepareUI2];
            return cell;
            
        }
        else if (indexPath.row == 1){
            [cell  prepareUIbuy];
            return cell;
            
        }
 
        
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            [cell  prepareUI3];
            return cell;
            
        }
        else if (indexPath.row == 1){
            [cell  prepareUI4];
            return cell;
            
        }
        
        
    }

    return cell;

    
    
    return [[UITableViewCell alloc]init];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1&&indexPath.row == 1) {
        NSLog(@"_BuyModlel == %@",_BuyModlel);
        [self loadModle];
        
        
    }
}
#pragma mark-获取详情
-(void)loadModle{
    if (!_BuyModlel.buyId.length) {
        [self showHint:@"无效id"];
        return;
    }
    NSDictionary * Parameterdic = @{
                                    @"buyId":_BuyModlel.buyId,
                                    
                                    };
    
    
    // [self showLoading:iszhuan AndText:nil];
    [self showLoading];
    [self.requestManager postWithUrl:@"api/buy/getBuyDetail.json" refreshCache:NO params:Parameterdic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        NSDictionary * dic = resultDic[@"object"];
       MCBuyModlel * Modlel = [MCBuyModlel mj_objectWithKeyValues:dic];
        NSString * imageUrl = dic[@"imageUrl"];
        id result = [self analysis:imageUrl];
        if ([result isKindOfClass:[NSArray class]]) {
            Modlel.imageUrl = result;
        }
        id json = [self analysis:Modlel.json];
        Modlel.Buyjson = [MCBuyjson mj_objectWithKeyValues:json];
        for (NSString * url in Modlel.imageUrl) {
            YJphotoModel*   photoModel =[[YJphotoModel alloc]init];
            photoModel.raw = url;
            [Modlel.YJphotos addObject:photoModel];
            
        }
        
        
        Modlel.MCdescription = dic[@"description"];
        Modlel.userModel = [YJUserModel mj_objectWithKeyValues:Modlel.user];
        
        ShoppingQXViewController *ctl = [[ShoppingQXViewController alloc]init];
        
        ctl.BuyModlel = Modlel;
        ctl.dataArray = (NSMutableArray*)@[Modlel];
        ctl.index = 0;//indexPath.section;
        
        [self pushNewViewController:ctl];

     
        
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];

        NSLog(@"失败");
    }];
    
    
    
}

-(void)actiontypeBtn:(UIButton*)btn{
    NSString * str = btn.titleLabel.text;
    if ([str isEqualToString:@"付款"]) {
        
        PaymentViewController * ctl = [[PaymentViewController alloc]init];
        
        ctl.buyIdStr = _BuyModlel.orderId;
        ctl.typeIndex = @"0";
        ctl.isBackRoot = YES;
        [self pushNewViewController:ctl];
        return;
    }
    if ([str isEqualToString:@"晒单"]) {
        
        
        
        WNImagePicker *pickerVC  = [[WNImagePicker alloc]init];
        
        [self pushNewViewController:pickerVC];
        
        return;
    }
    if ([str isEqualToString:@"退款详情"]) {
        
        RefundXQViewController * ctl = [[RefundXQViewController alloc]init];
        ctl.orderNumber = _BuyModlel.orderNumber;
        
        
        
        [self pushNewViewController:ctl];
        return;
    }

    if ([str isEqualToString:@"申请退款"]) {
        
        MCDrawBackViewController * ctl = [[MCDrawBackViewController alloc]init];
        ctl.orderId = _BuyModlel.orderNumber;
        NSString*   ss = [NSString stringWithFormat:@"%.2f",[_BuyModlel.price floatValue] * [_BuyModlel.count integerValue]];
        
        ctl.priceStr = ss;
        
        [self pushNewViewController:ctl];
        return;
    }

    if ([str isEqualToString:@"取消订单"]) {
        UIAlertView * al = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"是否取消该订单" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        al.tag = 9001;
        
        [al show];
        
        
        return;
        
    }
    if ([str isEqualToString:@"确认收货"]) {
        UIAlertView * al = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"是否确认收货？请收到货后，再确认收货，否则您可能钱货两空！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        al.tag = 9000;
        
        [al show];
        
        
        return;
    }
    if ([str isEqualToString:@"取消退款"]) {
        UIAlertView * al = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"确定要取消退款？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        al.tag = 9002;
        
        [al show];
        
        
        return;
    }

    
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 9000) {
        if (buttonIndex == 0) {
            
            [self showLoading];
            NSDictionary * dic = @{
                                   @"orderId":_BuyModlel.orderId
                                   
                                   };
            [self.requestManager postWithUrl:@"api/buy/finishOrder.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
                [self stopshowLoading];
                [self showHint:@"确认成功"];
                NSLog(@"resultDic ===%@",resultDic);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"didPurchaseViewObjNotification" object:@""];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    //发送通知
                    [self.navigationController popViewControllerAnimated:YES];
                });

                
                
            } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
                [self stopshowLoading];
                [self showAllTextDialog:description];
            }];
            
            
        }
    }
    if (alertView.tag == 9001) {
        if (buttonIndex == 0) {
            
            [self showLoading];
            NSDictionary * dic = @{
                                   @"orderId":_BuyModlel.orderId,
                                   @"type":@"sell"
                                   
                                   };
            [self.requestManager postWithUrl:@"api/buy/deleteNoPayOrder.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
                [self stopshowLoading];
                [self showHint:@"该订单已取消"];
                NSLog(@"resultDic ===%@",resultDic);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"didPurchaseViewObjNotification" object:@""];

                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    //发送通知
                    [self.navigationController popViewControllerAnimated:YES];
                });

                
                
            } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
                [self stopshowLoading];
                [self showAllTextDialog:description];
            }];
            
            
        }
    }
    if (alertView.tag == 9002) {
        if (buttonIndex == 0) {
            
            [self showLoading];
            NSDictionary * dic = @{
                                   @"orderNumber":_BuyModlel.orderNumber
                                   
                                   };
            [self.requestManager postWithUrl:@"api/refund/cancelRefund.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
                [self stopshowLoading];

                [[NSNotificationCenter defaultCenter] postNotificationName:@"didPurchaseViewObjNotification" object:@""];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    //发送通知
                    [self.navigationController popViewControllerAnimated:YES];
                });
                
                
            } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
                [self stopshowLoading];
                [self showAllTextDialog:description];
            }];
            
            
        }
    }

    
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
