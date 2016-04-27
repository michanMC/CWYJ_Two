//
//  zhizuoZP3ViewController.m
//  CWYouJi
//
//  Created by MC on 15/12/15.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "zhizuoZP3ViewController.h"
#import "jingdianModel.h"
#import "zhizuoZP2ViewController.h"
@interface zhizuoZP3ViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    jingdianModel *_jingdianModel;

    UITableView *_tableView;
    NSMutableArray *_dataArray;

    UIView * _table_view;
    
    UIScrollView * _scrollView;
    
    UIButton * _zanBtn;
    UIButton * _kenBtn;
    UIButton * _fooerBtn;

    CGFloat _scrollViewH;
    NSArray * _titlearray;
    NSArray * _title2array;

    NSArray * _imgarray;
    BOOL _isxuanzhe;
    
    UIButton * _shijianBtn;
    UILabel * _ShijianLbl;
    
    UITextField * _jingdiantext;
    NSString * _jingdianStr;

    
    
    UIView                * _inputView;//时间）
    UIDatePicker          * _datePicker;//用以选择时间的时间选择器
    UIView                * _maskView;//弹出inputView时的蒙版
    CGFloat               _inputViewHeight;
    NSString * _timeStr;

}

@end

@implementation zhizuoZP3ViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //[self.navigationController setToolbarHidden:YES animated:NO];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"制作游记";
    _requestManager2 = [NetworkManager instanceManager];
    _requestManager2.needSeesion = YES;

        _titlearray = @[@"东西好吃得不要不要的",@"三星级的价格，五星级的享受",@"景美，我和我的小伙伴都惊呆了",@"买买买"];
         _title2array = @[@"我有100钟方法让你吃不下去",@"住宿环境差，感觉不会再爱了",@"看到这景色，我的内心几乎是崩溃",@"青岛大虾，38元一只"];
    _imgarray = @[@"住",@"食",@"购",@"景"];
    _dataArray = [NSMutableArray array];

        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_icon_back_pressed"] style:UIBarButtonItemStylePlain target:self action:@selector(ActionBack)];
    [self prepareUI];
    [self loadWeizi];
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"disyemianjisuanObjNotification" object:@"3"];
    // Do any additional setup after loading the view.
}
-(void)ActionBack{
    
    UIAlertView * aa = [[UIAlertView alloc]initWithTitle:nil message:@"是否退出当前编辑？未完成的游记将不会保存" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
    aa.tag = 900;
    [aa show];
    
    
    
}
-(void)prepareUI{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64)];
    [_scrollView addSubview:[self prepareheadView]];
     [_scrollView addSubview:[self prepareleixingView]];
    
    _fooerBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, _scrollViewH + 50, Main_Screen_Width - 80, 40)];
    [_fooerBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_pressed"] forState:0];
    [_fooerBtn setTitle:@"下一步" forState:0];
   [_fooerBtn addTarget:self action:@selector(xiayibuBtn) forControlEvents:UIControlEventTouchUpInside];
    [_fooerBtn setTitleColor:[UIColor whiteColor] forState:0];
    [_scrollView addSubview:_fooerBtn];
    _scrollViewH += 90;
    _scrollView.contentSize = CGSizeMake(Main_Screen_Width, _scrollViewH);
   
    [self.view addSubview:_scrollView];
}
-(UIView*)prepareheadView{//230
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 180 + 50)];
    CGFloat  width = 150;
    CGFloat height = 150;
    CGFloat  x = (Main_Screen_Width - width)/2;
    CGFloat y = 20;
    
    UIImageView*  _haedImgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    _haedImgView.image = [UIImage imageNamed:@"-travel-notes_photo"];
    [view addSubview:_haedImgView];
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 180, Main_Screen_Width, 50)];
    lbl.text = @"你对此景点的看法是";
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:20];
    lbl.textAlignment = NSTextAlignmentCenter;
    [view addSubview:lbl];
    return view;
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 900) {
        if (buttonIndex == 0) {
            //self.requestManager2 = nil;
            
            [self.navigationController popViewControllerAnimated:YES];
            self.navigationController.navigationBarHidden = YES;
            
        }
    }
}

