//
//  DEMOHomeViewController.m
//  REFrostedViewControllerExample
//
//  Created by Roman Efimov on 9/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOHomeViewController.h"
#import "DEMONavigationController.h"
#import "UIViewController+REFrostedViewController.h"
#import "REFrostedViewController.h"
#import "ZZCarousel.h"
#import "MCplaceholderText.h"
#import "HomeTableViewCell.h"
#import "zuopinViewController.h"
#import "zuopinXQViewController.h"
#import "DMLazyScrollView.h"
#import "shaixuanView.h"
#import "zhizuoZP1ViewController.h"
#import "zhizuoZP3ViewController.h"
#import "jingdianView.h"
#import "homeYJModel.h"
#import "SettgViewController.h"
#import "jingdianModel.h"
#import "Home_LunBoGuangGao_Web.h"
#import "FenxianViewController.h"
#import "loginViewController.h"
#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "JSBadgeView.h"
#import "UIButton+WebCache.h"
#import <QuartzCore/QuartzCore.h>
#import "NoYJTableViewCell.h"
#import "YYClipImageTool.h"

@interface DEMOHomeViewController ()<ZZCarouselDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UITextFieldDelegate,jingdianViewDelegate>
{
    
    UITableView * _tableView;
    ZZCarousel *_headwheel;//广告图
    MCplaceholderText *_searchtext;
    UIButton * _faBuBtn;
    UIView * _daohanTiaoview;
    UIView * _daohanTiaoLineview;
    
    shaixuanView *_shaixuanView;
    jingdianView *_jiangdianView;
    //喜欢
    NSInteger _btnTagindexXH;
    //分类
    NSInteger _btnTagindexFL;
      //分类
    NSInteger _btnTagindexJL;

    
    NSMutableArray *_dataAarray;//数据源
    NSInteger _pageStr;
    
    NSMutableArray *_bannerArray;
    
    
    
    NSInteger  _spotIdStr;//景点
    NSInteger  _classifyStr;//类型
    NSInteger  _isRecommendStr;//推荐
    NSInteger  _jlStr;//距离

    
    NSMutableArray *_jingdianArray;
    
    
    NSMutableArray *_messageContents;
    int _messageCount;
    int _notificationCount;
    
    BOOL _isshiyongLo;
    
    UIButton * _headBtn;
    UILabel * ciytlbl;
    UIView *ciytbgViewd;
    
    BOOL _isbgPhoto;
}

@end

