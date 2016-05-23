//
//  ItemView.h
//  oc
//
//  Created by lyl on 15/11/24.
//  Copyright © 2015年 miruo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ItemViewDelegate <NSObject>

-(void)itemH:(CGFloat)itemh;

@optional
-(void)seleIndex:(NSInteger)index;

@end



typedef void(^ItemViewBlock)(id obj);


@interface ItemView : UIView

@property (nonatomic,strong) NSArray *itemArray;

@property (nonatomic,assign) CGFloat itemHeith; 

@property (nonatomic,copy) __block ItemViewBlock block;
@property (nonatomic,weak) id<ItemViewDelegate>delegate;
@property (nonatomic,strong)UIColor*  seleColor;


/**
 *  获取高度，应先有itemArray
 */
//- (CGFloat)getItemViewHeight;

//- (id)initWihtItemArray:(NSArray *)array;

- (void)ItemViewWithBlock:(ItemViewBlock)block;
- (id)initWithFrame:(CGRect)frame Skeystr:(NSString*)skeystr;


@end


