//
//  me2TableViewCell.h
//  MCCWYJ
//
//  Created by MC on 16/5/3.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface me2TableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView * imgview;

-(void)preapreTitleStr:(NSString*)titleStr Ishong:(BOOL)ishong;
@end
