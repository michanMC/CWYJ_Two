//
//  ContactListTableViewCell.h
//  MCCWYJ
//
//  Created by MC on 16/6/7.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "friendslistModel.h"

@protocol ContactListTableViewCellDelegate <NSObject>

-(void)selectModle:(friendslistModel*)molde;
-(void)selectModle2:(friendslistModel*)molde IsAdd:(BOOL)isadd;


@end



@interface ContactListTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *titleLbl;
@property(nonatomic,strong)UILabel *titlesubLbl;
@property(nonatomic,strong)UIImageView *imgview;
@property(nonatomic,strong)UIImageView *hongview;

@property(nonatomic,assign)BOOL issele;
@property(nonatomic,assign)BOOL issfabu;
@property(nonatomic,strong)UIButton * seleBtn;



-(void)prepareUI1;

-(void)prepareUI2:(friendslistModel*)modle;


@property(nonatomic,strong)UIButton *receiveBtn;
@property(nonatomic,weak)id<ContactListTableViewCellDelegate>delegate;
-(void)prepareUI3:(friendslistModel*)modle;


@end
