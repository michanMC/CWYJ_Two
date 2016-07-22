//
//  DepositViewController.m
//  MCCWYJ
//
//  Created by MC on 16/5/27.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "DepositViewController.h"
#import "DepositTableViewCell.h"
#import "AddDepositViewController.h"
@interface DepositViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView *_tableView;
    NSMutableArray *_dataPArray;//支付宝
    NSMutableArray *_dataWArray;//微信
    

    
    
}

@end

@implementation DepositViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现到";
    
    _dataPArray = [NSMutableArray array];
    _dataWArray = [NSMutableArray array];
    //监听数据的刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"didDepositObjNotification" object:nil];

     _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = AppMCBgCOLOR;

    [self prepareFooerView];
    [self loadData];
    // Do any additional setup after loading the view.
}
-(void)prepareFooerView{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 100)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.tableFooterView = view;
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(40, 40, Main_Screen_Width - 80, 35)];
    btn.backgroundColor = AppCOLOR;
    ViewRadius(btn, 5);
    [btn setTitle:@"添加新账号" forState:0];
    btn.titleLabel.font  = AppFont;
    [btn addTarget:self action:@selector(actionAdd) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    [view addSubview:btn];
    
    
    
    
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
            
            lbl.text = @"提现到支付宝";
            
            
        }
        else
        {
            img.image =[UIImage imageNamed:@"微信1"];
            
            lbl.text = @"提现到微信";
            
            
        }
        
    }
    else
    {
        if (_dataPArray.count) {
            img.image =[UIImage imageNamed:@"支付宝"];
            
            lbl.text = @"提现到支付宝";
            
            
        }
        else
        {
            img.image =[UIImage imageNamed:@"微信1"];
            
            lbl.text = @"提现到微信";
            
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
//        cell.selectionStyle = 
    }
    [cell prepareUI];
    
    if (_dataPArray.count && _dataWArray.count) {
        if (indexPath.section == 0) {
            if (_dataPArray.count > indexPath.row) {
                MyIntegralModel * modle = _dataPArray[indexPath.row];
                cell.titleLbl.text = [NSString stringWithFormat:@"%@(%@)",modle.name,modle.account];
                if (_seleModel.id == modle.id) {
                    cell.selectBtn.selected = YES;
                }
                else
                {
                    cell.selectBtn.selected = NO;;

                }
                
            }
            
            return cell;
            
        }
        else
        {
            if (_dataWArray.count > indexPath.row) {
                MyIntegralModel * modle = _dataWArray[indexPath.row];
                cell.titleLbl.text = [NSString stringWithFormat:@"%@(%@)",modle.name,modle.account];
                if (_seleModel.id == modle.id) {
                    cell.selectBtn.selected = YES;
                }
                else
                {
                    cell.selectBtn.selected = NO;;
                    
                }

                
            }
            
            return cell;
            
            
        }
        
    }
    else
    {
        if (_dataPArray.count) {
            if (_dataPArray.count > indexPath.row) {
                MyIntegralModel * modle = _dataPArray[indexPath.row];
                cell.titleLbl.text = [NSString stringWithFormat:@"%@(%@)",modle.name,modle.account];
                if (_seleModel.id == modle.id) {
                    cell.selectBtn.selected = YES;
                }
                else
                {
                    cell.selectBtn.selected = NO;;
                    
                }

                
            }
            return cell;
            
        }
        else
        {
            if (_dataWArray.count > indexPath.row) {
                MyIntegralModel * modle = _dataWArray[indexPath.row];
                cell.titleLbl.text = [NSString stringWithFormat:@"%@(%@)",modle.name,modle.account];
                if (_seleModel.id == modle.id) {
                    cell.selectBtn.selected = YES;
                }
                else
                {
                    cell.selectBtn.selected = NO;;
                    
                }

                
            }
            
            return cell;
            
        }
        
        
        
    }

    return cell;//[[UITableViewCell alloc]init];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