@implementation DEMOHomeViewController
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:@"homeView"];

    self.frostedViewController.panGestureEnabled = YES;
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"homeView"];

    self.frostedViewController.panGestureEnabled = NO;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
    
    
    
    
    
    if(![MCUser sharedInstance].isadd){
        [MCUser sharedInstance].isadd = YES;
        UIImageView * bdImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];

         NSString *paths = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:@"/qidong.png"];
        
      UIImage*  image = [UIImage imageWithContentsOfFile:paths];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        BOOL result = [fileManager fileExistsAtPath:paths];
        

      //  bdImg.image = image;

        
        if (!result) {
           
//              NSString *path = [[NSBundle mainBundle] pathForResource:@"efault-568h@2x" ofType:@"png"];
//            // bdImg.image = [UIImage imageWithContentsOfFile:path];
//            image = [UIImage imageWithContentsOfFile:path];
           // image = [UIImage imageNamed:@"efault-568h"];
        }
        [YYClipImageTool addToCurrentView:[UIApplication sharedApplication].windows[0] clipImage:image backgroundImage:@"bgImage"];


    }
    
    _isshiyongLo = YES;
    // NSLog(@">>>>>>%f",[[UIScreen mainScreen] bounds].size.width);
    _messageCount = 0;
    _notificationCount = 0;
    _messageContents = [[NSMutableArray alloc] initWithCapacity:6];
    [self prepareTuisong];//推送
    _spotIdStr = -1;
    _classifyStr = -1;
    _jlStr = -1;

    _isRecommendStr = -1;
    _pageStr = 1;
    //监听左视图的跳转
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectObj:) name:@"didSelectObjNotification" object:nil];
    //监听首页的刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dishuaxinObj:) name:@"dishuaxinObjNotification" object:nil];
    //监听评论的个数
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pinglunCoun:) name:@"pinglunCounNotification" object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dingweiobj:) name:@"dingweiCounNotification" object:nil];
    //监听跳过来的游记
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(oneyouji:) name:@"oneyoujiNotification" object:nil];
    
    self.title = @"Home Controller";
    _dataAarray  =[NSMutableArray array];
    _bannerArray = [NSMutableArray array];
    _jingdianArray = [NSMutableArray array];
    
    [self prepareUI];
    
    
    _shaixuanView = [[[NSBundle mainBundle] loadNibNamed:@"shaixuanView" owner:self options:nil] lastObject];
    _shaixuanView.frame = CGRectMake(0, 64.5, Main_Screen_Width, Main_Screen_Height - 64);
    _shaixuanView.hidden = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ActionShaixunView:)];
    [_shaixuanView.bgView addGestureRecognizer:tap];
    
    [self btnview:_shaixuanView.quanbu1];
    [self btnview:_shaixuanView.tuijian];
    [self btnview:_shaixuanView.butuijian];
    [self btnview:_shaixuanView.quanbu2];
    [self btnview:_shaixuanView.shiBtn];
    [self btnview:_shaixuanView.zhuBtn];
    [self btnview:_shaixuanView.jingBtn];
    [self btnview:_shaixuanView.gouBtn];
    
    [self btnview:_shaixuanView.km5Btn];
    [self btnview:_shaixuanView.km10Btn];
    [self btnview:_shaixuanView.km50Btn];
    [self btnview:_shaixuanView.km100Btn];
    [self btnview:_shaixuanView.buxianBtn];

    
    
    [_shaixuanView.quanbu1 addTarget:self action:@selector(actionShaixuan:) forControlEvents:UIControlEventTouchUpInside];
    [_shaixuanView.tuijian addTarget:self action:@selector(actionShaixuan:) forControlEvents:UIControlEventTouchUpInside];
    
    [_shaixuanView.butuijian addTarget:self action:@selector(actionShaixuan:) forControlEvents:UIControlEventTouchUpInside];
    
    [_shaixuanView.quanbu2 addTarget:self action:@selector(actionShaixuan:) forControlEvents:UIControlEventTouchUpInside];
    
    [_shaixuanView.shiBtn addTarget:self action:@selector(actionShaixuan:) forControlEvents:UIControlEventTouchUpInside];
    
    [_shaixuanView.zhuBtn addTarget:self action:@selector(actionShaixuan:) forControlEvents:UIControlEventTouchUpInside];
    [_shaixuanView.jingBtn addTarget:self action:@selector(actionShaixuan:) forControlEvents:UIControlEventTouchUpInside];
    
    [_shaixuanView.gouBtn addTarget:self action:@selector(actionShaixuan:) forControlEvents:UIControlEventTouchUpInside];
    
    [_shaixuanView.okBtn addTarget:self action:@selector(actionShaixuan:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [_shaixuanView.km5Btn addTarget:self action:@selector(actionShaixuan:) forControlEvents:UIControlEventTouchUpInside];
    [_shaixuanView.km50Btn addTarget:self action:@selector(actionShaixuan:) forControlEvents:UIControlEventTouchUpInside];
    [_shaixuanView.km10Btn addTarget:self action:@selector(actionShaixuan:) forControlEvents:UIControlEventTouchUpInside];
    [_shaixuanView.km100Btn addTarget:self action:@selector(actionShaixuan:) forControlEvents:UIControlEventTouchUpInside];
    [_shaixuanView.buxianBtn addTarget:self action:@selector(actionShaixuan:) forControlEvents:UIControlEventTouchUpInside];

    
    
    [self.view addSubview:_shaixuanView];
    
    
    
    _jiangdianView = [[jingdianView alloc]initWithFrame:CGRectMake(0, 64.5, Main_Screen_Width, Main_Screen_Height - 64.5)];
    [_jiangdianView prepareUI];
    _jiangdianView.delegate = self;
    _jiangdianView.hidden = YES;
    [self.view addSubview:_jiangdianView];
    
}
-(void)ActionShaixunView:(UITapGestureRecognizer*)tap{
    //     _shaixuanBtn.tag =  901;
    UIButton * btn = (UIButton*)[self.view viewWithTag:901];
    [self actionShaixuan:btn];
    
}
#pragma mark- 喜欢\分类
-(void)actionShaixuan:(UIButton*)btn{
    
    NSLog(@"%ld",btn.tag);
    //喜欢
    if (btn.tag >= 700 && btn.tag <= 702) {
        for (int i = 700; i < 703; i ++) {
            UIButton * subBtn = (UIButton*)[self.view viewWithTag:i];
            subBtn.selected = NO;
            [self StateNormalBtn:subBtn];
        }
        btn.selected = YES;
        [self StateSelectedBtn:btn];
        _btnTagindexXH  = btn.tag;
        
        
    }
    else if (btn.tag >= 800 && btn.tag <= 804)//分类
    {
        for (int i = 800; i < 805; i ++) {
            UIButton * subBtn = (UIButton*)[self.view viewWithTag:i];
            subBtn.selected = NO;
            [self StateNormalBtn:subBtn];
        }
        btn.selected = YES;
        [self StateSelectedBtn:btn];
        _btnTagindexFL  = btn.tag;
        
        
    }
    else if (btn.tag >= 400 && btn.tag <= 404)//分类
    {
        for (int i = 400; i < 405; i ++) {
            UIButton * subBtn = (UIButton*)[self.view viewWithTag:i];
            subBtn.selected = NO;
            [self StateNormalBtn:subBtn];
        }
        btn.selected = YES;
        [self StateSelectedBtn:btn];
        _btnTagindexJL  = btn.tag;
        
        
    }

    else if(btn.tag == 900){
        UIButton * btn2 = (UIButton*)[self.view viewWithTag:901];
        [self actionShaixuan:btn2];
        
        NSLog(@"喜欢%ld",_btnTagindexXH);
        NSLog(@"分类%ld",_btnTagindexFL);
        if (_btnTagindexXH == 0 || _btnTagindexXH == 700) {
            _isRecommendStr = -1;
        }
        else if(_btnTagindexXH == 701){
            
            _isRecommendStr = 1;
        }
        else if(_btnTagindexXH == 702){
            
            _isRecommendStr = 0;
        }
        
        if (_btnTagindexFL == 0 ||  _btnTagindexFL == 800) {
            _classifyStr = -1;
        }
        else if(_btnTagindexFL == 801){
            _classifyStr = 0;
            
        }else if(_btnTagindexFL == 802){
            _classifyStr = 1;
            
        }else if(_btnTagindexFL == 803){
            _classifyStr = 2;
            
        }else if(_btnTagindexFL == 804){
            _classifyStr = 3;
            
        }
        
        if (_btnTagindexJL == 0 ||  _btnTagindexJL == 400) {
            _jlStr = -1;
        }
        else if(_btnTagindexJL == 401){
            _jlStr = 0;
            
        }else if(_btnTagindexJL == 402){
            _jlStr = 1;
            
        }else if(_btnTagindexJL == 403){
            _jlStr = 2;
            
        }else if(_btnTagindexJL == 404){
            _jlStr = 3;
            
        }

        
        // [self actionHeader];
        _pageStr = 1;
        [self loadData:YES];
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"disyemianjisuanObjNotification" object:@"5"];
        
    }
    else if(btn.tag == 901){
        _jiangdianView.hidden = YES;
        if (!_shaixuanView.hidden) {//隐藏
            if (_tableView.contentOffset.y > 100) {
                _daohanTiaoview.backgroundColor = [UIColor whiteColor];
                _daohanTiaoLineview.backgroundColor =[ UIColor lightGrayColor];
                ciytbgViewd.hidden = YES;
                ciytlbl.hidden = YES;

            }
            else
            {
                _daohanTiaoview.backgroundColor = [UIColor clearColor];
                _daohanTiaoLineview.backgroundColor =[ UIColor clearColor];
                ciytbgViewd.hidden = NO;
                ciytlbl.hidden = NO;

            }
            _shaixuanView.hidden = YES;
            btn.selected = NO;
            
        }
        else
        {
            //            [UIView animateWithDuration:1 animations:^{
            //                _shaixuanView.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height);
            //
            //            }];
            _daohanTiaoview.backgroundColor = [UIColor whiteColor];
            ciytlbl.hidden = YES;
            ciytbgViewd.hidden = YES;

            _daohanTiaoLineview.backgroundColor =[ UIColor lightGrayColor];
            _shaixuanView.hidden = NO;
            
        }
        
    }
    
    
    
    
    
}
-(void)btnview:(UIButton*)btn{
    ViewRadius(btn, 15);
    btn.layer.borderColor = [UIColor grayColor].CGColor;
    btn.layer.borderWidth = 0.5;
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
}
-(void)StateSelectedBtn:(UIButton*)btn{
    
    btn.layer.borderColor = [UIColor orangeColor].CGColor;
    UIImageView * img = (UIImageView*)[_shaixuanView viewWithTag:btn.tag + 10];
    img.hidden = NO;
    
}
-(void)StateNormalBtn:(UIButton*)btn{
    
    btn.layer.borderColor = [UIColor grayColor].CGColor;
    UIImageView * img = (UIImageView*)[_shaixuanView viewWithTag:btn.tag + 10];
    img.hidden = YES;
    
    
}


