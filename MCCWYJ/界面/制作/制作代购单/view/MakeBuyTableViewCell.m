//
//  MakeBuyTableViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/5/21.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MakeBuyTableViewCell.h"

@interface MakeBuyTableViewCell ()
{
    
    
    
    
}

@end


@implementation MakeBuyTableViewCell


-(void)prepareUI1{
    
    for (UIView *view in self.contentView.subviews)
        [view removeFromSuperview];
    CGFloat selfViewH = 44 * 3 + 10 + 10 +20 +5;
    
    CGFloat x = 20;
    CGFloat y = 10;
    CGFloat w = 2;
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, selfViewH - 10)];
    lineView.backgroundColor = AppMCBgCOLOR;//[UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:lineView];
    y = (44 - 8)/2 +10;
    _hongdianView = [[UIView alloc]initWithFrame:CGRectMake(x - 3, y, 8, 8)];
    _hongdianView.backgroundColor = AppCOLOR;//[UIColor groupTableViewBackgroundColor];
    ViewRadius(_hongdianView, 8/2);
    [self.contentView addSubview:_hongdianView];

    
    y = 10;
    x = lineView.mj_x + 2 + 20;
    w =(Main_Screen_Width -x -20) / 2;
   CGFloat h = 44;
    _brandBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _brandBtn.backgroundColor = AppMCBgCOLOR;//[UIColor groupTableViewBackgroundColor];
    [_brandBtn setTitleColor:RGBCOLOR(127, 125, 147) forState:0];
    [_brandBtn setTitle:@"品牌" forState:0];
    _brandBtn.titleLabel.font = AppFont;
    ViewRadius(_brandBtn, 3);
    [self.contentView addSubview:_brandBtn];
    
    x += w + 10;
    _commodityfield = [[UITextField alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _commodityfield.placeholder = @"商品名";
    _commodityfield.font = AppFont;
    _commodityfield.textColor = AppTextCOLOR;
    _commodityfield.backgroundColor =AppMCBgCOLOR;// [UIColor groupTableViewBackgroundColor];
    ViewRadius(_commodityfield, 3);
    _commodityfield.textAlignment = NSTextAlignmentCenter;
    [_commodityfield setValue:RGBCOLOR(127, 125, 147) forKeyPath:@"_placeholderLabel.textColor"];

    [self.contentView addSubview:_commodityfield];

    x = _brandBtn.mj_x;
    y += 44 + 10;
    _modelfield = [[UITextField alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _modelfield.placeholder = @"型号";
    _modelfield.font = AppFont;
    _modelfield.textColor = AppTextCOLOR;
    _modelfield.backgroundColor = AppMCBgCOLOR;//[UIColor groupTableViewBackgroundColor];
    ViewRadius(_modelfield, 3);
    [_modelfield setValue:RGBCOLOR(127, 125, 147) forKeyPath:@"_placeholderLabel.textColor"];

    _modelfield.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_modelfield];
    x += w + 10;
    _colourfield = [[UITextField alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _colourfield.placeholder = @"颜色";
    _colourfield.font = AppFont;
    _colourfield.textColor = AppTextCOLOR;
    _colourfield.backgroundColor = AppMCBgCOLOR;//[UIColor groupTableViewBackgroundColor];
    ViewRadius(_colourfield, 3);
    [_colourfield setValue:RGBCOLOR(127, 125, 147) forKeyPath:@"_placeholderLabel.textColor"];

    _colourfield.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_colourfield];

    x = _brandBtn.mj_x;
    y += 44 + 10;
    lineView = [[UIView alloc]initWithFrame:CGRectMake(x, y, Main_Screen_Width - x - 10, 1)];
    lineView.backgroundColor= AppMCBgCOLOR;//[UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:lineView];

    y+=1 + 9;
    
    _pricefield = [[UITextField alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _pricefield.placeholder = @"单价";
    _pricefield.font = AppFont;
    _pricefield.textColor = AppTextCOLOR;
    _pricefield.backgroundColor = AppMCBgCOLOR;//[UIColor groupTableViewBackgroundColor];
    ViewRadius(_pricefield, 3);
    [_pricefield setValue:RGBCOLOR(127, 125, 147) forKeyPath:@"_placeholderLabel.textColor"];

    _pricefield.textAlignment = NSTextAlignmentCenter;
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(x+w - 20, y + 12, 20, 20)];
    lbl.text = @"￥";
    lbl.textColor = AppTextCOLOR;
    lbl.font = AppFont;
    
    
    [self.contentView addSubview:_pricefield];
    [self.contentView addSubview:lbl];

    
    
    x +=w + 30;
    w -=40;
    h = 30;
   y += 1;
    UIImageView * view = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    view.backgroundColor = [UIColor whiteColor];
    ViewRadius(view, 30/2);
    view.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    view.layer.borderWidth = 1;
    view.image = [UIImage imageNamed:@"数量增减1"];
    view.userInteractionEnabled = YES;
    [self.contentView addSubview:view];

    
    w = view.mj_w / 3;
    x = 0;
    y = 0;
    h = 30;
    _minBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [_minBtn setTitle:@"" forState:0];
    [_minBtn setTitleColor:RGBCOLOR(127, 125, 147) forState:0];
//    _minBtn.backgroundColor = [UIColor yellowColor];
    [view addSubview:_minBtn];

    
    x +=w;
    _countfield = [[UITextField alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _countfield.font = AppFont;
    _countfield.textColor = AppCOLOR;
    _countfield.backgroundColor = [UIColor whiteColor];
    _countfield.text = @"1";
    _countfield.textAlignment = NSTextAlignmentCenter;
//    _countfield.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
//    _countfield.layer.borderWidth = 1;
    
    _countfield.keyboardType  = UIKeyboardTypeNumberPad;
    [view addSubview:_countfield];
    x +=w;
    _addBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [_addBtn setTitle:@"" forState:0];
    [_addBtn setTitleColor:RGBCOLOR(127, 125, 147) forState:0];
//    _addBtn.backgroundColor = [UIColor yellowColor];
    [view addSubview:_addBtn];
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(view.mj_x, view.mj_y + view.mj_h+3, view.mj_w, 15)];
    lbl.text = @"选择数量";
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:lbl];
    
    
    
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)prepareUI7
{
    
    for (UIView *view in self.contentView.subviews)        [view removeFromSuperview];
    CGFloat selfViewH = 44 * 1 + 10 +20;
    
    CGFloat x = 20;
    CGFloat y = 10;
    CGFloat w = 2;
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, selfViewH - 10)];
    lineView.backgroundColor = AppMCBgCOLOR;//[UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:lineView];
    y = (44 - 8)/2 +10;
    _hongdianView = [[UIView alloc]initWithFrame:CGRectMake(x - 3, 0, 8, 8)];
    _hongdianView.backgroundColor = AppCOLOR;//[UIColor groupTableViewBackgroundColor];
    ViewRadius(_hongdianView, 8/2);
    [self.contentView addSubview:_hongdianView];
    
    
    y = 10;
    x = lineView.mj_x + 2 + 20;
    w = Main_Screen_Width - x - 10;//(Main_Screen_Width -x -20) / 2;
    CGFloat h = 44;
    
//    _percentBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
//    _percentBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    [_percentBtn setTitleColor:RGBCOLOR(127, 125, 147) forState:0];
//    [_percentBtn setTitle:@"5%" forState:0];
//    _percentBtn.titleLabel.font = AppFont;
//    ViewRadius(_percentBtn, 3);
//    [self.contentView addSubview:_percentBtn];
    
//    x += w + 10;
    
    _addserBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _addserBtn.backgroundColor = AppMCBgCOLOR;//[UIColor groupTableViewBackgroundColor];
    [_addserBtn setTitleColor:RGBCOLOR(127, 125, 147) forState:0];
    _addserBtn.titleLabel.font = AppFont;
    ViewRadius(_addserBtn, 3);
    [self.contentView addSubview:_addserBtn];
    
    y += 44 + 10;
    x = _addserBtn.mj_x;
    lineView = [[UIView alloc]initWithFrame:CGRectMake(x, y, Main_Screen_Width - x - 10, 1)];
    lineView.backgroundColor= AppMCBgCOLOR;//[UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:lineView];
    
 
}

-(void)prepareUI2{
    
    for (UIView *view in self.contentView.subviews)        [view removeFromSuperview];
    CGFloat selfViewH = 44 * 1 + 10 +20;
    
    CGFloat x = 20;
    CGFloat y = 10;
    CGFloat w = 2;
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, selfViewH - 10)];
    lineView.backgroundColor = AppMCBgCOLOR;//[UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:lineView];
    y = (44 - 8)/2 +10;
    _hongdianView = [[UIView alloc]initWithFrame:CGRectMake(x - 3, 0, 8, 8)];
    _hongdianView.backgroundColor = AppCOLOR;//[UIColor groupTableViewBackgroundColor];
    ViewRadius(_hongdianView, 8/2);
    [self.contentView addSubview:_hongdianView];
    
    
    y = 10;
    x = lineView.mj_x + 2 + 20;
    w =(Main_Screen_Width -x -20) / 2;
    CGFloat h = 44;

    _percentBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _percentBtn.backgroundColor =AppMCBgCOLOR;// [UIColor groupTableViewBackgroundColor];
    [_percentBtn setTitleColor:RGBCOLOR(127, 125, 147) forState:0];
    [_percentBtn setTitle:@"5%" forState:0];
    _percentBtn.titleLabel.font = AppFont;
    ViewRadius(_percentBtn, 3);
    [self.contentView addSubview:_percentBtn];
    
    x += w + 10;
    
    _addserBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _addserBtn.backgroundColor = AppMCBgCOLOR;//[UIColor groupTableViewBackgroundColor];
    [_addserBtn setTitleColor:RGBCOLOR(127, 125, 147) forState:0];
    _addserBtn.titleLabel.font = AppFont;
    ViewRadius(_addserBtn, 3);
    [self.contentView addSubview:_addserBtn];

    y += 44 + 10;
    x = _percentBtn.mj_x;
    lineView = [[UIView alloc]initWithFrame:CGRectMake(x, y, Main_Screen_Width - x - 10, 1)];
    lineView.backgroundColor= AppMCBgCOLOR;//[UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:lineView];
    
}

