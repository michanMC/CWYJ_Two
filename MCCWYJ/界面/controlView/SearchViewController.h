//
//  SearchViewController.h
//  MCCWYJ
//
//  Created by MC on 16/5/23.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "BaseViewController.h"

@protocol SearchViewControllerDelegate <NSObject>

-(void)selectTitleStr:(NSString*)str;

-(void)selectTitleStr:(NSString *)str Key:(NSString*)isKey;

@end
@interface SearchViewController : BaseViewController

@property(nonatomic,weak)id<SearchViewControllerDelegate>delegate;
@property(nonatomic,assign)BOOL isshaidan;

@property(nonatomic,copy)NSString *isdaigoudian;



@end