-(void)prepareUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
    _headwheel = [self headViewwheel:500];
    
    _tableView.tableHeaderView = [self addHeadView:_headwheel];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView addFooterWithTarget:self action:@selector(actionfooter)];
    [_tableView addHeaderWithTarget:self action:@selector(actionHeader)];
    _faBuBtn = [[UIButton alloc]initWithFrame:CGRectMake((Main_Screen_Width - 50)/2, Main_Screen_Height - 5 - 50, 50, 50)];
    [_faBuBtn setImage:[UIImage imageNamed:@"home_add_normal"] forState:UIControlStateNormal];
    [self.view addSubview:_faBuBtn];
    [_faBuBtn addTarget:self action:@selector(actionFabu) forControlEvents:UIControlEventTouchUpInside];
    
    [_headwheel reloadData];
    [self preparedaohangtiao];
    [self loadData:YES];
    [self loadbanner];
    
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"disyemianjisuanObjNotification" object:@"1"];
}
#pragma mrak-上下拉
-(void)actionHeader{
    _pageStr = 1;
    [self loadData:NO];
}
-(void)actionfooter{
    _pageStr ++;
    [self loadData:NO];
    
}
-(void)actionMenu:(UIButton*)btn{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if ([[defaults objectForKey:@"sessionId"] isEqualToString:@""]||![defaults objectForKey:@"sessionId"] ) {
        //登录
        
        
    }
    else
    {
        //if (_badgeView.badgeText.length) {
        /*保存数据－－－－－－－－－－－－－－－－－begin*/
        
        [btn addTarget:(DEMONavigationController *)self.navigationController action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
}

-(void)preparedaohangtiao{
    
    _daohanTiaoview  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 64)];
    
    CGFloat x = 10;
    CGFloat y = 25;
    CGFloat width = 30;
    CGFloat height = 30;
    UIView* headview = [[UIView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    [_daohanTiaoview addSubview:headview];
    _headBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    ViewRadius(_headBtn, 15);
    // [_headBtn setBackgroundImage:[UIImage imageNamed:@"home_mine_avatar2"] forState:0];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[defaults objectForKey:@"thumbnail"]);
    
    [_headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[defaults objectForKey:@"thumbnail"]] forState:0 placeholderImage:[UIImage imageNamed:@"home_mine_avatar2"]];
    _badgeView = [[JSBadgeView alloc] initWithParentView:headview alignment:JSBadgeViewAlignmentTopLeft];
    _badgeView.badgeText = @"";//[NSString stringWithFormat:@"%d", 0];
    
    
    
    
    
    
    
    
    [_headBtn addTarget:(DEMONavigationController *)self.navigationController action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    [_daohanTiaoview addSubview:_headBtn];
    
    
    
    
    
    
    
   // x += width + 5;
   ciytbgViewd  = [[UIView alloc]initWithFrame:CGRectMake(_headBtn.x, _headBtn.y+_headBtn.height, 40, 25)];
    ciytbgViewd.backgroundColor =[UIColor blackColor];
    ciytbgViewd.alpha = .4;
    ViewRadius(ciytbgViewd, 25/2);
    ciytlbl = [[UILabel alloc]initWithFrame:CGRectMake(_headBtn.x, _headBtn.y+_headBtn.height, 40, 25)];
    ciytlbl.text =[MCUser sharedInstance].myLocation.city;
    NSLog(@"%@",[MCUser sharedInstance].myLocation.city);
    if (![MCUser sharedInstance].myLocation.city) {
        ciytlbl.text = @"未知";
    }
    ciytlbl.textAlignment = NSTextAlignmentCenter;
    ciytlbl.textColor = [UIColor whiteColor];
    ciytlbl.font = [UIFont systemFontOfSize:12];
    ciytlbl.adjustsFontSizeToFitWidth = YES;
    
    
    
    [_daohanTiaoview addSubview:ciytbgViewd];
    [_daohanTiaoview addSubview:ciytlbl];
    
    width  =Main_Screen_Width - 2* 45;
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(x + 45, y, width, height)];
    bgView.backgroundColor =[UIColor blackColor];
    bgView.alpha = .4;
    ViewRadius(bgView, 15);
    [_daohanTiaoview addSubview:bgView];
    
    x += 10 + 45;
    y += 6.5;
    width  = 20;
    height = 20;
    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    img.image = [UIImage imageNamed:@"ic_icon_search"];
    [_daohanTiaoview addSubview:img];
    x +=width + 5;
    y -=6.5;
    width =Main_Screen_Width - (Main_Screen_Width - bgView.frame.size.width)/2 - 30 - 45;
    height = 30;
    _searchtext = [[MCplaceholderText alloc]initWithFrame:CGRectMake(x, y, width, height)];
    _searchtext.placeholder = @"输入景点搜索";
    _searchtext.textColor  =[UIColor whiteColor];
    _searchtext.font = AppFont;
    _searchtext.delegate =self;
    _searchtext.clearButtonMode = UITextFieldViewModeAlways;
    //_searchtext.backgroundColor = [UIColor redColor];
    [_searchtext addTarget:self action:@selector(actionText:) forControlEvents:UIControlEventEditingChanged];
    [_daohanTiaoview addSubview:_searchtext];
    x = Main_Screen_Width - 10 - 30;
    width = 30;
    height = 30;
    
    UIButton * _shaixuanBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    [_shaixuanBtn setImage:[UIImage imageNamed:@"home_mine_screened2"] forState:0];
    [_shaixuanBtn addTarget:self action:@selector(actionShaixuan:) forControlEvents:UIControlEventTouchUpInside];
    _shaixuanBtn.tag =  901;
    [_daohanTiaoview addSubview:_shaixuanBtn];
    _daohanTiaoLineview = [[UIView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 0.5)];
    _daohanTiaoLineview.backgroundColor = [UIColor clearColor];
    [_daohanTiaoview addSubview:_daohanTiaoLineview];
    [self.view addSubview:_daohanTiaoview];
    
    
    
}
#pragma mark-加载广告图
-(void)loadbanner{
    
    
    [self.requestManager requestWebWithParaWithURL:@"api/global/banner.json" Parameter:nil IsLogin:NO Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"guang游记==%@",resultDic);
        _bannerArray = resultDic[@"object"];
        
        _tableView.tableHeaderView = nil;
        
        _headwheel = [self headViewwheel:500];
        
        _tableView.tableHeaderView = [self addHeadView:_headwheel];
        
        
        [_headwheel reloadData];
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
        NSLog(@"失败");
    }];
    
    
    
    
}
#pragma mark-加载数据
-(void)loadData:(BOOL)isjuhua{
    
    //    NSDictionary * Parameterdic = @{
    //                                    @"page":@(_pageStr),
    //                                   @"spotId":@(_spotIdStr),
    //                                    @"classify":@(_classifyStr),
    //                                    @"isRecommend":@(_isRecommendStr),
    //
    //                                    };
    
    
    NSMutableDictionary * Parameterdic = [NSMutableDictionary dictionary];
    [Parameterdic  setObject:@(_pageStr) forKey:@"page"];
    if (_spotIdStr>=0 ) {
        [Parameterdic  setObject:@(_spotIdStr) forKey:@"spotId"];
        
    }
    if (_classifyStr>=0 ) {
        [Parameterdic  setObject:@(_classifyStr) forKey:@"classify"];
        
    }
    if (_jlStr>=0 ) {
        long long  distance;
        if (_jlStr == 0) {
            distance = 5000;
             [Parameterdic  setObject:@(distance) forKey:@"distance"];
        }
        if (_jlStr == 1) {
            distance = 10000;
            [Parameterdic  setObject:@(distance) forKey:@"distance"];
        }
        if (_jlStr == 2) {
            distance = 50000;
            [Parameterdic  setObject:@(distance) forKey:@"distance"];
        }
        if (_jlStr == 3) {
            distance = 100000;
            [Parameterdic  setObject:@(distance) forKey:@"distance"];
        }

       
        
    }

    if (_isRecommendStr>=0 ) {
        [Parameterdic  setObject:@(_isRecommendStr) forKey:@"isRecommend"];
        
    }
    CGFloat la = [MCUser sharedInstance].myLocation.la;
    CGFloat lo = [MCUser sharedInstance].myLocation.lo;
    [Parameterdic setObject:@(la) forKey:@"lat"];
    [Parameterdic setObject:@(lo) forKey:@"lng"];
    
    
//    //    {
//    lat = 0,
//    lng = 0,
//    page = 1,
//}

    
    
    
    [self showLoading:isjuhua AndText:nil];
    [self.requestManager requestWebWithParaWithURL:@"api/travel/query.json" Parameter:Parameterdic IsLogin:NO Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回游记==%@",resultDic);
        if (_pageStr == 1) {
            [_dataAarray removeAllObjects];
        }
        
        NSArray * objectArray = resultDic[@"object"];
        for (NSDictionary* dic in objectArray) {
            homeYJModel * model = [homeYJModel mj_objectWithKeyValues:dic];
            model.userModel = [YJUserModel mj_objectWithKeyValues:dic[@"user"]];
            NSLog(@"%@",model.userModel.isNew);
            
            if (model.photos) {
                for (NSDictionary * photodic in model.photos) {
                    YJphotoModel * photomodel = [YJphotoModel mj_objectWithKeyValues:photodic];
                    [model.YJphotos addObject:photomodel];
                }
            }
            
            
            [_dataAarray addObject:model];
        }
        if (_dataAarray.count == 0) {
            _isbgPhoto = YES;
        }
        else
        {
            _isbgPhoto = NO;

        }
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
        [_tableView reloadData];
        if ([MCUser sharedInstance].tiaoStr.length) {
            NSString * sss = [MCUser sharedInstance].tiaoStr;
            if ([sss isEqualToString:@"china"]) {
                //发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectObjNotification" object:@"3"];
                
            }
            else if([sss isEqualToString:@"world"]){
                //发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectObjNotification" object:@"5"];
            }
            else if([sss integerValue] > 0){
                //发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"oneyoujiNotification" object:sss];
   
            }
            [MCUser sharedInstance].tiaoStr = @"";
        }
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
        NSLog(@"失败");
    }];
    
    
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if (!textField.text.length) {
        if (_tableView.contentOffset.y > 100) {
            _daohanTiaoview.backgroundColor = [UIColor whiteColor];
            _daohanTiaoLineview.backgroundColor =[ UIColor lightGrayColor];
            ciytbgViewd.hidden = YES;
            ciytlbl.hidden = YES;

        }
        else
        {
            _daohanTiaoview.backgroundColor = [UIColor clearColor];
            _daohanTiaoLineview.backgroundColor =[ UIColor clearColor];
            ciytbgViewd.hidden = NO;
            ciytlbl.hidden = NO;
        }
        
        _jiangdianView.hidden = YES;
        
    }
    
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (!textField.text.length) {
        //_isshiyongLo = NO;
        textField.text = [MCUser sharedInstance].myLocation.city;
    }
    
}
#pragma mark-景点
-(void)actionText:(UITextField*)textField{
    
    _daohanTiaoview.backgroundColor = [UIColor whiteColor];
    _daohanTiaoLineview.backgroundColor =[ UIColor lightGrayColor];
    ciytlbl.hidden = YES;
    ciytbgViewd.hidden = YES;

    
    NSLog(@"string>>%@",textField.text);
    if (textField.text.length == 0 || [textField.text isEqualToString:@""] ||[textField.text isEqualToString:@" "]  ) {
        _spotIdStr = - 1;
        //[self actionHeader];
        _pageStr = 1;
        [_jingdianArray removeAllObjects];
        _jiangdianView.jingdianArray = _jingdianArray;
        // [self textFieldDidEndEditing:textField];
        [self loadData:NO];
        return;
    }
    //    if (<#condition#>) {
    //        <#statements#>
    //    }
    CGFloat la = [MCUser sharedInstance].myLocation.la;
    CGFloat lo = [MCUser sharedInstance].myLocation.lo;
    
    NSDictionary * Parameterdic = @{
                                    @"keyWord":textField.text,
                                    @"lat":@(la),
                                    @"lng":@(lo),
                                    };
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString * strurl = [NSString stringWithFormat:@"%@api/travel/searchSpots.json",AppURL];
    
    
    [manager POST:strurl parameters:Parameterdic success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         //NSLog(@"%@",responseObject);
         NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
         NSError *parserError = nil;
         NSDictionary *resultDic = nil;
         @try {
             NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             // NSLog(@"<<<<<<%@",responseString);
             
             
             NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
             NSError *err;
             
             
             resultDic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&err];
             
         }
         @catch (NSException *exception) {
             [NSException raise:@"网络接口返回数据异常" format:@"Error domain %@\n,code=%ld\n,userinfo=%@",parserError.domain,(long)parserError.code,parserError.userInfo];
             //发出消息错误的通知
         }
         @finally {
             //业务产生的状态码
             NSString *logicCode = [NSString stringWithFormat:@"%ld",[resultDic[@"code"] integerValue]];
             
             //成功获得数据
             if ([logicCode isEqualToString:@"1"]) {
                 
                 //                 completeBlock(resultDic);
                 
                 NSLog(@"返回》》==%@",resultDic);
                 [_jingdianArray removeAllObjects];
                 NSArray * objectArray = resultDic[@"object"];
                 if (![resultDic[@"object"] isEqual:[NSNull null]])

                 for (NSDictionary *dic in objectArray) {
                     jingdianModel * modle = [jingdianModel mj_objectWithKeyValues:dic];
                     [_jingdianArray addObject:modle];
                 }
                 if (_jingdianArray.count&&!(textField.text.length == 0 || [textField.text isEqualToString:@""] ||[textField.text isEqualToString:@" "])) {
                     
                     _jiangdianView.jingdianArray = _jingdianArray;
                     _shaixuanView.hidden = YES;
                     _jiangdianView.hidden = NO;
                     //  [_jiangdianView.tableView reloadData];
                 }
                 
                 
                 
                 
             }
             else{
                 //业务逻辑错误
                 NSString *message = [resultDic objectForKey:@"message"];
                 NSError *error = [NSError errorWithDomain:@"服务器业务逻辑错误" code:logicCode.intValue userInfo:nil];
                 
             }
         }
         
         
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
     }];
    
    
    
    
    
    /*
     
     // [self showLoading:YES AndText:nil];
     [self.requestManager requestWebWithParaWithURL:@"api/travel/searchSpots.json" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
     // [self stopshowLoading];
     NSLog(@"成功");
     NSLog(@"返回》》==%@",resultDic);
     [_jingdianArray removeAllObjects];
     NSArray * objectArray = resultDic[@"object"];
     for (NSDictionary *dic in objectArray) {
     jingdianModel * modle = [jingdianModel mj_objectWithKeyValues:dic];
     [_jingdianArray addObject:modle];
     }
     if (_jingdianArray.count&&!(textField.text.length == 0 || [textField.text isEqualToString:@""] ||[textField.text isEqualToString:@" "])) {
     
     _jiangdianView.jingdianArray = _jingdianArray;
     _shaixuanView.hidden = YES;
     _jiangdianView.hidden = NO;
     //  [_jiangdianView.tableView reloadData];
     }
     
     
     
     } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
     [self stopshowLoading];
     [self showAllTextDialog:description];
     
     NSLog(@"失败");
     }];
     
     
     
     */
    
    
    
}
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    _daohanTiaoview.backgroundColor = [UIColor whiteColor];
//    _daohanTiaoLineview.backgroundColor =[ UIColor lightGrayColor];
//    _shaixuanView.hidden = YES;
//    _jiangdianView.hidden = NO;
//    NSLog(@"string%@",textField.text);
//
//    return YES;
//
//}
//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    if (textField.text.length) {
//        _shaixuanView.hidden = YES;
//        _daohanTiaoview.backgroundColor = [UIColor whiteColor];
//        _daohanTiaoLineview.backgroundColor =[ UIColor lightGrayColor];
//        _shaixuanView.hidden = YES;
//        _jiangdianView.hidden = NO;
//        NSLog(@"string%@",textField.text);
//
//
//    }
//
//
//}
-(void)jingdianStr:(NSString *)str SpotId:(NSString *)spotId{
    _searchtext.text = str;
    [_searchtext resignFirstResponder];
    if (_tableView.contentOffset.y > 100) {
        _daohanTiaoview.backgroundColor = [UIColor whiteColor];
        _daohanTiaoLineview.backgroundColor =[ UIColor lightGrayColor];
        ciytlbl.hidden = YES;
        ciytbgViewd.hidden = YES;

    }
    else
    {
        _daohanTiaoview.backgroundColor = [UIColor clearColor];
        _daohanTiaoLineview.backgroundColor =[ UIColor clearColor];
        ciytlbl.hidden = NO;
        ciytbgViewd.hidden = NO;

    }
    if (spotId.length) {
        _spotIdStr = [spotId integerValue];
        
    }
    else
    {
        _spotIdStr = - 1;
    }
    _pageStr = 1;
    [self loadData:YES];
    //    [_jiangdianView removeFromSuperview];
    //    _jiangdianView = nil;
    _jiangdianView.hidden = YES;
    
    
}
#pragma mark-监听pinglunCoun
- (void)pinglunCoun:(NSNotification *)notication{
    
    _messageContents = [MCUser sharedInstance].messageContents;
    
    if ([MCUser sharedInstance].messageContents.count) {
        _badgeView.badgeText =[NSString stringWithFormat:@"%d", [MCUser sharedInstance].messageContents.count];
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[MCUser sharedInstance].messageContents.count];
    }
    else
    {
        _badgeView.badgeText = @"";
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    }
    
    
    
}
-(void)dingweiobj:(NSNotification *)notication{
    
    ciytlbl.text =[MCUser sharedInstance].myLocation.city;
    NSLog(@"%@",[MCUser sharedInstance].myLocation.city);
    if (![MCUser sharedInstance].myLocation.city) {
        ciytlbl.text = @"未知";
    }
    
    [self actionHeader];
    [self loadWeizi];
}
#pragma mark-监听
- (void)oneyouji:(NSNotification *)notication{
    
    if ([notication.object length]) {
        
        
        [self loadYoujione:notication.object];
    }
    
    

}
- (void)didSelectObj:(NSNotification *)notication
{
    NSLog(@"%@",notication);
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    // NSLog(@"sessionId = %@",[defaults objectForKey:@"sessionId"]);
    //取值
    NSString *reveiveString = notication.object;
    
    NSLog(@"%@",reveiveString);
    if ([reveiveString isEqualToString:@"1"]) {
        zuopinViewController * ctl = [[zuopinViewController alloc]init];
        ctl.SegmentIndex = 0;
        [self pushNewViewController:ctl];
    }
    if ([reveiveString isEqualToString:@"2"]) {
        zuopinViewController * ctl = [[zuopinViewController alloc]init];
        ctl.SegmentIndex = 1;
        [self pushNewViewController:ctl];
    }
    if ([reveiveString isEqualToString:@"3"]) {
        FenxianViewController * ctl = [[FenxianViewController alloc]init];
        if ([[defaults objectForKey:@"id"] integerValue] ) {
            ctl.adlinkurl = [NSString stringWithFormat:@"%@api/travel/chinaMap.jhtml?uid=%d",AppURL,[[defaults objectForKey:@"id"] integerValue]];
            ctl.adlin2kurl = [NSString stringWithFormat:@"%@api/travel/worldMap.jhtml?uid=%d",AppURL,[[defaults objectForKey:@"id"] integerValue] ];


            [self pushNewViewController:ctl];
        }
    }
    if ([reveiveString isEqualToString:@"5"]) {
        FenxianViewController * ctl = [[FenxianViewController alloc]init];
        ctl.indexs = 1;
        if ([[defaults objectForKey:@"id"] integerValue] ) {
            ctl.adlinkurl = [NSString stringWithFormat:@"%@api/travel/chinaMap.jhtml?uid=%d",AppURL,[[defaults objectForKey:@"id"] integerValue]];

            ctl.adlin2kurl = [NSString stringWithFormat:@"%@api/travel/worldMap.jhtml?uid=%d",AppURL,[[defaults objectForKey:@"id"] integerValue] ];

            
            
            [self pushNewViewController:ctl];
        }
 
    }
    if ([reveiveString isEqualToString:@"4"]) {
        SettgViewController * ctl = [[SettgViewController alloc]init];
        [self pushNewViewController:ctl];
    }
    if ([reveiveString isEqualToString:@"分享国外"]){
        FenxianViewController * ctl = [[FenxianViewController alloc]init];
        ctl.titleStr = reveiveString;
        
        if ([[defaults objectForKey:@"id"] integerValue] ) {
            
            ctl.adlinkurl = [NSString stringWithFormat:@"%@api/travel/worldMap.jhtml?uid=%d",AppURL,[[defaults objectForKey:@"id"] integerValue] ];
            //            ctl.adlinkurl = [NSString stringWithFormat:@"http://203.195.168.151:9000/hedgehogTravels/api/travel/worldMap.jhtml?uid=%@",[defaults objectForKey:@"sessionId"]];
            [self pushNewViewController:ctl];
        }
        
    }
    if ([reveiveString isEqualToString:@"分享国内"]){
        FenxianViewController * ctl = [[FenxianViewController alloc]init];
        ctl.titleStr = reveiveString;
        
        if ([[defaults objectForKey:@"id"] integerValue] ) {
            ctl.adlinkurl = [NSString stringWithFormat:@"%@api/travel/chinaMap.jhtml?uid=%d",AppURL,[[defaults objectForKey:@"id"] integerValue]];
            //            ctl.adlinkurl = [NSString stringWithFormat:@"http://203.195.168.151:9000/hedgehogTravels/api/travel/chinaMap.jhtml?user_session=%@",[defaults objectForKey:@"sessionId"]];
            [self pushNewViewController:ctl];
        }
        
        
        
        
    }
    
    
    //    if([reveiveString isEqualToString:@"登录"]){
    //        LoginUIViewController * ctl = [[LoginUIViewController alloc]init];
    //        [self pushNewViewController:ctl];
    //    }
    //    else if ([reveiveString isEqualToString:@"我的资料"]){
    //        MeCompanyViewController * ctl = [[MeCompanyViewController alloc]init];
    //#warning 个人
    //        // MeDataViewController * ctl = [[MeDataViewController alloc]init];
    //        [self pushNewViewController:ctl];
    //    }
    //
    
}
-(void)dishuaxinObj:(NSNotification*)notication{
    if ([notication.object isEqualToString:@"5"]) {
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        //  NSLog(@"%@",[defaults objectForKey:@"thumbnail"]);
        
        [_headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[defaults objectForKey:@"thumbnail"]] forState:0 placeholderImage:[UIImage imageNamed:@"home_mine_avatar2"]];
    }
    _pageStr = 1;
    [self loadData:NO];
}
#pragma mark-发布
-(void)actionFabu{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if ([[defaults objectForKey:@"sessionId"] isEqualToString:@""]||![defaults objectForKey:@"sessionId"] ) {
        //登录
        [self showAllTextDialog:@"请登录你的账号"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            /*保存数据－－－－－－－－－－－－－－－－－begin*/
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            [defaults setObject:@"" forKey:@"isLogOut"];
            // [defaults setObject :nil forKey:@"sessionId"];
            [MCUser sharedInstance].userSessionId = nil;
            [defaults setObject:nil forKey:@"sessionId"];
            // [defaults setObject:nil forKey:@"Pwd"];
            [defaults setObject:nil forKey:@"nickname"];
            [defaults setObject:nil forKey:@"mobile"];
            [defaults setObject:nil forKey:@"id"];
            
            
            //强制让数据立刻保存
            [defaults synchronize];
            // [[NetworkManager instanceManager] setSessionID:nil];
            
            loginViewController *loginVC = [[loginViewController alloc]init];
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            DEMONavigationController *nav = [[DEMONavigationController alloc]initWithRootViewController:loginVC];
            appDelegate.window.rootViewController = nav;
            
            
            
        });
        
        
    }
    else
    {
        //        zhizuoZP1ViewController * ctl = [[zhizuoZP1ViewController alloc]init];
        //        [self pushNewViewController:ctl];
        zhizuoZP3ViewController * ctl = [[zhizuoZP3ViewController alloc]init];
        [self pushNewViewController:ctl];
        
        
    }
    
    
    
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _faBuBtn.hidden = YES;
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView

