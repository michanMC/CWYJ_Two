//
//  MCShareView.h
//  MCCWYJ
//
//  Created by MC on 16/6/29.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCShareViewViewDelegate <NSObject>

-(void)MCShareViewselsctStr:(NSString*)selectStr;

@end



@interface MCShareView : UIView
- (void)showInWindow;
@property(nonatomic,weak)id<MCShareViewViewDelegate>delegate;

@end
