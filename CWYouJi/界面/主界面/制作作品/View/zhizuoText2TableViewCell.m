//
//  zhizuoText2TableViewCell.m
//  CWYouJi
//
//  Created by MC on 15/11/9.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "zhizuoText2TableViewCell.h"
#import "UIPlaceHolderTextView.h"
@interface zhizuoText2TableViewCell (){
    
    
    
    
}

@end

@implementation zhizuoText2TableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier    {
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        _holderTex = [[UIPlaceHolderTextView alloc]initWithFrame:CGRectMake(10, 5, Main_Screen_Width - 20, 400)];
        
        _holderTex.placeholder = @"你就不说点什么吗?";
        [self.contentView addSubview:_holderTex];
        _holderTex.font= AppFont;
        
        _countLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 406, Main_Screen_Width - 10, 20)];
        _countLbl.text = @"0/500";
        _countLbl.textColor = [UIColor grayColor];
        _countLbl.textAlignment = NSTextAlignmentRight;
        _countLbl.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_countLbl];
        
        
        
        
        
        
    }

    return self;
    
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
