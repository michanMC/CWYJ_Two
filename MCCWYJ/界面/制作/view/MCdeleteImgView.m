//
//  MCdeleteImgView.m
//  CWYouJi
//
//  Created by MC on 15/11/8.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "MCdeleteImgView.h"


@interface MCdeleteImgView (){
    
    
    
    
}

@end



@implementation MCdeleteImgView
-(instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES; // 裁剪边缘

        [self addSubview:_imgView];
        _deleteBtn =[[UIButton alloc]initWithFrame:CGRectMake(frame.size.width - 30, 0, 30, 30)];
        //_deleteBtn.backgroundColor = [UIColor yellowColor];
        
        [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"-travel-notes_icon_delete"] forState:0];
        _imgView.userInteractionEnabled = YES;
        [_imgView addSubview:_deleteBtn];
        
        
        
        
    }
    
    return self;
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
