//
//  GNViewController.m
//  CWYouJi
//
//  Created by MC on 16/1/15.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "GNViewController.h"

@interface GNViewController ()<UIWebViewDelegate>

{
   
    NSString * _countryCount;
    NSMutableDictionary * _ssDic;
    UIWebView *_GN_Web;
    NSString * _percent;
    BOOL _isZhuan;


}

@end

@implementation GNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height  - 64);
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MCfenxianView" owner:self options:nil];
        _fenxianView = [nib objectAtIndex:0];
        _fenxianView.frame = CGRectMake(0, Main_Screen_Height -150-64 , Main_Screen_Width, 150);
        __weak GNViewController * weakSelf = self;
    
        [_fenxianView.weiboBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
            if (_ssDic)
                [weakSelf actionFenxian:SSDKPlatformTypeSinaWeibo PopToRoot:NO SsDic:_ssDic];
            NSLog(@"微博");
        }];
    
        [_fenxianView.QQbtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
            if (_ssDic)
                [weakSelf actionFenxian:SSDKPlatformTypeQQ PopToRoot:NO SsDic:_ssDic];
            // [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            NSLog(@"QQ");
        }];
        [_fenxianView.weixinBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
            if (_ssDic)
                [weakSelf actionFenxian:SSDKPlatformSubTypeWechatSession PopToRoot:NO SsDic:_ssDic];
            //  [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            NSLog(@"weixin");
        }];
    
        [_fenxianView.doubanBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
            if (_ssDic)
                [weakSelf actionFenxian:SSDKPlatformSubTypeWechatTimeline PopToRoot:NO SsDic:_ssDic];
            //[weakSelf.navigationController popToRootViewControllerAnimated:YES];
            NSLog(@"朋友");
        }];
        
        
        
        
        
        [self.view addSubview:_fenxianView];
    
    
    
    
    
    

    [self addGNView];
     [self lodata];
    // Do any additional setup after loading the view.
}
-(void)addGNView{

    _GN_Web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-64-150)];
    _GN_Web.backgroundColor = [UIColor whiteColor];
    NSURL *url=[NSURL URLWithString:_adlinkurl];
    
    
    //利用url对象,来创建一个网络请求
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    //让 webView去加载请求
    [_GN_Web loadRequest:request];
    
    //设置代理
    _GN_Web.delegate = self;
    //            _GN_Web.scalesPageToFit = NO;
    //          _GN_Web.detectsPhoneNumbers = YES;
    //    _GN_Web.scalesPageToFit=YES;
    //        _GN_Web.scrollView.zoomScale = 1;
    //         _GN_Web.transform = CGAffineTransformScale(_GN_Web.transform, 1.5, 1.5);
    //        lunBoGuangGao_Web.center = view.center;
    //     lunBoGuangGao_Web.center =
    //    //html是否加载完成
    //        isLoadingFinished = NO;
    // [ _GN_Web loadHTMLString:_adlinkurl baseURL:url];
    [self.view addSubview:_GN_Web];
    
    
   
    
}
-(void)lodata{
    
    NSString * Parameterdic = @"api/travel/provinceCount.json";
       // Parameterdic = @"api/travel/countryCount.json";
    
    NSString * uid_Str = [MCUserDefaults objectForKey:@"id"];
    
    
    NSDictionary * dic = @{
                           @"uid":_uidStr?_uidStr : uid_Str,
                           
                           };
     [self showLoading];
    [self.requestManager postWithUrl:Parameterdic refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self hideHud];
        [self stopshowLoading];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        
        
        if ([resultDic objectForKey:@"object"][@"provinceCount"]) {
            _countryCount = [resultDic objectForKey:@"object"][@"provinceCount"];
            
        }
        if ([resultDic objectForKey:@"object"][@"percent"]) {
            _percent = [resultDic objectForKey:@"object"][@"percent"];
            
        }
        
        if ([_uidStr integerValue] ==[[MCUserDefaults objectForKey:@"id"] integerValue]) {
            
            _fenxianView.titleLbl.text = [NSString stringWithFormat:@"你已经踏遍全国%@个省了，打败了全国%@的用户。",_countryCount,_percent];

            
        }
        else
        {
            _fenxianView.titleLbl.text = [NSString stringWithFormat:@"ta已经踏遍全国%@个省了，打败了全国%@的用户。",_countryCount,_percent];

            
        }
        
        
        
        
        
        
        if (_adlinkurl.length &&  [resultDic objectForKey:@"object"][@"content"]) {
            
            _ssDic = [NSMutableDictionary dictionary];
            
            [_ssDic setObject:_adlinkurl forKey:@"url"];
            [_ssDic setObject:[resultDic objectForKey:@"object"][@"content"] forKey:@"title"];
            [_ssDic setObject:@"国内足迹" forKey:@"titlesub"];
            
        }

        
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
        
        NSLog(@"失败");

    }];
    
}
//加载出错的时候执行该方法。
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [_GN_Web stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
//    [self stopshowLoading];
    [self showAllTextDialog:@"加载失败"];
}

-(void)webViewDidStartLoad:(UIWebView*)webView{
    if (!_isZhuan) {
        _isZhuan = YES;
//        [self showLoading];
        NSLog(@"当将要开始加载请求时调用此方法");
        
    }
    
    NSString *meta = [NSString stringWithFormat:@"document.getElementsByName(\"viewport\")[0].content = \"width=%f, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\"", _GN_Web.frame.size.width];
    [_GN_Web stringByEvaluatingJavaScriptFromString:meta];
    [_GN_Web stringByEvaluatingJavaScriptFromString:
     @"var tagHead =document.documentElement.firstChild;"
     "var tagMeta = document.createElement(\"meta\");"
     "tagMeta.setAttribute(\"http-equiv\", \"Content-Type\");"
     "tagMeta.setAttribute(\"content\", \"text/html; charset=utf-8\");"
     "var tagHeadAdd = tagHead.appendChild(tagMeta);"];
    [_GN_Web stringByEvaluatingJavaScriptFromString:
     @"var tagHead =document.documentElement.firstChild;"
     "var tagStyle = document.createElement(\"style\");"
     "tagStyle.setAttribute(\"type\", \"text/css\");"
     "tagStyle.appendChild(document.createTextNode(\"BODY{padding: 10pt 10pt}\"));"
     "var tagHeadAdd = tagHead.appendChild(tagStyle);"];
    //拦截网页图片  并修改图片大小
    [_GN_Web stringByEvaluatingJavaScriptFromString:
     @"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function ResizeImages() { "
     "var myimg,oldwidth,oldheight;"
     "var maxwidth=300;"
     "for(i=0;i <document.images.length;i++){"
     "myimg = document.images[i];"
     "if(myimg.width > maxwidth){"
     "oldwidth = myimg.width;oldheight=myimg.height;"
     "myimg.width = maxwidth;"
     "myimg.height = oldheight*(maxwidth*1.0/oldwidth);"
     "}"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
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
