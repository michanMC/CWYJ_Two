//
//  MCbackButton.m
//  SyExam
//
//  Created by michan on 15/7/23.
//  Copyright (c) 2015年 MC. All rights reserved.
//

#import "MCbackButton.h"

@implementation MCbackButton
- (id)initWithFrame:(CGRect)frame

{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //可根据自己的需要随意调整
        
        self.titleLabel.textAlignment=NSTextAlignmentRight;
        
        self.titleLabel.font=[UIFont boldSystemFontOfSize:17.0];
        
         self.imageView.contentMode=UIViewContentModeCenter;
        
    }
    
    return self;
    
}
//重写父类UIButton的方法

//更具button的rect设定并返回文本label的rect

- (CGRect)titleRectForContentRect:(CGRect)contentRect

{
    CGFloat titleX = contentRect.origin.x;
    
    CGFloat titleW = contentRect.size.width - titleX;
    
    CGFloat titleH = contentRect.size.height;
    
    
    CGFloat titleY = 0;
    
    contentRect = (CGRect){{titleX,titleY},{titleW,titleH}};
    
    return contentRect;
    
}
//更具button的rect设定并返回UIImageView的rect

- (CGRect)imageRectForContentRect:(CGRect)contentRect

{
    
    CGFloat imageW = 18;
    
    CGFloat imageH = 18;
    
    CGFloat imageX = 0;
    
    CGFloat imageY =( contentRect.size.height - imageH )/2;
    
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
