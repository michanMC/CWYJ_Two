//
//  SearchViewController.h
//  MCCWYJ
//
//  Created by MC on 16/5/23.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "BaseViewController.h"
#import "jingdianModel.h"

typedef enum {
   SearchType_scenic,//景点
    SearchType_POP,//代购点
    SearchType_brand,//品牌

} MCSearchType;







@protocol SearchViewControllerDelegate <NSObject>

-(void)selectTitleModel:(jingdianModel*)model;

-(void)selectTitleStr:(NSString*)str;

-(void)selectTitleStr:(NSString *)str Key:(NSString*)isKey;

@end
@interface SearchViewController : BaseViewController
@property(nonatomic,assign)MCSearchType  SearchType;

@property(nonatomic,weak)id<SearchViewControllerDelegate>delegate;
@property(nonatomic,assign)BOOL isshaidan;

@property(nonatomic,copy)NSString *isdaigoudian;

@property(nonatomic,copy)NSString *Search_Str;


@end