-(UIView*)prepareleixingView{//150
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 230, Main_Screen_Width, 150)];
    
    CGFloat width = 90;
    CGFloat x = (Main_Screen_Width - 180)/6;
    CGFloat y = (150 - 70)/2;
    CGFloat height = 70;
    width = 70;
    x = 2 * x;
    
    _zanBtn = [[UIButton alloc]initWithFrame:CGRectMake(x , y, width, height)];
    [_zanBtn setImage:[UIImage imageNamed:@"不枉此行_normal"] forState:UIControlStateNormal];
    [view addSubview:_zanBtn];
    _zanBtn.tag =  100;
    x += 90 + x + 20;
    
    
    _kenBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, 70, 70)];
    [_kenBtn setImage:[UIImage imageNamed:@"坑了-个爹_normal"] forState:UIControlStateNormal];
    _kenBtn.tag = 200;
    [view addSubview:_kenBtn];
    _scrollViewH =230 + 150;
    [_zanBtn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_kenBtn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    return view;
    
}
-(UIView*)xuanzhezanleixin{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 230 + 150 , Main_Screen_Width, 160)];
    view.tag = 310;
    UIView * view2 = [[UIView alloc]initWithFrame:CGRectMake(20, 0, Main_Screen_Width - 40, 160)];
    [view addSubview:view2];
    view2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    CGFloat x = 10;
    CGFloat y = 10;
    CGFloat width = 20;
    CGFloat height = 20;
    
    for (int i = 0 ; i < 4; i++) {
        UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        img.image = [UIImage imageNamed:_imgarray[i]];
        [view2 addSubview:img];
        UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(50 , y, 204, height)];
        lbl.text = _titlearray[i];
        lbl.textColor = AppTextCOLOR;
        lbl.font = AppFont;
        [view2 addSubview:lbl];
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(248, y, 24, 24)];
        [btn setImage:[UIImage imageNamed:@"list_checkbox_normal"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"list_checkbox_checked"]
             forState:UIControlStateSelected];
        btn.tag = i + 2000;
        [btn addTarget:self action:@selector(actionxuanzhe:) forControlEvents:UIControlEventTouchUpInside];

        [view2 addSubview:btn];
        y += height + 20;
        
    }
    
    
    return view;
    
}
#pragma mark-选择类型
-(void)actionxuanzhe:(UIButton*)btn{
    //_isxuanzhe2 = YES;
    //[_tableView reloadData];
    
    for (int i = 2000 ; i <2004;  i ++) {
        
        UIButton * btn = (UIButton*)[self.view viewWithTag:i];
        btn.selected = NO;
        
    }
    for (int i = 3000 ; i <3004;  i ++) {
        
        UIButton * btn = (UIButton*)[self.view viewWithTag:i];
        btn.selected = NO;
        
    }

    btn.selected = YES;
    
    
    
}
-(UIView *)prepareTableView{
     _table_view = [[UIView alloc]initWithFrame:CGRectMake(0, 230 + 150 , Main_Screen_Width, 160)];
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    ViewRadius(_tableView, 5);
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(20, 0, Main_Screen_Width - 40, 160)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_table_view addSubview:_tableView];
    _table_view.hidden = YES;
    
    
    return _table_view;
    
}
-(UIView*)xuanzhekenleixin{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 230 + 150 , Main_Screen_Width, 160)];
    view.tag = 410;

    UIView * view2 = [[UIView alloc]initWithFrame:CGRectMake(20, 0, Main_Screen_Width - 40, 160)];
    [view addSubview:view2];
    view2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    CGFloat x = 10;
    CGFloat y = 10;
    CGFloat width = 20;
    CGFloat height = 20;
    
    for (int i = 0 ; i < 4; i++) {
        UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        img.image = [UIImage imageNamed:_imgarray[i]];
        [view2 addSubview:img];
        UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(40 , y, 214, height)];
        lbl.text = _title2array[i];
        lbl.textColor = AppTextCOLOR;
        lbl.font = AppFont;
        [view2 addSubview:lbl];
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(248, y , 24, 24)];
        [btn setImage:[UIImage imageNamed:@"list_checkbox_normal"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"list_checkbox_checked"]
             forState:UIControlStateSelected];
        btn.tag = i + 3000;
         [btn addTarget:self action:@selector(actionxuanzhe:) forControlEvents:UIControlEventTouchUpInside];
        [view2 addSubview:btn];

        y += height + 20;
        
       
        
        
        
    }
        
    
    
    return view;
    
}
-(UIView *)prepareDiandshi{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 230 + 150 + 160 + 20, Main_Screen_Width , 40 + 40 + 20)];
    
    _jingdiantext = [[UITextField alloc]initWithFrame:CGRectMake(20, 0, Main_Screen_Width - 40, 40)];
    _jingdiantext.placeholder = @"输入景点试试？";
    _jingdiantext.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _jingdiantext.textColor = AppTextCOLOR;
    _jingdiantext.font = AppFont;
    [_jingdiantext addTarget:self action:@selector(EditingChanged:) forControlEvents:UIControlEventEditingChanged];
    [view addSubview:_jingdiantext];
    
    
    _ShijianLbl = [[UILabel alloc]initWithFrame:CGRectMake(20, 40 + 20, Main_Screen_Width - 40, 40)];
    _ShijianLbl.textColor = AppTextCOLOR;
    _ShijianLbl.backgroundColor = [UIColor groupTableViewBackgroundColor];

    _ShijianLbl.font = AppFont;
    _ShijianLbl.text = @"请选择你的出游时间";
    [view addSubview:_ShijianLbl];
    
    
    _shijianBtn=  [[UIButton alloc]initWithFrame:CGRectMake(20, 40 + 20, Main_Screen_Width - 40, 40)];
            [_shijianBtn addTarget:self action:@selector(actionTime) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_shijianBtn];
    
    
    return view;
}
-(void)actionTime{
    _inputViewHeight = 300;
    [self prepareInputView];
    [self addElementsOfShareViewWithIndex:1];//选择时间
    [self startAnimationOfInputView];
    
    
}

