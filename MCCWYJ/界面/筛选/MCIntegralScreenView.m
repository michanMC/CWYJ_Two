//
//  MCIntegralScreenView.m
//  MCCWYJ
//
//  Created by MC on 16/6/1.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MCIntegralScreenView.h"


@interface MCIntegralScreenView ()
{
    UIButton * _allBtn;
    UIButton * _dayDataBtn;
    UIButton * _yearDataBtn;
    UIButton * _myDataBtn;

    UIButton * _startTimeBtn;
    UIButton * _finishTimeBtn;

    UIButton * _okBtn;
    
    
    
    
    MCIucencyView *_bgView;
    
    UIView * _bg2View;
    UIView *_okBgView;
    
    
    
    
    
    BOOL isshowtime;
    UIView                * _inputView;//时间）
    UIDatePicker          * _datePicker;//用以选择时间的时间选择器
    UIView                * _maskView;//弹出inputView时的蒙版
    CGFloat               _inputViewHeight;
    NSString * _timeStr;
    NSInteger _indextime;

    
    UIButton * _seleBtn;
    
}

@end



@implementation MCIntegralScreenView

-(instancetype)initWithFrame:(CGRect)frame
{
    
    
    self = [super initWithFrame:frame];
    if (self) {
        _indextime = 0;
        _bgView = [[MCIucencyView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, frame.size.height)];
        [_bgView setBgViewColor:[UIColor blackColor]];
        [_bgView setBgViewAlpha:.5];
        [self addSubview:_bgView];
   
        _bg2View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 10 + 20 + 30 + 10 + 50)];
        
        _bg2View.backgroundColor = [UIColor whiteColor];
        [_bgView addSubview:_bg2View];
        
        
        CGFloat x = 10;
        CGFloat y = 10;
        CGFloat w = 100;
        CGFloat h = 10;
        
        
        
        UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
        lbl.text = @"时间";
        lbl.textColor = [UIColor grayColor];
        lbl.font = AppFont;
        [_bg2View addSubview:lbl];
        
        NSArray *titelarray = @[
                                @"全部",
                                @"当日明细",
                                @"当月明细",
                                @"自定义"
                                
                                ];
        y += h + 10;
        w = (Main_Screen_Width - 10*5)/4;
        h = 30;
        
        for (NSInteger  i = 0; i < titelarray.count; i ++) {
            
            NSString * str = titelarray[i];
            
           UIButton* _selectBtn = [[UIButton alloc]initWithFrame:CGRectMake(x , y, w, h)];
            _selectBtn.tag = i + 900;
            [_selectBtn setTitle:str forState:0];
            [_selectBtn setTitleColor:RGBCOLOR(127, 125, 147) forState:UIControlStateNormal];
            [_selectBtn setTitleColor:RGBCOLOR(232, 48, 17) forState:UIControlStateSelected];
            _selectBtn.titleLabel.font = AppFont;
            _selectBtn.layer.borderWidth = 1;
           [_selectBtn addTarget:self action:@selector(actionselectBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            [_bg2View addSubview:_selectBtn];
            ViewRadius(_selectBtn, 3);
            
            CGFloat imgw = 20;
            CGFloat imgh = 20;
            
            CGFloat imgx = x + w - 15;
            CGFloat imgy = y-5;
            
            
            UIImageView * imgeView = [[UIImageView alloc]initWithFrame:CGRectMake(imgx, imgy, imgw, imgh)];
            imgeView.image = [UIImage imageNamed:@"icon_selected"];
            imgeView.tag = i + 910;

            [_bg2View addSubview:imgeView];
            
            
            
            
            
            
            if ( i == 0) {
                _selectBtn.selected = YES;
                _selectBtn.layer.borderColor = RGBCOLOR(232, 48, 17).CGColor;
                imgeView.hidden = NO;
                
            }
            else
            {
                _selectBtn.selected = NO;;
                _selectBtn.layer.borderColor = RGBCOLOR(127, 125, 147).CGColor;
                imgeView.hidden = YES;
                
                
            }
            
            x += w + 10;
            
        }
        
        y += h+10;
        
        
        _startTimeBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, y, (Main_Screen_Width-40)/2, 40)];
        [_startTimeBtn setTitle:@"请选择开始时间" forState:0];
        [_startTimeBtn setTitleColor:RGBCOLOR(127, 125, 147) forState:UIControlStateNormal];
        [_startTimeBtn setTitleColor:RGBCOLOR(232, 48, 17) forState:UIControlStateSelected];
        _startTimeBtn.titleLabel.font = AppFont;
        _startTimeBtn.layer.borderWidth = 1;
        [_bg2View addSubview:_startTimeBtn];
        _startTimeBtn.hidden = YES;
        _startTimeBtn.tag = 700;
        [_startTimeBtn addTarget:self action:@selector(actionTimeBtn:) forControlEvents:UIControlEventTouchUpInside];
        ViewRadius(_startTimeBtn, 3);

        
        _finishTimeBtn = [[UIButton alloc]initWithFrame:CGRectMake(10+10+10 +(Main_Screen_Width-40)/2, y, (Main_Screen_Width-40)/2, 40)];
        [_finishTimeBtn setTitle:@"请选择结束时间" forState:0];
        [_finishTimeBtn setTitleColor:RGBCOLOR(127, 125, 147) forState:UIControlStateNormal];
        [_finishTimeBtn setTitleColor:RGBCOLOR(232, 48, 17) forState:UIControlStateSelected];
        _finishTimeBtn.titleLabel.font = AppFont;
        _finishTimeBtn.layer.borderWidth = 1;
        _finishTimeBtn.tag = 701;

        [_finishTimeBtn addTarget:self action:@selector(actionTimeBtn:) forControlEvents:UIControlEventTouchUpInside];

        [_bg2View addSubview:_finishTimeBtn];
        _finishTimeBtn.hidden = YES;
        ViewRadius(_finishTimeBtn, 3);
        
        
        
        _okBgView = [[UIView alloc]initWithFrame:CGRectMake(0, y, Main_Screen_Width, 50)];
        [_bg2View addSubview:_okBgView];
        _okBgView.backgroundColor = [UIColor whiteColor];
        
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 0.5)];
        lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_okBgView addSubview:lineView];
        
        
        _okBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0.5, Main_Screen_Width, 49)];
        
        [_okBtn setTitle:@"确认" forState:0];
        
        [_okBtn setTitleColor:[UIColor grayColor] forState:0];
        
        [_okBgView addSubview:_okBtn];
        
        [_okBtn addTarget:self action:@selector(actionokBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actiontap:)];
        [_bgView addGestureRecognizer:tap];


        
        
        
        
        
        
    }
    return self;
    
}
-(void)setSeleIndex:(NSInteger)seleIndex
{
    NSInteger tagindex  = 900;
    if (seleIndex == -1) {
        tagindex = 900;
    }
    if (seleIndex == 0) {
        tagindex = 901;
    }
    if (seleIndex == 1) {
        tagindex = 902;
    }
    if (seleIndex == 2) {
        tagindex = 903;
        
            [_startTimeBtn setTitle:_startTime forState:0];
            [_finishTimeBtn setTitle:_endTime forState:0];
            

    }
    UIButton * btn = [self viewWithTag:tagindex];
    [self actionselectBtn:btn];
    
    
    
}
-(void)actionTimeBtn:(UIButton*)btn{
    if (btn.tag == 700) {
        _indextime = 1;
    }
    else
        _indextime = 2;
 
    [self actionTime];
    
    
}
-(void)actiontap:(UITapGestureRecognizer*)tap{
    if (_delegate) {
        [self hiddenInputView];

        [_delegate MCscreenhidden];
    }
    // [self removeFromSuperview];
    
}
-(void)actionokBtn:(UIButton*)btn{
    if (_delegate) {
        [self hiddenInputView];

        [_delegate MCscreenhidden];
        NSInteger index= 0;
        if (_seleBtn) {
       index  = _seleBtn.tag - 900;
         
            
        }
        else
        {
            index = 0;
        }
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        [dic setObject:[NSString stringWithFormat:@"%zd",index] forKey:@"seleindex"];
        if (index== 3) {
            [dic setObject:_startTime?_startTime:@"" forKey:@"start"];
            [dic setObject:_endTime?_endTime:@"" forKey:@"endTime"];

        }
        [_delegate MCscreenselsctDic:dic];
        
    }

    
}
-(void)StateNormal:(UIButton*)btn{
    
    btn.selected = NO;
    NSInteger i = btn.tag + 10;
    UIImageView * btnimg = [self viewWithTag: i];
    btnimg.hidden = YES;
    
    btn.layer.borderColor = RGBCOLOR(127, 125, 147).CGColor;


    
}
-(void)actionselectBtn:(UIButton*)btn{
    
    for (NSInteger i = 0; i < 4; i ++) {
        UIButton * btn = [self viewWithTag:900 + i];
        
        [self StateNormal:btn];
        
    }
    btn.selected = YES;
    btn.layer.borderColor = RGBCOLOR(232, 48, 17).CGColor;
    _seleBtn =btn;
    NSInteger i = btn.tag + 10;
    UIImageView * btnimg = [self viewWithTag: i];
    btnimg.hidden = NO;
    if (btn.tag == 903&&!isshowtime) {
        isshowtime = YES;
        [self showTime];
    }
    
    
}
-(void)showTime{
    _bg2View .frame= CGRectMake(0, 0, Main_Screen_Width, 10 + 20 + 30 + 10 + 50 + 40+10);
    _startTimeBtn.hidden = NO;
    _finishTimeBtn.hidden = NO;

    _okBgView.frame = CGRectMake(0, _okBgView.mj_y + 40 + 10, Main_Screen_Width, 50);
    
    
    
}
- (void)showInWindow{
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app.window addSubview:self];
    
    
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
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    _timeStr = [dateFormatter stringFromDate:date];
    [self hiddenInputView];
//    _timeLbl.text =_timeStr;
    if (_indextime==1) {
        
        _startTime = _timeStr;
        [_startTimeBtn setTitle:_timeStr forState:0];
    }
    else if (_indextime==2){
        _endTime = _timeStr;
        [_finishTimeBtn setTitle:_timeStr forState:0];

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




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
