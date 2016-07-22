//
//  BillViewController.m
//  MCCWYJ
//
//  Created by MC on 16/6/3.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "BillViewController.h"
#import "MCMyshoppingTableViewCell.h"
#import "YJNoDataTableViewCell.h"
#import "CarteViewController.h"
#import "ShoppingQXViewController.h"

#import "ShoppingFillViewController.h"
#import "PaymentViewController.h"
#import "MakeBuyViewController.h"
#import "OrderReceivViewController.h"
#import "MakeSellViewController.h"

@interface BillViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

{
//    UITableView *_tableView;
    NSMutableArray *_dataAarray;//数据源
    NSInteger  _pageStr;
    BOOL _isNoData;
    
    
    UIView * _editView;
    UIButton *_allSelectBtn;
    UIButton *_deleteBtn;
    NSMutableArray *_seleArray;
    MCBuyModlel * _BuyModlel;//点击btn用到的

}

@end

@implementation BillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataAarray  =[NSMutableArray array];
    _seleArray = [NSMutableArray array];
    _pageStr = 1;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RefreshHeader) name:@"didBillViewObjNotification" object:nil];

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
                           @"userId":[MCUserDefaults objectForKey:@"id"],
                           @"type":@(0),
                           @"pageSize":@(20)
                           
                           
                           };
    [self.requestManager postWithUrl:@"api/buy/getPicks.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
        
        NSArray * objectArray = resultDic[@"object"];
        for (NSDictionary * dic in objectArray) {
            MCBuyModlel *model = [MCBuyModlel mj_objectWithKeyValues:dic];
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
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isNoData) {
        return self.view.mj_h;
    }
    
    return 100 *MCHeightScale + 15 + 20 + 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isNoData) {
        YJNoDataTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mc2"];
        if (!cell) {
            cell = [[YJNoDataTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mc2"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell prepareNoDataUI:self.view.mj_h TitleStr:@"暂时没有发布订单,点击发布代购单"];
        [cell.tapBtn addTarget:self action:@selector(actionTapBtn) forControlEvents:UIControlEventTouchUpInside];
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
        cell.tixing = YES;
    [cell  prepareNotitleUI];
    cell.headerimgBtn.tag = 500 + indexPath.section;

    [cell.headerimgBtn addTarget:self action:@selector(ActionheaderimgBtn:) forControlEvents:UIControlEventTouchUpInside];
    if (_editView.hidden) {
        cell.bgView.frame = CGRectMake(0, 0, Main_Screen_Width, cell.bgView.mj_h);
        cell.shoppingBtn.tag = 700 + indexPath.section;
        
        [cell.shoppingBtn addTarget:self action:@selector(actionshoppingBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        cell.bgView.frame = CGRectMake(50, 0, Main_Screen_Width, cell.bgView.mj_h);
        
    }
        cell.selectBtn.selected = modle.isSele;
        cell.selectBtn.tag = indexPath.section + 600;

    [cell.selectBtn addTarget:self action:@selector(actionCellSeleBtn:) forControlEvents:UIControlEventTouchUpInside];

    
    
    return cell;
    }
    return [[UITableViewCell alloc]init];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section < _dataAarray.count&&_editView.hidden) {
        MCBuyModlel * modle = _dataAarray[indexPath.section];
        ShoppingQXViewController *ctl = [[ShoppingQXViewController alloc]init];
        ctl.BuyModlel = modle;
        ctl.dataArray = _dataAarray;
        ctl.index = indexPath.section;//indexPath.section;
        [MCIucencyView pickStr:nil];

        [_delegate pushNewViewController:ctl];
        
        
    }
 
    
    
}
-(void)actionshoppingBtn:(UIButton*)btn{
    NSString *sessionId = [MCUserDefaults objectForKey:@"sessionId"];
    if (!sessionId.length) {
        [self showHint:@"亲，请登录才能做此操作哦"];
        return;
    }
    
    _BuyModlel = _dataAarray[btn.tag - 700];
    
    if ([btn.titleLabel.text isEqualToString:@"购买"]) {
        ShoppingFillViewController * ctl = [[ShoppingFillViewController alloc]init];
        ctl.BuyModlel = _BuyModlel;
        [_delegate pushNewViewController:ctl];
    }
    else if ([btn.titleLabel.text isEqualToString:@"未支付"]) {
        PaymentViewController * ctl = [[PaymentViewController alloc]init];
        ctl.BuyModlel = _BuyModlel;
        NSMutableDictionary * pamDic = [NSMutableDictionary dictionary];
        
        
        [pamDic setObject:_BuyModlel.count forKey:@"count"];
        [pamDic setObject:_BuyModlel.deliveryAddress forKey:@"address"];
        [pamDic setObject:_BuyModlel.id forKey:@"buyId"];
        
        ctl.datadic = pamDic;
        [_delegate pushNewViewController:ctl];
        
    }
    else  if ([btn.titleLabel.text isEqualToString:@"再来"]) {
        
        MakeBuyViewController * ctl = [[MakeBuyViewController alloc]init];
        ctl.BuyModlel2 = _BuyModlel;
        
        [_delegate pushNewViewController:ctl];
        
    }
    else  if ([btn.titleLabel.text isEqualToString:@"制作求"]) {
        
        MakeBuyViewController * ctl = [[MakeBuyViewController alloc]init];
        ctl.BuyModlel2 = _BuyModlel;
        
        [_delegate pushNewViewController:ctl];
        
    }
    
    else  if ([btn.titleLabel.text isEqualToString:@"接单"]) {
        OrderReceivViewController * ctl = [[OrderReceivViewController alloc]init];
        ctl.BuyModlel = _BuyModlel;
        [_delegate pushNewViewController:ctl];
        
        
    }
    else  if ([btn.titleLabel.text isEqualToString:@"关闭订单"]) {
        UIAlertView * al = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"你是否要关闭该订单" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        al.tag = 4001;
        [al show];
        
    }
    else  if ([btn.titleLabel.text isEqualToString:@"完成订单"]) {
        UIAlertView * al = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"确认完成订单？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        al.tag = 4003;
        [al show];
        
    }

    else if ([btn.titleLabel.text isEqualToString:@"放弃订单"]) {
        
        UIAlertView * al = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"你是否要放弃该订单" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        al.tag = 4000;
        [al show];
        
    }
    
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 4000) {
        if (buttonIndex== 0) {
            
            [self showLoading];
            NSDictionary * dic = @{
                                   @"buyId":_BuyModlel.id
                                   };
            [self.requestManager postWithUrl:@"api/buy/cancelPick.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
                [self stopshowLoading];
                NSLog(@"resultDic ===%@",resultDic);
                [self showHint:@"该订单已放弃"];
                [self RefreshHeader];
                
            } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
                [self stopshowLoading];
                [self showAllTextDialog:description];
            }];
            
            
        }
    }
    else if (alertView.tag == 4001) {
        
        if (buttonIndex== 0) {
            
            [self showLoading];
            NSDictionary * dic = @{
                                   @"buyId":_BuyModlel.id
                                   };
            [self.requestManager postWithUrl:@"api/buy/closeSell.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
                [self stopshowLoading];
                NSLog(@"resultDic ===%@",resultDic);
                [self showHint:@"该订单已关闭"];
                
                [self RefreshHeader];
                
            } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
                [self stopshowLoading];
                [self showAllTextDialog:description];
            }];
        }
    }
    else if (alertView.tag == 4003) {
        
        if (buttonIndex== 0) {
            
            [self showLoading];
            NSDictionary * dic = @{
                                   @"buyId":_BuyModlel.id
                                   };
            [self.requestManager postWithUrl:@"api/buy/finishPick.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
                [self stopshowLoading];
                NSLog(@"resultDic ===%@",resultDic);
                [self showHint:@"该订单已完成"];
                //                [self refreshSubmodel];
//                [self refreshSubmodel];
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
    MCBuyModlel * model = _dataAarray[btn.tag - 600];
    if (btn.selected) {
        btn.selected = NO;
        model.isSele = NO;
        if ([_seleArray containsObject:model.id]) {
            [_seleArray removeObject:model.id];
        }
        if (_allSelectBtn.selected) {
            _allSelectBtn.selected = NO;
        }
    }
    else
    {
        btn.selected = YES;
        model.isSele = YES;
        [_seleArray addObject:model.id];
        
    }
    NSString * ss = [NSString stringWithFormat:@"删除(%d)",_seleArray.count];
    
    [_deleteBtn setTitle:ss forState:0];
    
}
-(void)actionAllSeleBtn:(UIButton*)btn{
    [_seleArray removeAllObjects];
    
    if (_allSelectBtn.selected) {
        _allSelectBtn.selected = NO;
        
        for (MCBuyModlel * model in _dataAarray) {
            model.isSele = NO;
        }
        
    }
    else
    {
        _allSelectBtn.selected = YES;
        for (MCBuyModlel * model in _dataAarray) {
            model.isSele = YES;
            [_seleArray addObject:model.id];
        }
        
        
        
    }
    [_tableView reloadData];
    NSString * ss = [NSString stringWithFormat:@"删除(%d)",_seleArray.count];
    
    [_deleteBtn setTitle:ss forState:0];
    
}
-(void)actiondeleteBtn:(UIButton*)btn{
    
    if (!_seleArray.count) {
        [self showAllTextDialog:@"请选择你要删除的作品"];
        return ;
    }
    NSString * collectionIds = [_seleArray componentsJoinedByString:@","];
    NSDictionary * Parameterdic = @{
                                    @"buyId":collectionIds
                                    };
    
    [self showLoading];
    [self.requestManager postWithUrl:@"api/buy/deleteBuy.json" refreshCache:NO params:Parameterdic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        [_seleArray removeAllObjects];
        [self showAllTextDialog:@"删除成功"];
        
        [_deleteBtn setTitle:@"删除(0)" forState:0];
        
        
        //        //发送通知首页刷新
        //        [[NSNotificationCenter defaultCenter] postNotificationName:@"dishuaxinObjNotification" object:@""];
        //
        //
        //        //发送通知
        //        [[NSNotificationCenter defaultCenter] postNotificationName:@"didzuopingshuaxinObjNotification" object:@""];
        //        [self actionEdit];
        //        [_tableView reloadData];
        if (_delegate) {
        [_delegate finishEdit];
        }
        [self RefreshHeader];
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
        
        NSLog(@"失败");
        
    }];
}
#pragma amark-发布代购
-(void)actionTapBtn{
    MakeBuyViewController * ctl = [[MakeBuyViewController alloc]init];
    [_delegate pushNewViewController:ctl];

    
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
