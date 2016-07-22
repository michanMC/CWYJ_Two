//
//  FriendYJViewController.m
//  MCCWYJ
//
//  Created by MC on 16/5/24.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "FriendYJViewController.h"
#import "SearchViewController.h"
#import "MCscreenView.h"
#import "YJTableViewCell.h"
#import "YJNoDataTableViewCell.h"
#import "homeYJModel.h"
#import "ProductionViewController.h"
@interface FriendYJViewController ()<MCscreenViewDelegate,UITableViewDelegate,UITableViewDataSource,SearchViewControllerDelegate>
{
    
    UITextField *_searchtext;
    
    BOOL _isShowScree;
    MCscreenView * _screenview;

    UITableView *_tableView;
    NSMutableArray *_dataAarray;//数据源
    NSInteger  _pageStr;
    BOOL _isNoData;
    NSMutableDictionary * Parameterdic;
    NSDictionary *_all2Dic;
    NSMutableDictionary * _allDic;


    
}

@end

@implementation FriendYJViewController
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self MCscreenhidden];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavBar];
    self.automaticallyAdjustsScrollViewInsets = NO;

    _dataAarray  =[NSMutableArray array];
    _pageStr = 1;
    Parameterdic = [NSMutableDictionary dictionary];
    
    [Parameterdic  setObject:@(_pageStr) forKey:@"page"];

    
    [Parameterdic setObject:@([_uid integerValue]) forKey:@"destUid"];
