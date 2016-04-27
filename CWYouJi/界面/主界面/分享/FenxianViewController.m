//
//  FenxianViewController.m
//  CWYouJi
//
//  Created by MC on 15/11/25.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "FenxianViewController.h"
#import "MCfenxianView.h"
#import "HMSegmentedControl.h"
#import "GNViewController.h"
#import "GWViewController.h"
@interface FenxianViewController ()<UIWebViewDelegate,UIScrollViewDelegate>
{
    HMSegmentedControl *titleSegment;

    MCfenxianView * _fenxianView;
   // UIWebView *lunBoGuangGao_Web;
    BOOL _isZhuan;
    NSString * _countryCount;
    NSString * _percent;
    NSString * _country2Count;
    NSString * _percent2;

    NSMutableDictionary * _ssDic;
    NSMutableDictionary * _ssDic2;

    UIView *_guoneiView;
    UIView *_guowaiView;
    UIWebView *_GN_Web;
    UIWebView *_GW_Web;

    
    GNViewController * _gnCtl;
    GWViewController * _gwCtl;

    
    

}
@property(nonatomic,strong)UIScrollView *mainScroll;

@end

@implementation FenxianViewController
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
-(void)addGNView{
    _gnCtl = [[GNViewController alloc]init];
    
    _gnCtl.adlinkurl = _adlinkurl;
    [self.mainScroll addSubview:_gnCtl.view];
    return;
    
    
    
    
    
    _guoneiView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - 64 - 150)];
    
    _guoneiView.backgroundColor = [UIColor yellowColor];
    [_mainScroll addSubview:_guoneiView];
    _GN_Web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, _guoneiView.frame.size.height)];
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
    [_guoneiView addSubview:_GN_Web];

    
    
    
}
-(void)addGWView{
    _gwCtl = [[GWViewController alloc]init];
    _gwCtl.adlinkurl = _adlin2kurl;

    [self.mainScroll addSubview:_gwCtl.view];
    return;
    

    _guowaiView = [[UIView alloc]initWithFrame:CGRectMake(Main_Screen_Width, 0, Main_Screen_Width, Main_Screen_Height - 64 - 150)];
    //_guowaiView.backgroundColor = [UIColor redColor];
    [_mainScroll addSubview:_guowaiView];
    _GW_Web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, _guowaiView.frame.size.height)];
    _GW_Web.backgroundColor = [UIColor whiteColor];
    

    NSURL *url=[NSURL URLWithString:_adlin2kurl];
    
    
    //利用url对象,来创建一个网络请求
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    //让 webView去加载请求
    [_GW_Web loadRequest:request];
    
    //设置代理
    _GW_Web.delegate = self;
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
    [_guowaiView addSubview:_GW_Web];
    
    
}

-(void)addAllSelect{
    
    //选择框
    titleSegment = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 44)];
    titleSegment.sectionTitles = @[@"国内足迹", @"全球足迹"];
    titleSegment.selectedSegmentIndex = _indexs;
    titleSegment.backgroundColor = [UIColor whiteColor];
    titleSegment.textColor = [UIColor grayColor];
    titleSegment.selectedTextColor = AppTextCOLOR;
    titleSegment.font = [UIFont systemFontOfSize:16];
    titleSegment.selectionIndicatorColor = UIColorFromRGB(0x29477d);//[UIColor colorWithPatternImage:[UIImage imageNamed:@"red_line_tap"]];
    titleSegment.selectionIndicatorHeight = 3;
    titleSegment.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    titleSegment.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    //[self.view addSubview:titleSegment];
    __weak typeof(self) weakSelf = self;
    __weak typeof(NSString*) weakurl1 = _adlinkurl;
    __weak typeof(NSString*) weakurl2 = _adlin2kurl;

    __weak typeof(UIWebView*) weakweb = _GN_Web;
