//
//  letf2TableViewCell.m
//  CWYouJi
//
//  Created by MC on 15/10/31.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "letf2TableViewCell.h"


@interface letf2TableViewCell (){
    UIImageView * _imgview;
    UILabel *_titleLbl;
    UIImageView * _img;
    
    
    
    
}

@end

@implementation letf2TableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat x = 20;
        CGFloat y = 10;
        CGFloat width = 20;
        CGFloat height = 20;
        _imgview = [[UIImageView alloc]initWithFrame:CGRectMake(x, (45 - 20)/2 , width, height)];
       // _imgview.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_imgview];
        
        x +=width + 10;
        y = 0;
        width = 100;
        height = 45;
        _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
        _titleLbl.text =@"已制作的作品（99）";
        _titleLbl.textColor = [UIColor whiteColor];
        _titleLbl.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_titleLbl];
        _img = [[UIImageView alloc]initWithFrame:CGRectMake(0, (45 - 15)/2, 15, 15)];
        _img.hidden = YES;
        _img.image = [UIImage imageNamed:@"mine_dot"];
        [self.contentView addSubview:_img];
        
        
        
    }
    return self;
}
-(void)setImgViewStr:(NSString *)imgViewStr{
    _imgview.image = [UIImage imageNamed:imgViewStr];
    
}
-(void)setTitleStr:(NSString *)titleStr{
    
    CGFloat w = [MCIucencyView heightforString:titleStr andHeight:45 fontSize:14];
    
    _titleLbl.text = titleStr;
    _titleLbl.frame = CGRectMake(_titleLbl.frame.origin.x, 0, w, 45);
    _img.frame = CGRectMake(_titleLbl.frame.origin.x + w + 10, _img.frame.origin.y, _img.frame.size.width, _img.frame.size.height);
    
    
    
    
}
-(void)setIsimg:(BOOL)isimg{
    
    _img.hidden = isimg;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
