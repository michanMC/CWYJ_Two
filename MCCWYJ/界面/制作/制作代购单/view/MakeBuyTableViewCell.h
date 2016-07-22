//
//  MakeBuyTableViewCell.h
//  MCCWYJ
//
//  Created by MC on 16/5/21.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"
@interface MakeBuyTableViewCell : UITableViewCell
@property(nonatomic,strong)UIView * hongdianView;




@property(nonatomic,strong)UIButton *brandBtn;
@property(nonatomic,strong)UITextField *commodityfield;
@property(nonatomic,strong)UITextField *modelfield;
@property(nonatomic,strong)UITextField *colourfield;
@property(nonatomic,strong)UITextField *pricefield;

@property(nonatomic,strong)UITextField *countfield;
@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,strong)UIButton *minBtn;
-(void)prepareUI1;



@property(nonatomic,strong)UIButton*percentBtn;
@property(nonatomic,strong)UIButton*addserBtn;
-(void)prepareUI2;
-(void)prepareUI7;


@property(nonatomic,strong)UILabel*countLbl;
@property(nonatomic,strong)UIPlaceHolderTextView *describefeildView;
-(void)prepareUI3;




@property(nonatomic,strong)UILabel *caidianLbl;
@property(nonatomic,strong)UIPickerView*caidianPikcerView;
-(void)prepareUI4;



@property(nonatomic,strong)UILabel * juriLbl;
@property(nonatomic,strong)UILabel * juri2Lbl;

-(void)prepareUI5;


@property(nonatomic,strong)UILabel * addserLbl;

-(void)prepareUI6;
@property(nonatomic,strong)UIButton * adderseleBtn;
@property(nonatomic,strong)UIView * adderbgView;
@property(nonatomic,strong)UIButton * seleBtn;
@property(nonatomic,strong)UIButton * seleBtn1;


@end