//    __weak typeof(UIWebView*) weakweb = _GN_Web;

  //  __block typeof(NSInteger) weakisBianji = _isBianji;
    
    [titleSegment setIndexChangeBlock:^(NSInteger index) {
        
        weakSelf.mainScroll.contentOffset =CGPointMake(index * Main_Screen_Width, 0);
        // [weakSelf lodata];
//        if (index == 0) {
//            NSURL *url=[NSURL URLWithString:weakurl1];
//            
//            
//            //利用url对象,来创建一个网络请求
//            NSURLRequest * request = [NSURLRequest requestWithURL:url];
//            
//            //让 webView去加载请求
//            [weakweb loadRequest:request];
//
//        }
//        else
//        {
//            NSURL *url=[NSURL URLWithString:weakurl2];
//            
//            
//            //利用url对象,来创建一个网络请求
//            NSURLRequest * request = [NSURLRequest requestWithURL:url];
//            
//            //让 webView去加载请求
//            [weakweb loadRequest:request];
//
//        }
        
    }];
    self.navigationItem.titleView = titleSegment;
    //
}
- (void)addScrollView
{
    //中间View
    self.mainScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64)];
    self.mainScroll.contentSize = CGSizeMake(Main_Screen_Width * 2, 0);
    _mainScroll.contentOffset = CGPointMake(Main_Screen_Width * _indexs, 0);
    //self.mainScroll.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
    self.mainScroll.delegate = self;
    self.mainScroll.pagingEnabled = YES;
    self.mainScroll.showsHorizontalScrollIndicator = NO;
    self.mainScroll.bounces = NO;
    [self.view addSubview:self.mainScroll];
    
    
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([scrollView isKindOfClass:[UITableView class]]) {
        return;
    }
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    [titleSegment setSelectedSegmentIndex:page animated:YES];
   // [self lodata];
    
    if (page == 0) {
      //  [self lodata];
    }
    else
    {
        
    }
}
-(void)ActionBack{

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"分享";
    self.view.backgroundColor  = [UIColor whiteColor];
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_icon_back_pressed"] style:UIBarButtonItemStylePlain target:self action:@selector(ActionBack)];
    [self addAllSelect];
    [self addScrollView];
    [self addGNView];
    [self addGWView];
//    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MCfenxianView" owner:self options:nil];
//    _fenxianView = [nib objectAtIndex:0];
//    _fenxianView.frame = CGRectMake(0, Main_Screen_Height -150 , Main_Screen_Width, 150);
//    __weak FenxianViewController * weakSelf = self;
//    
//    [_fenxianView.weiboBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
//        if (_ssDic)
//            [weakSelf actionFenxian:SSDKPlatformTypeSinaWeibo PopToRoot:NO SsDic:_ssDic];
//        NSLog(@"微博");
//    }];
//    
//    [_fenxianView.QQbtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
//        if (_ssDic)
//            [weakSelf actionFenxian:SSDKPlatformTypeQQ PopToRoot:NO SsDic:_ssDic];
//        // [weakSelf.navigationController popToRootViewControllerAnimated:YES];
//        NSLog(@"QQ");
//    }];
//    [_fenxianView.weixinBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
//        if (_ssDic)
//            [weakSelf actionFenxian:SSDKPlatformSubTypeWechatSession PopToRoot:NO SsDic:_ssDic];
//        //  [weakSelf.navigationController popToRootViewControllerAnimated:YES];
//        NSLog(@"weixin");
//    }];
//    
//    [_fenxianView.doubanBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
//        if (_ssDic)
//            [weakSelf actionFenxian:SSDKPlatformSubTypeWechatTimeline PopToRoot:NO SsDic:_ssDic];
//        //[weakSelf.navigationController popToRootViewControllerAnimated:YES];
//        NSLog(@"土豆");
//    }];
//    
//    
//    
//    
//    
//    [self.view addSubview:_fenxianView];
//
    
    
    
    
    
    
    
    
    
    
    
    /*
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 54, Main_Screen_Width, Main_Screen_Height - 64 - 150)];
    view.backgroundColor = [UIColor whiteColor];
        lunBoGuangGao_Web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - 75 - 170)];
    lunBoGuangGao_Web.backgroundColor = [UIColor whiteColor];
        NSURL *url=[NSURL URLWithString:_adlinkurl];
    
    
    //利用url对象,来创建一个网络请求
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    //让 webView去加载请求
    [lunBoGuangGao_Web loadRequest:request];
    
    //设置代理
    lunBoGuangGao_Web.delegate = self;
//        lunBoGuangGao_Web.scalesPageToFit = NO;
//      lunBoGuangGao_Web.detectsPhoneNumbers = YES;
    //lunBoGuangGao_Web.scalesPageToFit=YES;
//    lunBoGuangGao_Web.scrollView.zoomScale = 1;
//     lunBoGuangGao_Web.transform = CGAffineTransformScale(lunBoGuangGao_Web.transform, 1.5, 1.5);
//    lunBoGuangGao_Web.center = view.center;
   // lunBoGuangGao_Web.center =
    //html是否加载完成
//    isLoadingFinished = NO;
//   [ lunBoGuangGao_Web loadHTMLString:_adlinkurl baseURL:url];
    [view addSubview:lunBoGuangGao_Web];
    [self.view addSubview:view];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MCfenxianView" owner:self options:nil];
    _fenxianView = [nib objectAtIndex:0];
    _fenxianView.frame = CGRectMake(0, Main_Screen_Height -150 , Main_Screen_Width, 150);
    __weak FenxianViewController * weakSelf = self;

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
        NSLog(@"土豆");
    }];

    
    
    
    
    [self.view addSubview:_fenxianView];
    self.title = _titleStr;
    [self lodata];
     */
   // [self loadData];
    // Do any additional setup after loading the view.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

//加载完成的时候执行该方法。
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    //获取当前页面的title
   // self.title =  [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
   
   // lunBoGuangGao_Web.contentSize=newsize;

    [self stopshowLoading];
    
    //NSLog(@"title-%@--url-%@--",[webView stringByEvaluatingJavaScriptFromString:@"document.title"],webView.request.URL.absoluteString);
    //获取当前网页的html
    //NSString *lJs = @"document.documentElement.innerHTML";
    //self.currentHTML = [webView stringByEvaluatingJavaScriptFromString:lJs];
    
}
//加载出错的时候执行该方法。
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [_GN_Web stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];

    [self stopshowLoading];
    [self showAllTextDialog:@"加载失败"];
}

-(void)webViewDidStartLoad:(UIWebView*)webView{
    if (!_isZhuan) {
        _isZhuan = YES;
        [self showLoading:YES AndText:nil];
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



//-(void)loadData{
//    
//    [self showLoading:YES AndText:nil];
//    
////    [self.requestManager requestWebWithParaWithURL_NotResponseJson:@"api/travel/chinaMap.jhtml" Parameter:nil Finish:^(NSDictionary *resultDic) {
////        [self stopshowLoading];
////        NSLog(@">>>>>%@",resultDic);
////
////    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
////        [self stopshowLoading];
////        [self showHint:description];
////
////    }];
////    
////    return;
//    
//    
//    
//    [self.requestManager requestWebWithGETParaWith:@"api/travel/chinaMap.jhtml" Parameter:nil Finish:^(NSDictionary *resultDic) {
//        [self stopshowLoading];
//        NSLog(@">>>>>%@",resultDic);
//        
//    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
//        [self stopshowLoading];
//        [self showHint:description];
//    }];
//    
//    
//    
//}
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
