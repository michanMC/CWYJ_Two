//
//  MChomeViewController.m
//  CWYouJi
//
//  Created by MC on 16/4/28.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MChomeViewController.h"
#import "LeftViewController.h"
#import "UIViewController+NavBarHidden.h"
#import "ZZCarousel.h"
#import "MCplaceholderText.h"
#import "MCMApManager.h"
#import "LoginController.h"
#import "AppDelegate.h"
#import "SettViewViewController.h"
@interface MChomeViewController ()<UITableViewDataSource,UITableViewDelegate,ZZCarouselDelegate>
{
    
    UITableView *_tableView;
    NSMutableArray *_bannerArray;
  UIButton * _headBtn;
    MCplaceholderText *_searchtext;

}

@end

@implementation MChomeViewController



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    RESideMenu *sideMenuViewController  =(RESideMenu*)  appDelegate.window.rootViewController;
    
    sideMenuViewController.panGestureEnabled = YES;
    
    
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];//用于去除导航栏的底线，也就是周围的边线
    
    //刷新头像，地址
        [_headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[MCUserDefaults objectForKey:@"thumbnail"]] forState:0 placeholderImage:[UIImage imageNamed:@"home_mine_avatar2"]];
    
    
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    RESideMenu *sideMenuViewController  =(RESideMenu*)  appDelegate.window.rootViewController;
    
    sideMenuViewController.panGestureEnabled = NO;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    _bannerArray = [NSMutableArray array];
    //监听头像的刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disTouXiangObj:) name:@"disTouXiangObjNotification" object:nil];
    //跳转页面
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disCtlViewObj:) name:@"disCtlViewObjNotification" object:nil];
    //self.navigationController.navigationBarHidden = YES;
    [self prepareUI];
    
    //[self loadImg];
    // Do any additional setup after loading the view.
}
#pragma mark-跳转页面
-(void)disCtlViewObj:(NSNotification*)notication{
    NSString * objcStr =notication.object;
    [[[self.navigationController.navigationBar subviews]objectAtIndex:0] setAlpha:1];

       if ([objcStr isEqualToString:@"设置"]) {
        SettViewViewController * ctl = [[SettViewViewController alloc]init];
        [self pushNewViewController:ctl];
    }
    
    
    
}
-(void)disTouXiangObj:(NSNotification*)notication{
    //刷新头像，地址
    [_headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[MCUserDefaults objectForKey:@"thumbnail"]] forState:0 placeholderImage:[UIImage imageNamed:@"home_mine_avatar2"]];
    
}
-(void)prepareUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - 49) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    [self.view addSubview:_tableView];
    _tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
   [[[self.navigationController.navigationBar subviews]objectAtIndex:0] setAlpha:0];
    [MCMApManager sharedInstance];//定位
    [[MCMApManager sharedInstance] Isdingwei:YES CtlView:self];
//    [[MCMApManager sharedInstance] Isdingwei:YES CtlView:self];

    [self prepareHeadview];
        //2.设置导航条内容
    [self setUpNavBar];
    
    [self setKeyScrollView:_tableView scrolOffsetY:200*MCHeightScale options:nil];
    
    
    [self loadbanner];
    
}

#pragma mark - UI设置
#pragma mark -prepareHeadview
-(void)prepareHeadview{
    ZZCarousel* wheel  = [[ZZCarousel alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 200*MCHeightScale)];
    /*
     *   carouseScrollTimeInterval  ---  此属性为设置轮播多长时间滚动到下一张
     */
    wheel.carouseScrollTimeInterval = 5.0f;
    
    
    
    // 代理
    wheel.delegate = self;
    
    /*
     *   isAutoScroll  ---  默认为NO，当为YES时 才能使轮播进行滚动
     */
    wheel.isAutoScroll = YES;
    
    /*
     *   pageType  ---  设置轮播样式 默认为系统样式。ZZCarousel 中封装了 两种样式，另外一种为数字样式
     */
    wheel.pageType = ZZCarouselPageTypeOfNone;
    
    /*
     *   设置UIPageControl 在轮播中的位置、系统默认的UIPageControl 的顶层颜色 和底层颜色已经背景颜色
     */
    wheel.pageControlFrame = CGRectMake((Main_Screen_Width - 60 ) / 2, wheel.frame.size.height - 20, 60, 10);
    
    
    wheel.pageIndicatorTintColor = RGBCOLOR(250, 150, 110);//[UIColor whiteColor];
    wheel.currentPageIndicatorTintColor = RGBCOLOR(251, 78, 9);
    wheel.pageControlBackGroundColor = [UIColor whiteColor];
    
    /*
     *   设置数字样式的 UIPageControl 中的字体和字体颜色。 背景颜色仍然按照上面pageControlBackGroundColor属性来设置
     */
    wheel.pageControlOfNumberFont = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    wheel.pageContolOfNumberFontColor = [UIColor whiteColor];

        _tableView.tableHeaderView = wheel;

    [wheel reloadData];
    
}
#pragma mark -setUpNavBar

