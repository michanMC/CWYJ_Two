//
//  placeholderText.m
//  CWYouJi
//
//  Created by MC on 15/10/28.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "placeholderText.h"

@implementation placeholderText

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.leftView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        self.leftViewMode = UITextFieldViewModeAlways;
    

    }
    return self;
}


//- (void)drawPlaceholderInRect:(CGRect)rect{
////    UIColor *placeholderColor = [UIColor lightGrayColor];//设置颜色
////    [placeholderColor setFill];
////    
////    CGRect placeholderRect = CGRectMake(rect.origin.x+10, 10, rect.size.width - 10, self.frame.size.height);//设置距离
////    
////    
////    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
////    style.lineBreakMode = NSLineBreakByTruncatingTail;
////    style.alignment = self.textAlignment;
////    NSDictionary *attr = [NSDictionary dictionaryWithObjectsAndKeys:style,NSParagraphStyleAttributeName, self.font, NSFontAttributeName, placeholderColor, NSForegroundColorAttributeName, nil];
////    
////    [self.placeholder drawInRect:placeholderRect withAttributes:attr];
//    
//    
//    
//    
//}
-(CGRect) leftViewRectForBounds:(CGRect)bounds
{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 5;// 右偏5
    return iconRect;
}

@end
