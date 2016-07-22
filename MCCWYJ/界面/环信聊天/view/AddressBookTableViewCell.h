//
//  AddressBookTableViewCell.h
//  MCCWYJ
//
//  Created by MC on 16/6/14.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressBookViewController.h"
#import "AddressBookModel.h"
@interface AddressBookTableViewCell : UITableViewCell

@property(nonatomic,weak)AddressBookViewController*delegate;
@property(nonatomic,strong)AddressBookModel*model;
@property(nonatomic,strong)UIImageView* imgview;
@property(nonatomic,strong)UILabel* nameLbl;
@property(nonatomic,strong)UILabel* phoneLbl;
@property(nonatomic,strong)UIButton *Registbtn;



-(void)prepareUI;

@end
