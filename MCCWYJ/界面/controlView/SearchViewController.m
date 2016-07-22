//
//  SearchViewController.m
//  MCCWYJ
//
//  Created by MC on 16/5/23.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchTableViewCell.h"

@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,SearchViewControllerDelegate>
{
    UITextField *_searchtext;
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    NSString *_SearchStr;
}

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    [self setUpNavBar];
    
    
     _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = AppMCBgCOLOR;
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    
    if (_Search_Str.length) {
        _searchtext.text =_Search_Str;
        [self loadData:_Search_Str];

    }
    else
    {
        
        if (_SearchType == SearchType_scenic) {
            [self loadWeizi];
        }
        else if (_SearchType == SearchType_brand) {
            
            
            [self loadData:@""];
            
        }
        else if (_SearchType == SearchType_POP) {
            
            
            [self loadData:@""];
            
        }

    }
    // Do any additional setup after loading the view.
}





-(void)loadData:(NSString*)SearchStr{
    if (!SearchStr.length) {
        SearchStr= @"";
//        if (<#condition#>) {
//            <#statements#>
//        }
//        return;
    }
//        [self showLoading];
    NSDictionary * dic;
    NSString * urlstr = @"";
    CGFloat la = [MCMApManager sharedInstance].la;
    CGFloat lo = [MCMApManager sharedInstance].lo;

    if (_SearchType == SearchType_scenic) {
        
        dic = @{
                
                    @"keyWord":SearchStr,
                    @"lat":@(la),
                    @"lng":@(lo),
                    
                };
        urlstr = @"api/travel/searchSpots.json";
    }
    if (_SearchType == SearchType_brand) {
        
        dic = @{
                @"name":SearchStr,
                };
        urlstr = @"api/brand/query.json";
  
    }
    if (_SearchType == SearchType_POP) {
        
        dic = @{
                @"address":SearchStr,
                };
        urlstr = @"api/purchasing_address/getPurchasingAddress.json";
        
    }

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString * strurl = [NSString stringWithFormat:@"%@%@",AppURL,urlstr];
    
    
    [manager POST:strurl parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //NSLog(@"%@",responseObject);
        NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        NSError *parserError = nil;
        NSDictionary *resultDic = nil;
        @try {
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            // NSLog(@"<<<<<<%@",responseString);
            
            
            NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            
            
            resultDic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
            
        }
        @catch (NSException *exception) {
            [NSException raise:@"网络接口返回数据异常" format:@"Error domain %@\n,code=%ld\n,userinfo=%@",parserError.domain,(long)parserError.code,parserError.userInfo];
            //发出消息错误的通知
        }
        @finally {
            //业务产生的状态码
            NSString *logicCode = [NSString stringWithFormat:@"%ld",[resultDic[@"code"] integerValue]];
            
            //成功获得数据
            if ([logicCode isEqualToString:@"1"]) {
                
                //                 completeBlock(resultDic);
                
                NSLog(@"返回》》==%@",resultDic);
                [_dataArray removeAllObjects];
                NSArray * objectArray = resultDic[@"object"];
                if (![resultDic[@"object"] isEqual:[NSNull null]])
                    
                    for (NSDictionary *dic in objectArray) {
                        jingdianModel * modle = [jingdianModel mj_objectWithKeyValues:dic];
                        [_dataArray addObject:modle];
                    }
                
                if (_SearchType == SearchType_brand) {
                
                if (!_dataArray.count) {
                    jingdianModel * modle = [[jingdianModel alloc]init];
                    modle.nameChs = SearchStr;
                    [_dataArray addObject:modle];
                }
                }
                [_tableView reloadData];

                
                
            }
            else{
                //业务逻辑错误
                NSString *message = [resultDic objectForKey:@"message"];
                NSError *error = [NSError errorWithDomain:@"服务器业务逻辑错误" code:logicCode.intValue userInfo:nil];
                
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
   //
//    
//    [self.requestManager postWithUrl:urlstr refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
//        [self stopshowLoading];
//        NSLog(@"resultDic ===%@",resultDic);
//        [_dataArray removeAllObjects];
//        NSArray * objectArray = resultDic[@"object"];
//
//        if (![resultDic[@"object"] isEqual:[NSNull null]])
//            
//            for (NSDictionary *dic in objectArray) {
//                jingdianModel * modle = [jingdianModel mj_objectWithKeyValues:dic];
//                [_dataArray addObject:modle];
//            }
//    
//        [_tableView reloadData];
//        
//    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
//        [self stopshowLoading];
//        [self showAllTextDialog:description];
//    }];
//
//    
}
#pragma mark-位置
-(void)loadWeizi{
    
    if (![MCMApManager sharedInstance].lo || ![MCMApManager sharedInstance].la) {
        return;
    }
    NSDictionary * Parameterdic = @{
                                    @"lat":@([MCMApManager sharedInstance].la),
                                    @"lng":@([MCMApManager sharedInstance].lo)
                                    };
    
    //[self showLoading:isjuhua AndText:nil];
    [self.requestManager postWithUrl:@"api/travel/searchRecentSpot.json" refreshCache:NO params:Parameterdic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"shang成功");
        NSLog(@"返回==%@",resultDic);
        [_dataArray removeAllObjects];
        
        jingdianModel * model = [jingdianModel mj_objectWithKeyValues:resultDic[@"object"]];
        
        [_dataArray addObject:model];
        [_tableView reloadData];
        _searchtext.text =_Search_Str;
        
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        
        
        NSLog(@"shang失败%@",description);
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    return 44;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellid = @"SearchTableViewCell";
    SearchTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[SearchTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (_dataArray.count > indexPath.row) {
        jingdianModel * model = _dataArray[indexPath.row];
        if (_SearchType == SearchType_brand) {
            cell.titleLbl.text =[NSString stringWithFormat:@"%@(%@)",model.nameChs,model.nameEn?model.nameEn:@""] ;//@"广州图书馆";

        }
        else if (_SearchType == SearchType_scenic){
            cell.titleLbl.text = model.nameCH;//@"广州图书馆";
            
            cell.originalGrade.image = [UIImage imageNamed:model.originalGrade];
            
            if (model.trend == 0) {
                cell.trend.image = [UIImage imageNamed:@"green_arrow"];
            }
            else if (model.trend == 1)
            {
                cell.trend.image = [UIImage imageNamed:@"red_arrow"];

            }
            else
            {
                cell.trend.image = [UIImage imageNamed:@""];
 
            }
            
            
            if ([model.currentGrade isEqualToString:@"lv0"]) {
                cell.currentGrade.image = [UIImage imageNamed:@"Lv_0"];
            }
            else if ([model.currentGrade isEqualToString:@"lv1"])
            {
                cell.currentGrade.image = [UIImage imageNamed:@"Lv_1"];

            }
            else if ([model.currentGrade isEqualToString:@"lv2"])
            {
                cell.currentGrade.image = [UIImage imageNamed:@"Lv_2"];
                
            }
            else if ([model.currentGrade isEqualToString:@"lv3"])
            {
                cell.currentGrade.image = [UIImage imageNamed:@"Lv_3"];
                
            }
            else if ([model.currentGrade isEqualToString:@"lv4"])
            {
                cell.currentGrade.image = [UIImage imageNamed:@"Lv_4"];
                
            }
            else if ([model.currentGrade isEqualToString:@"lv5"])
            {
                cell.currentGrade.image = [UIImage imageNamed:@"Lv_5"];
                
            }
            else if ([model.currentGrade isEqualToString:@"lv6"])
            {
                cell.currentGrade.image = [UIImage imageNamed:@"Lv_6"];
                
            }
            else
            {
                cell.currentGrade.image = [UIImage imageNamed:@""];

            }

            
            
            

        }
        else if (_SearchType == SearchType_POP){
            cell.titleLbl.text = model.nameChs;//@"广州图书馆";
            
        }


    }
    return cell;
    
//    return [[UITableViewCell alloc]init];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_dataArray.count > indexPath.row) {
        
        jingdianModel * model = _dataArray[indexPath.row];
        if (_delegate) {
            [_delegate selectTitleModel:model];
        }

        
 
    }
    
    if (_isshaidan) {
        if (_delegate) {
            [_delegate selectTitleStr:@"111 " Key:_isdaigoudian];
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];

    
    
    
    
}
-(void)setUpNavBar{
    
    MCIucencyView * seachView = [[MCIucencyView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width , 30)];
    [seachView setBgViewColor:[UIColor groupTableViewBackgroundColor]];
    ViewRadius(seachView, 3);
    seachView.layer.borderWidth = .5;
    seachView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    
    _searchtext = [[UITextField alloc]initWithFrame:CGRectMake(30, 0, seachView.mj_w - 30, 30)];
    NSString * ss = @"输入景点搜索";
    if (_SearchType == SearchType_scenic) {
        
    }
    else if (_SearchType == SearchType_POP)
    {
      ss = @"输入代购点搜索";
    }
    else if (_SearchType == SearchType_brand)
    {
        ss = @"输入品牌搜索";
    }

    _searchtext.placeholder =ss;// @"输入景点搜索";
    _searchtext.textColor  =[UIColor lightGrayColor];
    _searchtext.font = AppFont;
    _searchtext.clearButtonMode = UITextFieldViewModeAlways;
//    _searchtext.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _searchtext.delegate = self;
    [_searchtext addTarget:self action:@selector(EditingChanged:) forControlEvents:UIControlEventEditingChanged];
    [seachView addSubview:_searchtext];

    
    UIImageView * imgview = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
    imgview.image = [UIImage imageNamed:@"ic_icon_search2"];
    [seachView addSubview:imgview];
    
    self.navigationItem.titleView = seachView;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(actionQx)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_icon_back_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(actionBack)];
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{

    _SearchStr = textField.text;
    [self EditingChanged2:_SearchStr];

}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * aString = [textField.text stringByReplacingCharactersInRange:range withString:string];

    if ([string isEqualToString:@"\n"]){
        [textField resignFirstResponder];
        [self EditingChanged2:aString];

        return NO;
    }
    

    
    [self EditingChanged2:aString];
    
    return YES;
    
    
}

#pragma mark-搜索景点
-(void)EditingChanged2:(NSString*)textStr{
    NSLog(@"textStr == %@",textStr);
    [self loadData:textStr];
   
    
}
-(void)EditingChanged:(UITextField*)text{
    
    [self EditingChanged2:text.text];

}





-(void)actionQx{
    
    [self actionBack];
    
}
-(void)actionBack{
    if (_delegate) {
        [_delegate selectTitleModel:nil];
    }

    if (_isshaidan) {
        if (_delegate) {
            [_delegate selectTitleStr:@"" Key:_isdaigoudian];
        }
    }

    [self.navigationController popViewControllerAnimated:YES];
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
