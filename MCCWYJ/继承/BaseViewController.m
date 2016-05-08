

#import "BaseViewController.h"
#import "CLGifLoadView.h"
#import "UIViewController+HUD.h"
#import "MChomeViewController.h"
@interface BaseViewController ()
{
    CLGifLoadView * gifLoading;

}

@end

@implementation BaseViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  //  self.navigationController.navigationBarHidden = YES;
    
}
- (void)pushNewViewController:(UIViewController *)newViewController {
    if (newViewController) {
    }
    [self.navigationController pushViewController:newViewController animated:YES];
}


-(void)stopshowLoading{
   // [self hideHud];
    [gifLoading setState:CLLoadStateFinish];

    
}

- (void)showAllTextDialog:(NSString *)title
{
   [self showHint:title];
}
#pragma mark - Loading

- (void)showLoading
{
    // [self showHudInView:self.view hint:nil];
    gifLoading = [[CLGifLoadView alloc]initWithFrame:self.view.bounds];
    gifLoading.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:gifLoading];
    [gifLoading setState:CLLoadStateLoading];

}
- (void)showLoading:(BOOL)show AndText:(NSString *)text
{
    if (show) {
        gifLoading = [[CLGifLoadView alloc]initWithFrame:self.view.bounds];
        gifLoading.backgroundColor = [UIColor clearColor];
        
        [self.view addSubview:gifLoading];
        
        [gifLoading setState:CLLoadStateLoading];
        
    }
    else{
        [self stopshowLoading];
        
    }
}

- (void)showSuccess
{
    
}

- (void)showError
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _requestManager = [MCNetworkManager instanceManager];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:@"sessionId"]){
            NSDictionary * dic = @{
                                   @"user_session":[defaults objectForKey:@"sessionId"],

                                   };

[_requestManager configCommonHttpHeaders:dic];
    }
    
   

    
    if (IOS7) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self appColorNavigation];
   // [self ColorNavigation];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    

}
-(void)appColorNavigation{
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     RGBCOLOR(127, 125, 147), NSForegroundColorAttributeName,
                                                                     [UIFont fontWithName:@"CourierNewPSMT" size:20.0], NSFontAttributeName,
                                                                     nil]];
    self.navigationController.navigationBar.barTintColor =    [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];//RGBCOLOR(127, 125, 147);
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
//    if (![self isKindOfClass:[MChomeViewController class] ]) {
//        [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
//
//    }
    
 
}
-(void)ColorNavigation{
    
    self.navigationController.navigationBar.barTintColor =       [UIColor whiteColor];
    [self.navigationController.navigationBar setTintColor:RGBCOLOR(127, 125, 147)];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     RGBCOLOR(127, 125, 147), NSForegroundColorAttributeName,
                                                                     [UIFont fontWithName:@"CourierNewPSMT" size:20.0], NSFontAttributeName,
                                                                     nil]];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)toPopVC
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
