//
//  MCscreenTableViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/5/23.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MCscreenTableViewCell.h"



@interface MCscreenTableViewCell ()
{
    
    
    NSInteger _tabindex;
    NSString *_selctStr;
    
}

@end


@implementation MCscreenTableViewCell
-(void)prepareUI:(NSMutableArray*)titelarray Datadic:(NSString*)select Tabindex:(NSInteger)tabindex{
    
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    _tabindex = tabindex;
    _selctStr =select;
    CGFloat btnx = 10;
    CGFloat btnoffx = 10;
    CGFloat btny = 5;
    CGFloat btnw = (Main_Screen_Width - 50) / 4;
    CGFloat btnh = 25;
    

    
    for (NSInteger  i = 0; i < titelarray.count; i ++) {
        
        NSString * str = titelarray[i];
        
       _selectBtn = [[UIButton alloc]initWithFrame:CGRectMake(btnx, btny, btnw, btnh)];
        _selectBtn.tag = i + tabindex;
        [_selectBtn setTitle:str forState:0];
        [_selectBtn setTitleColor:RGBCOLOR(127, 125, 147) forState:UIControlStateNormal];
        [_selectBtn setTitleColor:RGBCOLOR(232, 48, 17) forState:UIControlStateSelected];
        _selectBtn.titleLabel.font = AppFont;
        _selectBtn.layer.borderWidth = 1;
        [_selectBtn addTarget:self action:@selector(actionselectBtn:) forControlEvents:UIControlEventTouchUpInside];

        [self.contentView addSubview:_selectBtn];
        ViewRadius(_selectBtn, btnh / 2);
        
        CGFloat imgw = 20;
        CGFloat imgh = 20;

        CGFloat imgx = btnx + btnw - 15;
        CGFloat imgy = btny - 5;

        
        UIImageView * imgeView = [[UIImageView alloc]initWithFrame:CGRectMake(imgx, imgy, imgw, imgh)];
        imgeView.image = [UIImage imageNamed:@"icon_selected"];
        
        [self.contentView addSubview:imgeView];

        
        
        
        
        
        if ([select integerValue] == i) {
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
        
        btnx += btnw + btnoffx;
        if (i == 3) {
            btnx = 10;
            btny += btnh + 10;
        }
        
        
        
    }
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actiontap:)];
    
    [self.contentView addGestureRecognizer:tap];
    



}
-(void)actiontap:(UITapGestureRecognizer*)tap{
}


-(void)actionselectBtn:(UIButton*)btn{
    NSString * tabStr = [NSString stringWithFormat:@"%zd",btn.tag - _tabindex];
    
    
    if ([tabStr isEqualToString:_selctStr]) {
        return;
    }
    
    
    if (_delegate) {
        [_delegate selsctTabinde:_tabindex SeleStr:tabStr];
    }
    
    
//    _likeStr = tabStr;
//    [_tableView reloadData];
    
    
    
    
    
    
    
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
