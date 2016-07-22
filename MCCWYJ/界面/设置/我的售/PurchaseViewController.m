//
//  BillViewController.m
//  MCCWYJ
//
//  Created by MC on 16/6/3.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "PurchaseViewController.h"
#import "MCMyshoppingTableViewCell.h"
#import "YJNoDataTableViewCell.h"
#import "CarteViewController.h"
#import "BuyOrderViewController.h"
#import "PaymentViewController.h"
#import "MCDrawBackViewController.h"
#import "RefundXQViewController.h"
#import "WNImagePicker.h"
@interface PurchaseViewController ()<UITableViewDelegate,UITableViewDataSource,MCMyshoppingDegate,UIAlertViewDelegate>

{
    UITableView *_tableView;
    NSMutableArray *_dataAarray;//数据源
    NSInteger  _pageStr;
    BOOL _isNoData;
    
    
    UIView * _editView;
    UIButton *_allSelectBtn;
    UIButton *_deleteBtn;
    MCBuyModlel *_seleModle;
}

@end

@implementation PurchaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataAarray  =[NSMutableArray array];
    _pageStr = 1;
    //监听数据的刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RefreshHeader) name:@"didPurchaseViewObjNotification" object:nil];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width,Main_Screen_Height - 44 - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(RefreshHeader)];
    _tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(RefreshFooter)];
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = AppMCBgCOLOR;

    [self loadData];
    
    _editView = [[UIView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height - 44-64 - 49, Main_Screen_Width, 49)];
    _editView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_editView];
    _allSelectBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    [_allSelectBtn setImage:[UIImage imageNamed:@"list_checkbox_normal"] forState:UIControlStateNormal];
    [_allSelectBtn setImage:[UIImage imageNamed:@"list_checkbox_checked"] forState:UIControlStateSelected];
    [_allSelectBtn addTarget:self action:@selector(actionAllSeleBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_editView addSubview:_allSelectBtn];
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 50, 49)];
    lbl.text = @"全选";
    lbl.textColor = [UIColor darkTextColor];
    lbl.font = [UIFont systemFontOfSize:15];
    [_editView addSubview:lbl];
    
    _deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width - 120, 0, 120, 49)];
    _deleteBtn.backgroundColor = AppCOLOR;
    [_deleteBtn setTitle:@"删除(0)" forState:0];
    [_deleteBtn setTitleColor:[UIColor whiteColor] forState:0];
    [_deleteBtn addTarget:self action:@selector(actiondeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_editView addSubview:_deleteBtn];
    
    _editView.hidden = YES;
    
    
    // Do any additional setup after loading the view.
}
-(void)actionEdit{
    if (_editView.hidden) {
        _editView.hidden = NO;
        _tableView.frame = CGRectMake(0, 0, Main_Screen_Width,Main_Screen_Height - 44 - 64 - 49);
        
        
    }
    else
    {
        _allSelectBtn.selected = NO;
        _editView.hidden = YES;
        _tableView.frame = CGRectMake(0, 0, Main_Screen_Width,Main_Screen_Height - 44 - 64 );
        
        
        
    }
    [_tableView reloadData];
    
}

-(void)RefreshHeader{
    if (_editView.hidden) {
        [_dataAarray removeAllObjects];
        _pageStr = 1;
        [self loadData];
    }
    else
    {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }
    
    
}
-(void)RefreshFooter{
    if (_editView.hidden) {
        
        _pageStr ++;
        [self loadData];
    }
    else
    {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }
    
    
}

