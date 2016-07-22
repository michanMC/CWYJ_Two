//
//  MChomeViewController.m
//  CWYouJi
//
//  Created by MC on 16/4/28.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MChomeViewController.h"
#import "LeftViewController.h"
#import "UIViewController+NavBarHidden.h"
#import "MCMApManager.h"
#import "LoginController.h"
#import "AppDelegate.h"
#import "SettViewController.h"
#import "HomeCollectionViewCell.h"
#import "HomeHeaderCollectionReusableView.h"
#import "CarteViewController.h"
#import "MyTravelViewController.h"
#import "MyBaskViewController.h"
#import "MyPurchaseViewController.h"
#import "MySellViewController.h"
#import "MyTaskViewController.h"
#import "ContactListViewController.h"
#import "MCCityCardView.h"
#import "MCCityCardModle.h"
#import "ProductionViewController.h"
#import "ShoppingQXViewController.h"
#import "MyHotViewController.h"
#import "FenxianViewController.h"
#import "PromotionPage.h"
#import "AXPopoverView.h"
#import "AXPopoverLabel.h"
#import "AppDelegate.h"
#import "GengxinViewController.h"
#import "getGlobalSettModel.h"
@interface MChomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
   // UITableView *_tableView;
    UICollectionView *_collectionView;

    NSMutableArray *_bannerArray;
  UIButton * _headBtn;
    UIButton * _cityBtn;
    MCCityCardModle *  _CityCardModle;
    NSInteger _pageStr;
    NSMutableArray *_travelArray;
    NSMutableArray *_hotBuyArray;
    NSMutableArray *_recommendBuyArray;

    PromotionPage *proPage;

}

@end

