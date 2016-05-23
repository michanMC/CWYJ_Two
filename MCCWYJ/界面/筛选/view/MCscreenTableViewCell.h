//
//  MCscreenTableViewCell.h
//  MCCWYJ
//
//  Created by MC on 16/5/23.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCscreenTableViewCellDelegate <NSObject>

-(void)selsctTabinde:(NSInteger)tabindex SeleStr:(NSString*)selectStr;

@end




@interface MCscreenTableViewCell : UITableViewCell

@property(nonatomic,weak)id<MCscreenTableViewCellDelegate>delegate;



@property(nonatomic,strong)UIButton * selectBtn;
-(void)prepareUI:(NSMutableArray*)titelarray Datadic:(NSString*)select Tabindex:(NSInteger)tabindex;


@end
