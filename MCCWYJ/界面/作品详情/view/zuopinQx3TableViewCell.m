//
//  zuopinQx3TableViewCell.m
//  CWYouJi
//
//  Created by MC on 15/11/7.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "zuopinQx3TableViewCell.h"

@interface zuopinQx3TableViewCell (){
    UIImageView *_headImgView;
    UILabel * _nameLbl;
    
    UILabel *_titleLbl;
    
    
    
    
}

@end

@implementation zuopinQx3TableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier   {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat x = 20;
        CGFloat y = 0;
        CGFloat width = Main_Screen_Width - 80 - 40;
        CGFloat height = 0.5;
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        line.backgroundColor = [UIColor grayColor];
        //[self.contentView addSubview:line];
        
        y += height + 10;
        width = 25;
        height = 25;
        _headImgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _headImgView.image =[UIImage imageNamed:@"home_default-avatar"];
        ViewRadius(_headImgView, 25/2);
        _headImgView.layer.borderWidth =1.0;
        _headImgView.layer.borderColor = [UIColor whiteColor].CGColor;
        [self.contentView addSubview:_headImgView];
        
        x +=width + 5;
        width = 150;
        height = 20;
        y += 2.5;
        _nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _nameLbl.text = @"michan";
        _nameLbl.textColor= AppTextCOLOR;
        _nameLbl.font =[UIFont systemFontOfSize:14];
        [self.contentView addSubview:_nameLbl];
        _huifuBtn = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width - 80  - 35, y, 30, height)];
        [_huifuBtn setTitle:@"回复" forState:0];
        _huifuBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_huifuBtn setTitleColor:[UIColor orangeColor] forState:0];
        
        _huifuBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _huifuBtn.layer.borderWidth = .5;
        ViewRadius(_huifuBtn, 5);
        [self.contentView addSubview:_huifuBtn];

        x = 20;
        y += height + 10;
        
        height = 20;
        width = Main_Screen_Width - 80 - 30;
        _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _titleLbl.textColor = [UIColor grayColor];
        _titleLbl.font = [UIFont systemFontOfSize:13];
        _titleLbl.numberOfLines = 0;
        [self.contentView addSubview:_titleLbl];
        
        
        
    }
    return self;
}
-(void)setHeadStr:(NSString *)headStr
{
    [_headImgView sd_setImageWithURL:[NSURL URLWithString:headStr] placeholderImage:[UIImage imageNamed:@"home_default-avatar"]];
}
-(void)setNameStr:(NSString *)nameStr
{
    _nameLbl.text = nameStr;
}
-(void)setTitleStr:(NSString *)titleStr
{
   // NSString * str = [NSString stringWithFormat:@"%@",titleStr];
      //_titleLbl.text= str;
   // [_titleLbl setAttributedText:titleStr];

    CGFloat h = [MCIucencyView heightforString:titleStr andWidth:Main_Screen_Width - 80 - 30 fontSize:13];
    
    _titleLbl.frame = CGRectMake(_titleLbl.frame.origin.x, _titleLbl.frame.origin.y, _titleLbl.frame.size.width, h );
    
    
    
    if (IOS8) {
        
        if ([titleStr containsString:@"@作者:"]) {
            
            NSMutableAttributedString*  btn_arrstring = [[NSMutableAttributedString alloc] initWithString:titleStr];
            
            [btn_arrstring setAttributes:@{NSForegroundColorAttributeName : RGBCOLOR(75, 142, 244),	NSFontAttributeName : [UIFont systemFontOfSize:13]} range:NSMakeRange(0, 4)];
            [_titleLbl setAttributedText:btn_arrstring];
            
        }
        else
        {
          NSRange range = [titleStr rangeOfString:@"回复 "];
        
            if (range.length >0)//包含
            {
                
                NSString*string =titleStr;
                NSRange range1 = [string rangeOfString:@" :"];//匹配得到的下标
                if (!range1.length) {
                    range1 = [string rangeOfString:@" ："];
                }
                if (range1.length) {
                    
                
                NSLog(@"rang:%@",NSStringFromRange(range1));
                string = [string substringWithRange:range1];//截取范围类的字符串
                NSLog(@"截取的值为：%@",string);
                
               // 5+1;
                
               // NSString *ss = [NSString stringWithFormat:@"回复 %@ :",_pinglunModel.userModel.nickname];
                
                            //        [HcCustomKeyboard customKeyboard].mTextView.text = [NSString stringWithFormat:@"回复 %@ :",_pinglunModel.userModel.nickname];
                            NSMutableAttributedString *btn_arrstring = [[NSMutableAttributedString alloc] initWithString:titleStr];
                
                            [btn_arrstring addAttributes:@{NSForegroundColorAttributeName : RGBCOLOR(75, 142, 244),	NSFontAttributeName : [UIFont systemFontOfSize:12]} range:NSMakeRange(2, range1.location-2)];
                
                
                [_titleLbl setAttributedText:btn_arrstring];

                }
                else
                {
                    _titleLbl.text = titleStr;
                }
            }
            else//不包含
            {
                _titleLbl.text = titleStr;
            }

            
        }
    }
    else
    {
        NSRange range = [titleStr rangeOfString:@"@作者:"];//判断字符串是否包含
        if (range.length >0)//包含
        {
            NSMutableAttributedString*  btn_arrstring = [[NSMutableAttributedString alloc] initWithString:titleStr];
            
            [btn_arrstring setAttributes:@{NSForegroundColorAttributeName : RGBCOLOR(75, 142, 244),	NSFontAttributeName : [UIFont systemFontOfSize:13]} range:NSMakeRange(0, 4)];
            [_titleLbl setAttributedText:btn_arrstring];
        }
        else//不包含
        {
            NSRange range = [titleStr rangeOfString:@"回复 "];
            
            if (range.length >0)//包含
            {
                
                NSString*string =titleStr;
                NSRange range1 = [string rangeOfString:@" :"];//匹配得到的下标
                if (!range1.length) {
                    range1 = [string rangeOfString:@" ："];
                }
                if (range1.length) {

                NSLog(@"rang:%@",NSStringFromRange(range1));
                string = [string substringWithRange:range1];//截取范围类的字符串
                NSLog(@"截取的值为：%@",string);
                
                // 5+1;
                
                // NSString *ss = [NSString stringWithFormat:@"回复 %@ :",_pinglunModel.userModel.nickname];
                
                //        [HcCustomKeyboard customKeyboard].mTextView.text = [NSString stringWithFormat:@"回复 %@ :",_pinglunModel.userModel.nickname];
                NSMutableAttributedString *btn_arrstring = [[NSMutableAttributedString alloc] initWithString:titleStr];
                
                [btn_arrstring addAttributes:@{NSForegroundColorAttributeName : RGBCOLOR(75, 142, 244),	NSFontAttributeName : [UIFont systemFontOfSize:12]} range:NSMakeRange(3, range1.location-3)];
                
                
                [_titleLbl setAttributedText:btn_arrstring];
                
                }
                else
                {
                   _titleLbl.text = titleStr;
                }
            }
            else//不包含
            {
                _titleLbl.text = titleStr;
            }
        }
    }

    
    
    
    
    
    
    
    
    
    
    


    
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
