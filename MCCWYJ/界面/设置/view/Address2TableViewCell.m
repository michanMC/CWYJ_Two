//
//  Address2TableViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/5/4.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "Address2TableViewCell.h"

@interface Address2TableViewCell (){
    
    UILabel * _nameLbl;
    UILabel *_phoneLbl;
    UILabel *_addressLbl;
    UILabel *_morenLbl;
    CGFloat _morenW;
    
    
    
}

@end


@implementation Address2TableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat x = 10;
        CGFloat y = 0;
        CGFloat w = Main_Screen_Width /2;
        CGFloat h = 20;
        _nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
        _nameLbl.textColor = [UIColor darkTextColor];
        _nameLbl.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_nameLbl];
        x = Main_Screen_Width /2;
        _phoneLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
        _phoneLbl.textColor = [UIColor darkTextColor];
        _phoneLbl.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_phoneLbl];

        x = 10;
        y += h + 10;
        w = Main_Screen_Width - x  - 50;
        h = 40;
        
        _addressLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
        _addressLbl.textColor = AppTextCOLOR;//[UIColor darkTextColor];
       // _addressLbl.backgroundColor = [UIColor yellowColor];
        _addressLbl.numberOfLines = 0;
        _addressLbl.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_addressLbl];
 
//      _morenW = [MCIucencyView heightforString:@"[默认]" andHeight:20 fontSize:14];
//        
//        _morenLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, _morenW, 20)];
//        _morenLbl.textColor = AppRegTextCOLOR;//[UIColor darkTextColor];
//        _morenLbl.hidden =YES;
//        _morenLbl.font = [UIFont systemFontOfSize:14];
//        [self.contentView addSubview:_morenLbl];

        y +=h + 10;
        
        _deteBtn = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width - 30 - 20, (y - 30)/2, 30, 30)];
        _deteBtn.backgroundColor = AppRegTextCOLOR;
        [self.contentView addSubview:_deteBtn];

        
        
    }
    return self;
    
}
-(void)setNameStr:(NSString *)nameStr
{
    _nameLbl.text = nameStr;
}
-(void)setPhoneStr:(NSString *)phoneStr
{
    _phoneLbl.text = phoneStr;
}
-(void)setAddressStr:(NSString *)addressStr
{
    _addressLbl.text = addressStr;
}
-(void)setIsmoren:(BOOL)ismoren
{
    if (ismoren) {
        NSString * ss =[NSString stringWithFormat:@"[默认]%@",     _addressLbl.text];
        
      NSMutableAttributedString *btn_arrstring  =  [CommonUtil formatString:ss textColor:RGBCOLOR(127, 125, 147) font:14 textordinaryColor:RGBCOLOR(207, 0, 51) startNum:0 toNum:4];
        
        [_addressLbl setAttributedText:btn_arrstring];

        
    }
    else
    {
        
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
