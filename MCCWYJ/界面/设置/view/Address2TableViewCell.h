//
//  Address2TableViewCell.h
//  MCCWYJ
//
//  Created by MC on 16/5/4.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Address2TableViewCell : UITableViewCell
@property(nonatomic,copy)NSString * nameStr;
@property(nonatomic,copy)NSString * addressStr;
@property(nonatomic,copy)NSString * phoneStr;
@property (nonatomic,strong)UIButton *deteBtn;
@property(nonatomic,assign)BOOL  ismoren;

@end
