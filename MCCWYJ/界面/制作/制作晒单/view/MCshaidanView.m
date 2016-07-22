//
//  MCshaidanView.m
//  MCCWYJ
//
//  Created by MC on 16/5/25.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MCshaidanView.h"
#import "SearchViewController.h"
@interface MCshaidanView ()<SearchViewControllerDelegate,UITextFieldDelegate>{
    
    
    MCIucencyView *_bgView;
    UIView * _MCbgView;
    
    
    UILabel * _commodityLbl;//代购店
    UILabel * _brandLbl;//品牌

    
    
    UITextField * _priceField;//价钱
    UITextField * _numField;//数量
    UITextField * _nameField;//商品名
    UITextField * _modelField;//型号
    UITextField * _colourField;//颜色

    NSString *_commodityStr;
    NSString *_commodityid;

    NSString *_brandStr;
    NSString *_priceStr;
    NSString *_numStr;
    NSString *_nameStr;
    NSString *_modelStr;
    NSString *_colourStr;

    NSInteger _seleindex;

    
}

@end






@implementation MCshaidanView


-(instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _bgView = [[MCIucencyView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, frame.size.height)];
        [_bgView setBgViewColor:[UIColor blackColor]];
        [_bgView setBgViewAlpha:.5];
        [self addSubview:_bgView];
 
        
        
        
        _MCbgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 0)];
        
        
        [self addSubview:_MCbgView];

        
        CGFloat x = 0;
        CGFloat y = 0;
        
        CGFloat w = Main_Screen_Width;
        CGFloat h = 20;
        UILabel *lbl= [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
        lbl.textColor = [UIColor whiteColor];
        lbl.font = AppFont;
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.text = @"添加商品相关信息";
        [_MCbgView addSubview:lbl];
        
        
        
        x = 40;
        w = Main_Screen_Width - 80;
        y += h + 10;
        h = 30;
        
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
        ViewRadius(btn, 15);
        btn.layer.borderColor = [UIColor whiteColor].CGColor;
        btn.layer.borderWidth = 1;
        btn.tag = 900;
        [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_MCbgView addSubview:btn];
       _commodityLbl = [self setlblBtn:btn];
        _commodityLbl.text = @"代购点";
        
        
        y += h + 10;
        w = Main_Screen_Width/2 - 40 - 10;
        
        btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
        ViewRadius(btn, 15);
        btn.layer.borderColor = [UIColor whiteColor].CGColor;
        btn.layer.borderWidth = 1;
        
        [_MCbgView addSubview:btn];
        
     _priceField =   [self setTextBtn:btn];
        _priceField.tag = 200;
        _priceField.delegate = self;
        _priceField.placeholder = @"单价";
        [_priceField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];

        x = Main_Screen_Width/2;
        
        w = Main_Screen_Width/2 - 40;
        
        btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
        ViewRadius(btn, 15);
        btn.layer.borderColor = [UIColor whiteColor].CGColor;
        btn.layer.borderWidth = 1;
        
        [_MCbgView addSubview:btn];
        
       _numField = [self setTextBtn:btn];
        _numField.placeholder = @"数量";
        _numField.tag = 201;
        _numField.delegate = self;

        [_numField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];

        x = 40;
        y += h + 10;
        w = Main_Screen_Width/2 - 40 - 10;
        btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
        ViewRadius(btn, 15);
        btn.layer.borderColor = [UIColor whiteColor].CGColor;
        btn.layer.borderWidth = 1;
        btn.tag = 901;
        [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_MCbgView addSubview:btn];
        _brandLbl = [self setlblBtn:btn];
        _brandLbl.text = @"品牌";

        
        x = Main_Screen_Width/2;
        
        w = Main_Screen_Width/2 - 40;
        
        btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
        ViewRadius(btn, 15);
        btn.layer.borderColor = [UIColor whiteColor].CGColor;
        btn.layer.borderWidth = 1;
        
        [_MCbgView addSubview:btn];
        
        _nameField = [self setTextBtn:btn];
        _nameField.placeholder = @"商品名";
        _nameField.tag = 202;
        _nameField.delegate = self;

        [_nameField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];


        
        
        x = 40;
        y += h + 10;
        w = Main_Screen_Width/2 - 40 - 10;
        btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
        ViewRadius(btn, 15);
        btn.layer.borderColor = [UIColor whiteColor].CGColor;
        btn.layer.borderWidth = 1;
        
        [_MCbgView addSubview:btn];
        _modelField = [self setTextBtn:btn];
        _modelField.placeholder = @"型号";
        _modelField.tag = 203;
        _modelField.delegate = self;

        [_modelField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];

        
        x = Main_Screen_Width/2;
        
        w = Main_Screen_Width/2 - 40;
        
        btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
        ViewRadius(btn, 15);
        btn.layer.borderColor = [UIColor whiteColor].CGColor;
        btn.layer.borderWidth = 1;
        
        [_MCbgView addSubview:btn];
        
        _colourField = [self setTextBtn:btn];
        _colourField.placeholder = @"颜色";
        _colourField.tag = 204;
        _colourField.delegate = self;

        [_colourField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];

        
        
        y += h + 40;
        x = (Main_Screen_Width - w )/2;
        btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
        ViewRadius(btn, 15);
        
        btn.backgroundColor = AppCOLOR;
        [btn setTitleColor:[UIColor whiteColor] forState:0];
        [btn setTitle:@"确定" forState:0];
        btn.titleLabel.font = AppFont;
        [btn addTarget:self action:@selector(actionQD) forControlEvents:UIControlEventTouchUpInside];

        
        [_MCbgView addSubview:btn];
        y += h + 10;
        btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
        ViewRadius(btn, 15);
        
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitleColor:[UIColor grayColor] forState:0];
        [btn setTitle:@"取消" forState:0];
        btn.titleLabel.font = AppFont;
        [btn addTarget:self action:@selector(actionQX) forControlEvents:UIControlEventTouchUpInside];
        
        [_MCbgView addSubview:btn];

        y += h ;