{
    // NSLog(@"wqe");
    _faBuBtn.hidden = NO;
    // NSLog(@"%f",_tableView.contentOffset.y );
    
    if (scrollView == _tableView) {
        if (_tableView.contentOffset.y > 100) {
            [UIView animateWithDuration:1 animations:^{
                _daohanTiaoview.backgroundColor = [UIColor whiteColor];
                _daohanTiaoLineview.backgroundColor = [UIColor lightGrayColor];
                ciytbgViewd.hidden = YES;
                ciytlbl.hidden = YES;

            }];
            
            
        }
        else
        {
            
            
            [UIView animateWithDuration:1 animations:^{
                _daohanTiaoview.backgroundColor = [UIColor clearColor];
                _daohanTiaoLineview.backgroundColor = [UIColor clearColor];
                ciytbgViewd.hidden = NO;
                ciytlbl.hidden = NO;

                
            }];
            
        }
    }
    
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_isbgPhoto) {
        return 1;
    }

    return _dataAarray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isbgPhoto) {
        return Main_Screen_Height - 200;
    }
    return 150;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isbgPhoto) {
        static NSString *cellid2 = @"NoYJTableViewCell";
        NoYJTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid2];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"NoYJTableViewCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.titleLbl.textColor = AppTextCOLOR;
        return cell;
        
    }

    static NSString *cellid1 = @"HomeTableViewCell";
    HomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeTableViewCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.titleLbl1.textColor = AppTextCOLOR;
    cell.title2Lb.textColor = AppTextCOLOR;
    cell.dingweiimg.textColor = [UIColor grayColor];
    cell.nameLbl.textColor = [UIColor grayColor];
    ViewRadius(cell.headImg, 20);
    cell.headImg.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.headImg.layer.borderWidth = 1.5;
    if (_dataAarray.count > indexPath.section) {
        homeYJModel * model = _dataAarray[indexPath.section];
        //  NSMutableDictionary * model = _dataAarray[indexPath.section];
        //NSLog(@">>>>>>%@", model.title);
        
        //title
        if (model.title.length > 9) {//第一行大概9个字
            cell.titleLbl1.text = [model.title substringToIndex:9];
            cell.title2Lb.text = [model.title substringFromIndex:9];
            
        }
        else
        {
            cell.titleLbl1.text = model.title;
            cell.title2Lb.text = @"";
            
        }
        
        //photos
        
        if ([model.photos count]) {
            YJphotoModel * photomodel = model.YJphotos[0];
            NSString * str = [NSString stringWithFormat:@"%@",photomodel.thumbnail];
            
            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"travels-details_default-chart04"]];
        }
        
        //头像
        if(model.userModel.thumbnail)
        {
            [cell.headImg sd_setImageWithURL:[NSURL URLWithString:model.userModel.thumbnail] placeholderImage:[UIImage imageNamed:@"home_default-avatar"]];
            
        }
        //姓名
        if (model.userModel.nickname) {
            cell.nameLbl.text = model.userModel.nickname;
        }
        else
        {
            cell.nameLbl.text = @"游客";
        }
        
        cell.dingweiimg.text = model.spotName;
        //游记类型
        //NSLog(@">>>>%@",[self.classifyDic objectForKey:model[@"classify"]]);
        cell.typeLimgView.image  = [UIImage imageNamed:[self.classifyDic objectForKey:[NSString stringWithFormat:@"%ld",model.classify]]];
        
        NSLog(@"<<<<<%@",[NSString stringWithFormat:@"%ld",model.classify]);
        
        
        //游记推荐
        BOOL isRecommend = [model.isRecommend boolValue];
        if(!isRecommend){
            cell.tuijianimg.image = [UIImage imageNamed:@"踩"];
            
        }
        else
        {
            cell.tuijianimg.image = [UIImage imageNamed:@"荐"];
            
        }
        //        cell.tuijianimg.hidden = !isRecommend;

     cell.timeLbl.text =  [CommonUtil daysAgoAgainst:model.createDate];//[CommonUtil getStringWithLong:model.createDate Format:@"MM-dd"];
        cell.timeLbl.textColor = AppTextCOLOR;//[UIColor darkTextColor];
        cell.JLLbl.textColor = AppTextCOLOR;
        //9707.242555734487
        
        cell.JLLbl.text = [NSString stringWithFormat:@"%.2fKm",[model.distance floatValue]/1000];
        cell.neirongLbl.text = model.content;
        cell.neirongLbl.textColor =  UIColorFromRGB(0x908fa2);
        // [UIColor colorWithRGB:0xEE1289 alpha:1];
        
        
        
    }
    
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isbgPhoto) {
        
       // [self actionFabu];
        return;
    }
    
    homeYJModel * model = _dataAarray[indexPath.section];
    
    zuopinXQViewController * ctl = [[zuopinXQViewController alloc]init];
    ctl.home_model = model;
    ctl.dataArray = _dataAarray;
    ctl.index = indexPath.section;
    [self pushNewViewController:ctl];
}
#pragma mark-添加广告头
-(UIView*)addHeadView:(ZZCarousel*)zzcarView{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 200 )];
    [view addSubview:zzcarView];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIView * lineView =[[UIView alloc]initWithFrame:CGRectMake(0, 120, Main_Screen_Width, 0.5)];
    lineView.backgroundColor =[UIColor lightGrayColor];
    return view;
}

