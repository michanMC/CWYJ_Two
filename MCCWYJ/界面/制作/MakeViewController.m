//
//  MakeViewController.m
//  MCCWYJ
//
//  Created by MC on 16/5/5.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MakeViewController.h"
#import "zhizuoZP2ViewController.h"
#import "MCMApManager.h"
#import "jingdianModel.h"

@interface MakeViewController ()<UIScrollViewDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView * _ScrollView;
    CGFloat _CurrentH;

    UIButton * _zanBtn;
    UIButton * _caiBtn;
    
    UIView *_zanBgView;
    UIView *_caiBgView;
    
    
    
    NSArray *_zanTitleArray;
    NSArray *_caiTitleArray;

    

    BOOL _isactionZanCaiBtn;
    
    
    NSInteger _zanseleIndex;
    NSInteger _caiseleIndex;

    
    UITextField *_jingdianTextField;
    
    
    UILabel *_timeLbl;
    UIView                * _inputView;//时间）
    UIDatePicker          * _datePicker;//用以选择时间的时间选择器
    UIView                * _maskView;//弹出inputView时的蒙版
    CGFloat               _inputViewHeight;
    NSString * _timeStr;

    
    UITableView *_tableView;
    UIView *_bgtableView;
    
    
    
    jingdianModel * _jingdiangModel;
    NSString * _jingdianStr;
    NSMutableArray *_dataArray;

    
    
    
}

@end

@implementation MakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"制作游记";
    
    _zanseleIndex = 700;
    _caiseleIndex = 800;

//    _zanTitleArray = [NSArray array];
//    _caiTitleArray = [NSArray array];
    _zanTitleArray = @[
                       @"东西好吃得不要不要的",
                       @"三星级的价格，五星级的享受",
                       @"景美，我和我的小伙伴都惊呆了！",
                       @"买买买"
                       ];
    _caiTitleArray = @[
                       @"食之无味，弃之也不浪费",
                       @"除了不淋雨，其实就是天桥底",
                       @"世界有多大，此景有多差！",
                       @"钱包好空虚，宝宝好委屈"
                       ];

    
    
    _dataArray = [NSMutableArray array];
    
    _ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64)];
    _ScrollView.backgroundColor = AppMCBgCOLOR;
    _ScrollView.delegate =self;
    [self.view addSubview:_ScrollView];
    [self loadWeizi];
    [self preapreheadViewUI];
    // Do any additional setup after loading the view.
}

