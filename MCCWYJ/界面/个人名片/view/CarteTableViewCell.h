//
//  CarteTableViewCell.h
//  MCCWYJ
//
//  Created by MC on 16/5/23.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "homeYJModel.h"
@interface CarteTableViewCell : UITableViewCell
-(void)prepareUI:(NSString *)titleStr DataArray:(NSMutableArray*)dataArray;

@end