#pragma mark-ZZCarousel
-(ZZCarousel*)headViewwheel:(NSInteger)tag{
    ZZCarousel* wheel  = [[ZZCarousel alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 200)];
    wheel.tag = tag;
    /*
     *   carouseScrollTimeInterval  ---  此属性为设置轮播多长时间滚动到下一张
     */
    wheel.carouseScrollTimeInterval = 5.0f;
    
    
    
    // 代理
    wheel.delegate = self;
    
    /*
     *   isAutoScroll  ---  默认为NO，当为YES时 才能使轮播进行滚动
     */
    wheel.isAutoScroll = YES;
    
    /*
     *   pageType  ---  设置轮播样式 默认为系统样式。ZZCarousel 中封装了 两种样式，另外一种为数字样式
     */
    wheel.pageType = ZZCarouselPageTypeOfNone;
    
    /*
     *   设置UIPageControl 在轮播中的位置、系统默认的UIPageControl 的顶层颜色 和底层颜色已经背景颜色
     */
    wheel.pageControlFrame = CGRectMake((Main_Screen_Width - 60 ) / 2, wheel.frame.size.height - 20, 60, 10);
    
    
    wheel.pageIndicatorTintColor = RGBCOLOR(250, 150, 110);//[UIColor whiteColor];
    wheel.currentPageIndicatorTintColor = RGBCOLOR(251, 78, 9);
    wheel.pageControlBackGroundColor = [UIColor whiteColor];
    
    /*
     *   设置数字样式的 UIPageControl 中的字体和字体颜色。 背景颜色仍然按照上面pageControlBackGroundColor属性来设置
     */
    wheel.pageControlOfNumberFont = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    wheel.pageContolOfNumberFontColor = [UIColor whiteColor];
    //[view addSubview:wheel];
    
    return  wheel;
    
}
#pragma mark --- ZZCarouselDelegate


