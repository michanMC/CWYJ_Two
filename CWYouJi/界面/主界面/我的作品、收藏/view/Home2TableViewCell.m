//
//  HomeTableViewCell.m
//  CWYouJi
//
//  Created by MC on 15/10/31.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "Home2TableViewCell.h"
#import "JSBadgeView.h"


@interface Home2TableViewCell (){
    
    UIImageView * _bgimgView;
    UIImageView *_imgView;
    UIImageView *_headimgView;
    UIImageView *_leixingView;

    UILabel *_titleLbl;
    UILabel *_title2Lbl;
    UILabel *_dingweiLbl;
    UILabel *_nameLbl;
    JSBadgeView *_badgeView;
    UILabel *_timeLbl;
    UILabel *_neirongLbl;
    UILabel *_jlLbl;

}

@end


@implementation Home2TableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        _deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(10,(150-35)/2, 35, 35)];
        [_deleteBtn setImage:[UIImage imageNamed:@"list_checkbox_normal"] forState:UIControlStateNormal];
        [_deleteBtn setImage:[UIImage imageNamed:@"list_checkbox_checked"] forState:UIControlStateSelected];
        [self.contentView addSubview:_deleteBtn];

        
        
        CGFloat x = 10;
        CGFloat y = 1;
        CGFloat width = Main_Screen_Width - 20;
        CGFloat height = 148;
        
        _bgimgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _bgimgView.image = [UIImage imageNamed:@"home_list_bg"];
        [self.contentView addSubview:_bgimgView];
        _badgeView = [[JSBadgeView alloc] initWithParentView:_bgimgView alignment:JSBadgeViewAlignmentTopLeft];
        //_badgeView.badgeText = @"2";//[NSString stringWithFormat:@"%d", 0];
        

        x = 10;
        y = 10;
        width = 100;
        height = 100;
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _imgView.image =[UIImage imageNamed:@"travels-details_default-chart04"];
        [_bgimgView addSubview:_imgView];
        
        UIImageView * bgImg = [[UIImageView alloc]initWithFrame:CGRectMake(x, 17, 51, 21)];
        bgImg.image = [UIImage imageNamed:@"时间背景图"];
      //  [_bgimgView addSubview:bgImg];
//        _timeLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 51, 21)];
//        _timeLbl.textColor = [UIColor darkTextColor];
//        _timeLbl.font = [UIFont systemFontOfSize:12];
//        _timeLbl.text = @"09-09";
//        [bgImg addSubview:_timeLbl];
        
        
        y = 97;
        width = 40;
        height = width;
        _headimgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _headimgView.image = [UIImage imageNamed:@"home_default-avatar"];
        ViewRadius(_headimgView, 20);
        _headimgView.layer.borderColor = [UIColor whiteColor].CGColor;
        _headimgView.layer.borderWidth = 1.0;
        [_bgimgView addSubview:_headimgView];
        
        x = 58;
        y = 112;
        width = 76;//Main_Screen_Width - x - 40 - 10;
        height = 20;
        _nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
   // _nameLbl.backgroundColor = [UIColor yellowColor];

        _nameLbl.text = @"michan";
        _nameLbl.textColor = [UIColor grayColor];
        _nameLbl.font = [UIFont systemFontOfSize:13];
        [_bgimgView addSubview:_nameLbl];
        
        
        x = 125;
        y = 10;
        width = 125;
        height = 20;
        _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _titleLbl.textColor = AppTextCOLOR;
        _titleLbl.text = @"比马里亚纳";
        _titleLbl.font = [UIFont systemFontOfSize:13];
        [_bgimgView addSubview:_titleLbl];
       // _titleLbl.backgroundColor = [UIColor yellowColor];

        
        y += height;
        _title2Lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, 166, height)];
        _title2Lbl.textColor = AppTextCOLOR;
        _title2Lbl.text = @"一西太平洋的新海角";
        _title2Lbl.font = [UIFont systemFontOfSize:13];
        [_bgimgView addSubview:_title2Lbl];
       // _title2Lbl.backgroundColor = [UIColor yellowColor];

        y  = 11;
    
        width = 20;
        height = width;
        _leixingView = [[UIImageView alloc]initWithFrame:CGRectMake(Main_Screen_Width  - 60 - 5, y, width, height)];
        _leixingView.image =[UIImage imageNamed:@"食"];
        [_bgimgView addSubview:_leixingView];
        
        
       // x +=width +5;
        _tuijianView = [[UIImageView alloc]initWithFrame:CGRectMake(Main_Screen_Width - 45, y, width, height)];
        _tuijianView.image = [UIImage imageNamed:@"荐"];
        [_bgimgView addSubview:_tuijianView];
        
        
        y  = 50;
        width = 163;
        x = 125;
        height =40;
        _neirongLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _neirongLbl.textColor =  UIColorFromRGB(0x908fa2);
