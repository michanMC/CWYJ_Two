//
//  zuopinQxTableViewCell.m
//  CWYouJi
//
//  Created by MC on 15/11/7.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "zuopinQxTableViewCell.h"
#import "MCbackButton.h"
@interface zuopinQxTableViewCell (){
    UILabel * _titleLbl;
    UILabel * _subTitleLbl;
    UILabel * _dingweiLbl;
    UILabel * _timeLbl;
    UIImageView * _keyImgView;
    UIImageView * _tuijanImgView;

    UILabel *_dataLbl;
    
    UIView *_foorView;
    
    UIImageView * _headimgView;
    UILabel *_nameLbl;
}

@end

@implementation zuopinQxTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier   {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        

        CGFloat x = 20;
        CGFloat y = 10;
        CGFloat width = Main_Screen_Width - 80 - 30;
        CGFloat height = 20;
        _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _titleLbl.textColor = AppTextCOLOR;
        _titleLbl.font = [UIFont systemFontOfSize:16];
        _titleLbl.text = @"北马里亚纳";

        [self.contentView addSubview:_titleLbl];
        
        y += height;
        width -= 50;
        _subTitleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _subTitleLbl.textColor = AppTextCOLOR;
        _subTitleLbl.text = @"一西太平洋的新海角";
        _subTitleLbl.font = [UIFont systemFontOfSize:16];

        [self.contentView addSubview:_subTitleLbl];

        x = Main_Screen_Width - 80 - 50;
        width = 20;
        _keyImgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _keyImgView.image = [UIImage imageNamed:@"景"];
        [self.contentView addSubview:_keyImgView];
        x += width + 5;
        _tuijanImgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _tuijanImgView.image = [UIImage imageNamed:@"荐"];
        [self.contentView addSubview:_tuijanImgView];
        x = 20;
        y +=height + 10;
        width = 15;
        height = 15;
        UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(x, y+2, width, height)];
        
        img.image =[UIImage imageNamed:@"home_icon_map"];
        [self.contentView addSubview:img];
        
        x +=width;
        height = 20;
        width =( Main_Screen_Width - 80 - 40)/2 + 100;
        _dingweiLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _dingweiLbl.text = @"广州";
        _dingweiLbl.textColor = [UIColor grayColor];
        _dingweiLbl.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_dingweiLbl];
        
        
        x = (Main_Screen_Width - 80 - 50 - 15);
        width = 15;
        height = 15;
        
        img = [[UIImageView alloc]initWithFrame:CGRectMake(x, y+2, width, height)];
        img.image =[UIImage imageNamed:@"travels_icon_time"];
        [self.contentView addSubview:img];
        
        x +=width;
        height = 20;
        width =55;//( Main_Screen_Width - 80 - 40)/2;
        _timeLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _timeLbl.text = @"09-09";
        _timeLbl.textColor = [UIColor grayColor];
        _timeLbl.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_timeLbl];

        x = 20;
        y += 10 + height;
        
        width = Main_Screen_Width- 80-30;
        height = 20;//105
        _dataLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _dataLbl.textColor = [UIColor grayColor];
        _dataLbl.font = [UIFont systemFontOfSize:13];
        _dataLbl.numberOfLines = 0;
        _dataLbl.text=  @"王企鹅王企鹅王企鹅王企鹅王企鹅请问请问去问问企鹅我去";
        [self.contentView addSubview:_dataLbl];
        
        x = 0;
        y += height + 10  ;
        width = Main_Screen_Width - 80;
        height = 65;//160
       // 120 + 65
        
        _foorView = [[UIView alloc]initWithFrame:CGRectMake(x, y, width, height)];
       // _foorView.backgroundColor = [UIColor yellowColor];
        

        [self.contentView addSubview:_foorView];
        x = 10;
        y = 20;
        width = 35;
        height = 35;
        _headimgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _headimgView.image = [UIImage imageNamed:@"home_default-avatar"];
        ViewRadius(_headimgView, 35/2);
        _headimgView.layer.borderColor = [UIColor whiteColor].CGColor;
        _headimgView.layer.borderWidth = 1.0;
        
        [_foorView addSubview:_headimgView];
        
        x += width + 5;
        width = 130;
        _nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _nameLbl.textColor = [UIColor grayColor];
       // _nameLbl.backgroundColor = [UIColor yellowColor];
        _nameLbl.text = @"michan";
        _nameLbl.adjustsFontSizeToFitWidth = YES;
       // _nameLbl.minimumFontSize= 10;
        _nameLbl.font = AppFont;
        [_foorView addSubview:_nameLbl];
        
        
        y += 7;
        
        x = Main_Screen_Width - 80 - 50-10;
        width = 50;
        height = 20;
        _shouchangBtn = [[MCbackButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
        [_shouchangBtn setImage:[UIImage imageNamed:@"travels_icon_favorite_normal"] forState:UIControlStateNormal];
        _shouchangBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_shouchangBtn setTitle:@"收藏" forState:UIControlStateNormal];
        [_shouchangBtn setTitleColor:[UIColor grayColor] forState:0];
        [_foorView addSubview:_shouchangBtn];
        
        
        
        _gengimg = [[UIImageView alloc]initWithFrame:CGRectMake((Main_Screen_Width - 80 - 30) / 2, 5, 30, 5)];
        
        _gengimg.image =[UIImage imageNamed:@"travels_more_dot"];
        _gengimg.tag = 909;
        [_foorView addSubview:_gengimg];
        _gengduoBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, _foorView.frame.size.width, 20)];
      //  _gengduoBtn.backgroundColor = [UIColor redColor];
        [_foorView addSubview:_gengduoBtn];
        
        
    }
    
    return self;
    
    
}
-(void)setIsshouchang:(BOOL)isshouchang
{
    
    if (isshouchang) {
        [_shouchangBtn setTitle:@"已收藏" forState:0];
        [_shouchangBtn setImage:[UIImage imageNamed:@"travels_icon_favorite_pressed"] forState:0];
    }
    else
    {
        [_shouchangBtn setTitle:@"收藏" forState:0];
        [_shouchangBtn setImage:[UIImage imageNamed:@"travels_icon_favorite_normal"] forState:0];
        
    }
    
    
}
-(void)setTimeStr:(NSString *)timeStr
{
    NSLog(@"%@",timeStr);
    
    _timeLbl.text = timeStr;
}
-(void)setTitleStr:(NSString *)titleStr
{
    
    _titleLbl.text = titleStr;
}