-(NSInteger)numberOfZZCarousel:(ZZCarousel *)wheel
{
    if (_bannerArray.count) {
        return _bannerArray.count;
    }
    return 3;
}
-(ZZCarouselView *)zzcarousel:(UICollectionView *)zzcarousel viewForItemAtIndex:(NSIndexPath *)index itemsIndex:(NSInteger)itemsIndex identifire:(NSString *)identifire ZZCarousel:(ZZCarousel *)zZCarousel
{
    /*
     *  index参数         ※ 注意
     */
    ZZCarouselView *cell = [zzcarousel dequeueReusableCellWithReuseIdentifier:identifire forIndexPath:index];
    
    if (!cell) {
        cell = [[ZZCarouselView alloc]init];
    }
    //    cell.title.text = [_imagesGroup objectAtIndex:indexPath.row];
    //    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"图片地址"]];
    
    /*
     *  itemsIndex 参数   ※ 注意
     */
    if (_bannerArray.count) {
        NSDictionary * model = [_bannerArray objectAtIndex:itemsIndex];
        
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model[@"image"]] placeholderImage:[UIImage imageNamed:@"home_banner_default-chart"]];
    }
    else
        
        cell.imageView.image = [UIImage imageNamed:@"home_banner_default-chart"];
    //
    
    return cell;
}

