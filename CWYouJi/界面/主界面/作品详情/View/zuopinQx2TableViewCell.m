//
//  zuopinQx2TableViewCell.m
//  CWYouJi
//
//  Created by MC on 15/11/7.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "zuopinQx2TableViewCell.h"

@implementation zuopinQx2TableViewCell

- (void)awakeFromNib {
    // Initialization code
    ViewRadius(_BgView, 5);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
