//
//  AddadderssViewController.m
//  MCCWYJ
//
//  Created by MC on 16/5/5.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "AddadderssViewController.h"
#import "UIPlaceHolderTextView.h"
@interface AddadderssViewController ()
{
    UIView * _bgView1;
    UIView * _bgView2;
    UITextField * _nametext;
    UITextField * _phonetext;
    UITextField * _addersstext;
    UIPlaceHolderTextView *_addersTextView;
    UIButton * _seleBtn;
    
    

    
    
    
    
    
}

@end

@implementation AddadderssViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _titleStr;
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

    y+=h+0.5;
    _phonetext = [[UITextField alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _phonetext.font = AppFont;
    _phonetext.placeholder = @"请输入手机号码，不超过11位";
    [_bgView1 addSubview:_phonetext];

    
    
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
    
    y+=h+0.5 + 5;
    _addersTextView = [[UIPlaceHolderTextView alloc]initWithFrame:CGRectMake(x, y, w, 60 - 10 - 10)];
    _addersTextView.font = AppFont;
    _addersTextView.placeholder = @"请输入详细地址";
    [_bgView2 addSubview:_addersTextView];
    

    
    
    
    
    y = _bgView2.mj_h - 7 - 30;
    w = 30;
    h = 30;
    x = _bgView2.mj_w - 10 - w;
    _seleBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _seleBtn.backgroundColor = [UIColor redColor];
    [_bgView2 addSubview:_seleBtn];
    if ([_titleStr isEqualToString:@"编辑收货地址"]) {
        [self isbianjiAdderss];
    }
    
}
-(void)isbianjiAdderss{
    _nametext.text = @"MC";
    _phonetext.text = @"13420065848";
    _addersstext.text = @"广东省广州市天河区";
    _addersTextView.text = @"唐安录188号8楼紫金互联网咯有些共享";
    
    
    
}
#pragma mark-保存
-(void)addBtn{
    
    
    
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
