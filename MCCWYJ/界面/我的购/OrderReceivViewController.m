//
//  OrderReceivViewController.m
//  MCCWYJ
//
//  Created by MC on 16/6/24.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "OrderReceivViewController.h"
#import "ShoppingFillTableViewCell.h"
#import "HClActionSheet.h"
@interface OrderReceivViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSInteger _indexcell1;
    NSInteger _indexcell2;
    NSInteger  delayHours;

}

@end

@implementation OrderReceivViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"填写接单信息";
    _indexcell1 = 0;
    _indexcell2 = 0;
    delayHours = 5;
     _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self prepareFooer];
    // Do any additional setup after loading the view.
}
-(void)prepareFooer{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 150)];
//    view.backgroundColor = [UIColor whiteColor];
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(40, 150 - 40 -20,Main_Screen_Width - 2* 40, 40)];
    [btn setTitle:@"接单" forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    btn.titleLabel.font = AppFont;
    btn.backgroundColor = AppRegTextCOLOR;//[UIColor redColor];
    [view addSubview:btn];
    ViewRadius(btn, 5);
    [btn addTarget:self action:@selector(okbtn) forControlEvents:UIControlEventTouchUpInside];
    _tableView.tableFooterView = view;
    
    
}
-(void)okbtn{
    if (!_BuyModlel.id) {
        [self showHint:@"无效id"];
        return;
    }
    [self showLoading];

    NSDictionary * dic = @{
                         @"buyId":_BuyModlel.id,
                         @"isAnonymous":@(_indexcell1),
                         @"isSpareTime":@(_indexcell2),
                         @"delayHours" :delayHours == 5? @(0):@(delayHours)
                           };
    [self.requestManager postWithUrl:@"api/buy/addPickOrder.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
        [self showHint:@"接单成功"];
        if (_delegate)
        [_delegate refreshSubmodel];
        else
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"didMCMyshoppingObjNotification" object:@""];
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
            
        });

        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
    }];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 30)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(10,0 , Main_Screen_Width, 30)];
    lbl.text = @"订单显示设置";
    lbl.font = [UIFont systemFontOfSize:16];
    lbl.textColor = AppTextCOLOR;
    [view addSubview:lbl];
    return view;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellid = @"ShoppingFillTableViewCell";
    ShoppingFillTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[ShoppingFillTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    [cell prepareUI5];
//    cell.seleBtn.tag = indexPath.row + 400;
    cell.seleBtn.selected = NO;
    cell.seleBtn.userInteractionEnabled = NO;
    if (indexPath.row == 2) {
        [cell prepareUI3];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        cell.titleLbl.text = @"延迟时间";
        NSString * ss =@"不延时";
        if (delayHours == 5) {
            ss =@"不延时";
        }
        else
        {
            ss = @[@"1小时",@"2小时",@"3小时"][delayHours];
        }
        cell.addLbl.text = ss;//@"1小时";
        
        return cell;
        
    }
else if (indexPath.row == 0) {
        cell.titleLbl.text = @"是否匿名";
        cell.seleBtn.selected = _indexcell1;
    return cell;

    
    }
    else if (indexPath.row == 1) {
        cell.titleLbl.text = @"否延时显示";
        cell.seleBtn.selected = _indexcell2;
        return cell;


    }
    
//    UIButton * btn = [self.view viewWithTag:_indexcell3 + 400];
//    btn.selected = YES;
    return cell;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
//    _indexcell3 = indexPath.row;
    if (indexPath.row == 0) {
        if (_indexcell1==0) {
            _indexcell1 = 1;
        }
        else
            _indexcell1 = 0;

    }
    if (indexPath.row == 1) {
        if (_indexcell2==0) {
            _indexcell2 = 1;
        }
        else
            _indexcell2 = 0;
    }
    if (indexPath.row == 2) {
        
        HClActionSheet * actionSheet = [[HClActionSheet alloc] initWithTitle:@"延迟时间" style:HClSheetStyleDefault itemTitles:@[@"1小时",@"2小时",@"3小时"]];
        actionSheet.delegate = self;
        actionSheet.tag = 100;
        delayHours = 5;
        // actionSheet.titleTextColor = [UIColor redColor];
        actionSheet.itemTextColor = [UIColor blackColor];
        actionSheet.cancleTextColor = [UIColor redColor];//RGBCOLOR(36, 149, 221);
        actionSheet.cancleTitle = @"取消";
        __weak typeof(UITableView*) weakSelft = _tableView;
        [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
            delayHours = index;
            NSLog(@"block----%ld----%@", (long)index, title);
//            if (@[@"1小时",@"2小时",@"3小时"].count > index) {
//
//                
//                
//            }
            [weakSelft reloadData];

        }];
        [weakSelft reloadData];

        return;
    }

    
    
    [_tableView reloadData];
    
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
