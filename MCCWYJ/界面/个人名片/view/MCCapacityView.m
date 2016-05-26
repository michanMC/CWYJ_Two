//
//  MCCapacityView.m
//  MCCWYJ
//
//  Created by MC on 16/5/24.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MCCapacityView.h"


@interface MCCapacityView (){
    MCIucencyView *_bgView;
    UIImageView * _BgimgView;
    NSArray * _titleArray;
    
    
}

@end


@implementation MCCapacityView
-(instancetype)initWithFrame:(CGRect)frame TitleArray:(NSArray*)titleArray
{
    
    self = [super initWithFrame:frame];
    if (self) {
        _titleArray = titleArray;
        _bgView = [[MCIucencyView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, frame.size.height)];
        [_bgView setBgViewColor:[UIColor blackColor]];
        [_bgView setBgViewAlpha:.5];
        [self addSubview:_bgView];
   
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionTap)];
        [_bgView addGestureRecognizer:tap];
        
        CGFloat w = 150;
        CGFloat x = Main_Screen_Width - 155;
        CGFloat y = 0;
        CGFloat h = 40 * titleArray.count + 20 + (titleArray.count -1)*0.5;
        
        
        _BgimgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
        _BgimgView.image = [UIImage imageNamed:@"Pop-up-window"];
        [_bgView addSubview:_BgimgView];
        _BgimgView.userInteractionEnabled = YES;
        x = 0;
        y = 20;
        h = 40;
        
        for (NSInteger i = 0; i < titleArray.count; i ++) {
            
            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
            
            [btn setTitleColor:RGBCOLOR(127, 125, 147) forState:0];
            [btn setTitle:titleArray[i] forState:0];
            btn.titleLabel.font = AppFont;
            btn.tag = i + 500;
            [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
            [_BgimgView addSubview:btn];
            if (i < titleArray.count-1) {
                y +=h;
                UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(10, y, w - 20, 0.5)];
                lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
                [_BgimgView addSubview:lineView];
                y +=0.5;


            }
            
        }
      
        
    }
    return self;
}

-(void)actionTap{
    
    if (_delegate) {
        [_delegate MCCapacityViewhidden];
    }

    
}

-(void)actionBtn:(UIButton*)btn{
    NSString * str = _titleArray[btn.tag - 500];
    if (_delegate) {
        [_delegate MCCapacityViewselsctTitle:str];
    }

    
    
}

- (void)showInWindow{
    
    
    
    
    
    
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app.window addSubview:self];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
