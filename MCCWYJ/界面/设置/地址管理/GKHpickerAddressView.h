//
//  VTSelectionPickerView.h
//  huiyang
//  一个地理位置选择器
//  Created by Mac on 14-2-21.
//  Copyright (c) 2014年 wwj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "LocationsModel.h"

typedef void (^passStrValueBlock) (UIViewController * ctrl,NSString * addressName ,NSMutableDictionary*addressDic);

@interface GKHpickerAddressView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property (strong,nonatomic) UIPickerView * pickerView;
@property (strong,nonatomic) passStrValueBlock  valueBlock;
@property (strong,nonatomic) UIViewController * ctrl;
@property (strong,nonatomic)    NSMutableArray * dataArray;

/* 选择城市名
 @param
 *mobileNum：传入controller
 @return
 *block：addressName    选择的名字
 */
+ (GKHpickerAddressView *)shareInstancePickerAddressByctrl:(UIViewController *)ctrl DataArray:(NSMutableArray*)arr block:(passStrValueBlock)block;
@end
