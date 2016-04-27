//
//  zhizuoZp2TableViewCell.m
//  CWYouJi
//
//  Created by MC on 15/11/8.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "zhizuoZp2TableViewCell.h"

@implementation zhizuoZp2TableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
    
        CGFloat width = 90;
        CGFloat x = (Main_Screen_Width - 180)/6;
        CGFloat y = (150 - 70)/2;
        CGFloat height = 70;
        width = 70;
        x = 2 * x;
        _btn1 = [[UIButton alloc]initWithFrame:CGRectMake(x , y, width, height)];
        [_btn1 setImage:[UIImage imageNamed:@"不枉此行_normal"] forState:UIControlStateNormal];
        [self.contentView addSubview:_btn1];
        _btn1.tag =  100;
        x += 90 + x + 20;
        
        
        _btn2 = [[UIButton alloc]initWithFrame:CGRectMake(x, y, 70, 70)];
        [_btn2 setImage:[UIImage imageNamed:@"坑了-个爹_normal"] forState:UIControlStateNormal];
        _btn2.tag = 200;
        [self.contentView addSubview:_btn2];

        
        
        
    }
    
    return self;

}
//-(void)actuionBtn:(UIButton*)btn{
//    
//    if (btn.tag == 100) {
//        _btn1.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
//        
//        
//        
//        
//    }
//    else
//    {
//        
//        
//    }
//    
//    
//    
//    
//}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