#pragma mark-加载数据
-(void)loadData{
    [self showLoading];
    NSDictionary * dic = @{
                           @"pageNumber":@(_pageStr),
                           @"type":@"1",
                           @"pageSize":@(10)
                           
                           };
    [self.requestManager postWithUrl:@"api/buy/getSells.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
        
        NSArray * objectArray = resultDic[@"object"];
        for (NSDictionary * dic in objectArray) {
            MCBuyModlel *model = [MCBuyModlel mj_objectWithKeyValues:dic];
            model.Buystatus = [NSString stringWithFormat:@"%ld",[dic[@"status"] integerValue]];
            
            
            NSString * imageUrl = dic[@"imageUrl"];
            id result = [self analysis:imageUrl];
            if ([result isKindOfClass:[NSArray class]]) {
                model.imageUrl = result;
            }
            id json = [self analysis:model.json];
            model.Buyjson = [MCBuyjson mj_objectWithKeyValues:json];
            for (NSString * url in model.imageUrl) {
                YJphotoModel*   photoModel =[[YJphotoModel alloc]init];
                photoModel.raw = url;
                [model.YJphotos addObject:photoModel];
                
            }
            
            
            model.MCdescription = dic[@"description"];
            
            model.MCuserIntegral = dic[@"userIntegral"];
            model.userModel = [YJUserModel mj_objectWithKeyValues:model.user];
            [_dataAarray addObject:model];
        }
        
        
        if (_dataAarray.count) {
            _isNoData = NO;
        }
        else
        {
            _isNoData = YES;
            
        }
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        
        
        
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        
    }];
    

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_isNoData) {
        return 1;
    }
    return _dataAarray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isNoData) {
        return self.view.mj_h;
    }
    
    return 200;//100 *MCHeightScale + 15 + 20 + 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isNoData) {
        YJNoDataTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mc2"];
        if (!cell) {
            cell = [[YJNoDataTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mc2"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell prepareNoDataUI:self.view.mj_h TitleStr:@"暂时没有你要查询的数据"];
        //        [cell.tapBtn addTarget:self action:@selector(actionTapBtn) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
        
        
    }
    
    
    
        if (_dataAarray.count > indexPath.section) {
    static NSString * cellid = @"mc1";
    
    MCMyshoppingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[MCMyshoppingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
cell.selectionStyle = UITableViewCellSelectionStyleNone;

    MCBuyModlel * modle = _dataAarray[indexPath.section];
            cell.BuyModlel = modle;

    [cell  preparebuyUI];
            cell.degate =self;
//    [cell.headerimgBtn addTarget:self action:@selector(ActionheaderimgBtn:) forControlEvents:UIControlEventTouchUpInside];
    if (_editView.hidden) {
        cell.bgView.frame = CGRectMake(0, 0, Main_Screen_Width, cell.bgView.mj_h);
    }
    else
    {
        cell.bgView.frame = CGRectMake(50, 0, Main_Screen_Width, cell.bgView.mj_h);
        
    }
    
    [cell.selectBtn addTarget:self action:@selector(actionCellSeleBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    return cell;
        }
    return [[UITableViewCell alloc]init];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section < _dataAarray.count&&_editView.hidden) {
        MCBuyModlel * modle = _dataAarray[indexPath.section];
        BuyOrderViewController *ctl = [[BuyOrderViewController alloc]init];
        ctl.BuyModlel = modle;

        
        [_delegate pushNewViewController:ctl];
        
        
    }
    
    
    
}
-(void)seleTitle:(NSString *)str BuyModlel:(MCBuyModlel *)buyModlel
{
    _seleModle =buyModlel;
    if ([str isEqualToString:@"付款"]) {
        
        PaymentViewController * ctl = [[PaymentViewController alloc]init];
        
        ctl.buyIdStr = buyModlel.orderId;
        ctl.typeIndex = @"0";
        ctl.isBackRoot = YES;
        [_delegate pushNewViewController:ctl];
        return;
    }
    if ([str isEqualToString:@"晒单"]) {
      
        
        
        WNImagePicker *pickerVC  = [[WNImagePicker alloc]init];
        
        
        //    _commodityDic ===={
        //        colour = 123;
        //        price = 12;
        //        model = 213;
        //        brand = nike;
        //        commodity = 广州;
        //        num = 32;
        //        name = 123;
        //    }
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        [dic setObject:_seleModle.color ? _seleModle.color :@"" forKey:@"colour"];
        
        [dic setObject:_seleModle.price?_seleModle.price :@"" forKey:@"price"];
                
        [dic setObject:_seleModle.model?_seleModle.model:@"" forKey:@"model"];
        
        [dic setObject:_seleModle.brand?_seleModle.brand:@"" forKey:@"brand"];
        
        [dic setObject:_seleModle.chPickAddress ?_seleModle.chPickAddress:@"" forKey:@"commodity"];
        
        [dic setObject:_seleModle.pickAddresId ?_seleModle.pickAddresId:@"" forKey:@"commodityid"];

        
        [dic setObject:_seleModle.count ?_seleModle.count :@"" forKey:@"num"];
        
        [dic setObject:_seleModle.name ? _seleModle.name : @"" forKey:@"name"];

        pickerVC.commodityDic = dic;
        
        if (_seleModle.imageUrl.count) {
            NSLog(@"=====%@",_seleModle.imageUrl[0]);
            if (_seleModle.imageUrl[0]) {
                pickerVC.isshaiDan = YES;
                pickerVC.imgViewUrl =_seleModle.imageUrl[0];
                
                
            }
            
        }

        [_delegate pushNewViewController:pickerVC];

        return;
    }

    if ([str isEqualToString:@"取消订单"]) {
        UIAlertView * al = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"是否取消该订单" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        al.tag = 9001;
        
        [al show];
        
        
        return;

    }
    if ([str isEqualToString:@"申请退款"]) {
        
        MCDrawBackViewController * ctl = [[MCDrawBackViewController alloc]init];
        ctl.orderId = buyModlel.orderNumber;
        
        
     NSString*   ss = [NSString stringWithFormat:@"%.2f",[buyModlel.price floatValue] * [buyModlel.count integerValue]];

        ctl.priceStr = ss;

        [_delegate pushNewViewController:ctl];
        return;
    }
    if ([str isEqualToString:@"退款详情"]) {
        
        RefundXQViewController * ctl = [[RefundXQViewController alloc]init];
        ctl.orderNumber = buyModlel.orderNumber;
        
        
        
        [_delegate pushNewViewController:ctl];
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
                           @"orderId":_seleModle.orderId
                         
                           };
    [self.requestManager postWithUrl:@"api/buy/finishOrder.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        [self showHint:@"确认成功"];
        NSLog(@"resultDic ===%@",resultDic);
        [self RefreshHeader];
        
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
                                   @"orderId":_seleModle.orderId,
                                   @"type":@"sell"
                                   
                                   };
            [self.requestManager postWithUrl:@"api/buy/deleteNoPayOrder.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
                [self stopshowLoading];
                [self showHint:@"该订单已取消"];
                NSLog(@"resultDic ===%@",resultDic);
                [self RefreshHeader];
                
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
                                   @"orderNumber":_seleModle.orderNumber
                                   
                                   };
            [self.requestManager postWithUrl:@"api/refund/cancelRefund.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
                [self stopshowLoading];
                [self showHint:@"已取消"];
                NSLog(@"resultDic ===%@",resultDic);
                [self RefreshHeader];
                
            } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
                [self stopshowLoading];
                [self showAllTextDialog:description];
            }];
            
            
        }
    }


}
#pragma mark-点击头像
-(void)ActionheaderimgBtn:(UIButton*)btn{
    CarteViewController *ctl = [[CarteViewController alloc]init];
    [_delegate pushNewViewController:ctl];
    
    
}

-(void)actionCellSeleBtn:(UIButton*)btn{
    btn.selected = YES;
}
-(void)actionAllSeleBtn:(UIButton*)btn{
    if (_allSelectBtn.selected) {
        _allSelectBtn.selected = NO;
    }
    else
    {
        _allSelectBtn.selected = YES;
        
    }
    
    
}
-(void)actiondeleteBtn:(UIButton*)btn{
    
    //    [self actionEdit];
    //    [_tableView reloadData];
    //    if (_delegate) {
    //        [_delegate finishEdit];
    //    }
    
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
