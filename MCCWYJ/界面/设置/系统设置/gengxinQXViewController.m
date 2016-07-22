//
//  gengxinQXViewController.m
//  CWYouJi
//
//  Created by MC on 15/11/19.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "gengxinQXViewController.h"
#import "gongnengTableViewCell.h"
@interface gengxinQXViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    UITableView *_tableView;
    NSArray *_array;

}

@end

@implementation gengxinQXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"功能介绍";
    _array = @[@"制作自己专属的游记",@"查找旅游的实用攻略",@"向好友分享自己的游记"];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = AppMCBgCOLOR;


    // Do any additional setup after loading the view.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 70;
    }
    return 30;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mc5"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"mc5"];
        }
        cell.textLabel.text =_Gemodel.content; //@"刺猬游记1.02主要更新";
        cell.textLabel.font = AppFont;
        cell.textLabel.textColor = AppTextCOLOR;
        cell.detailTextLabel.text = [CommonUtil getStringWithLong:_Gemodel.modifyDate Format:@"YYYY年MM月dd日"];//@"2015月09月01日";        //cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.detailTextLabel.textColor = [UIColor grayColor];
        cell.contentView.backgroundColor = AppMCBgCOLOR;//[UIColor groupTableViewBackgroundColor];

        return cell;

    }
    gongnengTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"gongnengTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"gongnengTableViewCell" owner:self options:nil]lastObject];
    }
    cell.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    cell.titleLbl.text = _array[indexPath.row-1];
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
