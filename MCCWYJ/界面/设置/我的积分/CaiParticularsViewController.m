//
//  CaiParticularsViewController.m
//  MCCWYJ
//
//  Created by MC on 16/6/1.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "CaiParticularsViewController.h"
#import "MCCaiParticularsTableViewCell.h"
@interface CaiParticularsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView *_tableView;
    
    
    
}

@end

@implementation CaiParticularsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    
     _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64)];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = AppMCBgCOLOR;

    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([_QXModel.integralType isEqualToString:@"1"]) {
        return 3;
    }
//    else if ([_QXModel.tradeType isEqualToString:@"0"])
//    {
//        return 6;
//    }
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellid = @"CaiParticularsTableViewCell";
    MCCaiParticularsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[MCCaiParticularsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    NSString * ss;
    if ([_QXModel.tradeType isEqualToString:@"3"]||[_QXModel.tradeType isEqualToString:@"5"]||[_QXModel.tradeType isEqualToString:@"10"]||[_QXModel.tradeType isEqualToString:@"12"]) {
        ss = @"-";
        
        
    }
    else
    {
        ss = @"+";
    }
    ss = [NSString stringWithFormat:@"%@%@",ss,_QXModel.integral];

    [cell preppareui];

//    if([_QXModel.integralType isEqualToString:@"1"]){

    if (indexPath.row == 0) {
        cell.lbl_l.text = @"积分数量";
        cell.lbl_r.text = ss;
    }
    else if (indexPath.row == 1){
        cell.lbl_l.text = @"积分类型";
        NSString * sss = @"";
        if ([_QXModel.tradeType isEqualToString:@"0"]) {
            sss = @"充值";
        }
        else if([_QXModel.tradeType isEqualToString:@"1"]){
            sss = @"做任务";
            
        }
        else if([_QXModel.tradeType isEqualToString:@"2"]){
            sss = @"出售商品";
            
        }
        else if([_QXModel.tradeType isEqualToString:@"3"]){
            sss = @"代购单退款";
            
        }
        else if([_QXModel.tradeType isEqualToString:@"4"]){
            sss = @"完成代购";
            
        }
        else if([_QXModel.tradeType isEqualToString:@"5"]){
            sss = @"购买商品退款";
            
        }
        else if([_QXModel.tradeType isEqualToString:@"6"]){
            sss = @"发布代购单";
            
        }

        else if([_QXModel.tradeType isEqualToString:@"10"]){
            sss = @"提现";
            
        }
        else if([_QXModel.tradeType isEqualToString:@"12"]){
            sss = @"购买商品";
            
        }

        
        cell.lbl_r.text = sss;//@"赠点";
        
    }
    else if (indexPath.row == 2){
        cell.lbl_l.text = @"变动时间";
       NSString * ss2 = [CommonUtil getStringWithLong:[_QXModel.modifyDate longLongValue] Format:@"yyyy-MM-dd HH:mm"];

        cell.lbl_r.text =ss2;
        
    }
//    }

    return cell;
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
