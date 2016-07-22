//
//  AddadderssViewController.m
//  MCCWYJ
//
//  Created by MC on 16/5/5.
//  Copyright © 2016年 MC. All rights reserved.
//
#define kScreen_Frame       (CGRectMake(0, 0 ,Main_Screen_Width,Main_Screen_Height))


#import "AddadderssViewController.h"
#import "UIPlaceHolderTextView.h"
#import "XMLReader.h"
#import "LocationsModel.h"
#import "GKHpickerAddressView.h"
#import "UIView+RGSize.h"
@interface AddadderssViewController ()<UIPickerViewDataSource, UIPickerViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    UIView * _bgView1;
    UIView * _bgView2;
    UITextField * _nametext;
    UITextField * _phonetext;
    UITextField * _addersstext;
    UIPlaceHolderTextView *_addersTextView;
    UIButton * _seleBtn;
    NSMutableArray * _dataArray;
    
    
    NSString *_provinceStr;
    NSString *_cityStr;
    NSString *_regionStr;
    NSString *_addStr;

    
}
@property (strong, nonatomic) UIView *maskView;

@property (strong,nonatomic) UIPickerView * myPicker;

@property (strong, nonatomic) NSDictionary *pickerDic;
@property (strong, nonatomic) NSArray *provinceArray;
@property (strong, nonatomic) NSArray *cityArray;
@property (strong, nonatomic) NSArray *townArray;

@end

@implementation AddadderssViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _titleStr;
    _dataArray = [NSMutableArray array];
    [self prepareView];
    // Do any additional setup after loading the view.
}