//    [Parameterdic setObject:@([MCMApManager sharedInstance].lo) forKey:@"lng"];
    _all2Dic = @{
                 @"like":@"0",
                 @"classify":@"0",
                 @"distance":@"0"
                 };

    _allDic = [NSMutableDictionary dictionary];
    [_allDic setObject:@"" forKey:@"isRecommend"];
    [_allDic setObject:@"" forKey:@"classify"];
    [_allDic setObject:@"" forKey:@"distance"];

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height -64) style:UITableViewStylePlain];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(RefreshHeader)];
    _tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(RefreshFooter)];
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = AppMCBgCOLOR;

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
    
    [Parameterdic  setObject:@(_pageStr) forKey:@"page"];
    
    [self showLoading];
    [self.requestManager postWithUrl:@"api/travel/myTravels.json" refreshCache:NO params:Parameterdic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic == %@",resultDic);
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
    if (_isNoData) {
        return 1;
    }
    return _dataAarray.count;
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
    
    return 100 *MCHeightScale + 15 + 20 + 15;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isNoData) {
        YJNoDataTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mc2"];
        if (!cell) {
            cell = [[YJNoDataTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mc2"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell prepareNoDataUI:self.view.mj_h TitleStr:@"再怎么找也没有游记啦，你行你来写"];
        [cell.tapBtn addTarget:self action:@selector(actionTapBtn) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
        
        
    }
    
    
    
   if (_dataAarray.count > indexPath.row) {
        static NSString * cellid = @"mc1";
        YJTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[YJTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
       homeYJModel * model= _dataAarray[indexPath.row];
       [cell prepareUI:model];
//       cell.imgView.userInteractionEnabled = YES;
//       cell.headerimgBtn.tag = indexPath.section + 430;
//       [cell.headerimgBtn addTarget:self action:@selector(actionHearBtn:) forControlEvents:UIControlEventTouchDown];
       return cell;
    }
    
    
    
    return [[UITableViewCell alloc]init];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    homeYJModel * model = _dataAarray[indexPath.row];
    ProductionViewController *ctl = [[ProductionViewController alloc]init];
    ctl.home_model = model;
    ctl.dataArray = _dataAarray;
    ctl.index = indexPath.row ;//indexPath.section;
    
    [self pushNewViewController:ctl];
    

    
    
    
}
-(void)setUpNavBar{
    
    MCIucencyView * seachView = [[MCIucencyView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width - 100, 30)];
    [seachView setBgViewColor:[UIColor groupTableViewBackgroundColor]];
    ViewRadius(seachView, 3);
    seachView.layer.borderWidth = .5;
    seachView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _searchtext = [[UITextField alloc]initWithFrame:CGRectMake(30, 0, seachView.mj_w - 30, 30)];
    _searchtext.placeholder = @"输入景点搜索";
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
    
    
    
    
    
    
    CGFloat x = 10;
    CGFloat y = 25;
    CGFloat width = 30;
    CGFloat height = 30;
    
    UIButton * _screenBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    
    [_screenBtn setImage:[UIImage imageNamed:@"home_mine_screened"] forState:0];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_screenBtn];
    [_screenBtn addTarget:self action:@selector(action_screenBtn) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_icon_back_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(actionBack)];

    
    
}
-(void)actionBack{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
-(void)action_screenBtn{
    if (_isShowScree) {
        _isShowScree = NO;
        [_screenview removeFromSuperview];
        
    }
    else
    {
        _isShowScree = YES;
        _screenview = [[MCscreenView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height  - 64)];
        
        _screenview.delegate = self;
        NSLog(@"_all2Dic == %@",_all2Dic);

        [_screenview IsMYBuy:NO DataDic:_all2Dic];

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
    _all2Dic = selectDic;
    
    
    if ([selectDic[@"distance"] integerValue]==0) {
        [_allDic setObject:@"" forKey:@"distance"];
    }
    else
    {
        if ([selectDic[@"distance"] integerValue] == 1) {
            [_allDic setObject:@"5000" forKey:@"distance"];
            
        }
        if ([selectDic[@"distance"] integerValue] == 2) {
            [_allDic setObject:@"10000" forKey:@"distance"];
            
        }
        if ([selectDic[@"distance"] integerValue] == 3) {
            [_allDic setObject:@"50000" forKey:@"distance"];
            
        }
        if ([selectDic[@"distance"] integerValue] == 4) {
            [_allDic setObject:@"100000" forKey:@"distance"];
            
        }
        
    }
    
    
    if ([selectDic[@"like"] integerValue]==0) {
        [_allDic setObject:@"" forKey:@"isRecommend"];
        
    }
    else
    {
        [_allDic setObject:selectDic[@"like"] forKey:@"isRecommend"];
        
    }
    
    
    
    if ([selectDic[@"classify"] integerValue]==0) {
        [_allDic setObject:@"" forKey:@"classify"];
        
    }
    else
    {
        [_allDic setObject:selectDic[@"classify"] forKey:@"classify"];
        
    }
    
    
    [self selectAlldic:_allDic];
    

}
-(void)selectAlldic:(NSDictionary*)dic{
    _pageStr = 1;
    
    //    [Parameterdic  setObject:@(0) forKey:@"spotId"];
    NSString * classify = @"";
    if ([dic[@"classify"] isEqualToString:@"0"]) {
        classify = @"";
    }
    if ([dic[@"classify"] isEqualToString:@"1"]) {
        classify = @"0";
    }
    if ([dic[@"classify"] isEqualToString:@"2"]) {
        classify = @"1";
    }
    if ([dic[@"classify"] isEqualToString:@"3"]) {
        classify = @"2";
    }
    if ([dic[@"classify"] isEqualToString:@"4"]) {
        classify = @"3";
    }
    
    
    [Parameterdic  setObject:classify forKey:@"classify"];
    NSInteger _spotIdStr = -1;
    if ([dic[@"spotId"] length]) {
        _spotIdStr = [dic[@"spotId"] integerValue];
        
    }
    if (_spotIdStr >=  0 ) {
        [Parameterdic  setObject:@(_spotIdStr) forKey:@"spotId"];
        
    }
    else
    {
        [Parameterdic  setObject:@"" forKey:@"spotId"];
        
    }
    
    
    
    
    
    [Parameterdic  setObject:dic[@"distance"] forKey:@"distance"];
    
    
    
    
    NSString * isRecommend = @"";
    if ([dic[@"isRecommend"] isEqualToString:@"0"]) {
        isRecommend = @"";
    }
    if ([dic[@"isRecommend"] isEqualToString:@"1"]) {
        isRecommend = @"1";
    }
    if ([dic[@"isRecommend"] isEqualToString:@"2"]) {
        isRecommend = @"0";
    }
    
    
    
    [Parameterdic  setObject:isRecommend forKey:@"isRecommend"];
    [self RefreshHeader];
    
}


#pragma mark-点搜索
-(void)ActionsearchBtn{
    [self MCscreenhidden];
    SearchViewController  * ctl = [[SearchViewController alloc]init];
    ctl.SearchType = SearchType_scenic;
    ctl.delegate = self;
    ctl.Search_Str = _searchtext.text;

    [self pushNewViewController:ctl];
    
}
-(void)selectTitleModel:(jingdianModel *)model
{
    if (model) {
        _searchtext.text = model.nameCH;
        [_allDic setObject:model.id forKey:@"spotId"];
        
    }
    else
    {
        _searchtext.text = @"";
        [_allDic setObject:@"" forKey:@"spotId"];
        
    }
    
    [self selectAlldic:_allDic];
    
}

-(void)actionTapBtn{
    
    
    if (![MCUserDefaults objectForKey:@"sessionId"]||![[MCUserDefaults objectForKey:@"sessionId"] length]) {
        
        
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
