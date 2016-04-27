//
//  MyzuopinViewController.m
//  CWYouJi
//
//  Created by MC on 15/11/1.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "MyzuopinViewController.h"
#import "HomeTableViewCell.h"
#import "Home2TableViewCell.h"
#import "homeYJModel.h"
#import "NoYJTableViewCell.h"
@interface MyzuopinViewController ()<UITableViewDataSource,UITableViewDelegate>{
    BOOL _isEit;

    UIView * foorview;

    NSMutableArray *_dataArray;
    NSInteger pageStr;
    
    BOOL _isphoto;
    
    
}

@end

@implementation MyzuopinViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _isEit = NO;
        _deleArray = [NSMutableArray array];
       
        _dataArray = [NSMutableArray array];
        pageStr = 1;
      
        
        
    }
    return self;
}
//-(void)setDateMutablearray:(NSMutableArray *)dateMutablearray
//{
//    if (_tableView) {
//        [_tableView reloadData];
//    }
//}
-(void)didshuaxinObj:(NSNotification*)Notification{
    [_dataArray  removeAllObjects];
    [self loadData:NO];
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"MyzuopinView"];

}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"MyzuopinView"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //监听数据的刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didshuaxinObj:) name:@"didzuopingshuaxinObjNotification" object:nil];
     self.view.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - 44 - 64);
   // self.view.backgroundColor = [UIColor yellowColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height- 64 - 44) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView addHeaderWithTarget:self action:@selector(actionHeader)];
    [_tableView addFooterWithTarget:self action:@selector(actionFooter)];
    [self.view addSubview:_tableView];
    [self loadData:YES];
    // Do any additional setup after loading the view.
}
-(void)actionHeader{
    pageStr = 1;
    [_dataArray  removeAllObjects];
    [self loadData:NO];
    
}
-(void)actionFooter{
    
    pageStr ++;
    [self loadData:NO];
    
}
#pragma mark-加载数据
-(void)loadData:(BOOL)iszhuan{
    NSDictionary * Parameterdic = @{
                                    @"page":@(pageStr)
                                    };
    
    
    [self showLoading:iszhuan AndText:nil];
    [self.requestManager requestWebWithParaWithURL:@"api/travel/myTravels.json" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        for (NSDictionary * dic in resultDic[@"object"]) {
            homeYJModel * model = [homeYJModel mj_objectWithKeyValues:dic];
            model.userModel = [YJUserModel mj_objectWithKeyValues:dic[@"user"]];
            
            if (model.photos) {
                for (NSDictionary * photodic in model.photos) {
                    YJphotoModel * photomodel = [YJphotoModel mj_objectWithKeyValues:photodic];
                    [model.YJphotos addObject:photomodel];
                }
            }

            
            
            [_dataArray addObject:model];
        }
        if (_dataArray.count == 0) {
            _isphoto = YES;
        }
        else
        {
            _isphoto = NO;
        }
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];

        [_tableView reloadData];
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];

        [self hideHud];
        [self showAllTextDialog:description];
        
        NSLog(@"失败");
    }];
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_isphoto) {
        return 1;
    }
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isphoto) {
        return Main_Screen_Height - 64 - 44;
    }
    
    return 150;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isphoto) {
        static NSString *cellid2 = @"NoYJTableViewCell";
        NoYJTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid2];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"NoYJTableViewCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLbl.text = @"你暂无制作作品";
        cell.titleLbl.textColor = AppTextCOLOR;
        return cell;
        
    }

    
    
    
    static NSString *cellid1 = @"Home2TableViewCell";
    Home2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
    if (!cell) {
        //cell = [[[NSBundle mainBundle]loadNibNamed:@"Home2TableViewCell" owner:self options:nil]lastObject];
        cell = [[Home2TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid1];
    }
    
    if (_dataArray.count > indexPath.section) {
        homeYJModel * model = _dataArray[indexPath.section];
//        if (_dataArray) {
//            <#statements#>
//        }
        NSLog(@"%@",[CommonUtil daysAgoAgainst:model.createDate]);
        
        
        cell.timeStr =  [CommonUtil daysAgoAgainst:model.createDate];//[CommonUtil getStringWithLong:model.createDate Format:@"MM-dd"];
        NSInteger count = 0;
        
        
        for (NSString * titleif in _dateMutablearray) {
            
            
                if ([model.id isEqualToString:titleif]) {
                    count ++;
                   
                }
            
        }
        if (count) {
             cell.badgeStr = [NSString stringWithFormat:@"%d",count];
            
        }
        else
        {
            cell.badgeStr = @"";//[NSString stringWithFormat:@"%d",count];

        }
        
        
        
        
        
        //title
        if (model.title.length > 9) {//第一行大概9个字
            cell.titleStr = [model.title substringToIndex:9];
            cell.title2Str = [model.title substringFromIndex:9];
            
        }
        else
        {
            cell.titleStr = model.title;
            cell.title2Str = @"";
            
        }
        //photos
        
        if ([model.photos count]) {
           // NSString * str = model.photos[0][@"thumbnail"];
            YJphotoModel * phtotoModel = model.YJphotos[0];
            NSString * str = phtotoModel.thumbnail;
            cell.imgViewStr = str;
        }
        //头像
        if(model.userModel.thumbnail)
        {
            
            cell.headimgStr = model.userModel.thumbnail;
            
            
        }
        //姓名
        if (model.userModel.nickname) {
            cell.nameStr = model.userModel.nickname;
        }
        else
        {
            cell.nameStr = @"游客";
        }
        cell.dingweiStr = model.spotName;
        //游记类型
        //NSLog(@">>>>%@",[self.classifyDic objectForKey:model[@"classify"]]);
        cell.leixingStr  = [self.classifyDic objectForKey:[NSString stringWithFormat:@"%ld",(long)model.classify]];
        
        
        //游记推荐
        BOOL isRecommend = [model.isRecommend boolValue];
        if(!isRecommend){
           cell.tuijianView.image = [UIImage imageNamed:@"踩"];
        }else
        {
            cell.tuijianView.image = [UIImage imageNamed:@"荐"];
            
        }
      //  cell.istuijian = !isRecommend;
        cell.deleteBtn.selected = model.isdelete;
        cell.neirongStr = model.content;
        cell.jlStr = [NSString stringWithFormat:@"%.2fKm",[model.distance floatValue]/1000];


    
    }
    
    
    cell.isEit = _isEit;
    cell.deleteBtn.tag = indexPath.section + 200;
    [cell.deleteBtn addTarget:self action:@selector(actionCellBtn:) forControlEvents:UIControlEventTouchUpInside];
    

    
//    if (_isquanxuan) {//全选
//        cell.deleteBtn.selected = YES;
//        
//        
//        
//        
//    }
//    else
//    {
//        if ([_deleArray containsObject:@(cell.deleteBtn.tag)]) {
//            cell.deleteBtn.selected = YES;
//        }
//        else
//        {
//            cell.deleteBtn.selected = NO;
//        }
//  
//        
//    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
//    [UIView animateWithDuration:0.25 animations:^{
//        
        cell.contentView.frame = CGRectMake(-50, cell.contentView.frame.origin.y, cell.contentView.frame.size.width, cell.contentView.frame.size.height);
   // }];
    //cell.contentView.frame = CGRectMake(-50, cell.contentView.frame.origin.y, cell.contentView.frame.size.width, cell.contentView.frame.size.height);
    //    cell.titleLbl1.textColor = AppTextCOLOR;
    //    cell.title2Lb.textColor = AppTextCOLOR;
    //    cell.dingweiimg.textColor = [UIColor grayColor];
    //    cell.nameLbl.textColor = [UIColor grayColor];
    //    ViewRadius(cell.headImg, 20);
    return cell;

//    static NSString *cellid1 = @"HomeTableViewCell";
//    HomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
//    if (!cell) {
//        cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeTableViewCell" owner:self options:nil]lastObject];
//    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.backgroundColor = [UIColor clearColor];
//    cell.titleLbl1.textColor = AppTextCOLOR;
//    cell.title2Lb.textColor = AppTextCOLOR;
//    cell.dingweiimg.textColor = [UIColor grayColor];
//    cell.nameLbl.textColor = [UIColor grayColor];
//    ViewRadius(cell.headImg, 20);
//    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isphoto) {
        return;
        
    }
    
    if (!_isEit) {
    
    homeYJModel * model = _dataArray[indexPath.section];

    NSDictionary * dic = @{
        @"model":model,
        @"index":@(indexPath.section),
        @"dataarray":_dataArray
    };
        
        
        
    
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectzuopinNotification" object:dic];
    }
    
    
}



