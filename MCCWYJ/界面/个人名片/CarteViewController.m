//
//  CarteViewController.m
//  MCCWYJ
//
//  Created by MC on 16/5/23.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "CarteViewController.h"
#import "ItemView.h"
#import "CarteTableViewCell.h"
@interface CarteViewController ()<UITableViewDataSource,UITableViewDelegate,ItemViewDelegate>
{
    UITableView *_tableView;
    UIButton * _headBtn;
    UILabel *_nameLbl;
    UILabel * _IdLbl;
    UIImageView * _biaozhiimg;
    UIImageView * _headerView;
    ItemView*_itemView;

    
    
}

@end

@implementation CarteViewController
-(void)actionnav_popup{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"好友名片";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_popup"] style:UIBarButtonItemStylePlain target:self action:@selector(actionnav_popup)];
    [self prepareUI];
    
    
    // Do any additional setup after loading the view.
}
-(void)prepareUI{
    
     _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [self prepareheadView];
    [self prepareFooerView];
}
-(void)prepareheadView{
    
    _headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 250*MCHeightScale)];
    //    view.backgroundColor = [UIColor redColor];
    _headerView.image = [UIImage imageNamed:@"mine_Background"];
    _headerView.userInteractionEnabled = YES;
    _tableView.tableHeaderView = _headerView;
    
    
    
    CGFloat w = 80*MCWidthScale;
    
    CGFloat x = (Main_Screen_Width- w)/2;
    
    CGFloat h = w;
    CGFloat y = 60;
    
    _headBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    ViewRadius(_headBtn, w/2);
    _headBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    _headBtn.layer.borderWidth = 2;
//    [_headBtn addTarget:self action:@selector(actionHeadbtn) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:_headBtn];
    
    [_headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[MCUserDefaults objectForKey:@"thumbnail"]] forState:0 placeholderImage:[UIImage imageNamed:@"home_Avatar_146"]];
    //
    
    y +=h + 20;
    w = Main_Screen_Width;
    h = 20;
    w =  [MCIucencyView heightforString:[MCUserDefaults objectForKey:@"nickname"] andHeight:20 fontSize:16];
    
    x = (Main_Screen_Width-w)/2;
    _nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _nameLbl.text = [MCUserDefaults objectForKey:@"nickname"];
    _nameLbl.textColor = [UIColor whiteColor];
    _nameLbl.font = [UIFont systemFontOfSize:16];
    [_headerView addSubview:_nameLbl];
    
    _biaozhiimg = [[UIImageView alloc]init];
    _biaozhiimg.image = [UIImage imageNamed:@"Lv1"];
    [self updateBiaozhiLbl];
    [_headerView addSubview:_biaozhiimg];
    
    
    y +=h + 10;
    _IdLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, y, Main_Screen_Width, 20)];
    _IdLbl.textColor = [UIColor whiteColor];
    _IdLbl.font = [UIFont systemFontOfSize:13];
    _IdLbl.textAlignment = NSTextAlignmentCenter;
    _IdLbl.text = @"ID:12345532";
    [_headerView addSubview:_IdLbl];
    
    
    x = 0;
    y += 20 + 10;
    w = Main_Screen_Width;
    h = 250*MCHeightScale - y;
    _itemView = [[ItemView alloc] initWithFrame:CGRectMake(x, y, Main_Screen_Width , 100)];
    _itemView.delegate = self;
    _itemView.itemHeith = 25;
    
    _itemView.itemArray = @[@"优秀",@"喷雾剂",@"旷代",@"买了"];

    [_headerView addSubview:_itemView];

    
    
    
}

-(void)prepareFooerView{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 100)];
    _tableView.tableFooterView = view;
    
    
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(40, 50, Main_Screen_Width - 80, 35)];
    btn.backgroundColor = AppCOLOR;
    if (_isfriend) {
        [btn setTitle:@"发送消息" forState:0];

    }
    else
        [btn setTitle:@"加好友" forState:0];

    ViewRadius(btn, 5);
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    [view addSubview:btn];
    
    
    
}


#pragma mark-_itemView代理
-(void)itemH:(CGFloat)itemh
{
    _itemView.frame = CGRectMake(CGRectGetMinX(_itemView.frame), CGRectGetMinY(_itemView.frame), CGRectGetWidth(_itemView.frame), itemh + 10);
   CGFloat  h = 250*MCHeightScale - _itemView.mj_y;
    
    if (itemh + 10 > h) {
        
        CGFloat h2 = itemh + 10 - h;
        
        _headerView.frame = CGRectMake(_headerView.mj_x, _headerView.mj_y, _headerView.mj_w, _headerView.mj_h + h2);
        
        _tableView.tableHeaderView = _headerView;

    }
}

-(void)updateBiaozhiLbl{
    _biaozhiimg.frame  =CGRectMake(_nameLbl.mj_x -35 , _nameLbl.mj_y + 1.5, 30, 17);
    
    
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isfriend) {
        return 4;
    }
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_isfriend) {
        if (indexPath.row == 3) {
            return 44;
        }
    }
    else
    {
        if (indexPath.row == 1) {
            return 44;
        }

        
    }
    
    CGFloat h = 50;
    
    return h + 20;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_isfriend) {
        if (indexPath.row == 3) {
            static  NSString * cellid1 = @"CarteTableViewCell";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid1];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.textColor = AppTextCOLOR;
            cell.textLabel.text = @"足迹地图";
            return cell;

        
        
        }
    }
    else
    {
        if (indexPath.row == 1) {

            static  NSString * cellid2 = @"CarteTableViewCell";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid2];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid2];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.textColor = AppTextCOLOR;
            cell.textLabel.text = @"足迹地图";
            return cell;

        }
        
        
    }

    
    
    
    static  NSString * cellid = @"CarteTableViewCell";
    CarteTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[CarteTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell prepareUI:@"代购单"];
    return cell;
    return [[UITableViewCell alloc]init];
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