-(void)preapreheadViewUI{
    
    CGFloat y = 20;
    CGFloat w = 150;
    CGFloat h = w;
    CGFloat x = (Main_Screen_Width - w)/2;
    
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    imgView.image = [UIImage imageNamed:@"-travel-notes_photo"];
    
    [_ScrollView addSubview:imgView];
    
    y +=h + 20;
    x = 0;
    w = Main_Screen_Width;
    h = 20;
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textColor = AppTextCOLOR;
    lbl.text = @"你对此景点的看法是";
    lbl.font = [UIFont systemFontOfSize:20];
    lbl.textAlignment = NSTextAlignmentCenter;
    [_ScrollView addSubview:lbl];
    
    
    y += h + 20;
    
    w = 90;
    x = (Main_Screen_Width/2 - w)/2;
    h = w;
    _zanBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [_zanBtn setBackgroundImage:[UIImage imageNamed:@"赞-正常"] forState:UIControlStateNormal];
    [_zanBtn setBackgroundImage:[UIImage imageNamed:@"赞-选中"] forState:UIControlStateSelected];
    [_zanBtn addTarget:self action:@selector(actionZanCaiBtn:) forControlEvents:UIControlEventTouchUpInside];

    [_ScrollView addSubview:_zanBtn];
    
    
    x = Main_Screen_Width/2 + (Main_Screen_Width/2 - w)/2;

    _caiBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [_caiBtn setBackgroundImage:[UIImage imageNamed:@"踩-正常"] forState:UIControlStateNormal];
    [_caiBtn setBackgroundImage:[UIImage imageNamed:@"踩-选中"] forState:UIControlStateSelected];
    [_caiBtn addTarget:self action:@selector(actionZanCaiBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_ScrollView addSubview:_caiBtn];

    _CurrentH = y + h;
    _ScrollView.contentSize = CGSizeMake(Main_Screen_Width, _CurrentH + 20);
    
    
}

#pragma mark-actionZanCaiBtn
-(void)actionZanCaiBtn:(UIButton*)btn{
    
    if (!_isactionZanCaiBtn) {
        _isactionZanCaiBtn = YES;
        [self prepare2UI];
    }

    btn.selected = YES;
    if (btn == _zanBtn) {
        _caiBtn.selected = NO;
        _zanBgView.hidden = NO;
        _caiBgView.hidden = YES;

    }
    else
    {
        _zanBtn.selected = NO;
        _zanBgView.hidden = YES;
        _caiBgView.hidden = NO;

    }
    
    
}
-(void)prepare2UI{
    
    CGFloat  y = _CurrentH + 20;
    CGFloat x = 30;
    CGFloat w = Main_Screen_Width - 60;
    CGFloat h = 44 * 4 + 1.5;
    
    _zanBgView = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _zanBgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    ViewRadius(_zanBgView, 5);
    [_ScrollView addSubview:_zanBgView];
    
    NSArray * zanimgstrArray = @[@"食",@"住",@"景",@"特产"];
    
    CGFloat imgx = 20/2;
    CGFloat imgy = 20/2;
    CGFloat imgw = 40;
    CGFloat imgh = 24;
    CGFloat offy = 20  + 0.5;
    for (NSInteger i = 0; i<zanimgstrArray.count; i++) {
        NSString * imgStr = zanimgstrArray[i];
        UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(imgx, imgy, imgw, imgh)];
        img.image = [UIImage imageNamed:imgStr];
        img.contentMode = UIViewContentModeLeft;
        [_zanBgView addSubview:img];
        imgy += imgh +offy;
        
    }
    x = imgx + imgw + 5;
    w = _zanBgView.mj_w - x - 45;
    y = 44;
    h = 0.5;
    
    for (NSInteger i = 0; i<zanimgstrArray.count-1; i++) {
    
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(x,y , w, h)];
        
        lineView.backgroundColor = [UIColor whiteColor];
        [_zanBgView addSubview:lineView];
        y += h + 44;
    }
    
    y = 0;
    h = 44;
    
    
    for (NSInteger i = 0; i<_zanTitleArray.count; i++) {
        UILabel * titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
        titleLbl.text = _zanTitleArray[i];
        titleLbl.textColor = AppTextCOLOR;
        titleLbl.font = [UIFont systemFontOfSize:12*MCWidthScale];
//        titleLbl.adjustsFontSizeToFitWidth = YES;
        [_zanBgView addSubview:titleLbl];
        y +=h+0.5;
    
    }
    
    y = 7;
    w = 30;
    h = w;
    x = _zanBgView.mj_w - 40;
    for (NSInteger i = 0; i<_zanTitleArray.count; i++) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
        [btn setImage:[UIImage imageNamed:@"list_checkbox_normal"] forState:0];
        btn.tag = i + 700;
        [btn setImage:[UIImage imageNamed:@"list_checkbox_checked"] forState:UIControlStateSelected];
        if (i == 0) {
            btn.selected = YES;
        }
        [btn addTarget:self action:@selector(actionZanseleBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_zanBgView addSubview:btn];
        y += h + 14;
    
    }

      y = _CurrentH + 20;
     x = 30;
     w = Main_Screen_Width - 60;
    h = 44 * 4 + 1.5;

    
    //踩
    _caiBgView = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _caiBgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    ViewRadius(_caiBgView, 5);
    [_ScrollView addSubview:_caiBgView];
    
    
     imgy = 20/2;

    for (NSInteger i = 0; i<zanimgstrArray.count; i++) {
        NSString * imgStr = zanimgstrArray[i];
        UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(imgx, imgy, imgw, imgh)];
        img.image = [UIImage imageNamed:imgStr];
        img.contentMode = UIViewContentModeLeft;
        [_caiBgView addSubview:img];
        imgy += imgh +offy;
        
    }
    x = imgx + imgw + 5;
    w = _caiBgView.mj_w - x - 45;
    y = 44;
    h = 0.5;
    
    for (NSInteger i = 0; i<zanimgstrArray.count-1; i++) {
        
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(x,y , w, h)];
        
        lineView.backgroundColor = [UIColor whiteColor];
        [_caiBgView addSubview:lineView];
        y += h + 44;
    }
    
    y = 0;
    h = 44;
    
    
    for (NSInteger i = 0; i<_caiTitleArray.count; i++) {
        UILabel * titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
        titleLbl.text = _caiTitleArray[i];
        titleLbl.textColor = AppTextCOLOR;
        
        titleLbl.font = [UIFont systemFontOfSize:12*MCWidthScale];
//        titleLbl.adjustsFontSizeToFitWidth = YES;
        [_caiBgView addSubview:titleLbl];
        y +=h+0.5;
        
    }
    
    y = 7;
    w = 30;
    h = w;
    x = _caiBgView.mj_w - 40;
    for (NSInteger i = 0; i<_caiTitleArray.count; i++) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
        [btn setImage:[UIImage imageNamed:@"list_checkbox_normal"] forState:0];
        btn.tag = i + 800;
        [btn setImage:[UIImage imageNamed:@"list_checkbox_checked"] forState:UIControlStateSelected];
        if (i == 0) {
            btn.selected = YES;
        }
        [btn addTarget:self action:@selector(actionCaiseleBtn:) forControlEvents:UIControlEventTouchUpInside];

        [_caiBgView addSubview:btn];
        y += h + 14;
        
    }
    
    _zanBgView.hidden = YES;
    _caiBgView.hidden = YES;

    _CurrentH = _caiBgView.mj_y + _caiBgView.mj_h;
    _ScrollView.contentSize = CGSizeMake(Main_Screen_Width, _CurrentH + 20);

    [self prepareUI3];
}

