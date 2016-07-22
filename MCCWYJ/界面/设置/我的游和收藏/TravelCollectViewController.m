//
//  TravelCollectViewController.m
//  MCCWYJ
//
//  Created by MC on 16/6/2.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "TravelCollectViewController.h"
#import "homeYJModel.h"
#import "YJTableViewCell.h"
#import "YJNoDataTableViewCell.h"
#import "travelModel.h"
#import "ProductionViewController.h"
@interface TravelCollectViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    
    UITableView *_tableView;
    NSMutableArray *_dataAarray;//数据源
    NSInteger  _pageStr;
    BOOL _isNoData;
    
    
    UIView * _editView;
    UIButton *_allSelectBtn;
    UIButton *_deleteBtn;
    
    NSMutableArray *_seleArray;

}

@end

@implementation TravelCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataAarray  =[NSMutableArray array];
    _seleArray = [NSMutableArray array];
    _pageStr = 1;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width,Main_Screen_Height - 44 - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(RefreshHeader)];
    _tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(RefreshFooter)];
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = AppMCBgCOLOR;

    [self loadData];
    
    _editView = [[UIView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height - 44-64 - 49, Main_Screen_Width, 49)];
    _editView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_editView];
    _allSelectBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    [_allSelectBtn setImage:[UIImage imageNamed:@"list_checkbox_normal"] forState:UIControlStateNormal];
    [_allSelectBtn setImage:[UIImage imageNamed:@"list_checkbox_checked"] forState:UIControlStateSelected];
    [_allSelectBtn addTarget:self action:@selector(actionAllSeleBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_editView addSubview:_allSelectBtn];
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 50, 49)];
    lbl.text = @"全选";
    lbl.textColor = [UIColor darkTextColor];
    lbl.font = [UIFont systemFontOfSize:15];
    [_editView addSubview:lbl];
    
    _deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width - 120, 0, 120, 49)];
    _deleteBtn.backgroundColor = AppCOLOR;
    [_deleteBtn setTitle:@"删除(0)" forState:0];
    [_deleteBtn setTitleColor:[UIColor whiteColor] forState:0];
    [_deleteBtn addTarget:self action:@selector(actiondeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_editView addSubview:_deleteBtn];
    
    _editView.hidden = YES;
    

    // Do any additional setup after loading the view.
}
-(void)actionEdit{
    if (_editView.hidden) {
        _editView.hidden = NO;
        _tableView.frame = CGRectMake(0, 0, Main_Screen_Width,Main_Screen_Height - 44 - 64 - 49);
        
        
    }
    else
    {
        _allSelectBtn.selected = NO;
        _editView.hidden = YES;
        _tableView.frame = CGRectMake(0, 0, Main_Screen_Width,Main_Screen_Height - 44 - 64 );
        
        
        
    }
    [_tableView reloadData];
    
}


