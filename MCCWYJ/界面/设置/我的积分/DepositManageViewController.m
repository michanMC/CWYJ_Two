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
@interface DepositManageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView *_tableView;
    BOOL _isEdit;
    UIView *_tabrView;
    UIButton *_deleteBtn;
}

@end

@implementation DepositManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"账号管理";
    
     _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [self prepareFooerView];
    [self tabrView];
    _tabrView.hidden = YES;
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(actionrightBar:)];

    
    
    // Do any additional setup after loading the view.
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
    
    [_tabrView addSubview:_deleteBtn];

    
    
    
    
    

    
    
    
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
-(void)actionAdd{
    AddDepositViewController * ctl = [[AddDepositViewController alloc]init];
    [self pushNewViewController:ctl];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
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
    
    if (section == 0) {
        
        img.image =[UIImage imageNamed:@"支付宝"];
        
        lbl.text = @"支付宝账号";
        
        
    }
    else
    {
        img.image =[UIImage imageNamed:@"微信1"];
        
        lbl.text = @"微信账号";
        
        
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
    [cell prepareUI5];

    if (!_isEdit) {
        cell.bgView.frame = CGRectMake(0, 0, Main_Screen_Width-0, 44);

    }
    else
    {
        cell.bgView.frame = CGRectMake(40, 0, Main_Screen_Width-40, 44);

    }
    
    
    return cell;//[[UITableViewCell alloc]init];
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
