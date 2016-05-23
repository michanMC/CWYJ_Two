


//
//  ItemView.m
//  oc
//
//  Created by lyl on 15/11/24.
//  Copyright © 2015年 miruo. All rights reserved.
//

#import "ItemView.h"

@interface ItemView(){
    
    NSString *_skeystr;
    
}

@property (nonatomic,assign) CGFloat viewHeight;/**< item的高度 >*/


@end





@implementation ItemView

- (id)initWithFrame:(CGRect)frame Skeystr:(NSString*)skeystr{
    self = [super initWithFrame:frame];
    if (self) {
    
        _skeystr = skeystr;
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat viewWidth = CGRectGetWidth(self.frame);
    if (!_itemHeith) {
        _itemHeith = 30;
    }
    if (_itemArray.count > 0) {
        UIView *befourView = nil;
        for (NSInteger i = 0; i < _itemArray.count; i ++) {
            UIButton *itemLabel = [[UIButton alloc] init];
           // itemLabel.textAlignment = NSTextAlignmentCenter;
            if ([_skeystr isEqualToString:@"1"]) {
                [itemLabel setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
                
                [itemLabel setTitleColor:UIColorFromRGB(0x29477d) forState:UIControlStateSelected];
                itemLabel.backgroundColor = [UIColor whiteColor];
                ViewRadius(itemLabel, 3);
  
            }
            else
            {
                [itemLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [itemLabel setTitleColor:UIColorFromRGB(0x29477d) forState:UIControlStateSelected];
                itemLabel.backgroundColor = [UIColor clearColor];
                ViewRadius(itemLabel, 3);
                itemLabel.layer.borderColor = [UIColor whiteColor].CGColor;
                itemLabel.layer.borderWidth =0.5;
  
            }
           // itemLabel.textColor = [UIColor grayColor];
            //itemLabel.backgroundColor = [UIColor whiteColor];
            itemLabel.titleLabel.font = [UIFont systemFontOfSize:14];
            [itemLabel setTitle:_itemArray[i] forState:0];
            //itemLabel.text = _itemArray[i];
           
            itemLabel.tag = i + 700;
            [itemLabel addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:itemLabel];
            CGFloat itemWidth = [itemLabel.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}].width;
            if (befourView) {
                CGFloat maxWidht = CGRectGetMaxX(befourView.frame);
                if ((maxWidht + itemWidth * 1.2 + 15 + 10) > viewWidth) {/**< 该换行了 >*/
                    itemLabel.frame = CGRectMake(10, CGRectGetMaxY(befourView.frame) + 10, itemWidth * 1.2, _itemHeith);
                }else {
                    itemLabel.frame = CGRectMake(CGRectGetMaxX(befourView.frame) + 15, CGRectGetMinY(befourView.frame), itemWidth * 1.2, _itemHeith);
                }
            }else {
                itemLabel.frame = CGRectMake(10, 10, itemWidth * 1.2, _itemHeith);
            }
            befourView = itemLabel;
        }
        
        self.viewHeight = CGRectGetMaxY(befourView.frame) + 10;
    }
}
//- (CGFloat)getItemViewHeight {
//    return _viewHeight;
//}


//- (void)setItemArray:(NSArray *)itemArray {
//    if (_itemArray != itemArray) {
//        _itemArray = itemArray;
//        for (NSInteger i = 0; i < _itemArray.count; i ++) {
//            
//            
//        }
//    }
//}

-(void)actionBtn:(UIButton*)btn{
    
    /*
    for (int i = 0; i < _itemArray.count; i ++) {
        UIButton * btn2 = (UIButton*)[self viewWithTag:700 + i];
        btn2.selected = NO;
        btn2.backgroundColor = [UIColor whiteColor];
        btn2.layer.borderColor = [UIColor lightGrayColor].CGColor;
        btn2.layer.borderWidth =0.5;

    }
    btn.selected = YES;
    btn.layer.borderColor = UIColorFromRGB(0x29477d).CGColor;
    btn.layer.borderWidth =0.5;

    if (_seleColor) {
        btn.backgroundColor = _seleColor;
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];

    }
    else
    btn.backgroundColor = [UIColor whiteColor];
    
    */
    
    
    NSLog(@"%d",btn.tag - 700);
    if (_delegate) {
        //[_delegate seleIndex:btn.tag - 700];
    }
}

- (void)ItemViewWithBlock:(ItemViewBlock)block {
    self.block = block;
}

- (void)setViewHeight:(CGFloat)viewHeight {
    if (_viewHeight != viewHeight) {
        _viewHeight = viewHeight;
        
        [_delegate itemH:_viewHeight];
        
//        if (self.block) {
//            self.block([NSNumber numberWithFloat:_viewHeight]);
//        }
    }
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
