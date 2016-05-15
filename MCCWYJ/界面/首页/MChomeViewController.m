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
#import "MCMApManager.h"
#import "LoginController.h"
#import "AppDelegate.h"
#import "SettViewViewController.h"
#import "HomeCollectionViewCell.h"
#import "HomeHeaderCollectionReusableView.h"

@interface MChomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
   // UITableView *_tableView;
    UICollectionView *_collectionView;

    NSMutableArray *_bannerArray;
  UIButton * _headBtn;
    UIButton * _cityBtn;

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
        [_headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[MCUserDefaults objectForKey:@"thumbnail"]] forState:0 placeholderImage:[UIImage imageNamed:@"home_Avatar_44"]];
    
    
    
    
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
   // self.title = @"";
//    self.navigationController.title = @"首页";
    self.navigationItem.titleView = [[UIView alloc]init];
    _bannerArray = [NSMutableArray array];
    //监听头像的刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disTouXiangObj:) name:@"disTouXiangObjNotification" object:nil];
    //监听位置的刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disCityObj:) name:@"disCityObjNotification" object:nil];
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
-(void)disCityObj:(NSNotification*)notication{
    
    NSString * city = notication.object;
    if (!city||!city.length) {
        city = @"未知";
    }
    CGFloat w = [MCIucencyView heightforString:city andHeight:25 fontSize:14]+20;
    _cityBtn.frame = CGRectMake(_cityBtn.mj_x, 0, w, _cityBtn.mj_h);
    [_cityBtn setTitle:city forState:0];

}

-(void)disTouXiangObj:(NSNotification*)notication{
    //刷新头像，地址
    [_headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[MCUserDefaults objectForKey:@"thumbnail"]] forState:0 placeholderImage:[UIImage imageNamed:@"home_Avatar_44"]];
    
}
-(void)prepareCollectionView{
     UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64 - 49) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [_collectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:@"mc"];
    
    _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[HomeHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
        _collectionView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    

}
-(void)prepareUI{
    [self prepareCollectionView];
//   [[[self.navigationController.navigationBar subviews]objectAtIndex:0] setAlpha:0];
    [MCMApManager sharedInstance];//定位
    [[MCMApManager sharedInstance] Isdingwei:YES CtlView:self];
//    [[MCMApManager sharedInstance] Isdingwei:YES CtlView:self];

  //  [self prepareHeadview];
        //2.设置导航条内容
    [self setUpNavBar];
    
   // [self setKeyScrollView:_tableView scrolOffsetY:200*MCHeightScale options:nil];
    
    
    [self loadbanner];
    
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
    
    
    NSString * city = [MCUserDefaults objectForKey:@"city"];
    if (!city||!city.length) {
        city = @"未知";
    }
   CGFloat w = [MCIucencyView heightforString:city andHeight:25 fontSize:14]+20;
    _cityBtn = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width - 10 - w, (40-25)/2, w, 25)];
    [_cityBtn setTitle:city forState:0];
    ViewRadius(_cityBtn, 25/2);
    [_cityBtn setTitleColor:[UIColor whiteColor] forState:0];
    _cityBtn.titleLabel.font = AppFont;
    _cityBtn.backgroundColor = [UIColor lightGrayColor];
    
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_cityBtn];//[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:nil];
    
    
    
}
#pragma mark-加载广告图
-(void)loadbanner{
    
    [self showLoading];
    [self.requestManager postWithUrl:@"api/global/banner.json" refreshCache:NO params:nil IsNeedlogin:NO success:^(id resultDic) {
        NSLog(@"成功");
        [self stopshowLoading];

        NSLog(@"guang游记==%@",resultDic);
        _bannerArray = resultDic[@"object"];
        [_collectionView reloadData];
        
        [_collectionView.mj_header endRefreshing];
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
        NSLog(@"失败");
        [_collectionView.mj_header endRefreshing];

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
    [self loadbanner];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    //collectionView有多少的section
    return 5;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //collectionView有多少个Item
    if (section == 0 || section == 1)
        return 0;
    if (section == 2) {
        return 2;
    }
    return 4;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        HomeHeaderCollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        if(indexPath.section == 0){
            [headView prepareADUI];
            headView.backgroundColor = [UIColor whiteColor];
        }
        else
        {
            if(indexPath.section == 1)
                [headView prepareUI:@"朋友推荐"];
            if(indexPath.section == 2)
            [headView prepareMeUI:@"我的"];
            if(indexPath.section == 3)
                [headView prepareMeUI:@"热门"];
            if(indexPath.section == 4)
                [headView prepareUI:@"朋友江湖"];

            
            
//            if (indexPath.section == 1|| indexPath.section == 2)
//                headView.backgroundColor = [UIColor whiteColor];
//            else
                headView.backgroundColor = [UIColor groupTableViewBackgroundColor];


        }
        return headView;
    }
          return nil;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section== 0) {
        return CGSizeMake(Main_Screen_Width, 150*MCHeightScale);
    }
    return CGSizeMake(Main_Screen_Width, 40);
}





-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0|| indexPath.section == 1) {
        return CGSizeMake(0.001, 0.001);

    }
    if (indexPath.section == 4) {
        return CGSizeMake(Main_Screen_Width - 20, 150*MCHeightScale);
    }
//    if (indexPath.section == 2)
    //item
//    return CGSizeMake((Main_Screen_Width - 10)/2, 110*MCHeightScale + 85);
    else if (indexPath.section == 3)

    return CGSizeMake((Main_Screen_Width - 30)/2, 110*MCHeightScale + 85 + 30);

    return CGSizeMake((Main_Screen_Width - 30)/2, 110*MCHeightScale + 85);

}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0||section == 1) {
        return UIEdgeInsetsMake(0, 0, 0, 0);

    }
//    if (section == 3)
        return UIEdgeInsetsMake(10, 10,10, 10);

//    return UIEdgeInsetsMake(0, 0, 2.5, 0);

}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mc" forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[HomeCollectionViewCell alloc]init];
        
    }
    if (indexPath.section == 4) {
        [cell prepareYJUI];
    }
   else if (indexPath.section == 3) {
        [cell prepareHotUI];
    }
    else
    {
    [cell prepareMeUI];
    }
    return cell;
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