;
        _neirongLbl.numberOfLines = 0;
        _neirongLbl.text = @"北北北北北北北北北北北北北北北北北北北北北北北北北北北北";
        _neirongLbl.font = [UIFont systemFontOfSize:12];
        [_bgimgView addSubview:_neirongLbl];
       // _title2Lbl.backgroundColor = [UIColor yellowColor];

        
        
        
        x = 123;
       // y += height + 8;
        y = 95;//112;
        width = 20;
        height = 20;
        UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(x, y + 1.5, 17, 17)];
        img.image = [UIImage imageNamed:@"home_icon_map"];
        [_bgimgView addSubview:img];
        
        x += width;
        width = 150;
        _dingweiLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
      //  _dingweiLbl.backgroundColor = [UIColor yellowColor];
        _dingweiLbl.text=  @"中国广州";
        _dingweiLbl.textColor =[UIColor grayColor];
        _dingweiLbl.font =[UIFont systemFontOfSize:12];
        [_bgimgView addSubview:_dingweiLbl];
        //_dingweiLbl.backgroundColor = [UIColor yellowColor];

       // x += width + 5;
        x = 123;
       // y +=height + 5;
        y = 112;
        width = 17;
        height = 17;
        img =[[UIImageView alloc]initWithFrame:CGRectMake(x, y + 1.5, width, height)];
        img.image =[UIImage imageNamed:@"travels_icon_time"];
        [_bgimgView addSubview:img];
        x += width + 5;
        width = 100;
        height = 20;
        _timeLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _timeLbl.textColor = [UIColor grayColor];
        _timeLbl.font = [UIFont systemFontOfSize:12];
        _timeLbl.text = @"09-09";
        [_bgimgView addSubview:_timeLbl];
        x = Main_Screen_Width  - 100 -20 - 5;
        _jlLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _jlLbl.textColor = [UIColor grayColor];
        _jlLbl.font = [UIFont systemFontOfSize:12];
       // _jlLbl.text = @"1.30Km";
        _jlLbl.textAlignment = NSTextAlignmentRight;
        [_bgimgView addSubview:_jlLbl];
        
    }
    
    return self;
    
}
-(void)setJlStr:(NSString *)jlStr
{
    _jlLbl.text = jlStr;
}
-(void)setIsEit:(BOOL)isEit
{
    if (isEit) {
        _bgimgView.frame = CGRectMake(60, 1, Main_Screen_Width - 20, 148);
    }
    else
    {
        _bgimgView.frame = CGRectMake(10, 1, Main_Screen_Width - 20, 148);

    }
}
-(void)setTitleStr:(NSString *)titleStr
{
    _titleLbl.text = titleStr;
}
-(void)setTitle2Str:(NSString *)title2Str
{
    _title2Lbl.text = title2Str;
}

-(void)setLeixingStr:(NSString *)leixingStr
{
    _leixingView.image = [UIImage imageNamed:leixingStr];
}
-(void)setIstuijian:(BOOL)istuijian{
    
    _tuijianView.hidden = istuijian;
}
-(void)setDingweiStr:(NSString *)dingweiStr{
    _dingweiLbl.text = dingweiStr;
    
}
-(void)setNameStr:(NSString *)nameStr{
    _nameLbl.text = nameStr;
}
-(void)setImgViewStr:(NSString *)imgViewStr
{
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:imgViewStr] placeholderImage:[UIImage imageNamed:@"travels-details_default-chart04"]];
    
}
-(void)setHeadimgStr:(NSString *)headimgStr
{
    [_headimgView sd_setImageWithURL:[NSURL URLWithString:headimgStr] placeholderImage:[UIImage imageNamed:@"home_default-avatar"]];
    
    
}
-(void)setBadgeStr:(NSString *)badgeStr
{
    _badgeView.badgeText = badgeStr;
}
-(void)setNeirongStr:(NSString *)neirongStr
{
    _neirongLbl.text = neirongStr;
}
-(void)setTimeStr:(NSString *)timeStr{
    _timeLbl.text = timeStr;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

