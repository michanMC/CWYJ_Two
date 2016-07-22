//
//  MCDrawBackTableViewCell.h
//  MCCWYJ
//
//  Created by MC on 16/7/14.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"
@interface MCDrawBackTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel * lbl1;
@property(nonatomic,strong)UIButton * seleBtn;

@property(nonatomic,strong)UITextField * text1;

@property(nonatomic,strong)UIPlaceHolderTextView * textView1;
@property(nonatomic,strong)UILabel * lblcount;



-(void)prepareUI;

@end
