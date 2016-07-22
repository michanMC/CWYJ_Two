//
//  DepositManageViewController.m
//  MCCWYJ
//
//  Created by MC on 16/5/27.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "DepositManageViewController.h"
#import "AddDepositViewController.h"
#import "DepositTableViewCell.h"
#import "MyIntegralModel.h"
@interface DepositManageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView *_tableView;
    BOOL _isEdit;
    UIView *_tabrView;
    UIButton *_deleteBtn;
    NSMutableArray *_dataPArray;//支付宝
    NSMutableArray *_dataWArray;//微信
    NSMutableArray * _deleArray;
    
}

@end

@implementation DepositManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"账号管理";
    _deleArray = [NSMutableArray array];
    //监听数据的刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"didszhanghaoObjNotification" object:nil];
    
    
    _dataPArray = [NSMutableArray array];
    _dataWArray = [NSMutableArray array];

     _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = AppMCBgCOLOR;

    [self prepareFooerView];
    [self tabrView];
    _tabrView.hidden = YES;
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(actionrightBar:)];

    [self loadData];
    
    // Do any additional setup after loading the view.
}
-(void)loadData{
    
        [self showLoading];
    _dataPArray = [NSMutableArray array];
    _dataWArray = [NSMutableArray array];

    NSDictionary * dic = @{
                         
                           };
    [self.requestManager postWithUrl:@"api/paymentAccount/list.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
        for (NSDictionary * dic in resultDic[@"object"]) {
            MyIntegralModel * modle = [MyIntegralModel mj_objectWithKeyValues:dic];
            if (modle.type == 0) {
                [_dataPArray addObject:modle];

            }
            else
            {
                [_dataWArray addObject:modle];

            }
        }
        [_tableView reloadData];
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
    }];

    
}
-(void)actionrightBar:(UIBarButtonItem*)Item{
    
    if ([Item.title isEqualToString:@"编辑"]) {//编辑状态
        Item.title = @"完成";
        _isEdit = YES;
        [_tableView.tableFooterView removeFromSuperview];
        _tabrView.hidden = NO;
        _tableView.frame = CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64 - 49);

        
        
    }
    else{
        _isEdit = NO;

        [self prepareFooerView];
        Item.title = @"编辑";
        _tabrView.hidden = YES;
        _tableView.frame = CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64 );
        

        
        
    }
    [_tableView  reloadData];
    
    
}
-(void)tabrView{
    _tabrView = [[UIView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height - 49, Main_Screen_Width, 49)];
    _tabrView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tabrView];
    UIButton *_allSeleCtBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, (49-30)/2, 30, 30)];
    [_allSeleCtBtn setImage:[UIImage imageNamed:@"radio-btn_nor"] forState:UIControlStateNormal];
    [_allSeleCtBtn setImage:[UIImage imageNamed:@"radio-btn_selected"] forState:UIControlStateSelected];
    [_allSeleCtBtn addTarget:self action:@selector(allSeleCtBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_tabrView addSubview:_allSeleCtBtn];
    
    
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(40 + 10, 0, 50, 49)];
    lbl.text = @"全选";
    lbl.textColor = AppTextCOLOR;
    lbl.font = AppFont;
    [_tabrView addSubview:lbl];

    
    
    
    _deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width - 100, 0, 100, 49)];
    _deleteBtn.backgroundColor = AppCOLOR;
    [_deleteBtn setTitleColor:[UIColor whiteColor] forState:0];
    [_deleteBtn setTitle:@"删除(0)" forState:0];
    [_deleteBtn addTarget:self action:@selector(deleBtn) forControlEvents:UIControlEventTouchUpInside];
    [_tabrView addSubview:_deleteBtn];

    
    
    
}
-(void)allSeleCtBtnAction:(UIButton*)btn{
    
    if (btn.selected ) {
        btn.selected = NO;
        [_deleArray removeAllObjects];
    }
    else
    {
        btn.selected = YES;
        
        for (MyIntegralModel * modle in _dataPArray) {
            [_deleArray addObject:modle.id];
        }
        for (MyIntegralModel * modle in _dataWArray) {
            [_deleArray addObject:modle.id];
        }

        
    }
    
    [_tableView reloadData];
    
    [_deleteBtn setTitle:[NSString stringWithFormat:@"删除(%ld)",_deleArray.count] forState:0];
    

}
-(void)deleBtn{
    if (!_deleArray.count) {
        [self showHint:@"请选择要删除的账号"];
        return;
    }
    
    NSString *ids = [_deleArray componentsJoinedByString:@","];
    
        [self showLoading];
    NSDictionary * dic = @{
                         @"ids":ids
                           };
    [self.requestManager postWithUrl:@"api/paymentAccount/delete.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
        [self showHint:@"删除成功"];
        if (_delegate.seleModel.id) {
            for (NSString * modle in _deleArray) {
                NSLog(@"===%@",_delegate.seleModel.id);
                if ([_delegate.seleModel.id isEqualToString:modle]) {
                    _delegate.seleModel = nil;
                    [_delegate.tableView reloadData];
                    continue;
                }
            }
        }
    
        [_deleArray removeAllObjects];
        [_deleteBtn setTitle:[NSString stringWithFormat:@"删除(%ld)",_deleArray.count] forState:0];

        [self loadData];
        
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
    }];

    
}
-(void)prepareFooerView{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 120)];
    view.backgroundColor = AppMCBgCOLOR;//[UIColor groupTableViewBackgroundColor];
    _tableView.tableFooterView = view;
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(40, 40, Main_Screen_Width - 80, 40)];
    btn.backgroundColor = AppRegTextCOLOR;
    ViewRadius(btn, 5);
    [btn setTitle:@"添加新账号" forState:0];
    btn.titleLabel.font  = AppFont;
    [btn addTarget:self action:@selector(actionAdd) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    [view addSubview:btn];
    
    
}
-(void)actionAdd{
    AddDepositViewController * ctl = [[AddDepositViewController alloc]init];
    [self pushNewViewController:ctl];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_dataPArray.count && _dataWArray.count) {
        return 2;

    }
    else if (!_dataPArray.count && !_dataWArray.count)
    {
        return 0;
    }
    else
        return 1;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_dataPArray.count && _dataWArray.count) {
        if (section == 0) {
            return _dataPArray.count;
        }
        else
        {
            return _dataWArray.count;
            
        }
        
    }
    else if (!_dataPArray.count &&!_dataWArray.count)
        return 0;
    else
    {
        return _dataWArray.count? _dataWArray.count:_dataPArray.count;
    }

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view;
    view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 40)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 30, 30)];
    [view addSubview:img];
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(40 + 10, 0, Main_Screen_Width, 40)];
    lbl.textColor =AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:16];
    [view addSubview:lbl];
    if (_dataPArray.count && _dataWArray.count) {
        if (section == 0) {
            
            
            img.image =[UIImage imageNamed:@"支付宝"];
            
            lbl.text = @"支付宝账号";
            
            
        }
        else
        {
            img.image =[UIImage imageNamed:@"微信1"];
            
            lbl.text = @"微信账号";
            
            
        }
 
    }
    else
    {
        if (_dataPArray.count) {
            img.image =[UIImage imageNamed:@"支付宝"];
            
            lbl.text = @"支付宝账号";

            
        }
        else
        {
            img.image =[UIImage imageNamed:@"微信1"];
            
            lbl.text = @"微信账号";
 
        }
        
        
        
    }

    
    return view;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellid1 = @"DepositTableViewCell";
    DepositTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
    if (!cell) {
        cell = [[DepositTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid1];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    [cell prepareUI5];
    [cell.selectBtn addTarget:self action:@selector(actionSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    if (!_isEdit) {
        cell.bgView.frame = CGRectMake(0, 0, Main_Screen_Width-0, 44);
        
    }
    else
    {
        cell.bgView.frame = CGRectMake(40, 0, Main_Screen_Width-40, 44);
        
    }

    if (_dataPArray.count && _dataWArray.count) {
        if (indexPath.section == 0) {
            if (_dataPArray.count > indexPath.row) {
                MyIntegralModel * modle = _dataPArray[indexPath.row];
                cell.subtitleLbl.text = [NSString stringWithFormat:@"%@(%@)",modle.name,modle.account];
                cell.selectBtn.tag =300+indexPath.row;
                if ([_deleArray containsObject:modle.id]) {
                    cell.selectBtn.selected = YES;
                }
                else
                    cell.selectBtn.selected = NO;
 

            }
            
            return cell;
            
        }
        else
        {
            if (_dataWArray.count > indexPath.row) {
                MyIntegralModel * modle = _dataWArray[indexPath.row];
                cell.subtitleLbl.text = [NSString stringWithFormat:@"%@(%@)",modle.name,modle.account];
                cell.selectBtn.tag =800+indexPath.row;
                if ([_deleArray containsObject:modle.id]) {
                    cell.selectBtn.selected = YES;
                }
                else
                    cell.selectBtn.selected = NO;
            }
            
            return cell;
  
            
        }
        
    }
    else
    {
        if (_dataPArray.count) {
            if (_dataPArray.count > indexPath.row) {
                MyIntegralModel * modle = _dataPArray[indexPath.row];
                cell.subtitleLbl.text = [NSString stringWithFormat:@"%@(%@)",modle.name,modle.account];
                cell.selectBtn.tag =300+indexPath.row;

                if ([_deleArray containsObject:modle.id]) {
                    cell.selectBtn.selected = YES;
                }
                else
                    cell.selectBtn.selected = NO;
            }
            return cell;
            
        }
        else
        {
            if (_dataWArray.count > indexPath.row) {
                MyIntegralModel * modle = _dataWArray[indexPath.row];
                cell.subtitleLbl.text = [NSString stringWithFormat:@"%@(%@)",modle.name,modle.account];
                cell.selectBtn.tag =800+indexPath.row;
                if ([_deleArray containsObject:modle.id]) {
                    cell.selectBtn.selected = YES;
                }
                else
                    cell.selectBtn.selected = NO;
                
            }
            
            return cell;
 
        }
        
        
        
    }
    
    
    
    return cell;//[[UITableViewCell alloc]init];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (!_isEdit) {
        
        if (_delegate) {
            
            if (_dataPArray.count && _dataWArray.count) {
                if (indexPath.section == 0) {
                    if (_dataPArray.count > indexPath.row) {
                        MyIntegralModel * modle = _dataPArray[indexPath.row];
                        _delegate.seleModel = modle;
                        
                    }
                    
                    
                }
                else
                {
                    if (_dataWArray.count > indexPath.row) {
                        MyIntegralModel * modle = _dataWArray[indexPath.row];

                        _delegate.seleModel = modle;

                    }
                    
                    
                    
                }
                
            }
            else
            {
                if (_dataPArray.count) {
                    if (_dataPArray.count > indexPath.row) {
                        MyIntegralModel * modle = _dataPArray[indexPath.row];
                        _delegate.seleModel = modle;

                    }
                    
                }
                else
                {
                    if (_dataWArray.count > indexPath.row) {
                        MyIntegralModel * modle = _dataWArray[indexPath.row];
                        _delegate.seleModel = modle;

                    }
                    
                    
                }
                
                
                
            }
 
            
            
        }
        
        
    }
    else
    {
        
    }
 
    
    
    
}
-(void)actionSelectBtn:(UIButton*)btn{
    MyIntegralModel *modle;
    if (btn.tag <800) {
        modle = _dataPArray[btn.tag - 300];

    }
    else
    {
        modle = _dataWArray[btn.tag - 800];

    }
    
    if (btn.selected) {
        btn.selected = NO;
        if ([_deleArray containsObject:modle.id]) {
            [_deleArray removeObject:modle.id];
        }
    }
    else
    {
        btn.selected = YES;
        if (![_deleArray containsObject:modle.id]) {
            [_deleArray addObject:modle.id];
        }

    }
    
    [_deleteBtn setTitle:[NSString stringWithFormat:@"删除(%ld)",_deleArray.count] forState:0];
    
    
    
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
