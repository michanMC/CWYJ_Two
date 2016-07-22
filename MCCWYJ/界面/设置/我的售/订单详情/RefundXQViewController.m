//
//  RefundXQViewController.m
//  MCCWYJ
//
//  Created by MC on 16/7/15.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "RefundXQViewController.h"
#import "RefundXQTableViewCell.h"
#import "MCBuyModlel.h"
#import "RefundXQModel.h"
#import "HZPhotoBrowser.h"
@interface RefundXQViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,RefundXQDelegate,HZPhotoBrowserDelegate>
{
    
    RefundXQModel * _XQModel;
    UITableView *_tableView;
    UIView *toobView;
    
    
    
}

@end

@implementation RefundXQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"退款详情";
    self.view.backgroundColor = AppMCBgCOLOR;
    
    
     _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = AppMCBgCOLOR;
    [self.view addSubview:_tableView];
    [self loadData];
    
    // Do any additional setup after loading the view.
}
-(void)preparetoobView{
    
    toobView= [[UIView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height - 50, Main_Screen_Width, 50)];
    toobView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:toobView];
    CGFloat w = [MCIucencyView heightforString:@"取消退款" andHeight:30 fontSize:14] + 10;
    CGFloat y = 10;
    
    CGFloat x = Main_Screen_Width - w - 10;
    CGFloat h = 30;
    
  UIButton *  _typeBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    
    [_typeBtn setTitleColor:RGBCOLOR(207, 0, 51) forState:0];
    [_typeBtn setTitle:@"取消退款" forState:0];
    _typeBtn.titleLabel.font = AppFont;
    ViewRadius(_typeBtn, 3);
    
    _typeBtn.layer.borderColor = RGBCOLOR(207, 0, 51).CGColor;
    _typeBtn.layer.borderWidth = 1;
    [_typeBtn addTarget:self action:@selector(actiontypeBtn) forControlEvents:UIControlEventTouchUpInside];
    [toobView addSubview:_typeBtn];

    
    
    
}
-(void)actiontypeBtn
{
        UIAlertView * al = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"确定要取消退款？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        al.tag = 9000;
        
        [al show];
        
        
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 9000) {
        if (buttonIndex == 0) {
            
            [self showLoading];
            NSDictionary * dic = @{
                                   @"orderNumber":_orderNumber
                                   
                                   };
            [self.requestManager postWithUrl:@"api/refund/cancelRefund.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
                [self stopshowLoading];
                [self loadData];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"didPurchaseViewObjNotification" object:@""];
                    //发送通知
                   // [self.navigationController popViewControllerAnimated:YES];
                });
                
                
            } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
                [self stopshowLoading];
                [self showAllTextDialog:description];
            }];
            
            
        }
    }

    
}
-(void)loadData{
    if (!_orderNumber.length) {
        [self showHint:@"无效ID"];
        return;
    }
        [self showLoading];
    NSDictionary * dic = @{
                           @"orderNumber":_orderNumber
                           };
    [self.requestManager postWithUrl:@"api/refund/getRefundDetail.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
        
        NSDictionary * dic = resultDic[@"object"];
        
       
        _XQModel = [RefundXQModel mj_objectWithKeyValues:dic];
        
        _XQModel.MCdescription = dic[@"description"];
        _XQModel.BuyModlel = [MCBuyModlel mj_objectWithKeyValues:_XQModel.buy];
        
        
        
        NSString * imageUrl = dic[@"buy"][@"imageUrl"];
        id result = [self analysis:imageUrl];
        if ([result isKindOfClass:[NSArray class]]) {
            _XQModel.BuyModlel.imageUrl = result;
        }
        for (NSString * url in _XQModel.BuyModlel.imageUrl) {
            YJphotoModel*   photoModel =[[YJphotoModel alloc]init];
            photoModel.raw = url;
            [_XQModel.BuyModlel.YJphotos addObject:photoModel];
            
        }
        
        NSString * imageUrl2 = dic[@"imageUrl"];
        id result2 = [self analysis:imageUrl2];

        if ([result2 isKindOfClass:[NSArray class]]) {
            for (NSString * url in result2) {
                YJphotoModel*   photoModel =[[YJphotoModel alloc]init];
                photoModel.raw = url;
            [_XQModel.imgArray addObject:photoModel];
                
            }
        }

        
        
        if ([_XQModel.status isEqualToString:@"3"]) {
            _tableView.frame = CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64 - 50);
            if (toobView) {
                [toobView removeFromSuperview];
                toobView = nil;
            }
            [self preparetoobView];
            
        }
        else
        {
            _tableView.frame = CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64 );
  
            if (toobView) {
                [toobView removeFromSuperview];
                toobView = nil;
            }
        }
        
        
        
        [_tableView reloadData];
        
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
    }];

    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 40;
    }
    return 10;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
      
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 40)];
        view.backgroundColor = AppMCBgCOLOR;
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 5, 20)];
        lineView.backgroundColor = AppRegTextCOLOR;
        [view addSubview:lineView];
        UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(10 + 5 + 5, 0, 100, 40)];
        lbl.text = @"退款信息";
        lbl.textColor = AppTextCOLOR;
        lbl.font = [ UIFont systemFontOfSize:16];
        [view addSubview:lbl];
        return view;
        
        
    }
    
    
    
    return [[UIView alloc]init];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 150;
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0 ||indexPath.row == 1 ||indexPath.row == 4  ) {
            return 44;
        }
        if (indexPath.row == 2) {
            NSString * str = _XQModel.MCdescription;
            CGFloat w =Main_Screen_Width -( 10 + 70 + 5 + 10);
           CGFloat h = [MCIucencyView heightforString:str andWidth:w fontSize:15];
            if (h < 30) {
                h = 44 + 10;
            }
            else
            {
               
                
                h+= 10;
            }
            return h;
        }
        if (indexPath.row == 3) {
            
            CGFloat w =Main_Screen_Width -( 10 + 70 + 5 + 10);
            CGFloat h = (w - 30)/3;
            return h + 20;
            
            
        }
    }
    return 44;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellid = @"RefundXQTableViewCell";
    RefundXQTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[RefundXQTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.XQModel = _XQModel;

    if (indexPath.section == 0) {
        [cell preparebuyUI];
        return cell;
    }
    if (indexPath.section == 1) {
        [cell preparebuyUI2];
        cell.imgBgView.hidden = YES;
        cell.delegate = self;
        if (indexPath.row == 0) {
            cell.titleLbl.text = @"退款原因:";
            cell.titlesubLbl.text = _XQModel.reason;
            return cell;
        }
        if (indexPath.row == 1) {
            cell.titleLbl.text = @"退款金额:";
            cell.titlesubLbl.text = [NSString stringWithFormat:@"￥%@",_XQModel.price];
            return cell;
        }
        if (indexPath.row == 2) {
            cell.titleLbl.text = @"退款说明:";
            cell.titlesubLbl.text = _XQModel.MCdescription;
            return cell;
        }
        if (indexPath.row == 3) {
            cell.titleLbl.text = @"上传图片:";
//            cell.titlesubLbl.text = _XQModel.MCdescription;
            cell.imgBgView.hidden = NO;

            return cell;
        }
        if (indexPath.row == 4) {
            cell.titleLbl.text = @"退款状态:";
            NSString * ss = @"不明状态";
            //    0 不同意退款
            //    1 同意退款
            //    2 买家取消退款
            //    3 退款中
            if ([_XQModel.status isEqualToString:@"0"]) {
                ss = @"不同意退款";
            }
            else if ([_XQModel.status isEqualToString:@"1"]) {
                ss = @"同意退款";
            }
            else if ([_XQModel.status isEqualToString:@"2"]) {
                ss = @"买家取消退款";
            }
            else if ([_XQModel.status isEqualToString:@"3"]) {
                ss = @"退款中";
            }

            cell.titlesubLbl.text =ss;// _XQModel.MCdescription;
            return cell;
        }
    }

    
    
    return [[UITableViewCell alloc]init];
}
-(void)showimgindex:(NSInteger)index
{
    //启动图片浏览器
    HZPhotoBrowser *browserVc = [[HZPhotoBrowser alloc] init];
    browserVc.sourceImagesContainerView = self.view; // 原图的父控件
    browserVc.isNOJubao = YES;
    homeYJModel * model1 =[[homeYJModel alloc]init];// _dataArray[_index];

    model1.YJphotos =_XQModel.imgArray;
    
    browserVc.model =model1;
    browserVc.imageCount = model1.YJphotos.count; // 图片总数
    browserVc.currentImageIndex =(int)index;
    browserVc.delegate = self;
    [browserVc show];
}
#pragma mark - photobrowser代理方法
- (UIImage *)photoBrowser:(HZPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return [UIImage imageNamed:@"home_banner_default-chart"];
}

- (NSURL *)photoBrowser:(HZPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    
    homeYJModel * model =[[homeYJModel alloc]init];// _dataArray[_index];
    
    model.YJphotos =_XQModel.imgArray;
    
    
    if (model.YJphotos.count) {
        YJphotoModel * photoModel = model.YJphotos[index];
        NSString * imgurl = photoModel.raw;//[NSString stringWithFormat:@"%@%@",];
        
        return [NSURL URLWithString:[NSString stringWithFormat:@"%@",imgurl]];
    }
    return [NSURL URLWithString:@""];
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