- (void)setUpNavBar{
    CGFloat x = 10;
    CGFloat y = 25;
    CGFloat width = 30;
    CGFloat height = 30;

    _headBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    ViewRadius(_headBtn, 15);
    _headBtn.alpha = 1;
    [_headBtn addTarget:self action:@selector(LeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    [_headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[MCUserDefaults objectForKey:@"thumbnail"]] forState:0 placeholderImage:[UIImage imageNamed:@"home_mine_avatar2"]];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_headBtn];
    
    
    MCIucencyView * seachView = [[MCIucencyView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width - 100, 30)];
    ViewRadius(seachView, 5);
    _searchtext = [[MCplaceholderText alloc]initWithFrame:CGRectMake(30, 0, seachView.mj_w - 30, 30)];
    _searchtext.placeholder = @"输入景点搜索";
    _searchtext.textColor  =[UIColor whiteColor];
    _searchtext.font = AppFont;
    _searchtext.enabled = NO;
    _searchtext.clearButtonMode = UITextFieldViewModeAlways;
    [seachView addSubview:_searchtext];
    UIButton *_searchBtn = [[UIButton alloc]initWithFrame:_searchtext.bounds];
    [_searchBtn addTarget:self action:@selector(ActionsearchBtn) forControlEvents:UIControlEventTouchUpInside];
    [seachView addSubview:_searchBtn];

    UIImageView * imgview = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
    imgview.image = [UIImage imageNamed:@"ic_icon_search1"];
    [seachView addSubview:imgview];
    
    self.navigationItem.titleView = seachView;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:nil];
    
    
    
}
#pragma mark-加载广告图
-(void)loadbanner{
    
    [self showLoading];
    [self.requestManager postWithUrl:@"api/global/banner.json" refreshCache:NO params:nil IsNeedlogin:NO success:^(id resultDic) {
        NSLog(@"成功");
        [self stopshowLoading];

        NSLog(@"guang游记==%@",resultDic);
        _bannerArray = resultDic[@"object"];
        _tableView.tableHeaderView = nil;
        [self prepareHeadview];
        
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
        NSLog(@"失败");

    }];
    
    
}
#pragma mark-点击头像
-(void)LeftMenuViewController:(UIButton*)btn{
    if (![MCUserDefaults objectForKey:@"sessionId"]||![[MCUserDefaults objectForKey:@"sessionId"] length]) {
        LoginController * ctl = [[LoginController alloc]init];
        [self pushNewViewController:ctl];
        return;
    }
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"disDatadetailObjNotification" object:nil];
    [self presentLeftMenuViewController:btn];
}
#pragma mark-点击搜索
-(void)ActionsearchBtn
{
    
}
#pragma mark-下拉
-(void)loadNewData{
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 20;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.backgroundColor = indexPath.row % 2 ? [UIColor orangeColor]:[UIColor greenColor];
    
    cell.textLabel.text = @"zzzz";
    return cell;
}
#pragma mark --- ZZCarouselDelegate


-(NSInteger)numberOfZZCarousel:(ZZCarousel *)wheel
{
    if (_bannerArray.count) {
        return _bannerArray.count;
    }
    return 3;
}
-(ZZCarouselView *)zzcarousel:(UICollectionView *)zzcarousel viewForItemAtIndex:(NSIndexPath *)index itemsIndex:(NSInteger)itemsIndex identifire:(NSString *)identifire ZZCarousel:(ZZCarousel *)zZCarousel
{
    /*
     *  index参数         ※ 注意
     */
    ZZCarouselView *cell = [zzcarousel dequeueReusableCellWithReuseIdentifier:identifire forIndexPath:index];
    
    if (!cell) {
        cell = [[ZZCarouselView alloc]init];
    }
    //    cell.title.text = [_imagesGroup objectAtIndex:indexPath.row];
    //    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"图片地址"]];
    
    /*
     *  itemsIndex 参数   ※ 注意
     */
    if (_bannerArray.count) {
        NSDictionary * model = [_bannerArray objectAtIndex:itemsIndex];
        
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model[@"image"]] placeholderImage:[UIImage imageNamed:@"home_banner_default-chart"]];
    }
    else
        
        cell.imageView.image = [UIImage imageNamed:@"123"];
    //
    
    return cell;
}

//点击方法

-(void)zzcarouselScrollView:(ZZCarousel *)zzcarouselScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    //[self showAllTextDialog:[NSString stringWithFormat:@"点击了 第%ld张",(long)index]];
//    if(_bannerArray.count > index ){
//        NSDictionary * model = [_bannerArray objectAtIndex:index];
//        
//        Home_LunBoGuangGao_Web *vc = [[Home_LunBoGuangGao_Web alloc]init];
//        vc.adlinkurl = model[@"link"];
//        [self pushNewViewController:vc];
//        
//    }
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
