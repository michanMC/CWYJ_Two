//
//  CaiDetailedViewController.m
//  MCCWYJ
//
//  Created by MC on 16/5/27.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "CaiDetailedViewController.h"
#import "MyIntegralTableViewCell.h"
#import "CaiParticularsViewController.h"

@interface CaiDetailedViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    
    UITableView *_tableView;
    NSMutableArray * _dataArray;
    NSInteger _pageStr;

}



@end

@implementation CaiDetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageStr = 1;

    _dataArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor yellowColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - 64 - 44) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = AppMCBgCOLOR;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(RefreshHeader)];
    _tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(RefreshFooter)];

//    [self loadData2];

    // Do any additional setup after loading the view.
}
-(void)RefreshHeader{
    _pageStr = 1;
    [_dataArray removeAllObjects];
    [self loadData2];
    
    
}
-(void)RefreshFooter{
    _pageStr ++;
    [self loadData2];
    
    
}

-(void)loadData2{
    NSString * ss = @"";
    if (_seleIndex== -1) {
        ss = @"";
    }
    else
    {
        ss = [NSString stringWithFormat:@"%zd",_seleIndex];
    }

    
    
    NSDictionary * dic = @{
                           @"page":@(_pageStr),
                           @"type":@(0),
                           @"times":ss,
                           @"startTime":_startTime?_startTime:@"",
                           @"endTime":_endTime?_endTime:@""

                           

                           };
    [self.requestManager postWithUrl:@"api/integral/query.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
//        [_dataArray removeAllObjects];
        
        NSLog(@"resultDic ===%@",resultDic);
        for (NSDictionary * dic in resultDic[@"object"]) {
            IntegralQXModel * modle = [IntegralQXModel mj_objectWithKeyValues:dic];
            [_dataArray addObject:modle];
        }
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];

        [_tableView reloadData];
        
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];

    }];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 96;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellid1 = @"MyIntegralTableViewCell";
    
    MyIntegralTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
    if (!cell) {
        cell = [[MyIntegralTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid1];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    if (_dataArray.count > indexPath.row) {
        IntegralQXModel * model = _dataArray[indexPath.row];
        cell.QXModel = model;
        [cell prepareUI2];
        
        
    }
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_deleGate) {
        CaiParticularsViewController * ctl = [[CaiParticularsViewController alloc]init];
        
        if (_dataArray.count > indexPath.row) {
            IntegralQXModel * model = _dataArray[indexPath.row];
            ctl.QXModel = model;
            
            [_deleGate pushNewViewController:ctl];
            
        }
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