@implementation MChomeViewController



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    RESideMenu *sideMenuViewController  =(RESideMenu*)  appDelegate.window.rootViewController;
    
    sideMenuViewController.panGestureEnabled = NO;
    
    
    [(LCTabBarController*) self.tabBarController removeOriginControls];

    
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];//用于去除导航栏的底线，也就是周围的边线
    
    //刷新头像，地址
        [_headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[MCUserDefaults objectForKey:@"thumbnail"]] forState:0 placeholderImage:[UIImage imageNamed:@"home_Avatar_44"]];

    [self HomeRemind];
    self.navigationController.navigationBarHidden = NO;

    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    RESideMenu *sideMenuViewController  =(RESideMenu*)  appDelegate.window.rootViewController;
    
    sideMenuViewController.panGestureEnabled = NO;

}
- (void)viewDidLoad {
    [super viewDidLoad];
//  NSString * ss=  [CommonUtil md5:@"123456"];
//    NSLog(@"ss ==%@",ss);
//    
    
    
    _pageStr = 1;
    _travelArray = [NSMutableArray array];
    _hotBuyArray = [NSMutableArray array];
    _recommendBuyArray = [NSMutableArray array];
    
    
    getGlobalSettModel * model = [[getGlobalSettModel alloc]init];
    model.nearby = @"5";
    model.ausleseCount = @"10";
    model.goodsMaxCount = @"200";
    
    [MCUserDefaults setObject:model.nearby? model.nearby : @"5" forKey:@"nearby"];
    [MCUserDefaults setObject:model.ausleseCount? model.ausleseCount : @"10" forKey:@"ausleseCount"];
    [MCUserDefaults setObject:model.goodsMaxCount? model.goodsMaxCount : @"200" forKey:@"goodsMaxCount"];

    
    
   // self.title = @"";
//    self.navigationController.title = @"首页";
    self.navigationItem.titleView = [[UIView alloc]init];
    _bannerArray = [NSMutableArray array];
    //监听头像的刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disTouXiangObj:) name:@"disTouXiangObjNotification" object:nil];
    //监听位置的刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disCityObj:) name:@"disCityObjNotification" object:nil];
    //跳转页面
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disCtlViewObj:) name:@"disCtlViewObjNotification" object:nil];
    //监听数据的刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadNewData) name:@"didNewObjNotification" object:nil];
    
    
    //监听头像红点
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(HomeRemind) name:@"didHomeRemindObjNotification" object:nil];
    //监听刷新RegistrationID
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRegistrationIDObj) name:@"didRegistrationIDObjNotification" object:nil];
    
    //self.navigationController.navigationBarHidden = YES;
    
  NSString * urlKeystr =[MCUserDefaults objectForKey:@"imgUrl"];
    NSURL * urlKey = [NSURL URLWithString:urlKeystr];
   
    if (urlKey) {
        [self loadData];
        proPage= [PromotionPage promotionPageWithLoginImage:nil promotionURL:urlKey];
//        proPage.tag = 7777;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actiontapPromotionPage:)];
        [proPage addGestureRecognizer:tap];
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [app.window addSubview:proPage];
        
        __weak MChomeViewController *weakSelf = self;
        proPage.finishBlock = ^(){
            NSLog(@"进入主界面");
        };
        [self prepareUI];

    }
    else
    {
        [self prepareUI];
        [self loadData];
        
 
    }
    [[AXPopoverLabel appearance] setBackgroundDrawingColor:[UIColor whiteColor]];
    [[AXPopoverLabel appearance] setDetailFont:[UIFont systemFontOfSize:16]];
    
    [self prepareTuisong];//推送
    //[self loadImg];
    // Do any additional setup after loading the view.
}
-(void)actiontapPromotionPage:(UITapGestureRecognizer*)tap{
    
    
    [proPage hidePromotionPage];
    
    
}
-(void)loadData{
    [self loadNewData];
    [self loadImg];
    [self getGlobalSetting];

}
#pragma mark-江湖
-(void)loadData1:(BOOL)iszhuang{
    if (iszhuang) {
        [self showLoading];
 
    }
    NSDictionary * dic  = @{
                            @"page":@(_pageStr)
                            };
    [self.requestManager postWithUrl:@"api/travel/index.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic2 ===%@",resultDic);
        NSArray * objectArray = resultDic[@"object"];
        for (NSDictionary* dic in objectArray) {
            homeYJModel * model = [homeYJModel mj_objectWithKeyValues:dic];
            model.userModel = [YJUserModel mj_objectWithKeyValues:dic[@"user"]];
            
            if (model.photos) {
                for (NSDictionary * photodic in model.photos) {
                    YJphotoModel * photomodel = [YJphotoModel mj_objectWithKeyValues:photodic];
                    [model.YJphotos addObject:photomodel];
                }
            }
            
            
            [_travelArray addObject:model];
        }
        [_collectionView reloadData];
        [_collectionView.mj_header endRefreshing];
        [_collectionView.mj_footer endRefreshing];
        if (!iszhuang) {
            [self loadbanner];

        }
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
//        [self showAllTextDialog:description];
        [_collectionView reloadData];
        [_collectionView.mj_header endRefreshing];
        [_collectionView.mj_footer endRefreshing];
        if (!iszhuang) {
            [self loadbanner];
            
        }

    }];
    
    
}
#pragma mark-推荐
-(void)loadData2{
     [self showLoading];
//    [self showLoading];
    NSDictionary * dic  = @{
                            };
    [self.requestManager postWithUrl:@"api/buy/getBuyOfRecommend.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
       // [self stopshowLoading];
        NSLog(@"resultDic3 ===%@",resultDic);
        
        NSArray * array = resultDic[@"object"];
        for (NSDictionary * dic in array) {
            MCBuyModlel * model = [MCBuyModlel mj_objectWithKeyValues:dic];
            model.MCdescription = dic[@"description"];
            model.MCdescription = dic[@"description"];
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
            

            
            
            
            
            
            model.userModel = [YJUserModel mj_objectWithKeyValues:model.user];
            [_recommendBuyArray addObject:model];
        }
       
        [_collectionView reloadData];
        [self loadData3];//热
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        if ([description isEqualToString:@"用户登陆信息过期，请重新登陆"]||[description isEqualToString:@"请重新登陆"]) {
            [MCUserDefaults setObject:@"" forKey:@"sessionId"];

        }
        [self loadData3];//热
    }];
    
    
}
#pragma mark-热
-(void)loadData3{
    
//    [self showLoading];
    NSDictionary * dic  = @{
                            @"type":@(1)
                            };
    
    [self.requestManager postWithUrl:@"api/buy/getBuyOfHot.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
//        [self stopshowLoading];
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

            model.userModel = [YJUserModel mj_objectWithKeyValues:model.user];
            [_hotBuyArray addObject:model];
        }
        [_collectionView reloadData];
        [self loadData1:NO];//江湖
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self loadData1:NO];//江湖
    }];
    
    
}

