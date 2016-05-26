//
//  MCCapacityView.h
//  MCCWYJ
//
//  Created by MC on 16/5/24.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MCCapacityViewDelegate <NSObject>

-(void)MCCapacityViewselsctTitle:(NSString*)titleDic;
-(void)MCCapacityViewhidden;

@end


@interface MCCapacityView : UIView
@property(nonatomic,weak)id<MCCapacityViewDelegate>delegate;

-(instancetype)initWithFrame:(CGRect)frame TitleArray:(NSArray*)titleArray;

- (void)showInWindow;

@end
