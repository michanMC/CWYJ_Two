//
//  zhizuoZP1ViewController.m
//  CWYouJi
//
//  Created by MC on 15/11/8.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "zhizuoZP1ViewController.h"
#import "zhizuoZp1TableViewCell.h"
#import "zhizuoZp2TableViewCell.h"
#import "zhizuoZp3TableViewCell.h"
#import "zhizuoZp4TableViewCell.h"
#import "zhizuoZp5TableViewCell.h"
#import "zhizuoZP2ViewController.h"
#import "jingdianModel.h"
@interface zhizuoZP1ViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    UITableView *_tableView;
    BOOL _isxuanzhe;
    BOOL _isxuanzhe2;
    BOOL _isbianji;
    
    NSMutableArray *_dataArray;
    
    NSString * _jingdianStr;
    NSString * _timeStr;

    
    UIView                * _inputView;//时间）
    UIDatePicker          * _datePicker;//用以选择时间的时间选择器
    UIView                * _maskView;//弹出inputView时的蒙版
    CGFloat               _inputViewHeight;
    NSInteger index;
    
    NSArray *_titlearray;
    
    
    jingdianModel *_jingdianModel;
    
    

}

@end

@implementation zhizuoZP1ViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"zhizuoYJ"];

    self.navigationController.navigationBarHidden = NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"zhizuoYJ"];

    //[self.navigationController setToolbarHidden:YES animated:NO];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"制作游记";
    _titlearray = @[@"东西好吃得不要不要的",@"三星级的价格，五星级的享受",@"景美，我和我的小伙伴都惊呆了",@"买买买"];
    _dataArray = [NSMutableArray array];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_icon_back_pressed"] style:UIBarButtonItemStylePlain target:self action:@selector(ActionBack)];
    [self prepareUI];
    [self loadWeizi];

    // Do any additional setup after loading the view.
}
-(void)ActionBack{
    
    UIAlertView * aa = [[UIAlertView alloc]initWithTitle:nil message:@"是否退出当前编辑？未完成的游记将不会保存" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
    aa.tag = 900;
    [aa show];
    

    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 900) {
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
        self.navigationController.navigationBarHidden = YES;
 
    }
    }
}
-(void)prepareUI{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64)];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    _tableView.tableHeaderView = [self prepareheadView];
    _tableView.tableFooterView = [self prepareFooerView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    
    
    
}
-(UIView*)prepareFooerView{
    
    UIView * view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 100)];
    
  UIButton*  _btn3 = [[UIButton alloc]initWithFrame:CGRectMake(40, 100 - 40 - 20, Main_Screen_Width - 80, 40)];
    [_btn3 setBackgroundImage:[UIImage imageNamed:@"login_btn_pressed"] forState:0];
    [_btn3 setTitle:@"下一步" forState:0];
    [_btn3 addTarget:self action:@selector(xiayibuBtn) forControlEvents:UIControlEventTouchUpInside];
    [_btn3 setTitleColor:[UIColor whiteColor] forState:0];
    [view addSubview:_btn3];

    return view;
    
    
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
    
    for (int i = 300; i < 304; i++) {
        UIButton * btn3 = (UIButton*)[self.view viewWithTag:i];
        if (btn3.selected) {
            str2 = _titlearray[i - 300];
            break;
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
-(UIView*)prepareheadView{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 180)];
  CGFloat  width = 150;
   CGFloat height = 150;
  CGFloat  x = (Main_Screen_Width - width)/2;
   CGFloat y = 20;

  UIImageView*  _haedImgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    _haedImgView.image = [UIImage imageNamed:@"-travel-notes_photo"];
    [view addSubview:_haedImgView];
    
    return view;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isxuanzhe) {
        if (_isxuanzhe2) {
            
            if (_isbianji) {
                return  4 + _dataArray.count;
            }
            
            return 5;
        }

        return 3;
    }
    return 2;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
        return 50;
    }
    if (indexPath.row == 1) {
        return 150;
    }
    if (indexPath.row == 2)
    
    return 178;
    if (_isbianji) {
        if (indexPath.row == 3) {
             return 55;
        }
        return 44;
    }
    return 55;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid1 = @"zhizuoZp1TableViewCell";
    static NSString * cellid2 = @"zhizuoZp2TableViewCell";
    static NSString * cellid3 = @"zhizuoZp3TableViewCell";
    static NSString * cellid4 = @"zhizuoZp4TableViewCell";
    static NSString * cellid5 = @"zhizuoZp5TableViewCell";

    if (indexPath.row == 0) {
        
        zhizuoZp1TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"zhizuoZp1TableViewCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }
    if (indexPath.row == 1) {
        zhizuoZp2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid2];
        if (!cell) {
            cell = [[zhizuoZp2TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid2];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;

        cell.btn1.tag = 100;
        cell.btn2.tag = 200;
        [cell.btn1 addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn2 addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];

        return cell;
    }
    if (indexPath.row == 2) {
        
        zhizuoZp3TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid3];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"zhizuoZp3TableViewCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;

        cell.btn1.tag = 300;
        cell.btn2.tag = 301;
        cell.btn3.tag = 302;
        cell.btn4.tag = 303;

        [cell.btn1 addTarget:self action:@selector(actionxuanzhe:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn2 addTarget:self action:@selector(actionxuanzhe:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn3 addTarget:self action:@selector(actionxuanzhe:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn4 addTarget:self action:@selector(actionxuanzhe:) forControlEvents:UIControlEventTouchUpInside];

        
        [cell.btn1 setImage:[UIImage imageNamed:@"list_checkbox_checked"] forState:UIControlStateSelected];
        [cell.btn2 setImage:[UIImage imageNamed:@"list_checkbox_checked"] forState:UIControlStateSelected];
        [cell.btn3 setImage:[UIImage imageNamed:@"list_checkbox_checked"] forState:UIControlStateSelected];
        [cell.btn4 setImage:[UIImage imageNamed:@"list_checkbox_checked"] forState:UIControlStateSelected];

        ViewRadius(cell.bgview, 5);
        cell.lbl1.text = _titlearray[0];
        cell.lbl2.text = _titlearray[1];
        cell.lbl3.text = _titlearray[2];
        cell.lbl4.text = _titlearray[3];

        return cell;
        
    }
    if (indexPath.row == 3) {
        zhizuoZp4TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid4];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"zhizuoZp4TableViewCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;

        cell.btn1.hidden = YES;
        cell.text1.delegate = self;
        cell.text1.tag = 800;
        cell.text1.text = _jingdianStr;
        [cell.text1 addTarget:self action:@selector(EditingChanged:) forControlEvents:UIControlEventEditingChanged];
        return cell;
    }
    if (_isbianji) {
        zhizuoZp5TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid5];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"zhizuoZp5TableViewCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if(_dataArray.count >  indexPath.row - 4){
            jingdianModel * model = _dataArray[indexPath.row - 4];
            cell.titelLbl.text = model.nameCH;

        }
        
        return cell; //[[UITableViewCell alloc]init];
    }
    if (indexPath.row == 4) {
        zhizuoZp4TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid4];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"zhizuoZp4TableViewCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;

        cell.tag = 801;
        cell.text1.placeholder = @"请选择你的出游时间";
        cell.text1.enabled = NO;
        cell.text1.text = _timeStr;
       // [cell.text1 addTarget:self action:@selector(EditingChanged:) forControlEvents:UIControlEventEditingChanged];
        [cell.btn1 addTarget:self action:@selector(actionTime) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }

    
   return  [[UITableViewCell alloc]init];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_isbianji) {
        if (indexPath.row > 3) {
            UITextField * text = (UITextField*)[self.view viewWithTag:800];
            if (_dataArray.count >  indexPath.row - 4) {
                jingdianModel * model = _dataArray[indexPath.row - 4];
                text.text = model.nameCH;
                _jingdianModel = model;
                _jingdianStr = model.nameCH;//_dataArray[indexPath.row - 4];

            }
        }
        _isbianji = NO;
        [_tableView reloadData];
        
        
    }
    
    
}
#pragma mark-编辑
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 800) {
        
    }
    if (textField.tag == 801) {
        
        
        
        
    }

}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (textField.tag == 800) {
        if (!textField.text.length)
        textField.text = [MCUser sharedInstance].myLocation.city;

    }
    
}
-(void)actionTime{
    _inputViewHeight = 300;
    [self prepareInputView];
    [self addElementsOfShareViewWithIndex:1];//选择时间
    [self startAnimationOfInputView];
    

}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    return YES;
    
}
-(void)EditingChanged:(UITextField*)text{
    
    
    NSDictionary * Parameterdic = @{
                                    @"keyWord":text.text
                                    };
    
    
    // [self showLoading:YES AndText:nil];
    [self.requestManager requestWebWithParaWithURL:@"api/travel/searchSpots.json" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
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
            _isbianji = YES;
            
            [_tableView reloadData];
            
            //  [_jiangdianView.tableView reloadData];
        }
        
        
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
        
        NSLog(@"失败");
    }];
    

    
    
    //_dataArray = [NSMutableArray arrayWithObjects:@"123",@"213123",@"qweqwe",@"qwewqe", nil];
   

    
}
#pragma mark-选择类型
-(void)actionxuanzhe:(UIButton*)btn{
    _isxuanzhe2 = YES;
    [_tableView reloadData];
    
    for (int i = 300 ; i <304;  i ++) {
        
        UIButton * btn = (UIButton*)[self.view viewWithTag:i];
        btn.selected = NO;
        
    }
    btn.selected = YES;
    
    
    
}
-(void)actionBtn:(UIButton*)btn{
    if (btn.selected) {
        return;
    }
    
    _isxuanzhe = YES;
    if(btn.tag == 100){
        btn.selected = YES;
        UIButton * btn2 = (UIButton *)[self.view viewWithTag:200];
        btn2.selected= NO;
         _titlearray = @[@"东西好吃得不要不要的",@"三星级的价格，五星级的享受",@"景美，我和我的小伙伴都惊呆了",@"买买买"];
    }
    else{
        
        btn.selected = YES;
        UIButton * btn2 = (UIButton *)[self.view viewWithTag:100];
        btn2.selected= NO;

         _titlearray = @[@"我有100钟方法让你吃不下去",@"住宿环境差，感觉不会再爱了",@"看到这景色，我的内心几乎是崩溃",@"青岛大虾，38元一只"];
    }
    _tableView.tableHeaderView = nil;
    [_tableView reloadData];
    
    
    
    
    
    
    
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
    [_tableView reloadData];
}
#pragma mark-位置
-(void)loadWeizi{
    
    if (![MCUser sharedInstance].myLocation.lo || ![MCUser sharedInstance].myLocation.la) {
        return;
    }
    NSDictionary * Parameterdic = @{
                                    @"lat":@([MCUser sharedInstance].myLocation.la),
                                    @"lng":@([MCUser sharedInstance].myLocation.lo)
                                    };

    //[self showLoading:isjuhua AndText:nil];
    [self.requestManager requestWebWithParaWithURL:@"api/travel/searchRecentSpot.json" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"shang成功");
        NSLog(@"返回==%@",resultDic);
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        
        // [self showAllTextDialog:description];
        
        NSLog(@"shang失败%@",description);
    }];
    
    
    
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
