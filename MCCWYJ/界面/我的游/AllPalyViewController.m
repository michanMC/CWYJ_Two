//
//  AllPalyViewController.m
//  MCCWYJ
//
//  Created by MC on 16/5/8.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "AllPalyViewController.h"
#import "homeYJModel.h"
#import "YJTableViewCell.h"
@interface AllPalyViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView *_tableView;
    NSMutableArray *_dataAarray;//数据源
    NSInteger  _pageStr;

}

@end

@implementation AllPalyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = AppCOLOR;
    //刷新数据
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disqueryObj:) name:@"disqueryObjNotification" object:nil];
    
    
    _dataAarray  =[NSMutableArray array];
    _pageStr = 1;
     _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - 44 - 64 - 49) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(RefreshHeader)];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(RefreshFooter)];
    [self.view addSubview:_tableView];
    [self loadData];
    // Do any additional setup after loading the view.
}
-(void)disqueryObj:(NSNotification*)notication{
    _pageStr = 1;
    [self loadData];

}
-(void)RefreshHeader{
    _pageStr = 1;
    [self loadData];

    
}
-(void)RefreshFooter{
    _pageStr ++;
    [self loadData];

    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
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
    return 100 *MCHeightScale + 15 + 20 + 15;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_dataAarray.count > indexPath.section) {
        static NSString * cellid = @"mc1";
        YJTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[YJTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
//        cell.selectionStyle =
        homeYJModel * model= _dataAarray[indexPath.section];
        [cell prepareUI:model];
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
#pragma mark-加载数据
-(void)loadData{
    NSMutableDictionary * Parameterdic = [NSMutableDictionary dictionary];
    
    [Parameterdic  setObject:@(_pageStr) forKey:@"page"];
//    [Parameterdic  setObject:@(0) forKey:@"spotId"];
//    [Parameterdic  setObject:@(0) forKey:@"classify"];
//
//    [Parameterdic  setObject:@(5000) forKey:@"distance"];
//    [Parameterdic  setObject:@(0) forKey:@"isRecommend"];
    
    [Parameterdic setObject:@([MCMApManager sharedInstance].la) forKey:@"lat"];
    [Parameterdic setObject:@([MCMApManager sharedInstance].lo) forKey:@"lng"];

    [self showLoading];
    [self.requestManager postWithUrl:@"api/travel/query.json" refreshCache:NO params:Parameterdic IsNeedlogin:NO success:^(id resultDic) {
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
