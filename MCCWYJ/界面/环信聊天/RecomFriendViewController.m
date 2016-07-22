//
//  RecomFriendViewController.m
//  MCCWYJ
//
//  Created by MC on 16/7/4.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "RecomFriendViewController.h"
#import "friendslistModel.h"
#import "AddressBookTableViewCell.h"
#import "AddFriendViewController.h"
#import "CarteViewController.h"
#import "YJNoDataTableViewCell.h"

@interface RecomFriendViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView * _tableView;
    NSMutableArray * _dataArray;
    NSInteger _pageStr;
    BOOL _isNoData;

}

@end

@implementation RecomFriendViewController

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐好友";
    _dataArray = [NSMutableArray array];
    _pageStr = 1;
     _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(RefreshHeader)];
    _tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(RefreshFooter)];
    _tableView.backgroundColor = AppMCBgCOLOR;
    //监听数据的刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RefreshHeader) name:@"RecomFriendObjNotification" object:nil];
    [self loadData];
    // Do any additional setup after loading the view.
}
-(void)RefreshHeader{
    _pageStr = 1;
    [_dataArray removeAllObjects];
    [self loadData];
    
    
}
-(void)RefreshFooter{
    _pageStr ++;
    [self loadData];
    
    
}

-(void)loadData{
        [self showLoading];
    NSDictionary * dic = @{
                         @"page":@(_pageStr)
                           };
    [self.requestManager postWithUrl:@"api/friends/recommendFriend.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
        for (NSDictionary * dic in resultDic[@"object"]) {
            friendslistModel *  modle = [friendslistModel mj_objectWithKeyValues:dic];
            [_dataArray addObject:modle];
            
        }
        
        if (_dataArray.count) {
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
        if (_dataArray.count) {
            _isNoData = NO;
        }
        else
        {
            _isNoData = YES;
            
        }
        
        [_tableView reloadData];

        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];

    }];

    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isNoData) {
        return 1;
    }

    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isNoData) {
        return self.view.mj_h;
    }

    return 35 + 20;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isNoData) {
        YJNoDataTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mc2"];
        if (!cell) {
            cell = [[YJNoDataTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mc2"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell prepareNoDataUI:self.view.mj_h TitleStr:@"暂时没有你要查询的数据"];
        //        [cell.tapBtn addTarget:self action:@selector(actionTapBtn) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
        
        
    }

    
    AddressBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mc"];
    if (cell == nil) {
        cell = [[AddressBookTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mc"];
        
    }
    if (_dataArray.count > indexPath.row) {
    
    
    friendslistModel *model = [_dataArray objectAtIndex:indexPath.row];
    
    [cell prepareUI];
    cell.Registbtn.tag = indexPath.row + 500;
    [cell.Registbtn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    NSString *name = model.nickname;
    [cell.imgview sd_setImageWithURL:[NSURL URLWithString:model.thumbnail] placeholderImage:[UIImage imageNamed:@"home_Avatar_60"]];
    
    cell.nameLbl.text =name.length == 0 ?@"无":name;
    
    cell.phoneLbl.text = model.desc;
    if ([model.isApply boolValue]) {
        
        cell.Registbtn.backgroundColor = [UIColor whiteColor];
        [cell.Registbtn setTitleColor:[UIColor grayColor] forState:0];
        [cell.Registbtn setTitle:@"已申请" forState:0];
    }
    else
    {
                cell.Registbtn.backgroundColor = AppCOLOR;
                [cell.Registbtn setTitleColor:[UIColor whiteColor] forState:0];
                [cell.Registbtn setTitle:@"添加" forState:0];
    }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_dataArray.count > indexPath.row) {

    friendslistModel * model = _dataArray[indexPath.row];
        
    CarteViewController *ctl = [[CarteViewController alloc]init];
        model.userModel = [[YJUserModel alloc]init];
    model.userModel.id = model.uid;
    ctl.userModel = model.userModel;
    
    [self pushNewViewController:ctl];
    }
    
    
    
}
-(void)actionBtn:(UIButton*)btn{
    friendslistModel *model = [_dataArray objectAtIndex:btn.tag - 500];
    
    
    
    NSString *buddyName = model.hid;//[self.dataSource objectAtIndex:indexPath.row];
    AddFriendViewController * ctl = [[AddFriendViewController alloc]init];
    ctl.addHid = buddyName;
    ctl.uid = model.uid;
    [self pushNewViewController:ctl];
    
    

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
