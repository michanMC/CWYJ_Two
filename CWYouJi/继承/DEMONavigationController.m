//
//  DEMONavigationController.m
//  REFrostedViewControllerExample
//
//  Created by Roman Efimov on 9/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMONavigationController.h"
#import "DEMOMenuViewController.h"
#import "HZPhotoBrowser.h"
@interface DEMONavigationController ()

@property (strong, readwrite, nonatomic) DEMOMenuViewController *menuViewController;

@end

@implementation DEMONavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
}

- (void)showMenu
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}

#pragma mark -
#pragma mark Gesture recognizer

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController panGestureRecognized:sender];
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
    if ([self.topViewController isKindOfClass:[ HZPhotoBrowser class]]) { // 如果是这个 vc 则支持自动旋转
        return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
                
                interfaceOrientation == UIInterfaceOrientationLandscapeRight );    }

    
    return (interfaceOrientation == UIInterfaceOrientationPortrait );
}
//是否允许屏幕旋转

-(BOOL)shouldAutorotate{
    if ([self.topViewController isKindOfClass:[ HZPhotoBrowser class]]) { // 如果是这个 vc 则支持自动旋转
        return YES;
    }
    return NO;
}
//支持的方向
- (NSUInteger)supportedInterfaceOrientations {
        if (![self.topViewController isKindOfClass:[ HZPhotoBrowser class]]) {
            return UIInterfaceOrientationMaskPortrait;

        }
    return UIInterfaceOrientationMaskLandscapeRight;
    //UIInterfaceOrientationMaskPortrait
}

@end
