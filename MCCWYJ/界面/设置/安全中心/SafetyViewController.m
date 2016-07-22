//
//  SafetyViewController.m
//  MCCWYJ
//
//  Created by MC on 16/5/5.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "SafetyViewController.h"
#import "verifyViewController.h"
@interface SafetyViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView *_tableView;
    
}

@end

@implementation SafetyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"安全中心";
     _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = AppMCBgCOLOR;

    // Do any additional setup after loading the view.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mc"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"mc"];
        
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textColor = AppTextCOLOR;
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"登录密码";
        cell.detailTextLabel.text = @"建议你定期更改密码以保护账号安全";
    }
    if (indexPath.row == 1) {
        cell.textLabel.text = @"支付密码";
        cell.detailTextLabel.text = @"修改支付密码后24小时生效";
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    verifyViewController * ctl = [[verifyViewController alloc]init];
    if (indexPath.row == 0) {
        ctl.verifyStr = @"1";
    }
    else
    {
        ctl.verifyStr = @"2";
 
    }
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
