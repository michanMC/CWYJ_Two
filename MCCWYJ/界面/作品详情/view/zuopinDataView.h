//
//  zuopinDataView.h
//  CWYouJi
//
//  Created by MC on 15/11/25.
//  Copyright © 2015年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "pinglunModel.h"

@protocol zuopinDataViewDeleGate <NSObject>

-(void)pinglunModel:(homeYJModel*)model Index:(NSInteger)index IsHuifu:(BOOL)ishuifu PinglunModel:(pinglunModel*)pinglunModel;
-(void)zhuan:(NSString*)str;
-(void)stop:(NSString*)str;
@end





@interface zuopinDataView : UIView
@property(nonatomic,strong)UIImageView * bg_imgView;
@property(nonatomic,assign)BOOL isLoda;
@property(nonatomic,assign)NSInteger indexId;
@property(nonatomic,weak)id<zuopinDataViewDeleGate>deleGate;
@property(nonatomic,assign) NSInteger pagrStr;
@property(nonatomic,strong)  NSMutableArray * dataPingLunArray;

@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)homeYJModel *home_model;
//-(id)initFrame:(CGRect)frame;
@property (nonatomic , strong)NSDictionary * classifyDic;
@property (nonatomic,strong) MCNetworkManager *requestManager;
-(void)loadData:(BOOL)iszhuan;

@end
