//
//  ShoppingManViewController.m
//  MCCWYJ
//
//  Created by MC on 16/6/24.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "ShoppingManViewController.h"
#import "ShoppingManTableViewCell.h"
#import "ShoppingManModel.h"
#import "MCLogisticsViewController.h"
#import "HZPhotoBrowser.h"

@interface ShoppingManViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,ShoppingManDelegate,HZPhotoBrowserDelegate>
{
    UITableView *_tableView;
    NSMutableArray * _dataArray;
    NSInteger _pageStr;
    BOOL _isNoData;
    ShoppingManModel * _seleModel;
    ShoppingManModel * _seleimgModel;

    
    
    
    
}

@end

@implementation ShoppingManViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购买的人";
    
    //监听数据的刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RefreshHeader) name:@"ShoppingManView" object:nil];
    _pageStr = 1;

    _dataArray = [NSMutableArray array];
     _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = AppMCBgCOLOR;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(RefreshHeader)];
    _tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(RefreshFooter)];

    [self loadData];
    
    // Do any additional setup after loading the view.
}
-(void)RefreshHeader{
    _pageStr = 1;
    [_dataArray removeAllObjects];
    [self loadData];
    
    
}
-(void)RefreshFooter{
    _pageStr ++;
    [self loadData];
    
    
}

