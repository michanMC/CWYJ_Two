//
//  tiezhiView.h
//  MCCWYJ
//
//  Created by MC on 16/5/26.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MakeshaidanViewController.h"
#import "DecalsModel.h"
@interface tiezhiView : UIView


@property(nonatomic,strong)UIScrollView *ScrollView;
@property (nonatomic,weak)MakeshaidanViewController *delegate;

@property (nonatomic,strong)NSMutableArray *dataArray;


@end