-(void)prepareView{
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64)];
    bgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:bgView];
    CGFloat x = 10;
    CGFloat y = 64 + 10;
    CGFloat w= Main_Screen_Width - 20;
    CGFloat h = 44 * 2 + .5;
    _bgView1 = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _bgView1.backgroundColor = [UIColor whiteColor];
    ViewRadius(_bgView1, 5);
    _bgView1.layer.borderWidth = .5;
    _bgView1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:_bgView1];
    
    y = 44;
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(10, y, _bgView1.mj_w - 20, .5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [_bgView1 addSubview:lineView];
    
    
    y = _bgView1.mj_y + _bgView1.mj_h + 10;
    h = 44 * 2 + 60 + 1;
    
    _bgView2 = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _bgView2.backgroundColor = [UIColor whiteColor];
    ViewRadius(_bgView2, 5);
    _bgView2.layer.borderWidth = .5;
    _bgView2.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:_bgView2];

    y = 44;
    lineView = [[UIView alloc]initWithFrame:CGRectMake(10, y, _bgView2.mj_w - 20, .5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [_bgView2 addSubview:lineView];
    
    y = 44 + .5 + 60;
    lineView = [[UIView alloc]initWithFrame:CGRectMake(10, y, _bgView2.mj_w - 20, .5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [_bgView2 addSubview:lineView];
    
    UIButton * okbtn = [[UIButton alloc]initWithFrame:CGRectMake(40, Main_Screen_Height - 44 - 50, Main_Screen_Width - 80, 44)];
    [okbtn setTitle:@"保存" forState:0];
    [okbtn setTitleColor:[UIColor whiteColor] forState:0];
    okbtn.titleLabel.font = AppFont;
    okbtn.backgroundColor = AppRegTextCOLOR;//[UIColor redColor];
    [self.view addSubview:okbtn];
    ViewRadius(okbtn, 5);
    [okbtn addTarget:self action:@selector(addBtn) forControlEvents:UIControlEventTouchUpInside];
    [self prepareText];
}

-(void)prepareText{
    
    CGFloat x = 10;
    CGFloat y =0;
    CGFloat w= 64;
    CGFloat h = 44;

    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.text = @"收货人";
    lbl.textColor = AppTextCOLOR;
    lbl.font = AppFont;
    [_bgView1 addSubview:lbl];
    
    y+=h+.5;
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.text = @"联系电话";
    lbl.textColor = AppTextCOLOR;
    lbl.font = AppFont;
    [_bgView1 addSubview:lbl];

    x+=w;
    w = _bgView1.mj_w - x - 10;
    y = 0;
    _nametext = [[UITextField alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _nametext.font = AppFont;
    _nametext.placeholder = @"请输入姓名，最多输入10个字符";
    [_bgView1 addSubview:_nametext];
    _nametext.delegate = self;

    y+=h+0.5;
    _phonetext = [[UITextField alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _phonetext.font = AppFont;
    _phonetext.placeholder = @"请输入手机号码，不超过11位";
    [_bgView1 addSubview:_phonetext];
    _phonetext.delegate = self;

    
    
    x = 10;
     y =0;
     w= 64;
    h = 44;
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.text = @"收货地址";
    lbl.textColor = AppTextCOLOR;
    lbl.font = AppFont;
    [_bgView2 addSubview:lbl];
    
    y+=h+.5;
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.text = @"详细地址";
    lbl.textColor = AppTextCOLOR;
    lbl.font = AppFont;
    [_bgView2 addSubview:lbl];

    y+=60+.5;
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.text = @"默认地址";
    lbl.textColor = AppTextCOLOR;
    lbl.font = AppFont;
    [_bgView2 addSubview:lbl];

    
    
    
    x+=w;
    w = _bgView2.mj_w - x - 10;
    y = 0;
    _addersstext = [[UITextField alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _addersstext.font = AppFont;
    _addersstext.placeholder = @"请选择地址";
    _addersstext.enabled = NO;
    [_bgView2 addSubview:_addersstext];
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [btn addTarget:self action:@selector(actioncityBtn) forControlEvents:UIControlEventTouchUpInside];
    [_bgView2 addSubview:btn];

    
    y+=h+0.5 + 5;
    _addersTextView = [[UIPlaceHolderTextView alloc]initWithFrame:CGRectMake(x, y, w, 60 - 10 - 10)];
    _addersTextView.font = AppFont;
    _addersTextView.placeholder = @"请输入详细地址,最多输入30个字符";
    [_bgView2 addSubview:_addersTextView];
    _addersTextView.delegate = self;

    
    
    
    
    y = _bgView2.mj_h - 7 - 30;
    w = 30;
    h = 30;
    x = _bgView2.mj_w - 10 - w;
    _seleBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
//    _seleBtn.backgroundColor = [UIColor redColor];
    [_seleBtn setImage:[UIImage imageNamed:@"radio-btn_nor"] forState:UIControlStateNormal];
    [_seleBtn setImage:[UIImage imageNamed:@"radio-btn_selected"] forState:UIControlStateSelected];
    if (_model) {
        _seleBtn.selected = [_model.status boolValue];
    }
    else
    {
        
    }
    [_bgView2 addSubview:_seleBtn];
    
    [_seleBtn addTarget:self action:@selector(action_seleBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([_titleStr isEqualToString:@"编辑收货地址"]) {
        [self isbianjiAdderss];
    }
    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]){
        return NO;
    }
    
    NSString * aString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    if ([aString length] > 30) {
        return NO;
    }

    
    return YES;
    
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==_nametext) {
        if ([textField.text length] >= 10&&![string isEqualToString:@""]) {
            //[_tableview reloadData];
            return NO;
        }
    }
    if (textField==_phonetext) {
        if ([textField.text length] >= 11&&![string isEqualToString:@""]) {
            //[_tableview reloadData];
            return NO;
        }
    }

    
    return YES;
}
-(void)actioncityBtn{
    [_nametext resignFirstResponder];
    [_phonetext resignFirstResponder];
    [_addersstext resignFirstResponder];
    [_addersTextView resignFirstResponder];

    if (_dataArray.count) {
        [self citydata];
        return;
    }
        [self showLoading];
    
    [self.requestManager postWithUrl:@"api/common/locations.json" refreshCache:NO params:nil IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
        
        NSArray * ProvinceArray = resultDic[@"Country"][@"Province"];
        for (NSDictionary * dic in ProvinceArray) {
            
            LocationsModel * Locations_model = [LocationsModel mj_objectWithKeyValues:dic];
            for (NSDictionary*Cdic in Locations_model.City) {
             CityModel* City_modle = [CityModel mj_objectWithKeyValues:Cdic];
                for (NSDictionary*Rdic in City_modle.Region) {
                    RegionModel * Rmodel = [RegionModel mj_objectWithKeyValues:Rdic];
                    [City_modle.RegionArray addObject:Rmodel];
                }
                [Locations_model.CityArray addObject:City_modle];
                
            }
            [_dataArray addObject:Locations_model];
            
            
        }
        [self citydata];
        NSLog(@"======%zd",_dataArray.count);
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
//        [self showAllTextDialog:description];
    }];

}
-(void)citydata{
    
    [GKHpickerAddressView shareInstancePickerAddressByctrl:self DataArray:_dataArray block:^(UIViewController *ctrl, NSString *addressName,NSMutableDictionary*dic) {
        
        _provinceStr = dic[@"province"];
        _cityStr = dic[@"city"];
        _regionStr = dic[@"region"];
        _addStr =addressName;
        _addersstext.text = _addStr;
        NSLog(@"addressName == %@",addressName);
        if ([_titleStr isEqualToString:@"编辑收货地址"]) {
            _model.province =_provinceStr;
            _model.city =_cityStr;
            _model.region =_regionStr;

        }
        
    }];

}
-(void)isbianjiAdderss{
    _nametext.text = _model.name;
    _phonetext.text = _model.mobile;
    _addersstext.text = [NSString stringWithFormat:@"%@%@%@",_model.province,_model.city,_model.region];
    _addersTextView.text = _model.MCdescription;//@"唐安录188号8楼紫金互联网咯有些共享";
    
    
    
}
-(void)action_seleBtn:(UIButton*)btn{
    
    if (btn.selected) {
        btn.selected = NO;
    }
    else
    {
        btn.selected = YES;

    }
    
    
}
#pragma mark-保存
-(void)addBtn{
    
    [_nametext resignFirstResponder];
    [_phonetext resignFirstResponder];
    [_addersstext resignFirstResponder];
    [_addersTextView resignFirstResponder];

   
    
    NSDictionary * dic = @{
                         
                           };
    if ([_titleStr isEqualToString:@"地址管理"]) {
        if (!_nametext.text.length) {
            [self showHint:@"请输入收货人姓名"];
            return;
        }
        if (!_phonetext.text.length) {
            [self showHint:@"请输入手机号码"];
            return;
        }
        if (![CommonUtil isMobile:_phonetext.text]) {
            [self showHint:@"请正确输入手机号码"];
            return;

        }

        if (!_addersstext.text.length) {
            [self showHint:@"请选择收货地区"];
            return;
        }
        if (!_addersTextView.text.length) {
            [self showHint:@"请输入详细地址"];
            return;
        }

        dic = @{
                @"province":_provinceStr,
                @"city":_cityStr,
                @"region":_regionStr,
                @"description":_addersTextView.text,
                @"status":@(_seleBtn.selected),
                @"name":_nametext.text,
                @"mobile":_phonetext.text
                };
    }
    else
    {
                dic = @{
                    @"province":_model.province,
                    @"city":_model.city,
                    @"region":_model.region,
                    @"description":_addersTextView.text,
                    @"status":@(_seleBtn.selected),
                    @"name":_nametext.text,
                    @"mobile":_phonetext.text,
                    @"id":@([_model.id integerValue])
                    };

    }
    [self showLoading];

    [self.requestManager postWithUrl:@"api/logistics_address/update.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
          if ([_titleStr isEqualToString:@"地址管理"]) {
              [self showHint:@"添加成功"];
             
          }
        else
        {
            [self showHint:@"修改成功"];

        }
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didaddersObjNotification" object:@""];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
            
        });

        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
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
