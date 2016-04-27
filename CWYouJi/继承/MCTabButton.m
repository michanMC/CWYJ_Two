//
//  MCTabButton.m
//  SyExam
//
//  Created by michan on 15/7/2.
//  Copyright (c) 2015年 MC. All rights reserved.
//

#import "MCTabButton.h"

@implementation MCTabButton
- (id)initWithFrame:(CGRect)frame

{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //可根据自己的需要随意调整
        
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        
        self.titleLabel.font=[UIFont systemFontOfSize:10.0];
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        self.imageView.contentMode=UIViewContentModeCenter;
        
    }
    
    return self;
    
}
//重写父类UIButton的方法

//更具button的rect设定并返回文本label的rect

- (CGRect)titleRectForContentRect:(CGRect)contentRect

{
    
    CGFloat titleW = contentRect.size.width;
    
    CGFloat titleH = 20;
    
    CGFloat titleX = 0;
    
    CGFloat titleY = contentRect.size.height - titleH ;
    
    contentRect = (CGRect){{titleX,titleY},{titleW,titleH}};
    
    return contentRect;
    
}
//更具button的rect设定并返回UIImageView的rect

- (CGRect)imageRectForContentRect:(CGRect)contentRect

{
    
    CGFloat imageW = 20;
    
    CGFloat imageH = 20;
    
    CGFloat imageX = (contentRect.size.width - imageH)/ 2;
    
    CGFloat imageY = 3;
    
    contentRect = (CGRect){{imageX,imageY},{imageW,imageH}};
    
    return contentRect;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