#pragma mark-点击编辑
-(void)actionBianji{
    
    if (_isEit) {
        _isEit = NO;
        [foorview removeFromSuperview];
        _tableView.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - 64 - 44);
    }
    else
    {
        _isEit = YES;
        [self addfoorView];
        _tableView.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - 64 - 44 - 40);
        
    }
    [_tableView reloadData];
    
    
    
}
-(void)addfoorView{
    foorview = [[UIView alloc]initWithFrame:CGRectMake(0,Main_Screen_Height - 64 - 44 - 40 , Main_Screen_Width, 40)];
    UIView*lineView = [[UIView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height - 64 - 44 - 40, Main_Screen_Width, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [foorview addSubview:lineView];
    foorview.backgroundColor = [UIColor whiteColor];
    
    UIButton * delebtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 2.5, 35, 35)];
    [delebtn setImage:[UIImage imageNamed:@"list_checkbox_normal"] forState:UIControlStateNormal];
    [delebtn setImage:[UIImage imageNamed:@"list_checkbox_checked"] forState:UIControlStateSelected];
    delebtn.tag =  300;
    [delebtn addTarget:self action:@selector(quanxuanBtn:) forControlEvents:UIControlEventTouchUpInside];
    [foorview addSubview:delebtn];
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 30, 40)];
    lbl.text = @"全选";
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:15];
    [foorview addSubview:lbl];
    _deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width - 100, 0,100 , 40)];
    [_deleteBtn setTitleColor:[UIColor whiteColor] forState:0];
    [_deleteBtn setTitle:@"删除(0)" forState:0];
    [_deleteBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
        NSLog(@">>>>>%@",_deleArray);
        if (!_deleArray.count) {
            [self showAllTextDialog:@"请选择你要删除的作品"];
            return ;
        }
        
        NSMutableArray *travelIdarray = [NSMutableArray array];
        for (int i = 200; i < _dataArray.count + 200; i++) {
            if ([_deleArray containsObject:@(i)]) {
                homeYJModel * model = _dataArray[i-200];
                
                [travelIdarray addObject:model.id];
                
            }
            
        }

        
        
        
        
        NSString * travelIds = [travelIdarray componentsJoinedByString:@","];
        [self deletedata:travelIds];
    
        
    }];

    _deleteBtn.backgroundColor =[UIColor orangeColor];
    [foorview addSubview:_deleteBtn];
    [self.view addSubview:foorview];
    
    
    
}
-(void)deletedata:(NSString*)travelIds{
    
    NSDictionary * Parameterdic = @{
                                    @"travelIds":travelIds
                                    };
    
    
    [self showLoading:YES AndText:nil];
    [self.requestManager requestWebWithParaWithURL:@"api/travel/delete.json" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        [_dataArray removeAllObjects];
        [self showAllTextDialog:@"删除成功"];
        [self loadData:YES];
        [_deleArray removeAllObjects];
        [_deleteBtn setTitle:@"删除(0)" forState:0];

        //发送通知首页刷新
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dishuaxinObjNotification" object:@""];
        
        
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dishoucangshuaxinObjNotification" object:@""];
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
        
        NSLog(@"失败");
    }];

    
    
    
}
-(void)actionCellBtn:(UIButton*)btn{
    
    
    homeYJModel * homeModel =  _dataArray[btn.tag - 200];

    
    if ([_deleArray containsObject:@(btn.tag)]) {
        [_deleArray removeObject:@(btn.tag)];
        homeModel.isdelete = NO;

    }
    else{
        [_deleArray addObject:@(btn.tag)];
        homeModel.isdelete = YES;

    }
    
    //200

    
    [_deleteBtn setTitle:[NSString stringWithFormat:@"删除(%ld)",(unsigned long)_deleArray.count] forState:0];
    
    UIButton * quanxuanbtn = (UIButton*)[self.view viewWithTag:300];
    if (_dataArray.count == _deleArray.count ) {
        quanxuanbtn.selected = YES;
    }
    else
    {
        quanxuanbtn.selected = NO;

    }
    [_tableView reloadData];
    
    
    
    
}
-(void)quanxuanBtn:(UIButton*)btn{
    
    if (btn.selected) {
        btn.selected = NO;
         [_deleArray removeAllObjects];
        for (homeYJModel * model in _dataArray) {
            model.isdelete = NO;
        }
    [_deleteBtn setTitle:[NSString stringWithFormat:@"删除(%ld)",(unsigned long)_deleArray.count] forState:0];
    }
    else
    {
        
        btn.selected = YES;
        
        [_deleArray removeAllObjects];
        
    [_deleteBtn setTitle:[NSString stringWithFormat:@"删除(%d)",_dataArray.count] forState:0];
        for (int i = 0; i < _dataArray.count; i++) {
            homeYJModel * model = _dataArray[i];
            model.isdelete = YES;
            [_deleArray addObject:@(200+ i)];
        }
       
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
