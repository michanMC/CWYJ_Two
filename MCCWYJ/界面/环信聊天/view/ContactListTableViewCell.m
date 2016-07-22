//
//  ContactListTableViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/6/7.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "ContactListTableViewCell.h"

@interface ContactListTableViewCell ()
{
    
    
    friendslistModel * _model;
}

@end


@implementation ContactListTableViewCell


-(void)prepareUI1{
    for (UIView*view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    _imgview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
    ViewRadius(_imgview, 15);
    [self.contentView addSubview:_imgview];
    
    _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(10+40 + 10, 0, Main_Screen_Width - 60, 60)];
    _titleLbl.textColor = [UIColor blackColor];
    [self.contentView addSubview:_titleLbl];
    _titlesubLbl = [[UILabel alloc]initWithFrame:CGRectMake(10+40 + 10, 10+20 +3, Main_Screen_Width - 60, 20)];
    _titlesubLbl.textColor = AppTextCOLOR;
    _titlesubLbl.font = AppFont;
//    [self.contentView addSubview:_titlesubLbl];

    _hongview = [[UIImageView alloc]initWithFrame:CGRectMake(Main_Screen_Width - 20-7, (50-7)/2, 7, 7)];
    _hongview.backgroundColor = AppCOLOR;
    ViewRadius(_hongview, 7/2);
    [self.contentView addSubview:_hongview];
    

    
    
}
-(void)prepareUI2:(friendslistModel*)modle{
    
    for (UIView*view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    _model= modle;
    _imgview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 40, 40)];
    ViewRadius(_imgview, 20);
    _imgview.image = [UIImage imageNamed:@"home_Avatar_44"];
    [self.contentView addSubview:_imgview];
    _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(10+40 + 10, 0, Main_Screen_Width - 60, 50)];
    _titleLbl.textColor = [UIColor blackColor];
    [self.contentView addSubview:_titleLbl];
    
    _hongview = [[UIImageView alloc]initWithFrame:CGRectMake(Main_Screen_Width - 20-7, (50-7)/2, 7, 7)];
    _hongview.backgroundColor = AppCOLOR;
    ViewRadius(_hongview, 7/2);
    [self.contentView addSubview:_hongview];

    
    if (!_issele && !_issfabu) {
        
        UILongPressGestureRecognizer *headerLongPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(headerLongPress:)];
        [self addGestureRecognizer:headerLongPress];
        

    }
    if (_issfabu) {
        _seleBtn = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width  - 30 - 25, 10, 30, 30)];
        [_seleBtn setImage:[UIImage imageNamed:@"list_checkbox_normal"] forState:UIControlStateNormal];
        [_seleBtn setImage:[UIImage imageNamed:@"list_checkbox_checked"] forState:UIControlStateSelected];
        _seleBtn.selected = modle.isSele;
        [_seleBtn addTarget:self action:@selector(actionseleBtn:) forControlEvents:UIControlEventTouchUpInside];

        [self.contentView addSubview:_seleBtn];

    }

  
    
}
-(void)prepareUI3:(friendslistModel*)modle{
    for (UIView*view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    _model = modle;
    _imgview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
    ViewRadius(_imgview, 20);
    _imgview.image = [UIImage imageNamed:@"home_Avatar_44"];
    [self.contentView addSubview:_imgview];
    _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(10+40 + 10, 0, Main_Screen_Width - 60, 60)];
    _titleLbl.textColor = [UIColor blackColor];
    [self.contentView addSubview:_titleLbl];
    
    
    _receiveBtn = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width - 25 - 50, 15, 50, 30)];
    _receiveBtn.backgroundColor = AppCOLOR;
    [_receiveBtn setTitle:@"接受" forState:0];
    [_receiveBtn setTitleColor:[UIColor whiteColor] forState:0];
    _receiveBtn.titleLabel.font = AppFont;
    ViewRadius(_receiveBtn, 3);
    [_receiveBtn addTarget:self action:@selector(actionreceiveBtn) forControlEvents:UIControlEventTouchUpInside];

    [self.contentView addSubview:_receiveBtn];

    
    
}
-(void)actionreceiveBtn{
    if (_delegate) {
        [_delegate selectModle:_model];
    }
    
}
#pragma mark - action
- (void)headerLongPress:(UILongPressGestureRecognizer *)longPress
{
    
    
    if (longPress.state == UIGestureRecognizerStateBegan) {
        if(_delegate  && [_delegate respondsToSelector:@selector(selectModle:)])
        {
            [_delegate selectModle:_model];
        }
    }
}
-(void)actionseleBtn:(UIButton*)btn{
    if (btn.selected) {
        btn.selected = NO;
        _model.isSele = NO;
        [_delegate selectModle2:_model IsAdd:NO];

    }
    else
    {
        btn.selected = YES;
        _model.isSele = YES;

        [_delegate selectModle2:_model IsAdd:YES];


    }
    
    
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
