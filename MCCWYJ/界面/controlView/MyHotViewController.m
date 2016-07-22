//
//  MyHotViewController.m
//  MCCWYJ
//
//  Created by MC on 16/6/21.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MyHotViewController.h"
#import "SearchViewController.h"
#import "MCMyshoppingTableViewCell.h"
#import "ShoppingQXViewController.h"
#import "CarteViewController.h"
#import "ShoppingFillViewController.h"
#import "PaymentViewController.h"
#import "MakeBuyViewController.h"
#import "OrderReceivViewController.h"
#import "MakeSellViewController.h"
@interface MyHotViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,SearchViewControllerDelegate>
{
    
    UITextField *_searchtext;
    UITableView *_tableView;
    NSMutableArray *_dataAarray;
    NSInteger _pageStr;
    
    MCBuyModlel * _BuyModlel;
    NSMutableDictionary * Parameterdic;

}

@end

@implementation MyHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_icon_back_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(actionBack)];

//    self.title = @"热门";
    _dataAarray = [NSMutableArray array];
    _pageStr = 1;
    Parameterdic = [NSMutableDictionary dictionary];
    
    [Parameterdic  setObject:@(_pageStr) forKey:@"page"];
    [Parameterdic  setObject:@(0) forKey:@"type"];

     _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(RefreshHeader)];
    _tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(RefreshFooter)];
//    [self setUpNavBar];
    _tableView.backgroundColor = AppMCBgCOLOR;
    [self setUpNavBar];
    [self loadData3];

    // Do any additional setup after loading the view.
}

-(void)RefreshHeader{
    _pageStr = 1;
    [_dataAarray removeAllObjects];
    [self loadData3];
    
    
}
-(void)RefreshFooter{
    _pageStr ++;
    [self loadData3];
    
    
}

