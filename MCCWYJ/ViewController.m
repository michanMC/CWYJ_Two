//
//  ViewController.m
//  MCCWYJ
//
//  Created by MC on 16/4/28.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "MCNavViewController.h"
#import "MChomeViewController.h"
#import "MCMyshoppingViewController.h"
#import "MCplayViewController.h"
#import "LCTabBarController.h"
#import "LeftViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    MChomeViewController *vc1 = [[MChomeViewController alloc] init];
    vc1.tabBarItem.badgeValue = @"23";
    vc1.title = @"首页";
    vc1.tabBarItem.image = [UIImage imageNamed:@"tabbar_home"];
    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_home_selected"];
    
    MCMyshoppingViewController *vc2 = [[MCMyshoppingViewController alloc] init];
    vc2.tabBarItem.badgeValue = @"1";
    vc2.title = @"我的购";
    vc2.tabBarItem.image = [UIImage imageNamed:@"tabbar_message_center"];
    vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_message_center_selected"];
    
    MCplayViewController *vc3 = [[MCplayViewController alloc] init];
    vc3.title = @"我的游";
    vc3.tabBarItem.image = [UIImage imageNamed:@"tabbar_discover"];
    vc3.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_discover_selected"];
    
    MCNavViewController *navC1 = [[MCNavViewController alloc] initWithRootViewController:vc1];
    MCNavViewController *navC2 = [[MCNavViewController alloc] initWithRootViewController:vc2];
    MCNavViewController *navC3 = [[MCNavViewController alloc] initWithRootViewController:vc3];
    
    
    
    /**************************************** Key Code ****************************************/
    
    LCTabBarController *tabBarC    = [[LCTabBarController alloc] init];
    
    //    tabBarC.itemTitleFont          = [UIFont boldSystemFontOfSize:11.0f];
    //    tabBarC.itemTitleColor         = [UIColor greenColor];
    //    tabBarC.selectedItemTitleColor = [UIColor redColor];
    //    tabBarC.itemImageRatio         = 0.5f;
    //    tabBarC.badgeTitleFont         = [UIFont boldSystemFontOfSize:12.0f];
    
    tabBarC.viewControllers        = @[navC1, navC2, navC3];

    
    
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:tabBarC
                                                                    leftMenuViewController:[LeftViewController new]
                                                                   rightMenuViewController:nil];
    //sideMenuViewController.backgroundImage = [UIImage imageNamed:@"Stars"];
    sideMenuViewController.menuPreferredStatusBarStyle = UIStatusBarStyleLightContent; // UIStatusBarStyleLightContent
    sideMenuViewController.delegate = self;
    sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
    sideMenuViewController.contentViewInPortraitOffsetCenterX = Main_Screen_Width / 2 - 50;
    sideMenuViewController.scaleMenuView = NO;
//    sideMenuViewController.contentViewShadowOpacity = 0.6;
    sideMenuViewController.contentViewShadowRadius = 12;
    sideMenuViewController.contentViewShadowEnabled = NO;
    sideMenuViewController.scaleContentView = NO;
//   sideMenuViewController.interactivePopGestureRecognizerEnabled = NO;
//    sideMenuViewController.panGestureEnabled = NO;

    appDelegate.window.rootViewController = sideMenuViewController;


    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