//        if (iPhone6||iPhone6plus) {
//            _MCbgView.frame = CGRectMake(0, (Main_Screen_Height - y )/2, Main_Screen_Width, y);
//
//        }
//        else
//        {
            _MCbgView.frame = CGRectMake(0, (Main_Screen_Height - y )/2 - 40, Main_Screen_Width, y);
//        }
        
        
        
        
    }

    return self;
}
-(void)setCommodityDic:(NSMutableDictionary *)commodityDic
{
    
    _commodityDic = commodityDic;
    
    _commodityStr = commodityDic[@"commodity"]?commodityDic[@"commodity"]:@"";
    _commodityid = commodityDic[@"commodityid"]?commodityDic[@"commodityid"]:@"";
    _commodityLbl.text = commodityDic[@"commodity"]?commodityDic[@"commodity"]:@"代购点";
    
    _priceStr = commodityDic[@"price"]?commodityDic[@"price"]:@"";
    _priceField.text = _priceStr;
    

    _numStr = commodityDic[@"num"]?commodityDic[@"num"]:@"";
    _numField.text = _numStr;
    

    _brandStr = commodityDic[@"brand"]?commodityDic[@"brand"]:@"";
    _brandLbl.text = commodityDic[@"brand"]?commodityDic[@"brand"]:@"品牌";

    

    _nameStr = commodityDic[@"name"]?commodityDic[@"name"]:@"";
    _nameField.text =_nameStr;

    _modelStr = commodityDic[@"model"]?commodityDic[@"model"]:@"";
    _modelField.text = _modelStr;
    
    
    _colourStr = commodityDic[@"colour"]?commodityDic[@"colour"]:@"";
    _colourField.text = _colourStr;
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    
    if (textField.tag == 200) {
        _priceStr = textField.text;
    }
    if (textField.tag == 201) {
        _numStr = textField.text;
    }
    if (textField.tag == 202) {
        _nameStr = textField.text;
    }
    if (textField.tag == 203) {
        _modelStr = textField.text;
    }
    if (textField.tag == 204) {
        _colourStr = textField.text;
    }

    
    
}
-(void)actionQX{
    
    [_delegate removeMCshaidanView];
    
    
}
-(void)actionQD{
    for (NSString *i  in @[@"200",@"201",@"202",@"203",@"204"]) {
        NSInteger tabindex = [i integerValue];
        UITextField * text = [self viewWithTag:tabindex];
        [text resignFirstResponder];
        
        
    }
    NSLog(@"_commodityStr =%@",_commodityStr);
    NSLog(@"_commodityid =%@",_commodityid);

    NSLog(@"_priceStr =%@",_priceStr);
    NSLog(@"_priceStr =%@",_numStr);
    NSLog(@"_priceStr =%@",_brandStr);
    NSLog(@"_nameStr =%@",_nameStr);
    NSLog(@"_modelStr =%@",_modelStr);
    NSLog(@"_colourStr =%@",_colourStr);
    
    if (!_commodityStr.length) {
        kAlertMessage(@"请输入代购点");
        return;
    }
    if (!_commodityid.length) {
        kAlertMessage(@"无效代购点id");
        return;
    }
    if (!_priceStr.length) {
        kAlertMessage(@"请输入单价");
        return;
    }
    if (!_numStr.length) {
        kAlertMessage(@"请输入数量");
        return;
    }
//    if (!_brandStr.length) {
//        kAlertMessage(@"请输入品牌");
//        return;
//    }
    if (!_nameStr.length) {
        kAlertMessage(@"请输入商品名");
        return;
    }

    
    NSDictionary * dic = @{
                           @"commodity":_commodityStr,
                           @"commodityid":_commodityid,
                           @"price":_priceStr,
                           @"num":_numStr,
                           @"brand":_brandStr?_brandStr:@"",
                           @"name":_nameStr,
                           @"model":_modelStr?_modelStr:@"",
                           @"colour":_colourStr?_colourStr:@""
                           
                           };
    
    [_delegate commodityDic:dic];
    
    
    [_delegate removeMCshaidanView];

    
    
    
}
-(UILabel*)setlblBtn:(UIButton*)btn {
    
    CGFloat x = 20;
    CGFloat y = 0;
    CGFloat h = btn.mj_h;
    CGFloat w = btn.mj_w - 40;
  UILabel*  lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textColor = [UIColor whiteColor];
//    lbl.backgroundColor = AppCOLOR;
    lbl.font = AppFont;
    [btn addSubview:lbl];

    return lbl;
    
    
}
-(UITextField*)setTextBtn:(UIButton*)btn {
    
    CGFloat x = 20;
    CGFloat y = 0;
    CGFloat h = btn.mj_h;
    CGFloat w = btn.mj_w - 40;
    UITextField*  lbl = [[UITextField alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.textColor = [UIColor whiteColor];

    lbl.font = AppFont;

    [btn addSubview:lbl];
    
    return lbl;
    
    
}


-(void)actionBtn:(UIButton*)btn{
    
    for (NSString *i  in @[@"200",@"201",@"202",@"203",@"204"]) {
        NSInteger tabindex = [i integerValue];
        UITextField * text = [self viewWithTag:tabindex];
        [text resignFirstResponder];
        
        
    }
    
    SearchViewController  * ctl = [[SearchViewController alloc]init];
    ctl.delegate=self;
//    ctl.isshaidan = YES;

    if (btn.tag == 900) {
       
//        ctl.isdaigoudian = @"1";
        ctl.SearchType = SearchType_POP;
         _seleindex = 1;

        
        
    }
    else if (btn.tag == 901){
        ctl.SearchType = SearchType_brand;
        _seleindex = 2;

//        ctl.isdaigoudian = @"0";
 
    }
    
    [self hiddenView:YES];
    [_delegate pushNewViewController:ctl];

    
}
-(void)selectTitleModel:(jingdianModel*)model{
    
    NSLog(@"model == %@",model);
    if (_seleindex == 1) {
        if ([model.nameChs isEqualToString:@""]) {
            _commodityLbl.text = @"代购点";
            
            if (_commodityStr.length) {
                
                _commodityLbl.text = _commodityStr;//@"代购点";
                
                
            }
            
        }
        else{
            _commodityLbl.text = model.nameChs;
            _commodityStr = model.nameChs;
            _commodityid = model.id;
        }
 
    }
    else
    {
        if ([model.nameChs isEqualToString:@""]) {
            _brandLbl.text =@"品牌";
            if (_brandStr.length) {
                _brandLbl.text = _brandStr;//@
                
            }
            
        }
        else
        {
            _brandLbl.text = model.nameChs;
            _brandStr = model.nameChs;
        }
  
    }
    [self hiddenView:NO];

}

-(void)selectTitleStr:(NSString *)str Key:(NSString *)isKey
{
    
    if ([isKey isEqualToString:@"1"]) {
        if ([str isEqualToString:@""]) {
            _commodityLbl.text = @"代购点";
            if (_commodityStr.length) {
                _commodityLbl.text = _commodityStr;//@"代购点";

            }
            
        }
        else{
            _commodityLbl.text = str;
            _commodityStr = str;
        }
 
    }
    else
    {
        if ([str isEqualToString:@""]) {
            _brandLbl.text =@"品牌";
            if (_brandStr.length) {
                _brandLbl.text = _brandStr;//@
                
            }
            
        }
        else
        {
        _brandLbl.text = str;
            _brandStr = str;
        }
    }
    
    
    [self hiddenView:NO];

    
}

-(void)hiddenView:(BOOL)ishidden{
    
    self.hidden =ishidden;
    
    
}
- (void)showInWindow{
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [app.window addSubview:self];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