#pragma mark-跳转页面
-(void)disCtlViewObj:(NSNotification*)notication{
    NSString * objcStr =notication.object;
    [[[self.navigationController.navigationBar subviews]objectAtIndex:0] setAlpha:1];

    if ([objcStr isEqualToString:@"登录"]) {
        LoginController * ctl = [[LoginController alloc]init];
        [self pushNewViewController:ctl];
    }
    
       if ([objcStr isEqualToString:@"设置"]) {
        SettViewController * ctl = [[SettViewController alloc]init];
        [self pushNewViewController:ctl];
    }
    if ([objcStr isEqualToString:@"我的游"]) {
        MyTravelViewController * ctl = [[MyTravelViewController alloc]init];
        [self pushNewViewController:ctl];
    }
    if ([objcStr isEqualToString:@"我的晒"]) {
        MyBaskViewController * ctl = [[MyBaskViewController alloc]init];
        [self pushNewViewController:ctl];
    }
    if ([objcStr isEqualToString:@"我的求"]) {
        MyPurchaseViewController * ctl = [[MyPurchaseViewController alloc]init];
        [self pushNewViewController:ctl];
    }
    if ([objcStr isEqualToString:@"我的售"]) {
        MySellViewController * ctl = [[MySellViewController alloc]init];
        [self pushNewViewController:ctl];
    }
    if ([objcStr isEqualToString:@"我的任务"]) {
        MyTaskViewController * ctl = [[MyTaskViewController alloc]init];
        [self pushNewViewController:ctl];
    }
    if ([objcStr isEqualToString:@"通讯录"]) {
        ContactListViewController * ctl = [[ContactListViewController alloc]init];
        [self pushNewViewController:ctl];
    }
    if ([objcStr isEqualToString:@"我的足迹"]) {
        FenxianViewController * ctl = [[FenxianViewController alloc]init];
        
        if ([[MCUserDefaults objectForKey:@"id"] integerValue] ) {
            ctl.adlinkurl = [NSString stringWithFormat:@"%@api/travel/chinaMap.jhtml?uid=%ld",AppURL,[[MCUserDefaults objectForKey:@"id"] integerValue]];
            ctl.adlin2kurl = [NSString stringWithFormat:@"%@api/travel/worldMap.jhtml?uid=%ld",AppURL,[[MCUserDefaults objectForKey:@"id"] integerValue] ];
            
            
            [self pushNewViewController:ctl];
        }
    }
    if ([objcStr isEqualToString:@"系统消息"]) {
        GengxinViewController * ctl = [[GengxinViewController alloc]init];
        [self pushNewViewController:ctl];

    }




    
    
}
-(void)disCityObj:(NSNotification*)notication{
    
    NSString * city = notication.object;
    if (!city||!city.length) {
        city = @"未知";
    }
    CGFloat w = [MCIucencyView heightforString:city andHeight:25 fontSize:14]+20;
    _cityBtn.frame = CGRectMake(_cityBtn.mj_x, (44 -_cityBtn.mj_h)/2 , w, _cityBtn.mj_h);
    [_cityBtn addTarget:self action:@selector(action_cityBtn) forControlEvents:UIControlEventTouchUpInside];
    [_cityBtn setTitle:city forState:0];

}
#pragma mark-点击城市
-(void)action_cityBtn{
        [self showLoading];
    
    NSString * citystr = _cityBtn.titleLabel.text;
    NSString *responseString1 =  [citystr stringByReplacingOccurrencesOfString:@"市" withString:@""];

    
    NSDictionary * dic = @{
                           @"cityName":responseString1//_cityBtn.titleLabel.text
                           };
    [self.requestManager postWithUrl:@"api/city/query.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
        _CityCardModle = [MCCityCardModle mj_objectWithKeyValues:resultDic[@"object"]];

        NSArray * industryArray = [_CityCardModle.industry componentsSeparatedByString:@"、"];
        NSArray * artArray = [_CityCardModle.art componentsSeparatedByString:@"、"];
        NSArray * specialtyArray = [_CityCardModle.specialty componentsSeparatedByString:@"、"];
        NSArray * historyArray = [_CityCardModle.history componentsSeparatedByString:@"、"];

        NSMutableArray * array  = [NSMutableArray array];
        
        [array addObject:industryArray];
        [array addObject:artArray];
        [array addObject:specialtyArray];
        [array addObject:historyArray];
        MCCityCardView * view = [[MCCityCardView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
        view.Citystr = _CityCardModle.name;

        view.dataArray = array;
        
        
        [view showInWindow];
        

        
        
        
        
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
    }];

    
    
}
-(void)disTouXiangObj:(NSNotification*)notication{
    //刷新头像，地址
    [_headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[MCUserDefaults objectForKey:@"thumbnail"]] forState:0 placeholderImage:[UIImage imageNamed:@"home_Avatar_44"]];
    
}
-(void)prepareCollectionView{
     UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//    layout.sectionInset = UIEdgeInsetsMake(10, 1, 10, 1);
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64 - 49) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [_collectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:@"mc"];
    
    _collectionView.backgroundColor = ApphomeBgCOLOR;//[UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[HomeHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
        _collectionView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _collectionView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(RefreshFooter)];
    

}
-(void)prepareUI{
    [self prepareCollectionView];
    [MCMApManager sharedInstance];//定位
    [[MCMApManager sharedInstance] Isdingwei:YES CtlView:self];

        //2.设置导航条内容
    [self setUpNavBar];
    
    self.view.backgroundColor = ApphomeBgCOLOR;
}

