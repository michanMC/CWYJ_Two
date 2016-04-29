//
//  MCplaceholderText.m
//  CWYouJi
//
//  Created by MC on 15/10/29.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "MCplaceholderText.h"

@implementation MCplaceholderText
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
                
    }
    return self;
}


- (void)drawPlaceholderInRect:(CGRect)rect{
    UIColor *placeholderColor = [UIColor whiteColor];//设置颜色
    [placeholderColor setFill];

    CGRect placeholderRect = CGRectMake(rect.origin.x,rect.origin.y + 6, rect.size.width , 20);//设置距离


    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
   // style.lineBreakMode = NSLineBreakByTruncatingTail;
    style.alignment = self.textAlignment;
    NSDictionary *attr = [NSDictionary dictionaryWithObjectsAndKeys:style,NSParagraphStyleAttributeName, self.font, NSFontAttributeName, placeholderColor, NSForegroundColorAttributeName, nil];

    [self.placeholder drawInRect:placeholderRect withAttributes:attr];



    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
