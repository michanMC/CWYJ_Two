//
//  gongnengViewController.m
//  CWYouJi
//
//  Created by MC on 15/11/19.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "gongnengViewController.h"
#import "gongnengTableViewCell.h"
@interface gongnengViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_array;
}

@end

@implementation gongnengViewController
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
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.title = @"功能介绍";

    _array = @[@"制作自己专属的游记",@"查找旅游的实用攻略",@"向好友分享自己的游记"];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView = [self headView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    return _array.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    gongnengTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"gongnengTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"gongnengTableViewCell" owner:self options:nil]lastObject];
    }
    cell.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    cell.titleLbl.text = _array[indexPath.row];
    cell.titleLbl.textColor = AppTextCOLOR;
    cell.titleLbl.font = AppFont;
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
