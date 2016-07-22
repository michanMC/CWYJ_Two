//
//  MCDrawBackTableViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/7/14.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MCDrawBackTableViewCell.h"

@implementation MCDrawBackTableViewCell
-(void)prepareUI{
    
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    self.contentView.backgroundColor = AppMCBgCOLOR;
    CGFloat x = 10;
    CGFloat y = 10;
    CGFloat w = Main_Screen_Width - 2 * x;
    CGFloat h = 44;
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    bgView.backgroundColor = [UIColor whiteColor];
    ViewRadius(bgView , 3);
    [self.contentView addSubview:bgView];
    
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 64, h)];
    lbl.textColor = AppTextCOLOR;
    lbl.text = @"退款原因";
    lbl.font = [UIFont systemFontOfSize:16];
    [bgView addSubview:lbl];
    
    _lbl1  = [[UILabel alloc]initWithFrame:CGRectMake(10 + 64 + 10, 0, bgView.mj_w - 84, h)];
    _lbl1.textColor = AppTextCOLOR;
    _lbl1.text = @"请选择退款原因";
    _lbl1.font = [UIFont systemFontOfSize:16];
    [bgView addSubview:_lbl1];
    
    
    _seleBtn = [[UIButton alloc]initWithFrame:CGRectMake(_lbl1.mj_x, 0, _lbl1.mj_w, h)];
    
    [bgView addSubview:_seleBtn];
    
    
    
    
    y +=h + 10;
    
    bgView = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    bgView.backgroundColor = [UIColor whiteColor];
    ViewRadius(bgView , 3);
    [self.contentView addSubview:bgView];

    lbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 64, h)];
    lbl.textColor = AppTextCOLOR;
    lbl.text = @"退款金额";
    lbl.font = [UIFont systemFontOfSize:16];
    [bgView addSubview:lbl];

    _text1 = [[UITextField alloc]initWithFrame:CGRectMake(10 + 64 + 10, 0, bgView.mj_w - 84, h)];
    _text1.textColor = AppTextCOLOR;
    _text1.font = [UIFont systemFontOfSize:16];
    _text1.placeholder = @"输入退款金额";
    [bgView addSubview:_text1];
//    _text1.userInteractionEnabled = NO;

    
    y +=h + 20;
    h = 20;
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(10, y, 64, h)];
    lbl.textColor = AppTextCOLOR;
    lbl.text = @"退款说明";
    lbl.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:lbl];
    
    y += h + 10;
    h  = 200;
    
    bgView = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    bgView.backgroundColor = [UIColor whiteColor];
    ViewRadius(bgView , 3);
    [self.contentView addSubview:bgView];
//    NSLog(@"y == %f",y+h);
    _textView1 = [[UIPlaceHolderTextView alloc]initWithFrame:CGRectMake(5, 5, bgView.mj_w - 10, 175)];
    _textView1.textColor = AppTextCOLOR;
    _textView1.font = AppFont;
    _textView1.placeholder = @"请输入详细的退款说明";
    [bgView addSubview:_textView1];
    _lblcount = [[UILabel alloc]initWithFrame:CGRectMake(0, 180, bgView.mj_w - 10, 20)];
    _lblcount.textColor = AppTextCOLOR;
    _lblcount.font = AppFont;
    _lblcount.textAlignment = NSTextAlignmentRight;
    _lblcount.text = @"还可输入200字";
    [bgView addSubview:_lblcount];

    
    
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