#pragma mark -setUpNavBar

- (void)setUpNavBar{
    CGFloat x = 10;
    CGFloat y = 25;
    CGFloat width = 30;
    CGFloat height = 30;
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    

    _headBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    [view addSubview:_headBtn];
    ViewRadius(_headBtn, 15);
    _headBtn.alpha = 1;
    [_headBtn addTarget:self action:@selector(LeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    [_headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[MCUserDefaults objectForKey:@"thumbnail"]] forState:0 placeholderImage:[UIImage imageNamed:@"home_mine_avatar2"]];
//    _headBtn.backgroundColor = [UIColor clearColor];
    

    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:view];
    
    
    _hong_view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 7, 7)];
    ViewRadius(_hong_view, 7/2);
    _hong_view.backgroundColor = AppCOLOR;
    [view addSubview:_hong_view];
   [self HomeRemind];

    
    

    NSString * city = [MCUserDefaults objectForKey:@"city"];
    if (!city||!city.length) {
        city = @"未知";
    }
    
    
    
    
   CGFloat w = [MCIucencyView heightforString:city andHeight:25 fontSize:14]+20;
    
    
    
    
    _cityBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 0, w, 44)];
    [_cityBtn setTitle:city forState:0];
//    ViewRadius(_cityBtn, 25/2);
    [_cityBtn setTitleColor:[UIColor darkTextColor] forState:0];
    _cityBtn.titleLabel.font = AppFont;
//    _cityBtn.backgroundColor = [UIColor lightGrayColor];
    
    
    UIView * view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w + 30, 44)];
    [view2 addSubview:_cityBtn];
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, (44-15)/2, 15, 15)];
    imgView.image = [UIImage imageNamed:@"icon_map"];
    [view2 addSubview:imgView];
    imgView = [[UIImageView alloc]initWithFrame:CGRectMake(w + 15, (44-15)/2, 15, 15)];
    imgView.image = [UIImage imageNamed:@"icon_arrow"];
    [view2 addSubview:imgView];
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, view2.mj_w, 44)];
    
    [btn addTarget:self action:@selector(action_cityBtn) forControlEvents:UIControlEventTouchUpInside];
//    view2.backgroundColor = [UIColor yellowColor];
    [view2 addSubview:btn];

    
    self.navigationItem.titleView = view2;
    
    
    
    
}
#pragma mark-加载广告图
-(void)loadbanner{
    
  
    [self.requestManager postWithUrl:@"api/global/banner.json" refreshCache:NO params:nil IsNeedlogin:NO success:^(id resultDic) {
        NSLog(@"成功");
//        [self stopshowLoading];

        NSLog(@"guang游记==%@",resultDic);
        _bannerArray = resultDic[@"object"];
//        [_collectionView reloadData];
        [_collectionView reloadData];


    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
//        [self stopshowLoading];
//        [self showAllTextDialog:description];
        NSLog(@"失败");

    }];
    
    
}
#pragma mark-点击头像
-(void)LeftMenuViewController:(UIButton*)btn{
    if (![MCUserDefaults objectForKey:@"sessionId"]||![[MCUserDefaults objectForKey:@"sessionId"] length]) {
        LoginController * ctl = [[LoginController alloc]init];
        [self pushNewViewController:ctl];
        return;
    }
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"disDatadetailObjNotification" object:nil];
    [self presentLeftMenuViewController:btn];
}
#pragma mark-点击搜索
-(void)ActionsearchBtn
{
    
}
#pragma mark-下拉
-(void)loadNewData{
    _pageStr = 1;
    [_bannerArray removeAllObjects];
    [_hotBuyArray removeAllObjects];
    [_recommendBuyArray removeAllObjects];
    [_travelArray removeAllObjects];
    
    [self loadData2];//我

    
    
    
}

