//
//  MCMyshoppingViewController.m
//  CWYouJi
//
//  Created by MC on 16/4/28.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MCMyshoppingViewController.h"
#import "MCMyshoppingTableViewCell.h"
#import "YJTableViewCell.h"
#import "MakeBuyViewController.h"
#import "MCscreenView.h"
#import "SearchViewController.h"
#import "CarteViewController.h"
#import "WNImagePicker.h"
@interface MCMyshoppingViewController ()<UITableViewDelegate,UITableViewDataSource,MCscreenViewDelegate>
{
    UITextField *_searchtext;
    
    UITableView *_tableView;
    
    BOOL _isShowScree;
    MCscreenView * _screenview;
}

@end

@implementation MCMyshoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpNavBar];
    
    
     _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64 - 49) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //3种状态
    if (indexPath.section == 0) {

    return 100 *MCHeightScale + 15 + 20 + 10;
    }
    if (indexPath.section == 1) {
        return 100 *MCHeightScale + 15 + 20 + 10 + 44;

    }
    if(indexPath.section == 2){
    return 100 *MCHeightScale + 15 + 20 + 15;
    }

    return 44;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellid1 = @"MCMyshoppingTableViewCell1";
    static NSString * cellid2 = @"MCMyshoppingTableViewCell2";
    static NSString * cellid3 = @"mc3";

    if (indexPath.section == 0) {
    
    MCMyshoppingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
    if (!cell) {
        cell = [[MCMyshoppingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid1];
    }
    
    [cell  prepareNotitleUI];
        [cell.headerimgBtn addTarget:self action:@selector(ActionheaderimgBtn:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
    }
    if (indexPath.section == 1) {
        MCMyshoppingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid2];
        if (!cell) {
            cell = [[MCMyshoppingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid2];
        }
        
        [cell  prepareHastitleUI];
        [cell.headerimgBtn addTarget:self action:@selector(ActionheaderimgBtn:) forControlEvents:UIControlEventTouchUpInside];

        return cell;

    }
    if (indexPath.section == 2) {
        YJTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid3];
        if (!cell) {
            cell = [[YJTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid3];
        }
        //        cell.selectionStyle =
//        homeYJModel * model= _dataAarray[indexPath.section];
        [cell prepareUI:nil];
        [cell.headerimgBtn addTarget:self action:@selector(ActionheaderimgBtn:) forControlEvents:UIControlEventTouchUpInside];

        return cell;

    }
    
    return [[UITableViewCell alloc]init];
}
#pragma mark-点击头像
-(void)ActionheaderimgBtn:(UIButton*)btn{
    CarteViewController *ctl = [[CarteViewController alloc]init];
    [self pushNewViewController:ctl];
    
    
}



-(void)setUpNavBar{
    
    MCIucencyView * seachView = [[MCIucencyView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width - 100, 30)];
    [seachView setBgViewColor:[UIColor groupTableViewBackgroundColor]];
    ViewRadius(seachView, 3);
    seachView.layer.borderWidth = .5;
    seachView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _searchtext = [[UITextField alloc]initWithFrame:CGRectMake(30, 0, seachView.mj_w - 30, 30)];
    _searchtext.placeholder = @"输入景点搜索";
    _searchtext.textColor  =[UIColor lightGrayColor];
    _searchtext.font = AppFont;
    _searchtext.enabled = NO;
    _searchtext.clearButtonMode = UITextFieldViewModeAlways;
    [seachView addSubview:_searchtext];
    UIButton *_searchBtn = [[UIButton alloc]initWithFrame:_searchtext.bounds];
    [_searchBtn addTarget:self action:@selector(ActionsearchBtn) forControlEvents:UIControlEventTouchUpInside];
    [seachView addSubview:_searchBtn];
    
    UIImageView * imgview = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
    imgview.image = [UIImage imageNamed:@"ic_icon_search2"];
    [seachView addSubview:imgview];
    
    self.navigationItem.titleView = seachView;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(actionrightBtn)];
    CGFloat x = 10;
    CGFloat y = 25;
    CGFloat width = 30;
    CGFloat height = 30;
    
    UIButton * _screenBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    [_screenBtn addTarget:self action:@selector(action_screenBtn) forControlEvents:UIControlEventTouchUpInside];
    [_screenBtn setImage:[UIImage imageNamed:@"home_mine_screened"] forState:0];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_screenBtn];
    
}
-(void)actionrightBtn{
    [self MCscreenhidden];
    WNImagePicker *pickerVC  = [[WNImagePicker alloc]init];

    [self pushNewViewController:pickerVC];

    
    
    MakeBuyViewController * ctl = [[MakeBuyViewController alloc]init];
    
}
-(void)action_screenBtn{
    if (_isShowScree) {
        _isShowScree = NO;
        [_screenview removeFromSuperview];
        
    }
    else
    {
        _isShowScree = YES;
        _screenview = [[MCscreenView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height  - 64)];
        NSDictionary * dic = @{
                               @"like":@"0",
                               @"classify":@"0"
                               };
        
        _screenview.delegate = self;
        [_screenview IsMYBuy:YES DataDic:dic];
        [_screenview showInWindow];

    }
    

}
-(void)MCscreenhidden
{
    _isShowScree = NO;
    [_screenview removeFromSuperview];
 
}
-(void)MCscreenselsctDic:(NSMutableDictionary *)selectDic
{
    [self MCscreenhidden];
    NSLog(@"selectDic ==%@",selectDic);
    
}
#pragma mark-点搜索
-(void)ActionsearchBtn{
    
    [self MCscreenhidden];
    SearchViewController * ctl = [[SearchViewController alloc]init];
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