-(void)actionBtn:(UIButton*)btn{
    if (btn.selected) {
        return;
    }
    if (!_isxuanzhe) {
        _isxuanzhe = YES;
        [_scrollView addSubview:[self xuanzhezanleixin]];
         [_scrollView addSubview:[self xuanzhekenleixin]];
        [_scrollView addSubview:[self prepareTableView]];
        [_scrollView addSubview:[self prepareDiandshi ]];
        _scrollViewH +=160 + 40 + 40 + 20;
        

        _fooerBtn.frame = CGRectMake(40, _scrollViewH, Main_Screen_Width - 80, 40);
        _scrollViewH += 50;
        _scrollView.contentSize = CGSizeMake(Main_Screen_Width, _scrollViewH);
 _jingdiantext.text = _jingdianModel.nameCH;
    }
    if(btn.tag == 100){
        btn.selected = YES;
        UIButton * btn2 = (UIButton *)[self.view viewWithTag:200];
        btn2.selected= NO;
      //  _titlearray = @[@"东西好吃得不要不要的",@"三星级的价格，五星级的享受",@"景美，我和我的小伙伴都惊呆了",@"买买买"];
        UIView * view = (UIView*)[self.view viewWithTag:310];
        view.hidden = NO;
        UIView * view2 = (UIView*)[self.view viewWithTag:410];
        view2.hidden = YES;

        
    }
    else{
        
        btn.selected = YES;
        UIButton * btn2 = (UIButton *)[self.view viewWithTag:100];
        btn2.selected= NO;
        UIView * view = (UIView*)[self.view viewWithTag:310];
        view.hidden = YES;
        UIView * view2 = (UIView*)[self.view viewWithTag:410];
        view2.hidden = NO;
        

       // _titlearray = @[@"我有100钟方法让你吃不下去",@"住宿环境差，感觉不会再爱了",@"看到这景色，我的内心几乎是崩溃",@"青岛大虾，38元一只"];
    }
//    _tableView.tableHeaderView = nil;
//    [_tableView reloadData];
//    
    
    
    
    
    
    
    if (btn.tag == 100) {
        
        
        UIButton * btn1 = (UIButton*)[self.view viewWithTag:100];
        UIButton * btn2 = (UIButton*)[self.view viewWithTag:200];
        btn1.frame = CGRectMake(btn1.frame.origin.x, btn1.frame.origin.y - 10, 90, 90);
        
        btn2.frame = CGRectMake(btn2.frame.origin.x, (150 - 70)/2, 70, 70);
        
        
    }
    else
    {
        
        UIButton * btn1 = (UIButton*)[self.view viewWithTag:100];
        UIButton * btn2 = (UIButton*)[self.view viewWithTag:200];
        btn2.frame = CGRectMake(btn2.frame.origin.x, btn2.frame.origin.y - 10, 90, 90);
        
        btn1.frame = CGRectMake(btn1.frame.origin.x, (150 - 70)/2, 70, 70);
    }
    
    
    
}
#pragma mark - 弹出的选择框
-(void)prepareInputView
{
    CGFloat x      = 0;
    CGFloat y      = 0;
    CGFloat width  = Main_Screen_Width;
    CGFloat height = Main_Screen_Height;
    _maskView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    _maskView.backgroundColor = [UIColor lightGrayColor];
    _maskView.alpha           = 0;
    _maskView.hidden          = YES;
    [[UIApplication sharedApplication].windows.firstObject addSubview:_maskView];
    
    height = _inputViewHeight;
    y = Main_Screen_Height;
    _inputView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [_inputView setBackgroundColor:RGBACOLOR(240, 240, 240, 1.0)];
    [[UIApplication sharedApplication].windows.firstObject addSubview:_inputView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenInputView)];
    [_maskView addGestureRecognizer:tap];
}
-(void)startAnimationOfInputView
{
    CGFloat height = _inputViewHeight;
    CGFloat x      = 0;
    CGFloat y      = Main_Screen_Height - height;
    CGFloat width  = Main_Screen_Width;
    _maskView.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        _inputView.frame = CGRectMake(x, y, width, height);
        _maskView.alpha  = 0.5;
    } completion:^(BOOL finished) {
    }];
}
-(void)hiddenInputView
{
    CGFloat height   = _inputViewHeight;
    CGFloat x        = 0;
    CGFloat y        = Main_Screen_Height;
    CGFloat width    = Main_Screen_Width;
    _maskView.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        _inputView.frame = CGRectMake(x, y, width, height);
        _maskView.alpha  = 0;
    } completion:^(BOOL finished) {
        //        _maskView.hidden = YES;
        [_inputView removeFromSuperview];
        [_maskView removeFromSuperview];
        //[tb_view reloadData];
    }];
}
-(void)clickConfirmButton
{
    NSDate *date = _datePicker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    _timeStr = [dateFormatter stringFromDate:date];
    [self hiddenInputView];
    _ShijianLbl.text = _timeStr;
    //[_tableView reloadData];
}
-(void)addElementsOfShareViewWithIndex:(NSInteger*)index
{
    
    
    
    
    CGFloat x      = 0;
    CGFloat y      = 5;
    CGFloat width  = Main_Screen_Width;
    CGFloat height = 30;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
    label.font          = [UIFont systemFontOfSize:15];
    label.textColor     = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    [_inputView addSubview:label];
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"确定" forState:0];
    [button setTitleColor:[UIColor lightGrayColor] forState:0];
    [button setTitleColor:[UIColor grayColor] forState:1];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:self action:@selector(clickConfirmButton) forControlEvents:UIControlEventTouchUpInside];
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    button.layer.cornerRadius = 5.0;
    button.layer.borderWidth = 1.0;
    [_inputView addSubview:button];
    
    label.text      = @"请选择时间";
    x = 0;
    y += height;
    width = Main_Screen_Width;
    height = 200;
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [_inputView addSubview:_datePicker];
    
    x = 30;
    y += height + 15;
    width = Main_Screen_Width - 2 * x;
    height = 30;
    button.frame = CGRectMake(x, y, width, height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)EditingChanged:(UITextField*)text{
    if(text.text.length < 1){
        _jingdianStr = @"";
    }
    CGFloat la = [MCUser sharedInstance].myLocation.la;
    CGFloat lo = [MCUser sharedInstance].myLocation.lo;
    

    
    NSDictionary * Parameterdic = @{
                                    @"keyWord":text.text,
                                    @"lat":@(la),
                                    @"lng":@(lo),
                                    };
    

    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString * strurl = [NSString stringWithFormat:@"%@api/travel/searchSpots.json",AppURL];
    
    
    [manager POST:strurl parameters:Parameterdic success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         //NSLog(@"%@",responseObject);
         NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
         NSError *parserError = nil;
         NSDictionary *resultDic = nil;
         @try {
             NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             // NSLog(@"<<<<<<%@",responseString);
             
//             NSString *responseString = [response_String  stringByReplacingOccurrencesOfString:@"null" withString:@"\"\""];
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
                 
               // if (![resultDic[@"object"] isEqual:[NSNull null]])
                 for (NSDictionary *dic in objectArray) {
                     jingdianModel * modle = [jingdianModel mj_objectWithKeyValues:dic];
                     [_dataArray addObject:modle];
                 }
                 
                 if (_dataArray.count) {
                     //  _isbianji = YES;
                     _table_view.hidden = NO;
                     [_tableView reloadData];
                     
                     //  [_jiangdianView.tableView reloadData];
                 }
                 else
                 {
                     _table_view.hidden = YES;
                 }
                 
                 
                 
             }
             else{
                 //业务逻辑错误
                 NSString *message = [resultDic objectForKey:@"message"];
                 NSError *error = [NSError errorWithDomain:@"服务器业务逻辑错误" code:logicCode.intValue userInfo:nil];
                 
             }
         }
         
         
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
     }];

    
    
    
    
    
    
    
    
    
    
    
    /*
    
    // [self showLoading:YES AndText:nil];
    [_requestManager2 requestWebWithParaWithURL:@"api/travel/searchSpots.json" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self stopshowLoading];
        NSLog(@"成功");
        NSLog(@"返回》》==%@",resultDic);
        [_dataArray removeAllObjects];
        NSArray * objectArray = resultDic[@"object"];
        for (NSDictionary *dic in objectArray) {
            jingdianModel * modle = [jingdianModel mj_objectWithKeyValues:dic];
            [_dataArray addObject:modle];
        }
        
        if (_dataArray.count) {
          //  _isbianji = YES;
            _table_view.hidden = NO;
            [_tableView reloadData];
            
            //  [_jiangdianView.tableView reloadData];
        }
        else
        {
             _table_view.hidden = YES;
        }
        
        
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
        
        NSLog(@"失败");
    }];
    
    
    */
    
    //_dataArray = [NSMutableArray arrayWithObjects:@"123",@"213123",@"qweqwe",@"qwewqe", nil];
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mcc"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mcc"];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    if(_dataArray.count >  indexPath.row){
        jingdianModel * model = _dataArray[indexPath.row];
        cell.textLabel.text = model.nameCH;
        
    }
    return cell;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataArray.count >  indexPath.row) {
        jingdianModel * model = _dataArray[indexPath.row];
        _jingdiantext.text = model.nameCH;
        _jingdianModel = model;
        _jingdianStr = model.nameCH;//_dataArray[indexPath.row - 4];
        _table_view.hidden = YES;
        
    }
    
    
}
#pragma mark-下一步
-(void)xiayibuBtn{
    
    //    zhizuoZP2ViewController * ctl = [[zhizuoZP2ViewController alloc]init];
    //    [self pushNewViewController:ctl];
    //    return;
    NSString * str1= @"";
    NSString * str2= @"";
    
    UIButton * btn1 = (UIButton*)[self.view viewWithTag:100];
    UIButton * btn2 = (UIButton*)[self.view viewWithTag:200];
    if (btn1.selected) {
        str1 = @"赞美";
    }
    if (btn2.selected) {
        str1 = @"吐槽";
    }
    if ([str1 isEqualToString:@"赞美"]) {
        
    
    for (int i = 2000; i < 2004; i++) {
        UIButton * btn3 = (UIButton*)[self.view viewWithTag:i];
        if (btn3.selected) {
            str2 = _titlearray[i - 2000];
            break;
        }
    }
    }
    else if([str1 isEqualToString:@"吐槽"]){
        for (int i = 3000; i < 3004; i++) {
            UIButton * btn3 = (UIButton*)[self.view viewWithTag:i];
            if (btn3.selected) {
                str2 = _title2array[i - 3000];
                break;
            }
        }

    }
    
    
    if (!str1.length) {
        kAlertMessage(@"请选择你对此景点的看法");
        return;
    }
    if (!str2.length) {
        kAlertMessage(@"请选择你对此景点的看法");
        return;
    }
    if (!_jingdianStr.length || !_jingdianModel.id) {
        kAlertMessage(@"请输入你的景点");
        return;
    }
    if (!_timeStr.length) {
        kAlertMessage(@"请选择你出游的时间");
        return;
    }
    NSLog(@"str1 == %@",str1);
    NSLog(@"str2 == %@",str2);
    NSLog(@"_jingdianStr == %@",_jingdianStr);
    
    NSLog(@"_timeStr == %@",_timeStr);
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:str1 forKey:@"isRecommend"];
    [dic setObject:str2 forKey:@"classify"];
    [dic setObject:_jingdianModel.id forKey:@"spotId"];
    [dic setObject:_timeStr forKey:@"startTime"];
    [dic setObject:_jingdianStr forKey:@"jingdianStr"];
    
    
    
    zhizuoZP2ViewController * ctl = [[zhizuoZP2ViewController alloc]init];
    
    ctl.dataDic = dic;
    [self pushNewViewController:ctl];
    
}
#pragma mark-位置
-(void)loadWeizi{
    
    if (![MCUser sharedInstance].myLocation.lo || ![MCUser sharedInstance].myLocation.la) {
        NSLog(@"没有");
        return;
    }
    NSDictionary * Parameterdic = @{
                                    @"lat":@([MCUser sharedInstance].myLocation.la),
                                    @"lng":@([MCUser sharedInstance].myLocation.lo)
                                    };
    
    //[self showLoading:isjuhua AndText:nil];
    [self.requestManager requestWebWithParaWithURL:@"api/travel/searchRecentSpot.json" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"sha成功");
        NSLog(@"返回景点==%@",resultDic);
        NSLog(@"%@",resultDic[@"object"][@"nameCH"]);
        
        jingdianModel * model = [jingdianModel mj_objectWithKeyValues:resultDic[@"object"]];
        
        _jingdiantext.text = model.nameCH;
        _jingdianModel = model;
        _jingdianStr = model.nameCH;//
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        
        // [self showAllTextDialog:description];
        
        NSLog(@"shang失败%@",description);
    }];
    
    
    
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