-(void)setSubTitleStr:(NSString *)subTitleStr
{
    _subTitleLbl.text = subTitleStr;
}
-(void)setKeyImgStr:(NSString *)keyImgStr
{
    _keyImgView.image = [UIImage imageNamed:keyImgStr];
}
-(void)setTuijanImgStr:(NSString *)tuijanImgStr
{
    _tuijanImgView.image = [UIImage imageNamed:tuijanImgStr];

}
-(void)setDingweiStr:(NSString *)dingweiStr
{
    _dingweiLbl.text = dingweiStr;
    
}
-(void)setIsgengduan:(BOOL)isgengduan
{
    _isgengduan = isgengduan;
   //gengimg.hidden = isgengduan;
}

-(void)setDataStr:(NSString *)dataStr
{
    CGFloat h = [MCIucencyView heightforString:dataStr andWidth:Main_Screen_Width - 80 - 30 fontSize:13];
    if (_isgengduan) {
        _dataLbl.frame = CGRectMake(20, 85, Main_Screen_Width - 30 - 80, h);
        _foorView.frame = CGRectMake(0, _dataLbl.frame.origin.y + h, Main_Screen_Width - 80, 55);
        

    }
    _dataLbl.text = dataStr;
   
    
}
-(void)setNameLStr:(NSString *)nameLStr
{
    _nameLbl.text = nameLStr;
}
-(void)setHeadimgStr:(NSString *)headimgStr
{
    [_headimgView sd_setImageWithURL:[NSURL URLWithString:headimgStr] placeholderImage:[UIImage imageNamed:@"home_default-avatar"]];
    
}
-(void)setIshiddenShouC:(BOOL)ishiddenShouC
{
    UIImageView * img = (UIImageView*)[self.contentView viewWithTag:909];
    img.hidden = ishiddenShouC;
    _shouchangBtn.hidden = ishiddenShouC;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
