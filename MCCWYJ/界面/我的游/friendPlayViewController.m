//
//  friendPlayViewController.m
//  MCCWYJ
//
//  Created by MC on 16/5/8.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "friendPlayViewController.h"
#import "homeYJModel.h"
#import "YJTableViewCell.h"
#import "YJNoDataTableViewCell.h"
#import "CarteViewController.h"
@interface friendPlayViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    
    NSMutableArray *_dataAarray;//数据源
    NSInteger  _pageStr;
    BOOL _isNoData;
    NSMutableDictionary * Parameterdic;


}


@end

@implementation friendPlayViewController
-(void)disquery2Obj:(NSNotification*)notication{
    [self RefreshHeader];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //刷新数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disquery2Obj:) name:@"disquery2ObjNotification" object:nil];
    Parameterdic = [NSMutableDictionary dictionary];
    
    [Parameterdic  setObject:@(_pageStr) forKey:@"page"];
    //    [Parameterdic  setObject:@(0) forKey:@"spotId"];
    //    [Parameterdic  setObject:@(0) forKey:@"classify"];
    //
    //    [Parameterdic  setObject:@(5000) forKey:@"distance"];
    //    [Parameterdic  setObject:@(0) forKey:@"isRecommend"];
    
    [Parameterdic setObject:@([MCMApManager sharedInstance].la) forKey:@"lat"];
    [Parameterdic setObject:@([MCMApManager sharedInstance].lo) forKey:@"lng"];
    

    _dataAarray  =[NSMutableArray array];
    _pageStr = 1;

//    self.view.backgroundColor = [UIColor yellowColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - 44 - 64 - 49) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(RefreshHeader)];
    _tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(RefreshFooter)];
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
-(void)selectfridic:(NSDictionary*)dic{
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
    NSLog(@"Parameterdic ======%@",Parameterdic);

    [self RefreshHeader];
    
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
    if (_dataAarray.count > indexPath.section) {
        homeYJModel * model= _dataAarray[indexPath.section];
        if (model.YJoptsArray.count) {
            return 100 *MCHeightScale + 15 + 20 + 15 + 44;

        }

    }
    return 100 *MCHeightScale + 15 + 20 + 15 ;
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

    
    if (_dataAarray.count > indexPath.section) {
        static NSString * cellid = @"mc1";
        YJTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[YJTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        //        cell.selectionStyle =
        homeYJModel * model= _dataAarray[indexPath.section];
        if (model.YJoptsArray.count) {
            cell.isfriendPlay = YES;

        }
        else
        cell.isfriendPlay = NO;

        [cell prepareUI:model];
        cell.imgView.userInteractionEnabled = YES;
        cell.headerimgBtn.tag = indexPath.section + 530;
        [cell.headerimgBtn addTarget:self action:@selector(actionHearBtn:) forControlEvents:UIControlEventTouchDown];
        return cell;
    }
    
    
    
    return [[UITableViewCell alloc]init];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    homeYJModel * model = _dataAarray[indexPath.section];
    NSDictionary * dic = @{
                           @"model":model,
                           @"dataArray":_dataAarray,
                           @"index": [NSString stringWithFormat:@"%zd", indexPath.section]
                           };
    
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"disXQDatadetailObjNotification" object:dic];
}
-(void)actionTapBtn{
    
    
//    if (![MCUserDefaults objectForKey:@"sessionId"]||![[MCUserDefaults objectForKey:@"sessionId"] length]) {
//        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        
//        LoginController * ctl = [[LoginController alloc]init];
//        LCTabBarController *mainVC = (LCTabBarController *)app.window.rootViewController;
//        
//        MCNavViewController *nav = mainVC.selectedViewController;
//        
//        [nav pushViewController:ctl animated:YES];
//        
//        return;
//    }
    
    
}

#pragma mark-加载数据
-(void)loadData{
    
    [Parameterdic  setObject:@(_pageStr) forKey:@"page"];
    
    [self showLoading];
    [self.requestManager postWithUrl:@"api/travel/travelsOfFriend.json" refreshCache:NO params:Parameterdic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic == %@",resultDic);
        
        
        NSArray * objectArray = resultDic[@"object"];
        for (NSDictionary* dic in objectArray) {
            homeYJModel * model = [homeYJModel mj_objectWithKeyValues:dic];
            model.userModel = [YJUserModel mj_objectWithKeyValues:dic[@"user"]];
            NSLog(@"%@",model.userModel.isNew);
            
            if (model.opts) {
                for (NSDictionary * photodic in model.opts) {
            YJoptsModel*optsModel = [YJoptsModel mj_objectWithKeyValues:photodic];
                    [model.YJoptsArray addObject:optsModel];
 
                }
            }
            
            
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
//        [self showAllTextDialog:description];
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
-(void)actionHearBtn:(UIButton*)btn{
    NSString *sessionId = [MCUserDefaults objectForKey:@"sessionId"];
    if (!sessionId.length) {
        LoginController * ctl = [[LoginController alloc]init];
        [_delegate pushNewViewController:ctl];
        return;
    }

    homeYJModel * model= _dataAarray[btn.tag - 530];
    CarteViewController *ctl = [[CarteViewController alloc]init];
    ctl.userModel = model.userModel;
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