//点击方法

-(void)zzcarouselScrollView:(ZZCarousel *)zzcarouselScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    //[self showAllTextDialog:[NSString stringWithFormat:@"点击了 第%ld张",(long)index]];
    if(_bannerArray.count > index ){
    NSDictionary * model = [_bannerArray objectAtIndex:index];
    
    Home_LunBoGuangGao_Web *vc = [[Home_LunBoGuangGao_Web alloc]init];
    vc.adlinkurl = model[@"link"];
    [self pushNewViewController:vc];
    
    }
}
#pragma mark-推送
-(void)prepareTuisong{
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidSetup:)
                          name:kJPFNetworkDidSetupNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidClose:)
                          name:kJPFNetworkDidCloseNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidRegister:)
                          name:kJPFNetworkDidRegisterNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidLogin:)
                          name:kJPFNetworkDidLoginNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidReceiveMessage:)
                          name:kJPFNetworkDidReceiveMessageNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(serviceError:)
                          name:kJPFServiceErrorNotification
                        object:nil];
    
    
    
}

- (void)dealloc {
    
    [self unObserveAllNotifications];
}

- (void)unObserveAllNotifications {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidSetupNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidCloseNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidRegisterNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidLoginNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidReceiveMessageNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFServiceErrorNotification
                           object:nil];
}
- (void)networkDidSetup:(NSNotification *)notification {
    NSLog(@"已连接");
}

- (void)networkDidClose:(NSNotification *)notification {
    NSLog(@"未连接");
    
}

- (void)networkDidRegister:(NSNotification *)notification {
    NSLog(@"%@", [notification userInfo]);
    [[notification userInfo] valueForKey:@"RegistrationID"];
    NSLog(@"已注册");
}

