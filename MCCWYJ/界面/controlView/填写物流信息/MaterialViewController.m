//
//  MaterialViewController.m
//  MCCWYJ
//
//  Created by MC on 16/7/15.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MaterialViewController.h"
#import "MCLogisticsViewTableViewCell.h"
@interface MaterialViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView * _tableView;
    
    NSInteger _indexcell1;
    NSString *_courierCompanyStr;

    NSArray * _titleArray;
}

@end

@implementation MaterialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"填写物流信息";
    self.view.backgroundColor  = AppMCBgCOLOR;
    _titleArray = @[@"顺丰快递",@"圆通快递",@"中通快递",@"申通快递",@"EMS"];
    _indexcell1 = 10;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = AppMCBgCOLOR;
    [self.view addSubview:_tableView];
    // Do any additional setup after loading the view.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section ==0) {
        return @"请输入快递公司";
    }
    return @"请选择快递公司";
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellid = @"MCLogisticsViewTableViewCell";
    MCLogisticsViewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[MCLogisticsViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.seleBtn.userInteractionEnabled = NO;
    
    
    if (indexPath.section == 0) {
        [cell prepareCell4];
        cell.seleBtn.userInteractionEnabled = YES;
        [cell.seleBtn addTarget:self action:@selector(actionseleBtn:) forControlEvents:UIControlEventTouchUpInside];
        if (_indexcell1 == 9) {
            cell.seleBtn.selected = YES;
        }
        else
            cell.seleBtn.selected = NO;
        
        cell.text_Field.tag = 600;
        cell.text_Field.delegate = self;
        cell.text_Field.text = _courierCompanyStr;
        return cell;
    }
    else if (indexPath.section == 1){
        
        [cell prepareCell1];
        cell.titleLbl.text = _titleArray[indexPath.row];
        if (_indexcell1 == indexPath.row) {
            cell.seleBtn.selected = YES;
        }
        else
        {
            cell.seleBtn.selected = NO;
 
        }
        return cell;
    }
    
    
    
    
    
    return cell;

    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITextField * text = [self.view viewWithTag:600];
    [text resignFirstResponder];
    
    if (indexPath.section == 1) {
        _indexcell1 = indexPath.row;
        if (_delegate) {
            [_delegate updateCompanyStr:_titleArray[indexPath.row]];
        }
        [_tableView reloadData];
    }
    
}
-(void)actionseleBtn:(UIButton*)btn{
    UITextField * text = [self.view viewWithTag:600];
    [text resignFirstResponder];

    if (btn.selected ) {
        btn.selected = NO;
        _indexcell1 = 10;
        if (_delegate) {
            [_delegate updateCompanyStr:@""];
        }

    }
    else
    {
        btn.selected = YES;
        _indexcell1 = 9;
        if (_delegate) {
            if (_courierCompanyStr.length) {
                [_delegate updateCompanyStr:_courierCompanyStr];
 
            }
            else
            {
                [_delegate updateCompanyStr:@"其他"];

            }
        }


    }
    [_tableView reloadData];
    }
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    _courierCompanyStr = textField.text;
    
    
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
