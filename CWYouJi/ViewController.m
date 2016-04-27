//
//  ViewController.m
//  CWYouJi
//
//  Created by MC on 15/10/27.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "ViewController.h"
#import "REFrostedViewController.h"
#import "AppDelegate.h"
#import "DEMONavigationController.h"
#import "DEMOHomeViewController.h"
#import "DEMOMenuViewController.h"
#import "loginViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self lloginChenggong];
    return;
    // 没有注销且seesion没过期才可以直接进入主界面
    NSString* logout = [[NSUserDefaults standardUserDefaults] objectForKey:@"isLogOut"];

    if ( [logout isEqualToString:@"1"] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"] length]) {

        [self lloginChenggong];
    
    }
    else{
    
    loginViewController *loginVC = [[loginViewController alloc]init];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    DEMONavigationController *nav = [[DEMONavigationController alloc]initWithRootViewController:loginVC];
    appDelegate.window.rootViewController = nav;
    return;

    }

/*
    DEMONavigationController *navigationController = [[DEMONavigationController alloc] initWithRootViewController:[[DEMOHomeViewController alloc] init]];
    
    DEMOMenuViewController *menuController = [[DEMOMenuViewController alloc] initWithStyle:UITableViewStylePlain];
    

    REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navigationController menuViewController:menuController];
    
    frostedViewController.direction = REFrostedViewControllerDirectionLeft;
    frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
    frostedViewController.liveBlur = YES;
    frostedViewController.delegate = self;
    
    // Make it a root controller
    //
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = frostedViewController;
    
*/
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)lloginChenggong{
    
    DEMOHomeViewController * home = [[DEMOHomeViewController alloc] init];
    DEMONavigationController *navigationController = [[DEMONavigationController alloc] initWithRootViewController:home];
    
    
    DEMOMenuViewController *menuController = [[DEMOMenuViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navigationController menuViewController:menuController];
    
    frostedViewController.direction = REFrostedViewControllerDirectionLeft;
    
    frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
    frostedViewController.panGestureEnabled = YES;
    
    frostedViewController.liveBlur = YES;
    frostedViewController.delegate = self;
    frostedViewController.limitMenuViewSize = YES;
    // Make it a root controller
    //
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = frostedViewController;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
