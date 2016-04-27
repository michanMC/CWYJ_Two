//
//  Home_LunBoGuangGao_Web.m
//  iOS_TongFuBao_Mall
//
//  Created by 湘郎 on 15/10/13.
//  Copyright (c) 2015年 MacAir. All rights reserved.
//

#import "Home_LunBoGuangGao_Web.h"

@interface Home_LunBoGuangGao_Web ()<UIWebViewDelegate>
{
    UIWebView *lunBoGuangGao_Web;
    BOOL _isZhuan;
}


@end

@implementation Home_LunBoGuangGao_Web
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //[self.navigationController setToolbarHidden:YES animated:NO];
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*[self leftBarButtonBack];*/
    
    [self loadsView];
}

-(void)loadsView
{
//    NSURL *url=[NSURL URLWithString:[self.adlinkurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];http://
    lunBoGuangGao_Web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64)];

    
    
    if (IOS8) {
        
    if (![_adlinkurl containsString:@"http://"]) {
        _adlinkurl = [NSString stringWithFormat:@"http://%@",_adlinkurl];
    }
    }
    else
    {
        NSRange range = [_adlinkurl rangeOfString:@"http://"];//判断字符串是否包含
        if (range.length >0)//包含
        {
            
        }
        else//不包含
        {
            _adlinkurl = [NSString stringWithFormat:@"http://%@",_adlinkurl];
        }
    }
    NSLog(@"URL :%@",self.adlinkurl);

    NSURL *url=[NSURL URLWithString:_adlinkurl];
    
    
    //利用url对象,来创建一个网络请求
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    //让 webView去加载请求
    [lunBoGuangGao_Web loadRequest:request];
    
    //设置代理
    lunBoGuangGao_Web.delegate = self;
    
    [self.view addSubview:lunBoGuangGao_Web];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (!_isZhuan) {
        _isZhuan = YES;
        [self showLoading:YES AndText:nil];
        NSLog(@"当将要开始加载请求时调用此方法");

    }
    return YES;
}

//加载完成的时候执行该方法。
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    //获取当前页面的title
    self.title =  [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self stopshowLoading];
    
    //NSLog(@"title-%@--url-%@--",[webView stringByEvaluatingJavaScriptFromString:@"document.title"],webView.request.URL.absoluteString);
    //获取当前网页的html
    //NSString *lJs = @"document.documentElement.innerHTML";
    //self.currentHTML = [webView stringByEvaluatingJavaScriptFromString:lJs];

}
//加载出错的时候执行该方法。
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self stopshowLoading];
    [self showAllTextDialog:@"加载失败"];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