- (void)networkDidLogin:(NSNotification *)notification {
    NSLog(@"已登录");
    
    if ([APService registrationID]) {
        NSLog(@"get RegistrationID === %@",[APService registrationID]);
        [self updateClientId:[APService registrationID]];
    }
}
-(void)updateClientId:(NSString*)RegistrationID{
    
    NSDictionary * Parameterdic = @{
                                    @"clientId":RegistrationID,
                                    @"clientType":@(1)
                                    };
    
    
    //[self showLoading:isjuhua AndText:nil];
    [self.requestManager requestWebWithParaWithURL:@"api/user/updateClientId.json" Parameter:Parameterdic IsLogin:NO Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"上传成功");
        NSLog(@"返回==%@",resultDic);
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        //[self showAllTextDialog:description];
        
        NSLog(@"失败");
    }];
    
    
    
    
}
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    
    
    NSDictionary *content = [notification object];
    
    
    
    
    NSString *contentstr = content[@"content"];//[userInfo valueForKey:@"content"];
    NSString *travelId =[NSString stringWithFormat:@"%d",[content[@"travelId"] integerValue]];//[use] [userInfo valueForKey:@"content"];
    //111
    
    //1.获得音效文件的全路径
    
    NSURL *url=[[NSBundle mainBundle]URLForResource:@"sound.caf" withExtension:nil];
    
    //2.加载音效文件，创建音效ID（SoundID,一个ID对应一个音效文件）
    SystemSoundID soundID=0;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
    
    //把需要销毁的音效文件的ID传递给它既可销毁
    //AudioServicesDisposeSystemSoundID(soundID);
    
    //3.播放音效文件
    //下面的两个函数都可以用来播放音效文件，第一个函数伴随有震动效果
    //AudioServicesPlayAlertSound(soundID);
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"pinglun"] isEqualToString:@""] || ![[NSUserDefaults standardUserDefaults] objectForKey:@"pinglun"]) {//开评论
        
        
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"shengyin"] isEqualToString:@"2"]) {//关声音
            
            if(![[NSUserDefaults standardUserDefaults] objectForKey:@"zhendong"])
            {//指正
                
                AudioServicesPlaySystemSound (nil);//声音
                AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);//震动
                
                
            }
            
            
            
            
        }else if(([[[NSUserDefaults standardUserDefaults] objectForKey:@"shengyin"] isEqualToString:@""] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"zhendong"] isEqualToString:@""]) ||(![[NSUserDefaults standardUserDefaults] objectForKey:@"shengyin"] &&![[NSUserDefaults standardUserDefaults] objectForKey:@"zhendong"] )){//生意真懂
            
            
            // AudioServicesDisposeSystemSoundID(soundID);
            AudioServicesPlaySystemSound (soundID);//声音
            AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);//震动
            
            
            
        }else if(![[NSUserDefaults standardUserDefaults] objectForKey:@"shengyin"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"zhendong"])
        {//
            
            AudioServicesPlaySystemSound (soundID);//声音
            
            
        }
        

        
    }
    //[self addLocalNotification];
    
    // [_messageContents insertObject:contentstr atIndex:0];
    
    //    if ([_messageContents containsObject:travelId]) {
    //
    //    }
    [_messageContents addObject:travelId];
    
    [MCUser sharedInstance].messageContents =_messageContents;
    //_messageCount++;
    _messageCount =  [MCUser sharedInstance].messageContents.count;
    [self reloadMessageCountLabel];
    
    
    
    
    
    
    
    
    
    
    
    
}
#pragma mark 添加本地通知
-(void)addLocalNotification{
    
    //定义本地通知对象
    UILocalNotification *notification=[[UILocalNotification alloc]init];
    //    notification.alertBody=@"最近添加了诸多有趣的特性，是否立即体验？"; //通知主体
    //    notification.alertAction=@"打开应用"; //待机界面的滑动动作提示
    //    //notification.soundName=UILocalNotificationDefaultSoundName;//收到通知时播放的声音，默认消息声音
    
    //设置用户信息
    //  notification.userInfo=@{@"id":@1,@"user":@"Kenshin Cui"};//绑定到通知上的其他附加信息
    
    //调用通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
    
    
    
    
    
    
    
    
    
    
}

// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

- (void)serviceError:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSString *error = [userInfo valueForKey:@"error"];
    NSLog(@"%@", error);
}

- (void)addNotificationCount {
    _notificationCount++;
    [self reloadNotificationCountLabel];
}

- (void)addMessageCount {
    _messageCount++;
    [self reloadMessageCountLabel];
}

- (void)reloadMessageContentView {
    //_messageContentView.text = @"";
    _badgeView.badgeText = @"";
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[MCUser sharedInstance].messageContents.count];
}

- (void)reloadMessageCountLabel {
    _badgeView.badgeText =[NSString stringWithFormat:@"%d", _messageCount];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[MCUser sharedInstance].messageContents.count];
    //_messageCountLabel.text = [NSString stringWithFormat:@"%d", _messageCount];
}

- (void)reloadNotificationCountLabel {
    _badgeView.badgeText =[NSString stringWithFormat:@"%d", _notificationCount];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[MCUser sharedInstance].messageContents.count];
}
#pragma mark-上传位置
-(void)loadWeizi{
    
    if (![MCUser sharedInstance].myLocation.lo || ![MCUser sharedInstance].myLocation.la) {
        return;
    }
    
    NSDictionary * Parameterdic = @{
                                    @"lat":@([MCUser sharedInstance].myLocation.la),
                                    @"lng":@([MCUser sharedInstance].myLocation.lo)
                                    };
    
    //api/user/profiles/updateLocation.json
    //[self showLoading:isjuhua AndText:nil];
    [self.requestManager requestWebWithParaWithURL:@"api/user/profiles/updateLocation.json" Parameter:Parameterdic IsLogin:NO Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"shang成功");
        NSLog(@"返回==%@",resultDic);
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        // [self showAllTextDialog:description];
        
        NSLog(@"失败");
    }];
    
    
    
}
#pragma mark-单独请求一个游记
-(void)loadYoujione:(NSString*)travelId{
    if (!travelId) {
        [self showAllTextDialog:@"无效的游记id"];
        return;
    }
    
    NSDictionary * Parameterdic = @{
                                    @"travelId":travelId,
                                    
                                    };
    
    
     [self showLoading:YES AndText:nil];
    [self.requestManager requestWebWithParaWithURL:@"api/travel/detail.json" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        
        

        
        
        homeYJModel * model = [homeYJModel mj_objectWithKeyValues:resultDic[@"object"]];
    
        model.userModel = [YJUserModel mj_objectWithKeyValues:resultDic[@"object"][@"user"]];
        if (model.photos) {
            for (NSDictionary * photodic in model.photos) {
                YJphotoModel * photomodel = [YJphotoModel mj_objectWithKeyValues:photodic];
                [model.YJphotos addObject:photomodel];
            }
        }

        zuopinXQViewController * ctl = [[zuopinXQViewController alloc]init];
        ctl.home_model = model;
        if (model) {
            
            ctl.dataArray =[NSMutableArray arrayWithObjects:model, nil];
            ctl.index = 0;
            [self pushNewViewController:ctl];

        }
      
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        //        [self hideHud];
               [self showAllTextDialog:description];
        
        NSLog(@"失败");
    }];
    
  
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
