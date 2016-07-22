//
//  MakeshaidanViewController.h
//  MCCWYJ
//
//  Created by MC on 16/5/25.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "BaseViewController.h"

@interface MakeshaidanViewController : BaseViewController
@property(nonatomic,strong)UIImage * img;
-(void)MCactionTapimg;

//@property(nonatomic,strong)UIImageView * imgView;
@property(nonatomic,strong)NSMutableDictionary *commodity_Dic;

-(void)removeMCshaidanView;

-(void)commodityDic:(NSDictionary*)dic;




-(void)addteizhi:(UIButton*)btn;


@end