-(void)actionCaiseleBtn:(UIButton*)btn{
    
    for (NSInteger i = 800; i < 804; i++) {
        UIButton * btn2 = [self.view viewWithTag:i];
        btn2.selected = NO;
    }
    btn.selected = YES;
    _caiseleIndex = btn.tag;


}
-(void)actionZanseleBtn:(UIButton*)btn{

    for (NSInteger i = 700; i < 704; i++) {
        UIButton * btn2 = [self.view viewWithTag:i];
        btn2.selected = NO;
    }
    btn.selected = YES;
    _zanseleIndex = btn.tag;
    

    
    
}
-(void)prepareUI3{
    
    CGFloat  y = _CurrentH + 10;
    CGFloat x = 30;
    CGFloat w = Main_Screen_Width - 60;
    CGFloat h = 44 ;
    UIView * bgview = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    bgview.backgroundColor = [UIColor groupTableViewBackgroundColor];
    ViewRadius(bgview, 5);
    [_ScrollView addSubview:bgview];

    _jingdianTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, bgview.mj_w - 20, h)];
    _jingdianTextField.text = _jingdianStr;
    _jingdianTextField.placeholder = @"输入景点试试?";
    _jingdianTextField.textColor = AppTextCOLOR;
    _jingdianTextField.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _jingdianTextField.font = [UIFont systemFontOfSize:15];
    ViewRadius(_jingdianTextField, 5);
    _jingdianTextField.delegate = self;
    [bgview addSubview:_jingdianTextField];
    
    y += h + 10;
    
    bgview = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    bgview.backgroundColor = [UIColor groupTableViewBackgroundColor];
    ViewRadius(bgview, 5);
    [_ScrollView addSubview:bgview];
    
    
    _timeLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, bgview.mj_w - 20, h)];
    _timeLbl.text = @"请选择你的出游的时间";
    _timeLbl.font = [UIFont systemFontOfSize:15];
    _timeLbl.textColor = [UIColor lightGrayColor];
    [bgview addSubview:_timeLbl];
    
    UIButton * timebtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, w, h)];
    [timebtn addTarget:self action:@selector(actionTime) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview:timebtn];

    
    _CurrentH = y + 44;
    
    _ScrollView.contentSize = CGSizeMake(Main_Screen_Width, _CurrentH + 10);
    
    [self prepareUI4];
    [self preaprepushView];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    textField.text = _jingdianStr;
    
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]){
        [textField resignFirstResponder];
        return NO;
    }
    
    
    NSString * aString = [textField.text stringByReplacingCharactersInRange:range withString:string];

    [self EditingChanged:aString];
    
    return YES;
    
    
}
#pragma mark-搜索景点
-(void)EditingChanged:(NSString*)textStr{
    NSLog(@"textStr == %@",textStr);
    NSDictionary * Parameterdic = @{
                                    @"keyWord":textStr
                                    };
    
    
    
    [self.requestManager postWithUrl:@"api/travel/searchSpots.json" refreshCache:NO params:Parameterdic IsNeedlogin:YES success:^(id resultDic) {
        
        
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
            _bgtableView.hidden = NO;
            [_tableView reloadData];
            
        }
        else
        {
            _bgtableView.hidden = YES;

        }
        
        

        
        
        
        
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        _bgtableView.hidden = YES;

    }];
    
    
    
//    
//    // [self showLoading:YES AndText:nil];
//    [self.requestManager requestWebWithParaWithURL:@"api/travel/searchSpots.json" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
//        [self stopshowLoading];
//        NSLog(@"成功");
//        NSLog(@"返回》》==%@",resultDic);
//        [_dataArray removeAllObjects];
//        NSArray * objectArray = resultDic[@"object"];
//        for (NSDictionary *dic in objectArray) {
//            jingdianModel * modle = [jingdianModel mj_objectWithKeyValues:dic];
//            [_dataArray addObject:modle];
//        }
//        
//        if (_dataArray.count) {
//            _isbianji = YES;
//            
//            [_tableView reloadData];
//            
//            //  [_jiangdianView.tableView reloadData];
//        }
//        
//        
//        
//    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
//        [self stopshowLoading];
//        [self showAllTextDialog:description];
//        
//        NSLog(@"失败");
//    }];
//    
    

    
    
    
    
}




