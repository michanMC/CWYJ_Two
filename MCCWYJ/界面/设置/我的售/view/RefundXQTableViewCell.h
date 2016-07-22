//
//  RefundXQTableViewCell.h
//  MCCWYJ
//
//  Created by MC on 16/7/15.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefundXQModel.h"


@protocol RefundXQDelegate <NSObject>

-(void)showimgindex:(NSInteger)index;

@end



@interface RefundXQTableViewCell : UITableViewCell

@property(nonatomic,strong)RefundXQModel*XQModel;


-(void)preparebuyUI;
@property(weak,nonatomic)id<RefundXQDelegate>delegate;

@property(nonatomic,strong)UILabel * titleLbl;
@property(nonatomic,strong)UILabel * titlesubLbl;

@property(nonatomic,strong)UIView * imgBgView;

-(void)preparebuyUI2;



@end
