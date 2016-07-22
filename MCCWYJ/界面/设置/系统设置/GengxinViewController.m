//
//  GengxinViewController.m
//  CWYouJi
//
//  Created by MC on 15/11/19.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "GengxinViewController.h"
#import "gengxinQXViewController.h"
#import "gengxinmodel.h"
@interface GengxinViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    NSArray *_array;
    NSMutableArray * _dataArray;
    
    
    
}

@end

@implementation GengxinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    self.title = @"系统消息";
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = AppMCBgCOLOR;

    [self loadData:YES];
    // Do any additional setup after loading the view.
}
-(void)loadData :(BOOL)iszhuan{
    NSDictionary * Parameterdic = @{
                                    @"device":@(2)
                                    };
    
    
    [self showLoading];
    [self.requestManager postWithUrl:@"api/global/message.json" refreshCache:NO params:Parameterdic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"成功");
        NSLog(@"收藏返回==%@",resultDic);
        for (NSDictionary * dic in resultDic[@"object"]) {
            gengxinmodel * model = [gengxinmodel mj_objectWithKeyValues:dic];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];

    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
        
        NSLog(@"失败");


    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mc5"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"mc5"];
    }
    if (_dataArray.count > indexPath.row) {
        gengxinmodel * model = _dataArray[indexPath.row];
    
        cell.textLabel.text =model.content; //@"刺猬游记1.02主要更新";
    cell.textLabel.font = AppFont;
    cell.textLabel.textColor = AppTextCOLOR;
        cell.detailTextLabel.text = [CommonUtil getStringWithLong:model.modifyDate Format:@"YYYY年MM月dd日"];//@"2015月09月01日";
    //cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.detailTextLabel.textColor = [UIColor grayColor];

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    gengxinQXViewController * ctl = [[gengxinQXViewController alloc]init];
    if (_dataArray.count > indexPath.row) {
        gengxinmodel * model = _dataArray[indexPath.row];
        ctl.Gemodel = model;
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