-(void)prepareUI4{
    _bgtableView = [[UIView alloc]initWithFrame:CGRectMake(30, _CurrentH - 44*2 - 10 -(44 * 3 + 1) , _jingdianTextField.mj_w + 20, 44 * 3 + 1)];
    _bgtableView.backgroundColor = [UIColor whiteColor];
    _bgtableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _bgtableView.layer.borderWidth = 0.5;
    [_ScrollView addSubview:_bgtableView];
   _bgtableView.hidden = YES;
    
    
     _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, _bgtableView.mj_w, _bgtableView.mj_h) style:UITableViewStylePlain];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [_bgtableView addSubview:_tableView];
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mc2"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mc2"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (_dataArray.count > indexPath.row) {
       jingdianModel*  jingdiangModel = _dataArray[indexPath.row];
        cell.textLabel.text = jingdiangModel.nameCH;
        cell.textLabel.textColor = AppCOLOR;
        cell.textLabel.font = AppFont;
        return cell;
    }
    
    return [[UITableViewCell alloc]init];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _bgtableView.hidden = YES;
    
    if (_dataArray.count > indexPath.row) {
        _jingdiangModel = _dataArray[indexPath.row];
        _jingdianTextField.text = _jingdiangModel.nameCH;
        _jingdianStr = _jingdiangModel.nameCH;

    }

    

}

#pragma mark-下一步
-(void)preaprepushView{
    
    CGFloat y = _CurrentH + 40;
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(40, y,Main_Screen_Width - 2* 40, 40)];
    [btn setTitle:@"下一步" forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    btn.titleLabel.font = AppFont;
    btn.backgroundColor = AppRegTextCOLOR;//[UIColor redColor];
    [_ScrollView addSubview:btn];
    ViewRadius(btn, 5);
    [btn addTarget:self action:@selector(pushView) forControlEvents:UIControlEventTouchUpInside];

    
    _CurrentH = y + 40;
    
    _ScrollView.contentSize = CGSizeMake(Main_Screen_Width, _CurrentH + 70);
 
}
-(void)pushView{
    
    NSInteger tagIndex = 100;
    if (_zanBtn.selected) {
        tagIndex = 700;
        NSLog(@"赞");
    }
    if (_caiBtn.selected) {
        tagIndex = 800;

        NSLog(@"踩");
    }
//i + 700;
    NSString * str2= @"";

    for (int i = 0; i < 4; i++) {
        
        UIButton * btn = (UIButton*)[self.view viewWithTag:i + tagIndex];
        
        if (btn.selected) {
            if (tagIndex == 700) {
                str2 = _zanTitleArray[i];

            }
            else if (tagIndex == 800)
            {
                str2 = _caiTitleArray[i];

            }
            break;
        }
    }
    
    if (tagIndex == 100) {
        kAlertMessage(@"请选择你对此景点的看法");
        return;
    }
    if (!str2.length) {
        kAlertMessage(@"请选择你对此景点的看法");
        return;
    }
    if (!_jingdianStr.length || !_jingdiangModel.id) {
        kAlertMessage(@"请输入你的景点");
        return;
    }
    if (!_timeStr.length) {
        kAlertMessage(@"请选择你出游的时间");
        return;
    }

    NSLog(@"str2 == %@",str2);
    NSLog(@"_jingdianStr == %@",_jingdianStr);
    NSLog(@"_timeStr == %@",_timeStr);
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:@(tagIndex) forKey:@"isRecommend"];
    [dic setObject:str2 forKey:@"classify"];
    [dic setObject:_jingdiangModel.id forKey:@"spotId"];
    [dic setObject:_timeStr forKey:@"startTime"];
    [dic setObject:_jingdianStr forKey:@"jingdianStr"];
    
    zhizuoZP2ViewController * ctl = [[zhizuoZP2ViewController alloc]init];
    ctl.dataDic = dic;

    [self pushNewViewController:ctl];
}


#pragma mark-时间
-(void)actionTime{
    _inputViewHeight = 300;
    [self prepareInputView];
    [self addElementsOfShareViewWithIndex:1];//选择时间
    [self startAnimationOfInputView];
    
    
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
    _timeLbl.text =_timeStr;

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
        
        _jingdiangModel = [jingdianModel mj_objectWithKeyValues:resultDic[@"object"]];
        _jingdianStr = _jingdiangModel.nameCH;

        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        
        
        NSLog(@"shang失败%@",description);
    }];
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidLayoutSubviews {
    if (IOS7) {
        
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset:UIEdgeInsetsZero];
            
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)])  {
            [_tableView setLayoutMargins:UIEdgeInsetsZero];
        }
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if (IOS8) {
        
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
    }
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