-(void)RefreshHeader{
    if (_editView.hidden) {
        [_dataAarray removeAllObjects];
    _pageStr = 1;
    [self loadData];
    }
    else
    {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }
    
    
}
-(void)RefreshFooter{
    if (_editView.hidden) {

    _pageStr ++;
    [self loadData];
    }
    else
    {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }
    
    
}
#pragma mark-加载数据
-(void)loadData{
    [self showLoading];
    NSDictionary * dic = @{
                           @"page":@(_pageStr)
 
                           };
    [self.requestManager postWithUrl:@"api/travle/collection/query.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
        for (NSDictionary * dic in resultDic[@"object"]) {
            travelModel * model = [travelModel mj_objectWithKeyValues:dic];
            model.isselect = NO;
            model.homeModel = [homeYJModel mj_objectWithKeyValues:dic[@"travel"]];
            model.homeModel.userModel =[YJUserModel mj_objectWithKeyValues:dic[@"travel"][@"user"]];
            if (model.homeModel.photos) {
                for (NSDictionary * photodic in model.homeModel.photos) {
                    YJphotoModel * photomodel = [YJphotoModel mj_objectWithKeyValues:photodic];
                    [model.homeModel.YJphotos addObject:photomodel];
                }
            }
            
            [_dataAarray addObject:model];
        }
        if (_dataAarray.count == 0) {
            _isNoData = YES;
        }
        else
        {
            _isNoData = NO;
        }
        
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];

        [_tableView reloadData];

        
        
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
    }];
    

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
        [cell prepareNoDataUI:self.view.mj_h TitleStr:@"暂时没有你要查询的数据"];
        //        [cell.tapBtn addTarget:self action:@selector(actionTapBtn) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
        
        
    }
    
    
    
        if (_dataAarray.count > indexPath.section) {
    static NSString * cellid = @"mc1";
    YJTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[YJTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    
    //        cell.selectionStyle =
    travelModel * model= _dataAarray[indexPath.section];
            homeYJModel * homemodel = model.homeModel;

    [cell prepareUI:homemodel];
    if (_editView.hidden) {
        cell.BgView.frame = CGRectMake(0, 0, Main_Screen_Width, cell.BgView.mj_h);
    }
    else
    {
        cell.BgView.frame = CGRectMake(50, 0, Main_Screen_Width, cell.BgView.mj_h);
        
    }
    cell.selectBtn.selected = model.isselect;
    cell.selectBtn.tag = indexPath.section + 400;
    [cell.selectBtn addTarget:self action:@selector(actionCellSeleBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
       }
    
    
    
    return [[UITableViewCell alloc]init];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_isNoData) {
        return;
    }
    if (_editView.hidden) {
        travelModel * model = _dataAarray[indexPath.section];
        homeYJModel * homemodel = model.homeModel;
        NSMutableArray * data_Array = [NSMutableArray array];
        for (travelModel * model in _dataAarray) {
            [data_Array addObject:model.homeModel];
        }
        
        

    ProductionViewController *ctl = [[ProductionViewController alloc]init];
    ctl.home_model = homemodel;
    ctl.dataArray = data_Array;
    ctl.index = indexPath.section ;//indexPath.section;
    
    [_delegate pushNewViewController:ctl];
    }
}
-(void)actionCellSeleBtn:(UIButton*)btn{
    travelModel * model = _dataAarray[btn.tag - 400];
    if (btn.selected) {
        btn.selected = NO;
        model.isselect = NO;
        if ([_seleArray containsObject:model.id]) {
            [_seleArray removeObject:model.id];
        }
        if (_allSelectBtn.selected) {
            _allSelectBtn.selected = NO;
        }
    }
    else
    {
        btn.selected = YES;
        model.isselect = YES;
        [_seleArray addObject:model.id];

    }
    NSString * ss = [NSString stringWithFormat:@"删除(%d)",_seleArray.count];
    
    [_deleteBtn setTitle:ss forState:0];

    
    
    
    
}
-(void)actionAllSeleBtn:(UIButton*)btn{
    
    [_seleArray removeAllObjects];

    if (_allSelectBtn.selected) {
        _allSelectBtn.selected = NO;
        
        for (travelModel * model in _dataAarray) {
            model.isselect = NO;
        }

    }
    else
    {
        _allSelectBtn.selected = YES;
        for (travelModel * model in _dataAarray) {
            model.isselect = YES;
            [_seleArray addObject:model.id];
        }

        
        
    }
    [_tableView reloadData];
    NSString * ss = [NSString stringWithFormat:@"删除(%d)",_seleArray.count];
    
    [_deleteBtn setTitle:ss forState:0];

    
}
-(void)actiondeleteBtn:(UIButton*)btn{
    if (!_seleArray.count) {
        [self showAllTextDialog:@"请选择你要删除的作品"];
        return ;
    }
    NSString * collectionIds = [_seleArray componentsJoinedByString:@","];
    NSDictionary * Parameterdic = @{
                                    @"collectionIds":collectionIds
                                    };
    
    [self showLoading];
    [self.requestManager postWithUrl:@"api/travle/collection/deleteByCollectionIds.json" refreshCache:NO params:Parameterdic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        [_seleArray removeAllObjects];
        [self showAllTextDialog:@"删除成功"];
        
        [_deleteBtn setTitle:@"删除(0)" forState:0];
        
        
//        //发送通知首页刷新
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"dishuaxinObjNotification" object:@""];
//        
//        
//        //发送通知
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"didzuopingshuaxinObjNotification" object:@""];
//        [self actionEdit];
//        [_tableView reloadData];
        if (_delegate) {
            [_delegate finishEdit];
        }
        [self RefreshHeader];

    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
        
        NSLog(@"失败");

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
