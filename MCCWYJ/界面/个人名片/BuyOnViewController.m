//
//  BuyOnViewController.m
//  MCCWYJ
//
//  Created by MC on 16/5/24.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "BuyOnViewController.h"
#import "SearchViewController.h"
#import "MCMyshoppingTableViewCell.h"
#import "YJNoDataTableViewCell.h"
#import "ShoppingFillViewController.h"
#import "PaymentViewController.h"
#import "MakeBuyViewController.h"
#import "OrderReceivViewController.h"
#import "ShoppingQXViewController.h"

@interface BuyOnViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    
    UITextField *_searchtext;
    
    
    
    UITableView *_tableView;
    NSMutableArray *_dataAarray;//数据源
    NSInteger  _pageStr;
    BOOL _isNoData;
    MCBuyModlel * _BuyModlel;//点击btn用到的

    
}

@end

@implementation BuyOnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageStr = 1;
    _dataAarray = [NSMutableArray array];
    

    [self setUpNavBar];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(RefreshHeader)];
    _tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(RefreshFooter)];
    [self loadadata];
    _tableView.backgroundColor = AppMCBgCOLOR;


    // Do any additional setup after loading the view.
}
-(void)RefreshHeader{
    _pageStr = 1;
    [_dataAarray removeAllObjects];
    [self loadadata];
    
    
}
-(void)RefreshFooter{
    _pageStr ++;
    [self loadadata];
    
    
}

-(void)loadadata{
    [self showLoading];
    if (!_uid) {
        [self showHint:@"无效id"];
        return;
    }
    NSDictionary * dic = @{
                           @"pageNumber":@(_pageStr),
                           @"type":@(0),
                           @"pageSize":@(20),
                           @"userId":_uid
                           
                           
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isNoData) {
        return 1;
    }
    
    return _dataAarray.count;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isNoData) {
        return Main_Screen_Height - 64 - 49;
    }
    if (_dataAarray.count > indexPath.row) {
        MCBuyModlel * model= _dataAarray[indexPath.row];
        if (model.YJoptsArray.count) {
            return 100 *MCHeightScale + 15 + 20 + 10 + 44;
            
        }
        
    }
    
    return 100 *MCHeightScale + 15 + 20 + 10;

    
