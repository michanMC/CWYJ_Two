//
//  MCMyshoppingTableViewCell.h
//  MCCWYJ
//
//  Created by MC on 16/5/15.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSBadgeView.h"

@protocol MCMyshoppingDegate <NSObject>

-(void)seleTitle:(NSString*)str BuyModlel:(MCBuyModlel*)buyModlel;

@end



@interface MCMyshoppingTableViewCell : UITableViewCell
@property(weak,nonatomic)id<MCMyshoppingDegate>degate;
@property(nonatomic,strong)UIButton * headerimgBtn;
@property(nonatomic,strong)UIButton * shoppingBtn;



@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)UIView *bg2View;
@property(nonatomic,strong)UIButton *selectBtn;
@property(nonatomic,strong)MCBuyModlel*BuyModlel;
@property(nonatomic,strong)JSBadgeView *BadgeView;
@property(nonatomic,assign)BOOL  tixing;
@property(nonatomic,strong)UIButton * optsBtn;
-(void)prepareNotitleUI;




-(void)prepareHastitleUI;

@property(nonatomic,strong)UIButton *typeBtn;
@property(nonatomic,strong)UIButton *type2Btn;

//@property(nonatomic,strong)UIButton *reimburseBtn;

-(void)preparebuyUI;


@end
