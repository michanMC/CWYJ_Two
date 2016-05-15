//
//  me1TableViewCell.h
//  MCCWYJ
//
//  Created by MC on 16/5/3.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface me1TableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView * imgview;

-(void)prepareStr:(NSString*)str TitleStr:(NSString*)titleStr Ishong:(BOOL)ishong;

@end
