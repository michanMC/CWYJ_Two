//
//  ShoppingFillViewController.m
//  MCCWYJ
//
//  Created by MC on 16/6/22.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "ShoppingFillViewController.h"
#import "ShoppingFillTableViewCell.h"
#import "AddressViewController.h"
#import "PaymentViewController.h"
#import "HClActionSheet.h"
#import "PayOfPickModel.h"
@interface ShoppingFillViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,AddressViewSeleDegate>
{
    
    
    UITableView *_tableView;
    
    NSString * _countstr;
    NSInteger _indexcell2;
    NSInteger _indexcell3;
    NSInteger _indexcell4;

    NSString *_addser2Str;
    NSString *_addserid;

    NSInteger timeindex;
    NSInteger  delayHours;

}

@end

@implementation ShoppingFillViewController
-(void)didbackObj{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"填写购买信息";
    //监听数据的刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didbackObj) name:@"didmcbackObjNotification" object:nil];
    timeindex = 0;
    _countstr = [_BuyModlel.lastCount integerValue]?@"1":@"0";
    _indexcell2 = 0;
    _indexcell3 = 0;
    delayHours = 5;
     _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self fooerView];
    // Do any additional setup after loading the view.
}
-(void)fooerView{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 100)];
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(40, 30, Main_Screen_Width - 80, 40)];
    btn.backgroundColor = AppCOLOR;
    [btn setTitle:@"下一步" forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    btn.titleLabel.font = AppFont;
    [view addSubview:btn];
    [btn addTarget:self action:@selector(actionnext) forControlEvents:UIControlEventTouchUpInside];
    _tableView.tableFooterView = view;
    
    
    
}
-(void)actionnext{
    [[self selfText] resignFirstResponder];
    if (!_addser2Str.length) {
        [self showHint:@"请选择地址"];
        return;
    }
    [self showLoading];
    NSString * ss1;
    if(_indexcell2 == 0){
       ss1 = @"因为信，所以买";
    }
    else if (_indexcell2 == 1){
        ss1 = @"多次购买";

    }
    else if (_indexcell2 == 2){
        ss1 = @"铁哥们";
        
    }
    else if (_indexcell2 == 3){
        ss1 = @"朋友推荐不坑爹";
        
    }
    NSInteger ss = 1;
    if(_indexcell3 == 0){
        ss= 0;
    }
    else if (_indexcell3 == 1){
        ss= 1;

    }

    NSLog(@" ==== %@",_BuyModlel.id);
    
//    NSDictionary * dic = @{
//                         @"count":_countstr,
//                         @"address":_addser2Str,
//                         @"payType":@"weixin",
//                         @"reason":ss1,
//                        @"isAnonymous":@(ss),
//                            @"isSpareTime":@(0),
//                            @"delayHours":@(timeindex),
//                             @"buyId":_BuyModlel.id
//                           };
    
    NSMutableDictionary * pamDic = [NSMutableDictionary dictionary];
    
    
    [pamDic setObject:_countstr forKey:@"count"];
    [pamDic setObject:_addser2Str forKey:@"address"];
    [pamDic setObject:@"weixin" forKey:@"payType"];
    [pamDic setObject:ss1 forKey:@"reason"];
    [pamDic setObject:@(ss) forKey:@"isAnonymous"];
   
    [pamDic setObject:_addserid forKey:@"addressId"];

    
    NSUInteger dd = 0;
    if (delayHours == 5) {
        dd = 0;
    }
    else if (delayHours == 0){
        dd = 1;

    }
    else if (delayHours == 2){
        dd = 2;
        
    }
    else if (delayHours == 3){
        dd = 3;
        
    }
    [pamDic setObject:@(_indexcell4) forKey:@"isSpareTime"];
    [pamDic setObject:@(dd) forKey:@"delayHours"];
    [pamDic setObject:_BuyModlel.id forKey:@"buyId"];

    
    [self.requestManager postWithUrl:@"api/buy/addSellOrder.json" refreshCache:NO params:pamDic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
      PayOfPickModel*  _PickModel = [PayOfPickModel mj_objectWithKeyValues:resultDic[@"object"]];

        PaymentViewController * ctl = [[PaymentViewController alloc]init];
        NSDictionary * dics = [_BuyModlel mj_keyValues];
        MCBuyModlel * model = [MCBuyModlel mj_objectWithKeyValues:dics];
        model.id = _PickModel.targetId;
        ctl.BuyModlel = model;
        ctl.typeIndex = @"0";
      CGFloat price =   [_BuyModlel.price floatValue] * [_countstr integerValue];
        NSString * priceStr = [NSString stringWithFormat:@"%.2f",price];
        
        [pamDic setObject:priceStr forKey:@"caidianStr"];
        ctl.datadic = pamDic;
        
        [self pushNewViewController:ctl];
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
    }];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 2;
    }
    if (section == 2) {
        return 4;
    }
    if (section == 3) {
        return 3;
    }

    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return 40;
    }
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 60;
    }
    return 44;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 40)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 40)];
    lbl.textColor = AppTextCOLOR;
    lbl.text = @"购买理由";
    lbl.font = AppFont;
    [view addSubview:lbl];
    return view;
    }
    return [[UIView alloc]init];
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
    cell.BuyModlel = _BuyModlel;
    
    if (indexPath.section == 0) {
        [cell prepareUI1];
        cell.countfield.tag = 200;
        cell.countfield.text = _countstr;
        cell.countfield.delegate = self;
        [cell.addBtn addTarget:self action:@selector(actionAddbtn)  forControlEvents:UIControlEventTouchUpInside];
        [cell.minBtn addTarget:self action:@selector(actionMinbtn)  forControlEvents:UIControlEventTouchUpInside];

        
        return cell;
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.countStr = _countstr;
            CGFloat price =   [_BuyModlel.price floatValue] * [_countstr integerValue];
            NSString * priceStr = [NSString stringWithFormat:@"%.2f",price];
            [cell prepareUI2];
            cell.priceLbl.text =priceStr;

            return cell;

        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [cell prepareUI3];
            cell.addLbl.text = _addser2Str?_addser2Str:@"请选择地址";
            return cell;

        }
    }
    if (indexPath.section == 2) {
        [cell prepareUI4];
        cell.seleBtn.tag = indexPath.row + 300;
        cell.seleBtn.selected = NO;
        cell.seleBtn.userInteractionEnabled = NO;
        if (indexPath.row == 0) {
            cell.titleLbl.text = @"因为信，所以买";
        }
       else if (indexPath.row == 1) {
         cell.titleLbl.text = @"多次购买";
        }
       else if (indexPath.row == 2) {
          cell.titleLbl.text = @"铁哥们";
        }
      else  if (indexPath.row == 3) {
          cell.titleLbl.text = @"朋友推荐不坑爹";
        }
        UIButton * btn = [self.view viewWithTag:_indexcell2 + 300];
        btn.selected = YES;
        return cell;
    }
    if (indexPath.section == 3) {
        if (indexPath.row == 2) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            [cell prepareUI3];
            NSString * ss =@"不延时";
            cell.titleLbl.text = @"延迟时间";

            if (delayHours == 5) {
                ss =@"不延时";
            }
            else
            {
                ss = @[@"1小时",@"2小时",@"3小时"][delayHours];
            }
            cell.addLbl.text = ss;//@"1小时";
//            cell.addLbl.text = @"1小时";

            return cell;

        }
        else
        {
        [cell prepareUI5];
//            cell.seleBtn.tag = indexPath.row + 400;
            cell.seleBtn.userInteractionEnabled = NO;
            
            if (indexPath.row == 0) {
                
                cell.titleLbl.text = @"是否匿名";
                cell.seleBtn.selected = _indexcell3;

            }
            else if (indexPath.row == 1) {
                cell.titleLbl.text = @"否延时显示";
                cell.seleBtn.selected = _indexcell4;

            }
//            UIButton * btn = [self.view viewWithTag:_indexcell3 + 400];
//            
//            btn.selected = YES;

        return cell;
        }
    }


    
    
    
    return [[UITableViewCell alloc]init];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1&&indexPath.row == 1) {
        [[self selfText] resignFirstResponder];
        
        AddressViewController * ctl = [[AddressViewController alloc]init];
        
        ctl.isSele = YES;
        ctl.degate = self;
        [self pushNewViewController:ctl];
        

    }
    else if(indexPath.section == 2){
        _indexcell2 = indexPath.row;
        [_tableView reloadData];

    }
    else if(indexPath.section == 3&&indexPath.row != 2){
        if (indexPath.row == 0) {
            if (_indexcell3==0 ) {
                _indexcell3 = 1;
            }
            else
            {
                _indexcell3 = 0;

            }
        }
        else
        {
            if (_indexcell4==0 ) {
            _indexcell4 = 1;
        }
        else
        {
            _indexcell4 = 0;
            
        }

            
        }
        
        [_tableView reloadData];

    }
    else if(indexPath.section == 3&&indexPath.row == 2){
        
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

    
    
}
-(void)seleAddressModel:(AddressModel *)modle
{
    _addser2Str = [NSString stringWithFormat:@"%@%@%@%@",modle.province?modle.province:@"",modle.city?modle.city:@"",modle.region?modle.region:@"",modle.MCdescription?modle.MCdescription:@"" ];
    _addserid = modle.id;
    
    [_tableView reloadData];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    NSInteger count = [textField.text integerValue];
    if (count > [_BuyModlel.lastCount integerValue]) {
        count = [_BuyModlel.lastCount integerValue];
    }
    if (count <= 0) {
        count = 1;
    }

    _countstr = [NSString stringWithFormat:@"%ld",count];
    
    [self selfText].text =_countstr;

    [_tableView reloadData];
    
}
-(UITextField*)selfText{
    
    UITextField * text = [ self.view viewWithTag:200];
    return text;
    
    
}
-(void)actionAddbtn{
    [[self selfText] resignFirstResponder];
    NSInteger count = [[self selfText].text integerValue];
    count++;
    if (count > [_BuyModlel.lastCount integerValue]) {
        count = [_BuyModlel.lastCount integerValue];
    }
    _countstr = [NSString stringWithFormat:@"%ld",count];
    
    [self selfText].text =_countstr;
    [_tableView reloadData];

}
-(void)actionMinbtn{
    [[self selfText] resignFirstResponder];

    NSInteger count = [[self selfText].text integerValue];
    count--;
    if (count <= 0) {
        count = 1;
    }
    _countstr = [NSString stringWithFormat:@"%ld",count];
    
    [self selfText].text =_countstr;
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
