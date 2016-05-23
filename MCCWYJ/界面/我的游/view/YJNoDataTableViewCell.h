//
//  YJNoDataTableViewCell.h
//  MCCWYJ
//
//  Created by MC on 16/5/23.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJNoDataTableViewCell : UITableViewCell
-(void)prepareNoDataUI:(CGFloat)viewH TitleStr:(NSString*)titleStr;
@property(nonatomic,strong)UIButton * tapBtn;
@end