//    return 100 *MCHeightScale + 15 + 20 + 10;
    
    
    //3种状态
    if (indexPath.section == 0) {
        
        return 100 *MCHeightScale + 15 + 20 + 10;
    }
    if (indexPath.section == 1) {
        return 100 *MCHeightScale + 15 + 20 + 10 + 44;
        
    }
    if(indexPath.section == 2){
        return 100 *MCHeightScale + 15 + 20 + 15;
    }
    
    return 44;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellid1 = @"MCMyshoppingTableViewCell1";
    static NSString * cellid2 = @"MCMyshoppingTableViewCell2";
    static NSString * cellid3 = @"mc3";
    if (_isNoData) {
        YJNoDataTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mc2"];
        if (!cell) {
            cell = [[YJNoDataTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mc2"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell prepareNoDataUI:self.view.mj_h TitleStr:@"再怎么找也没有游记啦，你行你来写"];
        //        [cell.tapBtn addTarget:self action:@selector(actionTapBtn) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
        
        
    }
    

    
    
    if (_dataAarray.count > indexPath.row) {
        
        MCMyshoppingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
        if (!cell) {
            cell = [[MCMyshoppingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        MCBuyModlel * modle = _dataAarray[indexPath.row];
        cell.BuyModlel = modle;
        [cell  prepareNotitleUI];
        //        cell.headerimgBtn.tag = 500 + indexPath.section;
        cell.shoppingBtn.tag = 600 + indexPath.row;
        
        [cell.shoppingBtn addTarget:self action:@selector(actionshoppingBtn:) forControlEvents:UIControlEventTouchUpInside];
        //        [cell.headerimgBtn addTarget:self action:@selector(ActionheaderimgBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
        
    }
    
    
    
    /*
     
     
     
     if (indexPath.section == 0) {
     
     MCMyshoppingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
     if (!cell) {
     cell = [[MCMyshoppingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid1];
     }
     
     [cell  prepareNotitleUI];
     [cell.headerimgBtn addTarget:self action:@selector(ActionheaderimgBtn:) forControlEvents:UIControlEventTouchUpInside];
     
     return cell;
     }
     
     
     
     if (indexPath.section == 1) {
     MCMyshoppingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid2];
     if (!cell) {
     cell = [[MCMyshoppingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid2];
     }
     
     [cell  prepareHastitleUI];
     [cell.headerimgBtn addTarget:self action:@selector(ActionheaderimgBtn:) forControlEvents:UIControlEventTouchUpInside];
     
     return cell;
     
     }
     if (indexPath.section == 2) {
     YJTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid3];
     if (!cell) {
     cell = [[YJTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid3];
     }
     //        cell.selectionStyle =
     //        homeYJModel * model= _dataAarray[indexPath.section];
     [cell prepareUI:nil];
     [cell.headerimgBtn addTarget:self action:@selector(ActionheaderimgBtn:) forControlEvents:UIControlEventTouchUpInside];
     
     return cell;
     
     }
     */
     return [[UITableViewCell alloc]init];
     
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < _dataAarray.count) {
        MCBuyModlel * modle = _dataAarray[indexPath.row];
        ShoppingQXViewController *ctl = [[ShoppingQXViewController alloc]init];
        ctl.BuyModlel = modle;
        ctl.dataArray = _dataAarray;
        ctl.index = indexPath.row;//indexPath.section;
        
        [self pushNewViewController:ctl];
        
        
    }
    
    
}

-(void)actionshoppingBtn:(UIButton*)btn{
    
    _BuyModlel = _dataAarray[btn.tag - 600];
    
    if ([btn.titleLabel.text isEqualToString:@"购买"]) {
        ShoppingFillViewController * ctl = [[ShoppingFillViewController alloc]init];
        ctl.BuyModlel = _BuyModlel;
        [self pushNewViewController:ctl];
    }
    else if ([btn.titleLabel.text isEqualToString:@"去支付"]) {
        PaymentViewController * ctl = [[PaymentViewController alloc]init];
        ctl.BuyModlel = _BuyModlel;
        NSMutableDictionary * pamDic = [NSMutableDictionary dictionary];
        
        
        [pamDic setObject:_BuyModlel.count forKey:@"count"];
        [pamDic setObject:_BuyModlel.deliveryAddress forKey:@"address"];
        [pamDic setObject:_BuyModlel.id forKey:@"buyId"];
        
        ctl.datadic = pamDic;
        ctl.buyIdStr = _BuyModlel.buyId;
        [self pushNewViewController:ctl];
        
    }
    else  if ([btn.titleLabel.text isEqualToString:@"再来"]) {
        
        MakeBuyViewController * ctl = [[MakeBuyViewController alloc]init];
        ctl.BuyModlel2 = _BuyModlel;
        
        [self pushNewViewController:ctl];
        
    }
    else  if ([btn.titleLabel.text isEqualToString:@"制作求"]) {
        
        MakeBuyViewController * ctl = [[MakeBuyViewController alloc]init];
        ctl.BuyModlel2 = _BuyModlel;
        
        [self pushNewViewController:ctl];
        
    }
    
    else  if ([btn.titleLabel.text isEqualToString:@"接单"]) {
        OrderReceivViewController * ctl = [[OrderReceivViewController alloc]init];
        ctl.BuyModlel = _BuyModlel;
        [self pushNewViewController:ctl];
        
        
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
    
}

-(void)ActionheaderimgBtn:(UIButton*)btn{
    
    
    
}




-(void)setUpNavBar{
    
    MCIucencyView * seachView = [[MCIucencyView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width - 100, 30)];
    [seachView setBgViewColor:[UIColor groupTableViewBackgroundColor]];
    ViewRadius(seachView, 3);
    seachView.layer.borderWidth = .5;
    seachView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _searchtext = [[UITextField alloc]initWithFrame:CGRectMake(30, 0, seachView.mj_w - 30, 30)];
    _searchtext.placeholder = @"输入代购点搜索";
    _searchtext.textColor  =[UIColor lightGrayColor];
    _searchtext.font = AppFont;
    _searchtext.enabled = NO;
    _searchtext.clearButtonMode = UITextFieldViewModeAlways;
    [seachView addSubview:_searchtext];
    UIButton *_searchBtn = [[UIButton alloc]initWithFrame:_searchtext.bounds];
    [_searchBtn addTarget:self action:@selector(ActionsearchBtn) forControlEvents:UIControlEventTouchUpInside];
    [seachView addSubview:_searchBtn];
    
    UIImageView * imgview = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
    imgview.image = [UIImage imageNamed:@"ic_icon_search2"];
    [seachView addSubview:imgview];
    
    self.navigationItem.titleView = seachView;
    
    
    
    
    
    
    //    CGFloat x = 10;
    //    CGFloat y = 25;
    //    CGFloat width = 30;
    //    CGFloat height = 30;
    //
    ////    UIButton * _screenBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    //
    //    [_screenBtn setImage:[UIImage imageNamed:@"home_mine_screened"] forState:0];
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_screenBtn];
    //    [_screenBtn addTarget:self action:@selector(action_screenBtn) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_icon_back_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(actionBack)];
    
    
}
-(void)actionBack{
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark-点搜索
-(void)ActionsearchBtn{
    SearchViewController  * ctl = [[SearchViewController alloc]init];
    ctl.Search_Str= _searchtext.text;
    ctl.SearchType = SearchType_POP;
    ctl.delegate =self;

    [self pushNewViewController:ctl];
    
}
-(void)selectTitleModel:(jingdianModel *)model
{
    if (model) {
        _searchtext.text = model.nameChs;
       // [Parameterdic setObject:model.id forKey:@"addressId"];
        //        addressId	7
    }
    else
    {
        _searchtext.text = @"";
       // [Parameterdic setObject:@"" forKey:@"addressid"];
        
    }
    [self RefreshHeader];
    //    [self loadData];
    
    
    
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
