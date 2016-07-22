//
//  MCWebViewController.m
//  MCCWYJ
//
//  Created by MC on 16/6/28.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MCWebViewController.h"

@interface MCWebViewController ()<UIWebViewDelegate>
{
    
    UIWebView* _webView;

}

@end

@implementation MCWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64)];
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    [self loadGoogle];

    
    
    
    
    
    // Do any additional setup after loading the view.
}
#pragma mark-开始加载
-(void)loadGoogle{
    NSString * urlStr;
    if (!_menuagenturl) {
        
    }
    else
    {
        urlStr = _menuagenturl;
    }
    NSLog(@"当前WEB地址为 : %@",urlStr);
    NSURL *url=[NSURL URLWithString:urlStr];
    
    //利用url对象,来创建一个网络请求
  NSURLRequest*  _request = [[NSURLRequest alloc] initWithURL:url
                
                                     cachePolicy:NSURLRequestUseProtocolCachePolicy
                
                                 timeoutInterval:20];
    
    
    
    
    //让 webView去加载请求
    [_webView loadRequest:_request];
    
    
}
#pragma mark UIWebViewDelegate 网页加载响应
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    
    return YES;
}
#pragma mark-当网页视图已经开始加载一个请求
-(void)webViewDidStartLoad:(UIWebView*)webView {//当网页视图已经开始加载一个请求后，得到通知。

    
    // [webView reload];
}
#pragma mark-当网页视图结束
- (void)webViewDidFinishLoad:(UIWebView* )webView
{//当网页视图结束加载一个请求之后，得到通知。
    //获取当前页面的title
    NSString *docTitle =  [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (docTitle.length > 0) {
        self.navigationItem.title = docTitle;
    }

}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error

{
    
    
    
}

#pragma mark-当网页视图失败
-(void)webView:(id)webView  DidFailLoadWithError:(NSError*)error{//当在请求加载中发生错误时
    
    
    
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
