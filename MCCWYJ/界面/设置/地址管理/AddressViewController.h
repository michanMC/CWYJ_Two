//
//  AddressViewController.h
//  MCCWYJ
//
//  Created by MC on 16/5/4.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "BaseViewController.h"
#import "AddressModel.h"


@protocol AddressViewSeleDegate <NSObject>

-(void)seleAddressModel:(AddressModel*)modle;

@end


@interface AddressViewController : BaseViewController


@property(weak,nonatomic)id<AddressViewSeleDegate>degate;

@property(nonatomic,assign)BOOL isSele;


@end
