//
//  MCMyshoppingViewController.m
//  CWYouJi
//
//  Created by MC on 16/4/28.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MCMyshoppingViewController.h"
#import "MCMyshoppingTableViewCell.h"
#import "YJTableViewCell.h"
#import "MakeBuyViewController.h"
#import "MCscreenView.h"
#import "SearchViewController.h"
#import "CarteViewController.h"
#import "WNImagePicker.h"
#import "MCCapacityView.h"
#import "ShoppingQXViewController.h"
#import "MakeSellViewController.h"
#import "YJNoDataTableViewCell.h"
#import "ShoppingFillViewController.h"
#import "PaymentViewController.h"
#import "MakeBuyViewController.h"
#import "OrderReceivViewController.h"

@interface MCMyshoppingViewController ()<UITableViewDelegate,UITableViewDataSource,MCscreenViewDelegate,MCCapacityViewDelegate,SearchViewControllerDelegate>
{
    UITextField *_searchtext;
    
    UITableView *_tableView;
    
    BOOL _isShowScree;
    MCscreenView * _screenview;
    
    
    
    NSString * _typeStr;
    NSString * _address;

    MCCapacityView * _CapacityView;

    BOOL _isShowCapacity;
    NSMutableDictionary * Parameterdic;
    NSDictionary *Parameterdic2;
    NSInteger _pageStr;
    NSMutableArray *_dataAarray;
    BOOL _isNoData;
    MCBuyModlel * _BuyModlel;//点击btn用到的
    
}

@end

@implementation MCMyshoppingViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //监听数据的刷新
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MyshoppingGoin) name:@"didMCMyshoppingGoinObjNotification" object:nil];
 
    }
    return self;
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self MCCapacityViewhidden];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [(LCTabBarController*) self.tabBarController removeOriginControls];
    self.navigationController.navigationBarHidden = NO;
    