-(void)RefreshFooter{
    _pageStr++;
    [self loadData1:YES];//江湖

    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    //collectionView有多少的section
    return 5;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //collectionView有多少个Item
    if (section == 0 || section == 1)
        return 0;
    if (section == 2) {
        return _recommendBuyArray.count;
    }
    if(section == 3)
        return _hotBuyArray.count;
    
    return _travelArray.count;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        HomeHeaderCollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        
        
        if (!headView)
            headView = [[HomeHeaderCollectionReusableView alloc]initWithFrame:CGRectMake(0, 10, Main_Screen_Width, 40)];
        headView.backgroundColor = ApphomeBgCOLOR;

        
    if(indexPath.section == 0){
            if (_bannerArray.count) {
            
            headView.delgateSelf = self;
           [headView prepareADUI:_bannerArray];
            headView.backgroundColor = [UIColor whiteColor];
            }
        else
        {
            [headView prepareREMUI];

            
        }
            return headView;

        }
        
    if(indexPath.section == 1){

               [headView prepareUI:@"朋友推荐"];
                return headView;
    }
            
    if(indexPath.section == 2){
        

        
               if (_recommendBuyArray.count) {
                   [headView prepareMeUI:@"我的"];
                    [headView.modeBtn addTarget:self action:@selector(actiuonme_modeBtn) forControlEvents:UIControlEventTouchUpInside];
                    return headView;


                }
                else{
                    [headView prepareREMUI];
                    return headView;

                }
//                    [headView prepareMeUI:@""];


    }
        
    if(indexPath.section == 3){

               if (_hotBuyArray.count) {
                  [headView prepareMeUI:@"热门"];
//        headView.backgroundColor = [UIColor whiteColor];

                    [headView.modeBtn addTarget:self action:@selector(actiuonme_hotBtn) forControlEvents:UIControlEventTouchUpInside];
                    return headView;

                }
                else{
                    [headView prepareREMUI];

                    return headView;

//                    [headView prepareMeUI:@""];

                }

            }
    if(indexPath.section == 4){

//                [headView prepareUI:@"朋友江湖"];
               if (_travelArray.count) {
                    [headView prepareUI:@"朋友江湖"];
                    return headView;


                }
                else
                {
                    [headView prepareREMUI];

                    return headView;

//                    [headView prepareUI:@""];

                }

            }
        
        return headView;
        
    }
          return nil;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section== 0) {
        if (_bannerArray.count) {
            return CGSizeMake(Main_Screen_Width, 150*MCHeightScale);

        }
        else

           return CGSizeMake(Main_Screen_Width, 0.001);
    }
    if (_hotBuyArray.count || _recommendBuyArray.count) {
        if (section == 1) {
            return CGSizeMake(Main_Screen_Width, 40);

        }
        
        if (!_recommendBuyArray.count) {
            if (section == 2)

            return CGSizeMake(Main_Screen_Width, 0.001);

        }
        else
        {
            if (section == 2)

            return CGSizeMake(Main_Screen_Width, 40);

        }
        
        
        if (!_hotBuyArray.count) {
            if (section == 3)

              return CGSizeMake(Main_Screen_Width, 0.001);
            
        }
        else
        {
            if (section == 3)

            return CGSizeMake(Main_Screen_Width, 40);
            
        }
    
    }
    else
    {

        return CGSizeMake(Main_Screen_Width, 0.001);

    }
    if (section == 4) {
        return CGSizeMake(Main_Screen_Width, 40);

    }
    else

       return CGSizeMake(Main_Screen_Width, 0.001);
 

}





