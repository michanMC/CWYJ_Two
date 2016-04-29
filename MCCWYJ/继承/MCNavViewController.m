//
//  NavViewController.m
//  StarGroups
//
//  Created by fenguoxl on 15/3/12.
//  Copyright (c) 2015年 fenguo. All rights reserved.
//

#import "MCNavViewController.h"
//#import "HZPhotoBrowser.h"
@interface MCNavViewController ()

@end

@implementation MCNavViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
            
            interfaceOrientation == UIInterfaceOrientationLandscapeRight );
}
//是否允许屏幕旋转

-(BOOL)shouldAutorotate{
//    if ([self.topViewController isKindOfClass:[ HZPhotoBrowser class]]) { // 如果是这个 vc 则支持自动旋转
//        return YES;
//    }
    return NO;
}
//支持的方向
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeRight;
}

@end