-(void)prepareUI3{
    
    
    for (UIView *view in self.contentView.subviews)        [view removeFromSuperview];
    CGFloat selfViewH = 150;
    
    CGFloat x = 20;
    CGFloat y = 0;
    CGFloat w = 2;
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, selfViewH - 0)];
    lineView.backgroundColor =AppMCBgCOLOR;// [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:lineView];

    y = (selfViewH - 8)/2;
    _hongdianView = [[UIView alloc]initWithFrame:CGRectMake(x - 3, y, 8, 8)];
    _hongdianView.backgroundColor = AppCOLOR;//[UIColor groupTableViewBackgroundColor];
    ViewRadius(_hongdianView, 8/2);
    [self.contentView addSubview:_hongdianView];

    
    
    x = lineView.mj_x + 2 + 20;
    w =(Main_Screen_Width -x -10);
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(x, 0, w, selfViewH)];
    view.backgroundColor = AppMCBgCOLOR;//[UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:view];
    
    x = 10;
    y = 10;
    w = view.mj_w - 20;
   CGFloat h = view.mj_h - 20 - 10;
    
    _describefeildView = [[UIPlaceHolderTextView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _describefeildView.placeholder = @"描述";
    _describefeildView.textColor = AppTextCOLOR;
    _describefeildView.font = AppFont;
    _describefeildView.backgroundColor = AppMCBgCOLOR;//[UIColor groupTableViewBackgroundColor];
    [view addSubview:_describefeildView];
    
    _countLbl = [[UILabel alloc]initWithFrame:CGRectMake(view.mj_w - 10 - 100, view.mj_h - 20, 100, 20)];
    _countLbl.textColor = AppTextCOLOR;
    _countLbl.font = AppFont;
    _countLbl.textAlignment = NSTextAlignmentRight;
    _countLbl.text = @"1/500";
    [view addSubview:_countLbl];
    
}
-(void)prepareUI4{
    
    for (UIView *view in self.contentView.subviews)        [view removeFromSuperview];
    CGFloat selfViewH = 20 + 20 + 100 +10 + 20;
    
    CGFloat x = 20;
    CGFloat y = 0;
    CGFloat w = 2;
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, selfViewH - 0)];
    lineView.backgroundColor = AppMCBgCOLOR;//[UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:lineView];
    
    y = (selfViewH - 8)/2;
    _hongdianView = [[UIView alloc]initWithFrame:CGRectMake(x - 3, y, 8, 8)];
    _hongdianView.backgroundColor = AppCOLOR;//[UIColor groupTableViewBackgroundColor];
    ViewRadius(_hongdianView, 8/2);
    [self.contentView addSubview:_hongdianView];
    
    
  
    
    x = lineView.mj_x + 2 + 20;
    w =(Main_Screen_Width -x -10);
    
   lineView = [[UIView alloc]initWithFrame:CGRectMake(x, 10, w, 1)];
    lineView.backgroundColor = AppMCBgCOLOR;//[UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:lineView];

    
    y = 20;
   CGFloat h = 20;
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.text = @"支付采点";
    lbl.textColor = AppTextCOLOR;
    lbl.font = AppFont;
    [self.contentView addSubview:lbl];

    w = 64;
    h = 64;
    y =(selfViewH -w)/2 + 20;
    x = (Main_Screen_Width - w)/2 - w - 10 + 40;
    
    _caidianLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _caidianLbl.textColor = AppCOLOR;
    _caidianLbl.text = @"22";
    _caidianLbl.textAlignment = NSTextAlignmentCenter;
    _caidianLbl.font = [UIFont systemFontOfSize:22];
    _caidianLbl.layer.borderColor =RGBCOLOR(232, 48, 17).CGColor;
    _caidianLbl.layer.borderWidth = 1;
    ViewRadius(_caidianLbl, w/2);
    [self.contentView addSubview:_caidianLbl];

    x = (Main_Screen_Width - w)/2 + 40 + 20;
    y = 0;
    w = 60;
    _caidianPikcerView = [[UIPickerView alloc]initWithFrame:CGRectMake(x, y, w, 60)];
    
    if (IOS8) {
        _caidianPikcerView.frame = CGRectMake(x, (selfViewH - 100)/2, w, 100);
    }