-(void)setUpNavBar{
    
    MCIucencyView * seachView = [[MCIucencyView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width - 100, 30)];
    [seachView setBgViewColor:[UIColor groupTableViewBackgroundColor]];
    ViewRadius(seachView, 3);
    seachView.layer.borderWidth = .5;
    seachView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _searchtext = [[UITextField alloc]initWithFrame:CGRectMake(30, 0, seachView.mj_w - 30, 30)];
    _searchtext.placeholder = @"请输入代购点关键字";
    _searchtext.textColor  =[UIColor lightGrayColor];
    _searchtext.font = AppFont;
    _searchtext.enabled = NO;
    //    _searchtext.clearButtonMode = UITextFieldViewModeAlways;
    [seachView addSubview:_searchtext];
    UIButton *_searchBtn = [[UIButton alloc]initWithFrame:_searchtext.bounds];
    [_searchBtn addTarget:self action:@selector(ActionsearchBtn) forControlEvents:UIControlEventTouchUpInside];
    [seachView addSubview:_searchBtn];
    
    UIImageView * imgview = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
    imgview.image = [UIImage imageNamed:@"ic_icon_search2"];
    [seachView addSubview:imgview];
    
    self.navigationItem.titleView = seachView;
    
    
}
#pragma mark-热
-(void)loadData3{
    
       [self showLoading];
    
    
    
//    NSDictionary * dic  = @{
//                            @"type":@(0),
//                            @"page":@(_pageStr)
//                            };
//
    [Parameterdic  setObject:@(_pageStr) forKey:@"page"];

    [self.requestManager postWithUrl:@"api/buy/getBuyOfHot.json" refreshCache:NO params:Parameterdic IsNeedlogin:YES success:^(id resultDic) {
                [self stopshowLoading];
        NSLog(@"resultDic4 ===%@",resultDic);
        NSArray * array = resultDic[@"object"];
        for (NSDictionary * dic in array) {
            MCBuyModlel * model = [MCBuyModlel mj_objectWithKeyValues:dic];
            model.MCdescription = dic[@"description"];
            NSString * imageUrl = dic[@"imageUrl"];
            id result = [self analysis:imageUrl];
            if ([result isKindOfClass:[NSArray class]]) {
                model.imageUrl = result;
            }
            
            model.userModel = [YJUserModel mj_objectWithKeyValues:model.user];
            [_dataAarray addObject:model];
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
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataAarray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100 *MCHeightScale + 15 + 20 + 10;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellid1 = @"MCMyshoppingTableViewCell1";
    static NSString * cellid2 = @"MCMyshoppingTableViewCell2";
    static NSString * cellid3 = @"mc3";
    
    
    
    
    if (_dataAarray.count > indexPath.section) {
        
        MCMyshoppingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
        if (!cell) {
            cell = [[MCMyshoppingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        MCBuyModlel * modle = _dataAarray[indexPath.section];
        cell.BuyModlel = modle;
        [cell  prepareNotitleUI];
        cell.headerimgBtn.tag = 500 + indexPath.section;
        [cell.headerimgBtn addTarget:self action:@selector(ActionheaderimgBtn:) forControlEvents:UIControlEventTouchUpInside];
        cell.shoppingBtn.tag = indexPath.section + 900;
        [cell.shoppingBtn addTarget:self action:@selector(actionshoppingBtn:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
    }
    return [[UITableViewCell alloc]init];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < _dataAarray.count) {
        MCBuyModlel * modle = _dataAarray[indexPath.section];
        ShoppingQXViewController *ctl = [[ShoppingQXViewController alloc]init];
        ctl.BuyModlel = modle;
        ctl.dataArray = _dataAarray;
        ctl.index = indexPath.section;//indexPath.section;
        ctl.isHot = YES;
        [self pushNewViewController:ctl];
        
        
    }
    
    
}
-(void)actionshoppingBtn:(UIButton*)btn{
       _BuyModlel = _dataAarray[btn.tag - 900];
    
    if ([btn.titleLabel.text isEqualToString:@"购买"]) {
        if ([_BuyModlel.isFriend isEqualToString:@"0"]) {
            [self showHint:@"只有好友才能使用该功能"];
            return;
        }

        ShoppingFillViewController * ctl = [[ShoppingFillViewController alloc]init];
        ctl.BuyModlel = _BuyModlel;
        [self pushNewViewController:ctl];
    }
    else if ([btn.titleLabel.text isEqualToString:@"未支付"]) {
        PaymentViewController * ctl = [[PaymentViewController alloc]init];
        ctl.BuyModlel = _BuyModlel;
        NSMutableDictionary * pamDic = [NSMutableDictionary dictionary];
        
        
        [pamDic setObject:_BuyModlel.count forKey:@"count"];
        [pamDic setObject:_BuyModlel.deliveryAddress forKey:@"address"];
        [pamDic setObject:_BuyModlel.id forKey:@"buyId"];
        
        ctl.datadic = pamDic;
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
    else  if ([btn.titleLabel.text isEqualToString:@"再次发布"]) {
        MakeSellViewController * ctl = [[MakeSellViewController alloc]init];
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





#pragma mark-点搜索
-(void)ActionsearchBtn{
    SearchViewController * ctl = [[SearchViewController alloc]init];
    ctl.Search_Str= _searchtext.text;
    ctl.SearchType = SearchType_POP;
    ctl.delegate =self;
    [self pushNewViewController:ctl];
    
}
-(void)selectTitleModel:(jingdianModel *)model
{
    if (model) {
        _searchtext.text = model.nameChs;
        [Parameterdic setObject:model.id forKey:@"addressId"];
        //        addressId	7
    }
    else
    {
        _searchtext.text = @"";
        [Parameterdic setObject:@"" forKey:@"addressId"];
        
    }
    [self RefreshHeader];
    //    [self loadData];
    
    
    
}

-(void)actionBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark-点击头像
-(void)ActionheaderimgBtn:(UIButton*)btn{
    CarteViewController *ctl = [[CarteViewController alloc]init];
    YJUserModel * model = [[YJUserModel alloc]init];
    MCBuyModlel * mdoel2 = _dataAarray[btn.tag - 500];
    model = mdoel2.userModel;
//    model.nickname = mdoel2.name;

    ctl.userModel = model;
    [self pushNewViewController:ctl];
    
    
}
-(void)MCscreenselsctDic:(NSMutableDictionary *)selectDic
{
    NSLog(@"selectDic ==%@",selectDic);
//    Parameterdic2 = selectDic;
//    [Parameterdic  setObject:@(0) forKey:@"classify"];
//    if ([selectDic[@"classify"] integerValue]==0) {
//        [Parameterdic setObject:@"" forKey:@"type"];
//        
//    }
//    else if([selectDic[@"classify"] integerValue]==1)
//    {
//        [Parameterdic setObject:@"show" forKey:@"type"];
//        
//        
//    }
//    else if([selectDic[@"classify"] integerValue]==2)
//    {
//        [Parameterdic setObject:@"pick" forKey:@"type"];
//        
//        
//    }
//    else if([selectDic[@"classify"] integerValue]==3)
//    {
//        [Parameterdic setObject:@"sell" forKey:@"type"];
//        
//        
//    }
//    
//    [self RefreshHeader];
//    
    
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
