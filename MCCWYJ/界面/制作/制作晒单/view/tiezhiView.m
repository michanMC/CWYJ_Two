//
//  tiezhiView.m
//  MCCWYJ
//
//  Created by MC on 16/5/26.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "tiezhiView.h"


@interface tiezhiView (){
    
    CGRect _selfViewframe;
    
    
    
}

@end




@implementation tiezhiView

-(instancetype)initWithFrame:(CGRect)frame
{
  self =   [super initWithFrame:frame];
    if (self) {
        _selfViewframe =frame;
        
        
        UIView * hongview = [[UIView alloc]initWithFrame:CGRectMake(10, (40 - 5)/2, 5, 5)];
        hongview.backgroundColor = AppCOLOR;
        ViewRadius(hongview, 2.5);
        [self addSubview:hongview];
        
        UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(10 + 5 + 5, 0, Main_Screen_Width - 20, 40)];
        lbl.text = @"选择贴纸";
        lbl.textColor = AppTextCOLOR;
        lbl.font = [UIFont systemFontOfSize:16];
        [self addSubview:lbl];

        
        _ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, frame.size.width, 64 + 20)];
        [self addSubview:_ScrollView];

        
        
        
    }
    return self;
}
-(void)setDataArray:(NSMutableArray *)dataArray
{
    
    _dataArray = dataArray;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 64;
    CGFloat h = w;
    for (NSInteger i = 0; i < _dataArray.count; i++) {
        DecalsModel * model = _dataArray[i];
        
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
        
//        [btn setBackgroundImage:[UIImage imageNamed:@"buy_default-photo"] forState:0];
        [btn sd_setImageWithURL:[NSURL URLWithString:model.image] forState:0 placeholderImage:[UIImage imageNamed:@"buy_default-photo"]];
        btn.tag = 300+i;
        [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_ScrollView addSubview:btn];
        
        UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y+w, w, 20)];
        lbl.textColor = AppTextCOLOR;
        lbl.font = AppFont;
        lbl.text = model.title;//@"穿搭新建";
        lbl.textAlignment = NSTextAlignmentCenter;
        [_ScrollView addSubview:lbl];
        
        x +=w +5;
        
    }
    
    _ScrollView.contentSize = CGSizeMake(x , 0);
    
    

    
}
-(void)actionBtn:(UIButton*)btn{
    [_delegate addteizhi:btn];
    
    
}







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