//    _caidianPikcerView.backgroundColor = [UIColor whiteColor];
    // 显示选中框
//    _caidianPikcerView.showsSelectionIndicator=YES;
//    pickerView.dataSource = self;
//    pickerView.delegate = self;
    [self.contentView addSubview:_caidianPikcerView];
    
    x += w + 10;
    y = (selfViewH-20)/2;
    w = 20;
    h = 20;
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.text = @"%";
    lbl.textColor = AppTextCOLOR;
    [self.contentView addSubview:lbl];

    
    x = lineView.mj_x + 2 + 20;
    w =(Main_Screen_Width -x -10);
    
    lineView = [[UIView alloc]initWithFrame:CGRectMake(x, selfViewH - 8, w, 1)];
    lineView.backgroundColor = AppMCBgCOLOR;//[UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:lineView];

    
    
}
-(void)prepareUI5{
    for (UIView *view in self.contentView.subviews)        [view removeFromSuperview];
    CGFloat selfViewH = 44;
    CGFloat x = 20;
    CGFloat y = 0;
    CGFloat w = 2;
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, selfViewH - 0)];
    lineView.backgroundColor =AppMCBgCOLOR;// [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:lineView];
    
    y = (selfViewH - 8)/2;
    _hongdianView = [[UIView alloc]initWithFrame:CGRectMake(x - 3, y, 8, 8)];
    _hongdianView.backgroundColor = AppCOLOR;//[UIColor groupTableViewBackgroundColor];
    ViewRadius(_hongdianView, 8/2);
    [self.contentView addSubview:_hongdianView];
    
    
    x = lineView.mj_x + 2 + 20;
    w =(Main_Screen_Width -x -10);
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(x, 0, w, selfViewH)];
    view.backgroundColor = AppMCBgCOLOR;//[UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:view];
    ViewRadius(view, 3);
    
    _juriLbl = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, 44)];
    _juriLbl.textColor = AppTextCOLOR;
    _juriLbl.text = @"谁可以看";
    _juriLbl.font = [UIFont systemFontOfSize:15];
    [view addSubview:_juriLbl];
    
    
    UIImageView * imgview = [[UIImageView alloc]initWithFrame:CGRectMake(view.mj_w - 10 - 20, 12, 22, 20)];
    imgview.image = [UIImage imageNamed:@"icon_more2"];
    [view addSubview:imgview];
    
    _juri2Lbl = [[UILabel alloc]initWithFrame:CGRectMake(imgview.mj_x - 200 - 20, 0, 200, 44)];
    _juri2Lbl.textColor = AppTextCOLOR;
    _juri2Lbl.text = @"公开";
    _juri2Lbl.textAlignment = NSTextAlignmentRight;
    _juri2Lbl.font = [UIFont systemFontOfSize:15];
    [view addSubview:_juri2Lbl];
    
    
    
}
-(void)prepareUI6{
    
    for (UIView *view in self.contentView.subviews)        [view removeFromSuperview];
    CGFloat selfViewH = 20 + 44 + 44 + 20 + 10;
    CGFloat x = 20;
    CGFloat y = 0;
    CGFloat w = 2;
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, selfViewH - 0)];
    lineView.backgroundColor =AppMCBgCOLOR;// [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:lineView];
    
    y = (selfViewH - 8)/2 + 10;
    _hongdianView = [[UIView alloc]initWithFrame:CGRectMake(x - 3, y, 8, 8)];
    _hongdianView.backgroundColor = AppCOLOR;//[UIColor groupTableViewBackgroundColor];
    ViewRadius(_hongdianView, 8/2);
    [self.contentView addSubview:_hongdianView];

    
    
    
    x = lineView.mj_x + 2 + 20;
    
    w =(Main_Screen_Width -x -10);
    lineView = [[UIView alloc]initWithFrame:CGRectMake(x, 10, w, 1)];
    lineView.backgroundColor = AppMCBgCOLOR;//[UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:lineView];
    
    UIView * view2 = [[UIView alloc]initWithFrame:CGRectMake(x, 20 , w, 44)];
    view2.backgroundColor = AppMCBgCOLOR;//[UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:view2];
    ViewRadius(view2, 3);

    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 44)];
    lbl.textColor = AppTextCOLOR;
    lbl.text = @"当面交易";
    lbl.font = AppFont;
    [view2 addSubview:lbl];
    
    
    _seleBtn1= [[UIButton alloc]initWithFrame:CGRectMake(view2.mj_w - 30, 6, 30, 30)];
    [_seleBtn1 setImage:[UIImage imageNamed:@"list_checkbox_normal"] forState:UIControlStateNormal];
    [_seleBtn1 setImage:[UIImage imageNamed:@"list_checkbox_checked"] forState:UIControlStateSelected];
    [view2 addSubview:_seleBtn1];
    _seleBtn1.userInteractionEnabled = NO;
    _seleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, view2.mj_w, view2.mj_h)];
    [view2 addSubview:_seleBtn];
    
    
    

    
     _adderbgView= [[UIView alloc]initWithFrame:CGRectMake(x, 20 + 44 + 10, w, 44)];
    _adderbgView.backgroundColor = AppMCBgCOLOR;//[UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:_adderbgView];
    ViewRadius(_adderbgView, 3);
    
    

    
    

    UIImageView * imgview = [[UIImageView alloc]initWithFrame:CGRectMake(_adderbgView.mj_w - 10 - 20, 12, 22, 20)];
    imgview.image = [UIImage imageNamed:@"icon_more2"];
    [_adderbgView addSubview:imgview];
    
    _addserLbl = [[UILabel alloc]initWithFrame:CGRectMake( 20, 0, _adderbgView.mj_w - 20 - 10 - 30, 44)];
    _addserLbl.textColor = AppTextCOLOR;
    _addserLbl.text = @"广东省广州市天河区唐安路1213号";
    _addserLbl.font = [UIFont systemFontOfSize:14];
    [_adderbgView addSubview:_addserLbl];

    _adderseleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, _adderbgView.mj_w, _adderbgView.mj_h)];
//    if (!_seleBtn1.selected) {
//        _addserBtn.userInteractionEnabled = YES;
//    }
//    else
//        _addserBtn.userInteractionEnabled = NO;

    [_adderbgView addSubview:_adderseleBtn];

    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