-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0|| indexPath.section == 1) {
        return CGSizeMake(0.001, 0.001);

    }
    if (indexPath.section == 4) {
        return CGSizeMake(Main_Screen_Width - 20, 150*MCHeightScale);
    }
    if (indexPath.section == 2)
    {
        if (indexPath.row < _recommendBuyArray.count) {
//            return CGSizeMake((Main_Screen_Width - 30)/2, 110*MCHeightScale + 85);

            return CGSizeMake((Main_Screen_Width-30) /2, 110*MCHeightScale + 85);
            
 
        }
    }
    else if (indexPath.section == 3)
    {
        
    return CGSizeMake((Main_Screen_Width - 30)/2, 110*MCHeightScale + 85 + 30);
    }

    return CGSizeMake((Main_Screen_Width - 30)/2, 110*MCHeightScale + 85);

}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0||section == 1) {
        return UIEdgeInsetsMake(0, 0, 0, 0);

    }
    if (section == 2)
    {

        return UIEdgeInsetsMake(10, 10,10, 10);
//        UIKIT_STATIC_INLINE UIEdgeInsets UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right) {

            
        
    }

//    if (section == 3)
        return UIEdgeInsetsMake(10, 10,10, 10);

//    return UIEdgeInsetsMake(0, 0, 2.5, 0);

}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mc" forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[HomeCollectionViewCell alloc]init];
        
    }
    if (indexPath.section == 4) {
        
        if (indexPath.row < _travelArray.count) {
            homeYJModel * modle = _travelArray[indexPath.row];
            cell.model = modle;
            
            [cell prepareYJUI];
            cell.headerimgBtn.tag = 880+indexPath.row;
            
            [cell.headerimgBtn addTarget:self action:@selector(ActionheaderimgBtn:) forControlEvents:UIControlEventTouchUpInside];

        }
        
        return cell;


    }
   else if (indexPath.section == 3) {
       if (indexPath.row < _hotBuyArray.count) {
           MCBuyModlel * modle = _hotBuyArray[indexPath.row];
           cell.BuyModlel = modle;
           
           [cell prepareHotUI];
           cell.headerimgBtn.tag = 330 + indexPath.row;
           [cell.headerimgBtn addTarget:self action:@selector(ActionheaderimgBtn1:) forControlEvents:UIControlEventTouchUpInside];

       }

   }
    else
    {
        
        if (indexPath.row < _recommendBuyArray.count) {
            MCBuyModlel * modle = _recommendBuyArray[indexPath.row];
            cell.BuyModlel = modle;

            [cell prepareMeUI];
            cell.headerimgBtn.tag = 550 + indexPath.row;

        [cell.headerimgBtn addTarget:self action:@selector(ActionheaderimgBtn2:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 3) {
        if (indexPath.row < _hotBuyArray.count) {
            MCBuyModlel * modle = _hotBuyArray[indexPath.row];
            ShoppingQXViewController *ctl = [[ShoppingQXViewController alloc]init];
            ctl.BuyModlel = modle;
            ctl.dataArray = _hotBuyArray;
            ctl.index = indexPath.row;//indexPath.section;
            
            [self pushNewViewController:ctl];

            
        }
        
    }

    if (indexPath.section == 4) {
        
        if (indexPath.row < _travelArray.count) {
            homeYJModel * modle = _travelArray[indexPath.row];
            ProductionViewController *ctl = [[ProductionViewController alloc]init];
            
            

            ctl.home_model = modle;
            ctl.dataArray = _travelArray;
            ctl.index = indexPath.row;//indexPath.section;
            
            [self pushNewViewController:ctl];

        
        }
    }
    if (indexPath.section == 2) {
    
        if (indexPath.row < _recommendBuyArray.count) {
            MCBuyModlel * modle = _recommendBuyArray[indexPath.row];
            ShoppingQXViewController *ctl = [[ShoppingQXViewController alloc]init];
            ctl.BuyModlel = modle;
            
            ctl.dataArray = _recommendBuyArray;
            ctl.index = indexPath.row;//indexPath.section;
            
            [self pushNewViewController:ctl];
            
            
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

    YJUserModel * modle = [[YJUserModel alloc]init];
    if (btn.tag >= 880) {
        homeYJModel * model = _travelArray[btn.tag - 880];
        modle = model.userModel;
    }
    
    CarteViewController *ctl = [[CarteViewController alloc]init];
    ctl.userModel = modle;
//   ctl.isfriend = YES;
    [self pushNewViewController:ctl];
    
    
}
-(void)ActionheaderimgBtn1:(UIButton*)btn{
    NSString *sessionId = [MCUserDefaults objectForKey:@"sessionId"];
    if (!sessionId.length) {
        LoginController * ctl = [[LoginController alloc]init];
        [self pushNewViewController:ctl];
        return;
    }

  MCBuyModlel * modle =  _hotBuyArray[btn.tag - 330];
    CarteViewController *ctl = [[CarteViewController alloc]init];
    ctl.userModel = modle.userModel;
    //   ctl.isfriend = YES;
    [self pushNewViewController:ctl];

}
-(void)ActionheaderimgBtn2:(UIButton*)btn{
    NSString *sessionId = [MCUserDefaults objectForKey:@"sessionId"];
    if (!sessionId.length) {
        LoginController * ctl = [[LoginController alloc]init];
        [self pushNewViewController:ctl];
        return;
    }

    MCBuyModlel * modle =  _recommendBuyArray[btn.tag - 550];
    CarteViewController *ctl = [[CarteViewController alloc]init];
    ctl.userModel = modle.userModel;
    //   ctl.isfriend = YES;
    [self pushNewViewController:ctl];
    
}

-(void)actiuonme_modeBtn{
    
    self.tabBarController.selectedIndex = 1;
    
    
}

-(void)actiuonme_hotBtn{
    MyHotViewController * ctl = [[MyHotViewController alloc]init];
    [self pushNewViewController:ctl];
    
}
-(void)loadImg{
    
    [self.requestManager postWithUrl:@"api/common/bootPicture.json" refreshCache:NO params:nil IsNeedlogin:NO success:^(id resultDic) {
        
        NSLog(@"resultDic ===>>>>>%@",resultDic);
        if (resultDic[@"object"][@"image"]) {
            [MCUserDefaults setObject:resultDic[@"object"][@"image"] forKey:@"imgUrl"];

        }
//        NSURL  *urlKey = [NSURL URLWithString:resultDic[@"object"][@"image"]];
        
        
        
        
        
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {

    }];
    
    
    
}
-(void)getGlobalSetting{
    
    [self.requestManager postWithUrl:@"api/global/setting/getGlobalSetting.json" refreshCache:NO params:nil IsNeedlogin:NO success:^(id resultDic) {
        /*
        nearby = 11;位置社交距离（公里
        ausleseCount = 11;精华贴所需收藏数,
        id = 1;
        friendRecommendDay = 11;好友推荐间隔（天）
        integralExpire = 2016-06-16;积分有效期,
        createDate = 1467190746000;
        goodsMaxCount = 200;单一售卖单商品数量最大值,
        modifyDate = 1467190746000;
         */
        
        
        
        NSLog(@"resultDic ===>>>>>%@",resultDic);
        getGlobalSettModel * model = [getGlobalSettModel mj_objectWithKeyValues:resultDic[@"object"]];
        [MCUserDefaults setObject:model.nearby? model.nearby : @"5" forKey:@"nearby"];
        [MCUserDefaults setObject:model.ausleseCount? model.ausleseCount : @"10" forKey:@"ausleseCount"];
        [MCUserDefaults setObject:model.goodsMaxCount? model.goodsMaxCount : @"200" forKey:@"goodsMaxCount"];


        
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        
        getGlobalSettModel * model = [[getGlobalSettModel alloc]init];
        model.nearby = @"5";
        model.ausleseCount = @"10";
        model.goodsMaxCount = @"200";

        [MCUserDefaults setObject:model.nearby? model.nearby : @"5" forKey:@"nearby"];
        [MCUserDefaults setObject:model.ausleseCount? model.ausleseCount : @"10" forKey:@"ausleseCount"];
        [MCUserDefaults setObject:model.goodsMaxCount? model.goodsMaxCount : @"200" forKey:@"goodsMaxCount"];
        

        
    }];
    

    
    
    
}
-(void)didRegistrationIDObj{
    NSString *  RegistrationID = [JPUSHService registrationID];
    if (RegistrationID.length) {
        [self updateClientId:[JPUSHService registrationID]];
    }
    
}

#pragma mark-红点
-(void)HomeRemind{
    
  BOOL i = [MCIucencyView HomeRemind];
    _hong_view.hidden = i;
    
    
}
//- (void)dealloc {
//    [self unObserveAllNotifications];
//}
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