//    [self MyshoppingGoin];
    

}
-(void)didMCMyshoppingObj{
    [self RefreshHeader];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = AppMCBgCOLOR;//[UIColor whiteColor];
    //监听数据的刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didMCMyshoppingObj) name:@"didMCMyshoppingObjNotification" object:nil];
    
    _pageStr = 1;
    Parameterdic = [NSMutableDictionary dictionary];
    
    [Parameterdic  setObject:@(_pageStr) forKey:@"pageNumber"];
    [Parameterdic  setObject:@(10) forKey:@"pageSize"];
    Parameterdic2 = @{
                 @"like":@"0",
                 
                 };

    //    [Parameterdic  setObject:@(0) forKey:@"spotId"];
    //    [Parameterdic  setObject:@(0) forKey:@"classify"];
    //
    //    [Parameterdic  setObject:@(5000) forKey:@"distance"];
    //    [Parameterdic  setObject:@(0) forKey:@"isRecommend"];
    
//    [Parameterdic setObject:@([MCMApManager sharedInstance].la) forKey:@"lat"];
//    [Parameterdic setObject:@([MCMApManager sharedInstance].lo) forKey:@"lng"];
//    
    
    _dataAarray = [NSMutableArray array];
    [self setUpNavBar];
    
    
     _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64 - 49) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = AppMCBgCOLOR;
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(RefreshHeader)];
//    [MJRefreshFooter]
    _tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(RefreshFooter)];
    [self loadData];
    // Do any additional setup after loading the view.
}
-(void)RefreshHeader{
    _pageStr = 1;
    [_dataAarray removeAllObjects];
    [self loadData];
    
    
}
-(void)RefreshFooter{
    _pageStr ++;
    [self loadData];
    
    
}
-(void)loadData{
    
    
        [self showLoading];
    [Parameterdic  setObject:@(_pageStr) forKey:@"pageNumber"];
//    [Parameterdic setObject:@"2" forKey:@"addressid"];

    [self.requestManager postWithUrl:@"api/buy/getBuyList.json" refreshCache:NO params:Parameterdic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
        NSArray * array = resultDic[@"object"];
        for (NSDictionary * dic in array) {
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
            for (NSDictionary * operateOpdic in model.operateOps) {
                YJoptsModel*   photoModel =[YJoptsModel mj_objectWithKeyValues:operateOpdic];
                [model.YJoptsArray addObject:photoModel];
                
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
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        [self stopshowLoading];

        [self showHint:description];

        if (_dataAarray.count) {
            _isNoData = NO;
            [_tableView  reloadData];
            
        }
        else
        {
            _isNoData = YES;
            [_tableView  reloadData];
            
        }

        
        
    
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
    if (_isNoData) {
        return 1;
    }

    return _dataAarray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isNoData) {
        return Main_Screen_Height - 64 - 49;
    }
    if (_dataAarray.count > indexPath.section) {
        MCBuyModlel * model= _dataAarray[indexPath.section];
        if (model.YJoptsArray.count) {
            CGFloat  optsH = 44;
            if ([model.type isEqualToString:@"sell"]) {
                
            if (model.isOpenopts) {
                
                NSMutableArray * niacknameArray = [NSMutableArray array];
                
                for (YJoptsModel * opstmodel in model.YJoptsArray) {
                    if ([opstmodel.isAnonymity isEqualToString:@"1"]||[opstmodel.isAnonymity isEqualToString:@"-1"]) {
                        if (opstmodel.niackname.length) {
                            [niacknameArray addObject:opstmodel.niackname];
                            
                        }
                        else{
                            [niacknameArray addObject:@"匿名好友"];
                            
                        }
                    }
                    else
                    {
                        [niacknameArray addObject:@"匿名好友"];
                        
                        
                    }
                }
                NSString * countNum = [NSString stringWithFormat:@"%ld",niacknameArray.count];
                NSString * niacknameStr = [niacknameArray componentsJoinedByString:@","];
                
                NSString * optsStr = [NSString stringWithFormat:@"有%@位好友%@了该单,%@",countNum,@"购买",niacknameStr];
//                optsStr = @"抗韩中年人笑笑喜欢装X，并且经常当着几十万水友装X，那感觉怎么说呢...贼爽！然而装X一时爽，翻车火葬场！不久前笑笑在直播中就吹破了牛皮，并且这一次结果很惨。下面就跟随小编一起来回顾下吧";
                optsH = [MCIucencyView heightforString:optsStr andWidth:Main_Screen_Width - 45 fontSize:14]+10;
                
                
            }
                if (optsH < 44) {
                    optsH =44;
                }
                
            }
            return 100 *MCHeightScale + 15 + 20 + 10 + optsH;
            
        }
        
    }

    return 100 *MCHeightScale + 15 + 20 + 10;

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
        [cell prepareNoDataUI:self.view.mj_h TitleStr:@"暂时查询不到你要的数据"];
//        [cell.tapBtn addTarget:self action:@selector(actionTapBtn) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
        
        
    }

    
    
    if (_dataAarray.count > indexPath.section) {
        
        MCMyshoppingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
        if (!cell) {
            cell = [[MCMyshoppingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        MCBuyModlel * modle = _dataAarray[indexPath.section];
        cell.BuyModlel = modle;
        [cell  prepareNotitleUI];
        cell.optsBtn.tag = indexPath.section + 700;
        [cell.optsBtn addTarget:self action:@selector(actionOptsBtn:) forControlEvents:UIControlEventTouchUpInside];
        cell.headerimgBtn.tag = 500 + indexPath.section;
        cell.shoppingBtn.tag = 600 + indexPath.section;

        [cell.shoppingBtn addTarget:self action:@selector(actionshoppingBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell.headerimgBtn addTarget:self action:@selector(ActionheaderimgBtn:) forControlEvents:UIControlEventTouchUpInside];
        
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
    if (indexPath.section < _dataAarray.count) {
        MCBuyModlel * modle = _dataAarray[indexPath.section];
        ShoppingQXViewController *ctl = [[ShoppingQXViewController alloc]init];
        ctl.BuyModlel = modle;
        ctl.dataArray = _dataAarray;
        ctl.index = indexPath.section;//indexPath.section;
        
        [self pushNewViewController:ctl];
        
        
    }

    
}
-(void)actionOptsBtn:(UIButton*)btn{
    MCBuyModlel * modle = _dataAarray[btn.tag - 700];
    if (modle.isOpenopts) {
        modle.isOpenopts = NO;

    }
    else
        modle.isOpenopts = YES;

    [_tableView reloadData];
    
    
    
}
-(void)actionshoppingBtn:(UIButton*)btn{
    NSString *sessionId = [MCUserDefaults objectForKey:@"sessionId"];
    if (!sessionId.length) {
        [self showHint:@"亲，请登录才能做此操作哦"];
        return;
    }

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
    else  if ([btn.titleLabel.text isEqualToString:@"关闭订单"]) {
        UIAlertView * al = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"你是否要关闭该订单" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        al.tag = 4001;
        [al show];
        
    }

    else if ([btn.titleLabel.text isEqualToString:@"放弃订单"]) {
        
        UIAlertView * al = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"你是否要放弃该订单" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        al.tag = 4000;
        [al show];
        
    }
    else  if ([btn.titleLabel.text isEqualToString:@"完成订单"]) {
        UIAlertView * al = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"确认完成订单？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        al.tag = 4003;
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
    NSString *sessionId = [MCUserDefaults objectForKey:@"sessionId"];
    if (!sessionId.length) {
        LoginController * ctl = [[LoginController alloc]init];
        [self pushNewViewController:ctl];
        return;
    }

    CarteViewController *ctl = [[CarteViewController alloc]init];
    YJUserModel * model = [[YJUserModel alloc]init];
    MCBuyModlel * mdoel2 = _dataAarray[btn.tag - 500];
    model = mdoel2.userModel;
    ctl.userModel = model;

    [self pushNewViewController:ctl];
    
    
}



-(void)setUpNavBar{
    
    MCIucencyView * seachView = [[MCIucencyView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width - 100, 30)];
    [seachView setBgViewColor:[UIColor groupTableViewBackgroundColor]];
    ViewRadius(seachView, 3);
    seachView.layer.borderWidth = .5;
    seachView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _searchtext = [[UITextField alloc]initWithFrame:CGRectMake(30, 0, seachView.mj_w - 30-20, 30)];
    _searchtext.placeholder = @"输入代购点搜索";
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
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(actionrightBtn)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_icon_add"] style:UIBarButtonItemStylePlain target:self action:@selector(actionrightBtn)];

    
    
    
    CGFloat x = 10;
    CGFloat y = 25;
    CGFloat width = 30;
    CGFloat height = 30;
    
    UIButton * _screenBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    [_screenBtn addTarget:self action:@selector(action_screenBtn) forControlEvents:UIControlEventTouchUpInside];
    [_screenBtn setImage:[UIImage imageNamed:@"home_mine_screened"] forState:0];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_screenBtn];
    
}
-(void)actionrightBtn{
    [self MCscreenhidden];
    
    
    
    if (_isShowCapacity) {
        _isShowCapacity = NO;
        [_CapacityView removeFromSuperview];
        
    }
    else
    {
        _isShowCapacity = YES;
        NSArray * array = [NSArray array];
            array = @[@"发布晒单",@"发布求单",@"发布售单"];
        
        
        _CapacityView = [[MCCapacityView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) TitleArray:array];
        _CapacityView.delegate = self;
        
        [_CapacityView showInWindow];
        
        
    }
    
    
    
}
-(void)MCCapacityViewselsctTitle:(NSString *)titleDic
{
    [self MCCapacityViewhidden];
    
    NSString *sessionId = [MCUserDefaults objectForKey:@"sessionId"];
    if (!sessionId.length) {
        [self showHint:@"亲，请登录才能做此操作哦"];
        return;
    }

    if ([titleDic isEqualToString:@"发布晒单"]) {
        WNImagePicker *pickerVC  = [[WNImagePicker alloc]init];
        
        [self pushNewViewController:pickerVC];

    }
    if ([titleDic isEqualToString:@"发布求单"]) {
        MakeBuyViewController * ctl = [[MakeBuyViewController alloc]init];
        [self pushNewViewController:ctl];

    }
    if ([titleDic isEqualToString:@"发布售单"]) {
        MakeSellViewController * ctl = [[MakeSellViewController alloc]init];
        [self pushNewViewController:ctl];
        
    }

    
    NSLog(titleDic);
}
-(void)MCCapacityViewhidden
{
    _isShowCapacity = NO;
    [_CapacityView removeFromSuperview];
}

-(void)action_screenBtn{
    [self MCCapacityViewhidden];

    if (_isShowScree) {
        _isShowScree = NO;
        [_screenview removeFromSuperview];
        
    }
    else
    {
        _isShowScree = YES;
        _screenview = [[MCscreenView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height  - 64)];
////        NSDictionary * dic = @{
//                               @"like":@"0",
//                               @"classify":@"0"
//                               };
//        
        _screenview.delegate = self;
        [_screenview IsMYBuy:YES DataDic:Parameterdic2];
        [_screenview showInWindow];

    }
    

}
-(void)MCscreenhidden
{
    _isShowScree = NO;
    [_screenview removeFromSuperview];
 
}
-(void)MCscreenselsctDic:(NSMutableDictionary *)selectDic
{
    [self MCscreenhidden];
    NSLog(@"selectDic ==%@",selectDic);
    Parameterdic2 = selectDic;
//    [Parameterdic  setObject:@(0) forKey:@"classify"];
    if ([selectDic[@"classify"] integerValue]==0) {
        [Parameterdic setObject:@"" forKey:@"type"];
        
    }
    else if([selectDic[@"classify"] integerValue]==1)
    {
        [Parameterdic setObject:@"show" forKey:@"type"];

        
    }
    else if([selectDic[@"classify"] integerValue]==2)
    {
        [Parameterdic setObject:@"pick" forKey:@"type"];
        
        
    }
    else if([selectDic[@"classify"] integerValue]==3)
    {
        [Parameterdic setObject:@"sell" forKey:@"type"];
        
        
    }
    
    [self RefreshHeader];

    
}
#pragma mark-点搜索
-(void)ActionsearchBtn{
    [self MCCapacityViewhidden];

    [self MCscreenhidden];
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
-(void)MyshoppingGoin{
    
    NSString *sessionId = [MCUserDefaults objectForKey:@"sessionId"];
    if (!sessionId.length) {

        
        
        LoginController * ctl = [[LoginController alloc]init];
        [self pushNewViewController:ctl];
        return;
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
