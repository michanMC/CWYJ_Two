//
//  MCplayViewController.m
//  CWYouJi
//
//  Created by MC on 16/4/28.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MCplayViewController.h"
#import "MCplaceholderText.h"
#import "HMSegmentedControl.h"
#import "AllPalyViewController.h"
#import "friendPlayViewController.h"
#import "ProductionViewController.h"
#import "homeYJModel.h"
#import "MakeViewController.h"
#import "MCscreenView.h"
#import "SearchViewController.h"
@interface MCplayViewController ()<UIScrollViewDelegate,MCscreenViewDelegate>
{
    UITextField *_searchtext;
    HMSegmentedControl *_SegmentView;
    UIScrollView* _mainScrollView;
    AllPalyViewController *_allViewCtl;
    friendPlayViewController *_friendViewCtl;


    BOOL _isShowScree;
    MCscreenView * _screenview;

}

@end

@implementation MCplayViewController
-(void)disXQDatadetailObj:(NSNotification*)notication{
    NSDictionary * dic = (NSDictionary*)notication.object;
    ProductionViewController *ctl = [[ProductionViewController alloc]init];
    ctl.home_model = dic[@"model"];
    ctl.dataArray = dic[@"dataArray"];
    ctl.index = [dic [@"index"] integerValue];//indexPath.section;

    [self pushNewViewController:ctl];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //监听跳详情
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disXQDatadetailObj:) name:@"disXQDatadetailObjNotification" object:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpNavBar];
    [self prepareCurrentScrollView];
    [self addAllSelect];
    [self addallView];
    [self addfriendView];
    // Do any additional setup after loading the view.
}
#pragma mark-actionMake
-(void)actionMake{
    [self MCscreenhidden];

    MakeViewController * ctl = [[MakeViewController alloc]init];
   
    
    
    [self pushNewViewController:ctl];
    
    
    
}




-(void)setUpNavBar{

     MCIucencyView * seachView = [[MCIucencyView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width - 100, 30)];
    [seachView setBgViewColor:[UIColor groupTableViewBackgroundColor]];
     ViewRadius(seachView, 3);
    seachView.layer.borderWidth = .5;
    seachView.layer.borderColor = [UIColor lightGrayColor].CGColor;
     _searchtext = [[UITextField alloc]initWithFrame:CGRectMake(30, 0, seachView.mj_w - 30, 30)];
     _searchtext.placeholder = @"输入景点搜索";
     _searchtext.textColor  =[UIColor lightGrayColor];
     _searchtext.font = AppFont;
     _searchtext.enabled = NO;
     _searchtext.clearButtonMode = UITextFieldViewModeAlways;
     [seachView addSubview:_searchtext];
     UIButton *_searchBtn = [[UIButton alloc]initWithFrame:_searchtext.bounds];
     [_searchBtn addTarget:self action:@selector(ActionsearchBtn) forControlEvents:UIControlEventTouchUpInside];
     [seachView addSubview:_searchBtn];
     
     UIImageView * imgview = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
     imgview.image = [UIImage imageNamed:@"ic_icon_search2"];
     [seachView addSubview:imgview];
     
     self.navigationItem.titleView = seachView;
    
 self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(actionMake)];
    
    
    
    CGFloat x = 10;
    CGFloat y = 25;
    CGFloat width = 30;
    CGFloat height = 30;
    
    UIButton * _screenBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    
    [_screenBtn setImage:[UIImage imageNamed:@"home_mine_screened"] forState:0];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_screenBtn];
    [_screenBtn addTarget:self action:@selector(action_screenBtn) forControlEvents:UIControlEventTouchUpInside];

    
    

}
-(void)action_screenBtn{
    if (_isShowScree) {
        _isShowScree = NO;
        [_screenview removeFromSuperview];
        
    }
    else
    {
        _isShowScree = YES;
        _screenview = [[MCscreenView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height  - 64)];
        NSDictionary * dic = @{
                               @"like":@"0",
                               @"classify":@"0",
                               @"distance":@"0"
                               };
        
        _screenview.delegate = self;
        [_screenview IsMYBuy:NO DataDic:dic];
        [_screenview showInWindow];
        
    }
    
    
}
-(void)MCscreenhidden
{
    _isShowScree = NO;
    [_screenview removeFromSuperview];
    
}
-(void)MCscreenselsctDic:(NSMutableDictionary *)selectDic
{
    [self MCscreenhidden];
    NSLog(@"selectDic ==%@",selectDic);
    
}

-(void)addAllSelect{
    //选择框
    _SegmentView = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 44)];
    _SegmentView.sectionTitles = @[@"全部游记", @"好友游记"];
    _SegmentView.selectedSegmentIndex = 0;
    _SegmentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _SegmentView.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor darkTextColor], NSFontAttributeName : [UIFont systemFontOfSize:16]};
    _SegmentView.selectedTitleTextAttributes = @{NSForegroundColorAttributeName :       RGBCOLOR(232, 48, 17),NSFontAttributeName : [UIFont systemFontOfSize:16]};
    
    _SegmentView.selectionIndicatorHeight = 3;
    _SegmentView.selectionIndicatorColor = AppCOLOR;//[UIColor orangeColor];
    _SegmentView.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    _SegmentView.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    __weak typeof(UIScrollView*) weakScrollView = _mainScrollView;

    [_SegmentView setIndexChangeBlock:^(NSInteger index) {
        weakScrollView.contentOffset =CGPointMake(index * Main_Screen_Width, 0);

        
    }];
    


    [self.view addSubview:_SegmentView];

}
#pragma mark-点搜索
-(void)ActionsearchBtn{
    [self MCscreenhidden];
    SearchViewController  * ctl = [[SearchViewController alloc]init];
    [self pushNewViewController:ctl];
    
}
-(void)prepareCurrentScrollView{
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64+44, Main_Screen_Width, Main_Screen_Height - 44 - 64 - 49)];
    _mainScrollView.contentSize = CGSizeMake(Main_Screen_Width * 2, 0);
    _mainScrollView.backgroundColor = [UIColor whiteColor];
    _mainScrollView.bounces = NO;
    _mainScrollView.delegate =self;
    _mainScrollView.tag = 700;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_mainScrollView];
    
    
}
-(void)addallView{
    
    _allViewCtl = [[AllPalyViewController alloc]init];
    _allViewCtl.view.frame = CGRectMake(0, 0, Main_Screen_Width, _mainScrollView.mj_h);
    [_mainScrollView addSubview:_allViewCtl.view];
    
}
-(void)addfriendView{
    _friendViewCtl = [[friendPlayViewController alloc]init];
    _friendViewCtl.view.frame = CGRectMake(Main_Screen_Width, 0, Main_Screen_Width, _mainScrollView.mj_h);
    [_mainScrollView addSubview:_friendViewCtl.view];

    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if (scrollView != _mainScrollView) {
        return;
    }
    NSInteger currentPage = scrollView.contentOffset.x/_mainScrollView.frame.size.width;

    _SegmentView.selectedSegmentIndex = currentPage;

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
