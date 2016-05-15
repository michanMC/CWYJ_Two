//
//  zuopinQx2TableViewCell.h
//  CWYouJi
//
//  Created by MC on 15/11/7.
//  Copyright © 2015年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface zuopinQx2TableViewCell : UITableViewCell
@property (strong, nonatomic)  UIView *BgView;
@property (strong, nonatomic)  UIButton *jubaoBtn;
@property (strong, nonatomic)  UIButton *pinglunBtn;
@property (strong, nonatomic)  UIButton *showBtn;
-(void)prepareUI:(NSString*)pinglunCuntStr;

@end
