//
//  BaskCollecViewController.m
//  MCCWYJ
//
//  Created by MC on 16/6/3.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "BaskCollecViewController.h"
#import "homeYJModel.h"
#import "YJTableViewCell.h"
#import "YJNoDataTableViewCell.h"
#import "CarteViewController.h"
@interface BaskCollecViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    UITableView *_tableView;
    NSMutableArray *_dataAarray;//数据源
    NSInteger  _pageStr;
    BOOL _isNoData;
    
    
    UIView * _editView;
    UIButton *_allSelectBtn;
    UIButton *_deleteBtn;
    

}

@end

@implementation BaskCollecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataAarray  =[NSMutableArray array];
    _pageStr = 1;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width,Main_Screen_Height - 44 - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(RefreshHeader)];
    _tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(RefreshFooter)];
    _tableView.backgroundColor = AppMCBgCOLOR;

    [self.view addSubview:_tableView];
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
                           @"pageNumber":@(_pageStr),
                           @"userId":[MCUserDefaults objectForKey:@"id"],
                           @"type":@(1),
                           @"pageSize":@(20)
                           
                           
                           };
    [self.requestManager postWithUrl:@"api/buy/getShows.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
        
        NSArray * objectArray = resultDic[@"object"];
        for (NSDictionary * dic in objectArray) {
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
        [self stopshowLoading];
        [self showAllTextDialog:description];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];

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
    
    return 100 *MCHeightScale + 15 + 20 + 10;
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
        MCMyshoppingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[MCMyshoppingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //        cell.selectionStyle =
        //        homeYJModel * model= _dataAarray[indexPath.section];
        MCBuyModlel * modle = _dataAarray[indexPath.section];
        cell.BuyModlel = modle;
        
        
        [cell  prepareNotitleUI];
        if (_editView.hidden) {
            cell.bgView.frame = CGRectMake(0, 0, Main_Screen_Width, cell.bgView.mj_h);
        }
        else
        {
            cell.bgView.frame = CGRectMake(50, 0, Main_Screen_Width, cell.bgView.mj_h);
            
        }
        cell.selectBtn.tag = indexPath.section + 600;
        
        [cell.selectBtn addTarget:self action:@selector(actionCellSeleBtn:) forControlEvents:UIControlEventTouchUpInside];
        cell.headerimgBtn.tag = 500 + indexPath.section;
        
        [cell.headerimgBtn addTarget:self action:@selector(ActionheaderimgBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
        return cell;
    }
    
    
    //    }
    
    
    
    return [[UITableViewCell alloc]init];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section < _dataAarray.count&&_editView.hidden) {
        MCBuyModlel * modle = _dataAarray[indexPath.section];
        ShoppingQXViewController *ctl = [[ShoppingQXViewController alloc]init];
        ctl.BuyModlel = modle;
        ctl.dataArray = _dataAarray;
        ctl.index = indexPath.section;//indexPath.section;
        
        [_delegate pushNewViewController:ctl];
        
        
    }
    
    
    
}

#pragma mark-点击头像
-(void)ActionheaderimgBtn:(UIButton*)btn{
    CarteViewController *ctl = [[CarteViewController alloc]init];
    [_delegate pushNewViewController:ctl];
    
    
}


-(void)actionCellSeleBtn:(UIButton*)btn{
    btn.selected = YES;
}
-(void)actionAllSeleBtn:(UIButton*)btn{
    if (_allSelectBtn.selected) {
        _allSelectBtn.selected = NO;
    }
    else
    {
        _allSelectBtn.selected = YES;
        
    }
    
    
}
-(void)actiondeleteBtn:(UIButton*)btn{
    
    //    [self actionEdit];
    //    [_tableView reloadData];
    //    if (_delegate) {
    //        [_delegate finishEdit];
    //    }
    
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
