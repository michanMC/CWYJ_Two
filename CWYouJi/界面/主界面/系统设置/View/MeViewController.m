//
//  MeViewController.m
//  CWYouJi
//
//  Created by MC on 15/11/19.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "MeViewController.h"
#import "yijianViewController.h"
#import "gongnengViewController.h"
#import "GengxinViewController.h"
@interface MeViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    
    UITableView *_tableView;
    NSArray *_array;

}
@end

@implementation MeViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //[self.navigationController setToolbarHidden:YES animated:NO];
    self.navigationController.navigationBarHidden = YES;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    _array = @[@"功能介绍",@"意见反馈"];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView = [self headView];
       // Do any additional setup after loading the view.
}
-(UIView *)headView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 170)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIImageView * imgview = [[UIImageView alloc]initWithFrame:CGRectMake((Main_Screen_Width- 80)/2, 20, 80, 80)];
    imgview.image =[UIImage imageNamed:@"mine_logo"];
    [view addSubview:imgview];
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 110, Main_Screen_Width, 20)];
    lbl.textColor = AppTextCOLOR;
    lbl.text = @"刺猬游记";
    lbl.textAlignment = NSTextAlignmentCenter;
    [view addSubview:lbl];
    
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 130, Main_Screen_Width, 20)];
    lbl.textColor = AppTextCOLOR;
    lbl.text = @"v1.0.0";
    lbl.textAlignment = NSTextAlignmentCenter;
    [view addSubview:lbl];

    
    
    return view;
    
    
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
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mc3"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mc3"];
    }
    cell.textLabel.text = _array[indexPath.row];
    cell.textLabel.font = AppFont;
    cell.textLabel.textColor = AppTextCOLOR;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 1) {
        yijianViewController * ctl = [[yijianViewController alloc]init];
        [self pushNewViewController:ctl];
        
    }
    if (indexPath.row == 0) {
        gongnengViewController * ctl = [[gongnengViewController alloc]init];
        [self pushNewViewController:ctl];
        
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
