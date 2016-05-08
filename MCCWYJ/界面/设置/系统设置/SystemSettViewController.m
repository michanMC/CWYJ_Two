//
//  SystemSettViewController.m
//  MCCWYJ
//
//  Created by MC on 16/5/5.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "SystemSettViewController.h"
#import "SettgTableViewCell.h"
@interface SystemSettViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

{
    UITableView *_tableView;
    NSArray *_array;
}

@end

@implementation SystemSettViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"系统设置";
    _array = @[@[@"系统通知",@"评论通知"],
               @[@"清除缓存"]
               ];

 _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    [self.view addSubview:_tableView];
    // Do any additional setup after loading the view.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    SettgTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SettgTableViewCell"];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SettgTableViewCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.tileLbl.text = _array[indexPath.section][indexPath.row];
    cell.tileLbl.textColor = AppTextCOLOR;


    if (indexPath.section == 0) {
 
    cell.SWBtn.tag = indexPath.row + 600;
    
    [cell.SWBtn setImage:[UIImage imageNamed:@"toggle-off"] forState:UIControlStateNormal];
    [cell.SWBtn setImage:[UIImage imageNamed:@"toggle-on"] forState:UIControlStateSelected];
    cell.SWBtn.selected = YES;
    [cell.SWBtn addTarget:self action:@selector(actionSwBtn:) forControlEvents:UIControlEventTouchUpInside];
 
    }
    else
    {
//        cell.SWBtn.hidden = YES;
        [cell.SWBtn setImage:nil forState:UIControlStateNormal];
        cell.SWBtn.enabled = NO;
        [cell.SWBtn setTitle:@"23.3M" forState:0];
        [cell.SWBtn setTitleColor:RGBCOLOR(127, 125, 147) forState:0];
        cell.SWBtn.titleLabel.font = AppFont;
        
    }
    return cell;
    
    
}
-(void)actionSwBtn:(UIButton*)btn{
    
    
    if (btn.selected ) {
        btn.selected = NO;
        
    }
    else
    {
        btn.selected = YES;
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