-(void)loadData{
        [self showLoading];
    NSDictionary * dic = @{
                         @"buyId":_BuyModlel.id,
                         @"pageNumber":@(_pageStr),
                         @"pageSize":@(10)
                           };
    [self.requestManager postWithUrl:@"api/buy/getBuyerList.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
        for (NSDictionary * dic in resultDic[@"object"]) {
            ShoppingManModel * modle = [ShoppingManModel mj_objectWithKeyValues:dic];
            
            NSString * imageUrl = modle.imageUrls;
            id result = [self analysis:imageUrl];
            if ([result isKindOfClass:[NSArray class]]) {
                for (NSString * url in result) {
                    YJphotoModel*   photoModel =[[YJphotoModel alloc]init];
                    photoModel.raw = url;
                    [modle.YJphotos addObject:photoModel];
                    
                }
            }
        [_dataArray addObject:modle];
        }
        if (_dataArray.count) {
            _isNoData = NO;
        }
        else
        {
            _isNoData = YES;
            
        }
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];

        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        [self stopshowLoading];
        
        [self showHint:description];
        
        if (_dataArray.count) {
            _isNoData = NO;
            [_tableView  reloadData];
            
        }
        else
        {
            _isNoData = YES;
            [_tableView  reloadData];
            
        }
        
    }];

    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_dataArray.count > section) {
        ShoppingManModel* model = _dataArray[section];
        // 订单状态 未发货：0,     已发货：1,    已完成：2,    已关闭：3,退款成功：4，退款中：5
        
        
        if ([model.status isEqualToString:@"0"]) {
            
            return 3;
            
        }
        if ([model.status isEqualToString:@"1"]) {
            if (model.courierCompany.length) {
                return 4;
            }
            else
            return 3;
            
        }
        if ([model.status isEqualToString:@"2"]) {
            return 3;
            
            
        }
        if ([model.status isEqualToString:@"3"]) {
            return 3;
            
        }
        if ([model.status isEqualToString:@"4"]) {
            return 3;
            
        }
        if ([model.status isEqualToString:@"5"]) {
            if (model.courierCompany.length) {

            return 5;
            }
            else
            {
                return 4;
            }
        }
        
    }
        

    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_dataArray.count > indexPath.section) {
        ShoppingManModel* model = _dataArray[indexPath.section];
        // 订单状态 未发货：0,     已发货：1,    已完成：2,    已关闭：3,退款成功：4，退款中：5
        if (indexPath.row == 0) {
            return 60;
        }
        if (indexPath.row == 1) {
            return 80;
        }

        if ([model.status isEqualToString:@"0"]) {
            
            if (indexPath.row == 2) {
                return 50;
            }
        }
        
        
        if ([model.status isEqualToString:@"1"]) {
            
            if (!model.courierCompany.length) {
                if (indexPath.row == 2) {
                    return 50;
                }
            }
            else{
            if (indexPath.row == 2) {
                return 80;
            }

            
            if (indexPath.row == 3) {
                return 50;
            }
            }
        }
        
        
        if ([model.status isEqualToString:@"2"]) {
            if (indexPath.row == 2) {
                return 50;
            }
            
        }
        if ([model.status isEqualToString:@"3"]) {
            if (indexPath.row == 2) {
                return 50;
            }
            
        }
        if ([model.status isEqualToString:@"4"]) {
            if (indexPath.row == 2) {
                return 50;
            }
            
        }
        if ([model.status isEqualToString:@"5"]) {
            
            if (model.courierCompany.length) {
    
            if (indexPath.row == 2) {
                return 80;
            }
            if (indexPath.row == 3) {
                NSString * ss =model.refundMessage;// @"退款说明: 今天收到货了，发现收到的商品与描述不符，希望卖家能同意退款，谢谢啦";
                CGFloat x = 10 + 35 + 10;
                CGFloat  w = Main_Screen_Width - x - 10;
                CGFloat h1 = [MCIucencyView heightforString:ss andWidth:w fontSize:14];
                if (h1 < 20) {
                    h1 = 20;
                }
                
                
                w = [MCIucencyView heightforString:@"上传图片:" andHeight:20 fontSize:14];
                x += w + 5;
                w = (Main_Screen_Width -x - 5 * 3)/3;
                
                return 5 + 20 + 5 + h1 + 5 + 20 +10 +(w + 10);
                
                
            }

            if (indexPath.row == 4) {
                return 50;
            }

            }
            else
            {
                
                if (indexPath.row == 2) {
                    NSString * ss =model.refundMessage;// @"退款说明: 今天收到货了，发现收到的商品与描述不符，希望卖家能同意退款，谢谢啦";
                    CGFloat x = 10 + 35 + 10;
                    CGFloat  w = Main_Screen_Width - x - 10;
                    CGFloat h1 = [MCIucencyView heightforString:ss andWidth:w fontSize:14];
                    if (h1 < 20) {
                        h1 = 20;
                    }
                    
                    
                    w = [MCIucencyView heightforString:@"上传图片:" andHeight:20 fontSize:14];
                    x += w + 5;
                    w = (Main_Screen_Width -x - 5 * 3)/3;
                    
                    return 5 + 20 + 5 + h1 + 5 + 20 +10 +(w + 10);
                    
                    
                }
                
                if (indexPath.row == 3) {
                    return 50;
                }
 
                
            }
        }




/*
        
        
        
    
    
    if (indexPath.row == 2) {
        return 80;
    }
    if (indexPath.row == 3) {
        NSString * ss =model.refundMessage;// @"退款说明: 今天收到货了，发现收到的商品与描述不符，希望卖家能同意退款，谢谢啦";
        CGFloat x = 10 + 35 + 10;
      CGFloat  w = Main_Screen_Width - x - 10;
        CGFloat h1 = [MCIucencyView heightforString:ss andWidth:w fontSize:14];
        if (h1 < 20) {
            h1 = 20;
        }

        
        w = [MCIucencyView heightforString:@"上传图片:" andHeight:20 fontSize:14];
        x += w + 5;
        w = (Main_Screen_Width -x - 5 * 3)/3;

        return 5 + 20 + 5 + h1 + 5 + 20 +10 +(w + 10);
        
        
    }
 
*/
    }
    return 50;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellid =@"ShoppingManTableViewCell";
    ShoppingManTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell ) {
        cell = [[ShoppingManTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.selectionStyle =
    UITableViewCellSelectionStyleNone;
    if (_dataArray.count > indexPath.section) {
        ShoppingManModel* model = _dataArray[indexPath.section];
        cell.ShoppingModel = model;
        cell.delegate = self;
        if (indexPath.row == 0) {
            [cell prepareUI1];
        }
        else if (indexPath.row == 1) {
            [cell prepareUI2];
        }

        // 订单状态 未发货：0,     已发货：1,    已完成：2,    已关闭：3,退款成功：4，退款中：5
        if ([model.status isEqualToString:@"0"]) {
           
            if (indexPath.row == 2) {
                [cell prepareUI3];

            }
        }
        
        if ([model.status isEqualToString:@"1"]) {
            
            if (!model.courierCompany.length) {
                if (indexPath.row == 2) {
                    
                    [cell prepareUI3];
                    
                }

            }
            else
            {
            
            if (indexPath.row == 2) {
                
                [cell prepareUI4];

            }
            else if (indexPath.row == 3){
                [cell prepareUI3];

                
            }
            }
        }
        
        
        if ([model.status isEqualToString:@"2"]) {
            
             if (indexPath.row == 2){
                [cell prepareUI3];
                
                
            }
        }

        if ([model.status isEqualToString:@"3"]) {
            
            if (indexPath.row == 2){
                [cell prepareUI3];
                
                
            }
        }

        if ([model.status isEqualToString:@"4"]) {
            
            if (indexPath.row == 2){
                [cell prepareUI3];
                
                
            }
        }
        
        if ([model.status isEqualToString:@"5"]) {
            if (model.courierCompany.length) {

            if (indexPath.row == 2){
                [cell prepareUI4];
                
            }
            else if (indexPath.row == 3){
                [cell prepareUI5];
                
                
            }
            else if (indexPath.row == 4){
                [cell prepareUI3];
                
                
            }
            }
            else
            {
                 if (indexPath.row == 2){
                    [cell prepareUI5];
                    
                    
                }
                else if (indexPath.row == 3){
                    [cell prepareUI3];
                    
                    
                }
 
            }
        }

        cell.typeBtn.tag = indexPath.section + 1000;
        cell.type2Btn.tag = indexPath.section + 2000;

        [cell.typeBtn addTarget:self action:@selector(actiontypeBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell.type2Btn addTarget:self action:@selector(actiontypeBtn:) forControlEvents:UIControlEventTouchUpInside];

    
//    else if (indexPath.row == 2) {
//        [cell prepareUI4];
//    }
//    else if (indexPath.row == 3) {
//        [cell prepareUI5];
//    }
//    else if (indexPath.row ==4) {
//        [cell prepareUI3];
//    }
    }
    return cell;
    
}
-(void)actiontypeBtn:(UIButton*)btn{
    
    
    if ([btn.titleLabel.text isEqualToString:@"拒绝退款"]) {
        ShoppingManModel * model = _dataArray[btn.tag - 2000];
        _seleModel = model;
        UIAlertView * al = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"是否拒绝该订单的退款？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        al.tag = 9000;
        
        [al show];
        
        
        return;


        
        
        
    }
    if ([btn.titleLabel.text isEqualToString:@"同意退款"]) {
        ShoppingManModel * model = _dataArray[btn.tag - 1000];
        _seleModel = model;
        UIAlertView * al = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"是否同意该订单的退款？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        al.tag = 9001;
        
        [al show];
        
        
        return;
        
        
        
        
        
    }

    else
    {
        ShoppingManModel * model = _dataArray[btn.tag - 1000];
        if ([btn.titleLabel.text isEqualToString:@"发货"]) {
            MCLogisticsViewController * ctl = [[MCLogisticsViewController alloc]init];
            ctl.orderId = model.orderNumber;
            [self pushNewViewController:ctl];
        }

        
    }
    
    
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 9000) {
        if (buttonIndex == 0) {
            
              [self showLoading];
    NSDictionary * dic = @{
                         @"orderNumber":_seleModel.orderNumber
                           };
    [self.requestManager postWithUrl:@"api/refund/disAgreedRefund.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
        
        [self showHint:@"拒绝成功"];
        [self RefreshHeader];
        
        
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
    }];
  
            
        }
    }
    if (alertView.tag == 9001) {
        if (buttonIndex == 0) {
            
            [self showLoading];
            NSDictionary * dic = @{
                                   @"orderNumber":_seleModel.orderNumber
                                   };
            [self.requestManager postWithUrl:@"api/refund/agreedRefund.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
                [self stopshowLoading];
                NSLog(@"resultDic ===%@",resultDic);
                
                [self showHint:@"退款成功"];
                [self RefreshHeader];
                
                
                
            } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
                [self stopshowLoading];
                [self showAllTextDialog:description];
            }];
            
            
        }
    }
    

    
}
-(void)seleImgModel:(ShoppingManModel *)mdoel Index:(NSInteger)index
{
    _seleimgModel = mdoel;
    //启动图片浏览器
    HZPhotoBrowser *browserVc = [[HZPhotoBrowser alloc] init];
    browserVc.sourceImagesContainerView = self.view; // 原图的父控件
    browserVc.isNOJubao = YES;
    homeYJModel * model1 =[[homeYJModel alloc]init];// _dataArray[_index];
    
    model1.YJphotos =mdoel.YJphotos;
    
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
    
    model.YJphotos =_seleimgModel.YJphotos;
    
    
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
