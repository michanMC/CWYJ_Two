//
//  MCShareView.m
//  MCCWYJ
//
//  Created by MC on 16/6/29.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MCShareView.h"

@interface MCShareView (){
    
    
    MCIucencyView *_bgView;

    
    
}

@end


@implementation MCShareView

-(instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        _bgView = [[MCIucencyView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, frame.size.height)];
        [_bgView setBgViewColor:[UIColor blackColor]];
        [_bgView setBgViewAlpha:.5];
        [self addSubview:_bgView];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actiontap:)];
        
        [_bgView addGestureRecognizer:tap];
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height - 44 - 40 - 60 - 40 - 0.5, Main_Screen_Width, 44 + 40 + 60 + 40 + 0.5)];
        view.backgroundColor = [UIColor whiteColor];
//        view.userInteractionEnabled = NO;
        [_bgView addSubview:view];

        
        UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 40)];
        lbl.textColor = AppTextCOLOR;
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.font = [UIFont systemFontOfSize:16];
        lbl.text = @"分享到";
        [view addSubview:lbl];

        
        CGFloat w = 40;
        CGFloat h = 40;
        CGFloat x = (Main_Screen_Width - 40*4)/5;
        CGFloat offx = x;
        CGFloat y = 40 + 30;
        NSArray * arr = @[@"weibo",@"qq1",@"weixin",@"douban"];
        for (NSInteger i = 0; i < 4; i++) {
            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
            
            [btn setBackgroundImage:[UIImage imageNamed:arr[i]] forState:0];
            btn.tag = 100+i;
            x += offx + w;
            [view addSubview:btn];
            [btn addTarget:self action:@selector(actionBTN:) forControlEvents:UIControlEventTouchUpInside];
        }
        y += w + 30;
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, y, Main_Screen_Width, 0.5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [view addSubview:lineView];
        y +=0.5;
        
        UIButton * btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, y, Main_Screen_Width, 44)];
        [btn1 setTitle:@"取消" forState:0];
        [btn1 setTitleColor:[UIColor grayColor] forState:0];
        btn1.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn1 addTarget:self action:@selector(actionQuexiao) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn1];

        
        
    }
    return self;
}
-(void)actionQuexiao{
    [self removeFromSuperview];

}
-(void)actionBTN:(UIButton*)btn{
    NSString * str =@"";
    if (btn.tag == 100) {
        str = @"微博";
    }
    
    else if (btn.tag == 101){
        str = @"QQ";
        
    }
    else if (btn.tag == 102){
        str = @"微信";
        
    }
    else if (btn.tag == 103){
        str = @"朋友圈";
        
    }
    
    
    if (_delegate) {
        [_delegate MCShareViewselsctStr:str];
        [self actionQuexiao];
    }
    
    
    
    
}
-(void)actiontap:(UITapGestureRecognizer*)tap{
//    if (_delegate) {
//        [_delegate MCscreenhidden];
//    }
//    // [self removeFromSuperview];
    [self removeFromSuperview];
    
    
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
