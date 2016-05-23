//
//  MCscreenView.m
//  MCCWYJ
//
//  Created by MC on 16/5/23.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MCscreenView.h"
#import "AppDelegate.h"
#import "MCscreenTableViewCell.h"

@interface MCscreenView ()<UITableViewDelegate,UITableViewDataSource,MCscreenTableViewCellDelegate>{
    
    UITableView * _tableView;
    
    
    MCIucencyView *_bgView;
    
    
    BOOL _isMYBuy;
    NSDictionary *_dataDic;
    
    NSString * _likeStr;
    NSString * _classify;
    
    NSString *_distanceStr;
    
    
    
    NSArray * _likearray;
    NSArray * _buyclassarray;
    
    
    NSArray * _Nobuyclassarray;
    NSArray * _distancearray;

    NSMutableDictionary *_selectDic;
    

}

@end


@implementation MCscreenView
-(instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _likearray = @[@"全部",@"推荐",@"不推荐"];
        _buyclassarray = @[@"全部",@"晒",@"求",@"售"];
        
        
        _Nobuyclassarray = @[@"全部",@"食",@"住",@"景",@"购"];
        _distancearray = @[@"不限",@"5公里",@"10公里",@"50公里",@"100公里"];
        _selectDic = [NSMutableDictionary dictionary];
       
        [_selectDic setObject:@"0" forKey:@"like"];
        [_selectDic setObject:@"0" forKey:@"classify"];
        [_selectDic setObject:@"0" forKey:@"distance"];

        
        _bgView = [[MCIucencyView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, frame.size.height)];
        [_bgView setBgViewColor:[UIColor blackColor]];
        [_bgView setBgViewAlpha:.5];
        [self addSubview:_bgView];
        
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, frame.size.height)];
        _tableView.bounces = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_bgView addSubview:_tableView];
        
        [self prepareFooerView];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actiontap:)];
        
        [_tableView addGestureRecognizer:tap];
        
    }
    
    return self;
    
}
-(void)actiontap:(UITapGestureRecognizer*)tap{
    if (_delegate) {
        [_delegate MCscreenhidden];
    }
   // [self removeFromSuperview];
    
}

-(void)IsMYBuy:(BOOL)isMYBuy DataDic:(NSDictionary*)dic{
    
    _isMYBuy = isMYBuy;
    _dataDic = dic;
    
    [_tableView reloadData];
    
}


-(void)prepareFooerView{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 44)];
    view.backgroundColor = [UIColor whiteColor];
    UIView * lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 0.5)];
    lineview.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:lineview];
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, .5, Main_Screen_Width, 43.5)];
    [btn setTitleColor:RGBCOLOR(127, 125, 147) forState:0];
    [btn setTitle:@"确定" forState:0];
    [view addSubview:btn];
    [btn addTarget:self action:@selector(actionBtn) forControlEvents:UIControlEventTouchUpInside];
    _tableView.tableFooterView = view;
    
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_isMYBuy) {
        return 2;
    }
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 30)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel * titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 30)];
    titleLbl.textColor = [UIColor lightGrayColor];
    titleLbl.font = AppFont;
    [view addSubview:titleLbl];
    if (section == 0) {
        titleLbl.text = @"喜好";
    }
    else if (section == 1)
        titleLbl.text = @"分类";
    else if (section == 2)
        titleLbl.text = @"距离";


    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSArray * array = [NSArray array];
    if (_isMYBuy) {
        if (indexPath.section == 0) {
            array = _likearray;
        }
        else
            array = _buyclassarray;
    }
    else
    {
        if (indexPath.section == 0)
            array = _likearray;
        else if(indexPath.section == 1)
            array = _Nobuyclassarray;
        else
            array = _distancearray;
 
    }
    
    CGFloat btnx = 10;
    CGFloat btnoffx = 10;
    CGFloat btny = 5;
    CGFloat btnw = (Main_Screen_Width - 50) / 4;
    CGFloat btnh = 25;
    
    for (NSInteger  i = 0; i < array.count; i ++) {
        btnx += btnw + btnoffx;
        if (i == 3) {
            btnx = 10;
            btny += btnh + 10;
        }
    }
    if (array.count == 4) {
     return   btny  + 15;
    }
    return  btny + btnh + 15;

    
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellid = @"MCscreenTableViewCell";
    MCscreenTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[MCscreenTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid
                ];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.delegate = self;
    if (_isMYBuy) {
        if (indexPath.section == 0) {
            [cell prepareUI:_likearray Datadic:_likeStr?_likeStr:@"0" Tabindex:400];
            return cell;
        }
        if (indexPath.section == 1) {
            [cell prepareUI:_buyclassarray Datadic:_classify?_classify:@"0" Tabindex:500];
            return cell;
        }
    }
    else
    {
        if (indexPath.section == 0) {
            [cell prepareUI:_likearray Datadic:_likeStr?_likeStr:@"0" Tabindex:600];
            return cell;
        }
        if (indexPath.section == 1) {
            [cell prepareUI:_Nobuyclassarray Datadic:_classify?_classify:@"0" Tabindex:700];
            return cell;
        }
        if (indexPath.section == 2) {
            [cell prepareUI:_distancearray Datadic:_distanceStr?_distanceStr:@"0" Tabindex:800];
            return cell;
        }
    }
    
    return cell;
    
    return [[UITableViewCell alloc]init];
    
    
    
}
-(void)selsctTabinde:(NSInteger)tabindex SeleStr:(NSString *)selectStr
{
    if (_isMYBuy) {
        if (tabindex == 400) {
            _likeStr = selectStr;
            [_selectDic setObject:selectStr forKey:@"like"];

        }
        else if (tabindex == 500){
            _classify = selectStr;
            [_selectDic setObject:selectStr forKey:@"classify"];


        }
    }
    else
    {
        if (tabindex == 600) {
            _likeStr = selectStr;
            [_selectDic setObject:selectStr forKey:@"like"];
            
        }
        else if (tabindex == 700){
            _classify = selectStr;
            [_selectDic setObject:selectStr forKey:@"classify"];
            
            
        }
        else if (tabindex == 800){
            _distanceStr = selectStr;
            [_selectDic setObject:selectStr forKey:@"distance"];
            
            
        }

  
        
    }
    
    [_tableView reloadData];
}
-(void)actionBtn{
    
    if (_delegate) {
        
        [_delegate MCscreenselsctDic:_selectDic];
    }

    
    return;
    
}
- (void)showInWindow{
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app.window addSubview:self];
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
