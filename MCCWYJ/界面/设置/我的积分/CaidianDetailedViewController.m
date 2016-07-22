//
//  CaidianDetailedViewController.m
//  MCCWYJ
//
//  Created by MC on 16/5/27.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "CaidianDetailedViewController.h"
#import "HMSegmentedControl.h"
#import "AllDetailedViewController.h"
#import "CaiDetailedViewController.h"
#import "ZenDetailedViewController.h"
#import "MCIntegralScreenView.h"
@interface CaidianDetailedViewController ()<UIScrollViewDelegate,MCscreenViewDelegate>
{
    
    HMSegmentedControl *_SegmentView;
    UIScrollView* _mainScrollView;
    AllDetailedViewController * _addctl;
    CaiDetailedViewController * _Caictl;
    ZenDetailedViewController * _Zenctl;
    MCIntegralScreenView * _screenview;
    BOOL _isShowScree;
    
    NSInteger _indeSele;
    NSString* _startTime;
    NSString* _endTime;

    

}
@end

@implementation CaidianDetailedViewController
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self MCscreenhidden];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"采点明细";
    _indeSele = -1;
    CGFloat x = 10;
    CGFloat y = 25;
    CGFloat width = 30;
    CGFloat height = 30;
    
    UIButton * _screenBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, width, height)];
    
    [_screenBtn setImage:[UIImage imageNamed:@"home_mine_screened"] forState:0];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_screenBtn];
    [_screenBtn addTarget:self action:@selector(action_screenBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    [self prepareCurrentScrollView];
    [self addAllSelect];
    [self addAllView];
    [self addCaiView];
    [self addZenView];

    // Do any additional setup after loading the view.
}
-(void)action_screenBtn{
    
    if (_isShowScree) {
        _isShowScree = NO;
        [_screenview removeFromSuperview];
        
    }
    else
    {
        _screenview = [[MCIntegralScreenView alloc]initWithFrame:CGRectMake(0, 65, Main_Screen_Width, Main_Screen_Height  - 65)];
        _screenview.startTime = _startTime;
        _screenview.endTime = _endTime;

        _screenview.seleIndex = _indeSele;
        
        _isShowScree = YES;
        _screenview.delegate = self;
        
        [_screenview showInWindow];
        
    }
    
    
}
-(void)MCscreenhidden
{
    _isShowScree = NO;
    [_screenview removeFromSuperview];
    
}
-(void)MCscreenselsctDic:(NSMutableDictionary*)selectDic
{
    [self MCscreenhidden];
    
    NSString * ss = selectDic[@"seleindex"];
    // times     0,当天，1当月，2，自定义；
     _startTime = @"";
    _endTime = @"";

    
    if ([ss isEqualToString:@"0"]) {
        _indeSele = -1;
    }
    if ([ss isEqualToString:@"1"]) {
        _indeSele = 0;
    }
    if ([ss isEqualToString:@"2"]) {
        _indeSele = 1;
    }
    if ([ss isEqualToString:@"3"]) {
        _indeSele = 2;
        _startTime = selectDic[@"start"];
        _endTime = selectDic[@"endTime"];

    }
    
    _addctl.seleIndex = _indeSele;
    _addctl.startTime = _startTime;
    _addctl.endTime = _endTime;
    [_addctl RefreshHeader];
    
    _Caictl.seleIndex = _indeSele;
    _Caictl.startTime = _startTime;
    _Caictl.endTime = _endTime;
    [_Caictl RefreshHeader];

    
    _Zenctl.seleIndex = _indeSele;
    _Zenctl.startTime = _startTime;
    _Zenctl.endTime = _endTime;
    [_Zenctl RefreshHeader];

    
    
}
-(void)addAllView{
     _addctl= [[AllDetailedViewController alloc]init];
    _addctl.view.frame = CGRectMake(0, 0, Main_Screen_Width, _mainScrollView.mj_h);
    _addctl.seleIndex = _indeSele;
    _addctl.deleGate = self;
    [_mainScrollView addSubview:_addctl.view];
    [_addctl loadData2];
    
}
-(void)addCaiView{
    _Caictl = [[CaiDetailedViewController alloc]init];
    _Caictl.view.frame = CGRectMake(Main_Screen_Width, 0, Main_Screen_Width, _mainScrollView.mj_h);
    _Caictl.deleGate = self;
    _Caictl.seleIndex = _indeSele;

    [_mainScrollView addSubview:_Caictl.view];
    [_Caictl loadData2];

    
}
-(void)addZenView{
    
    _Zenctl = [[ZenDetailedViewController alloc]init];
    _Zenctl.view.frame = CGRectMake(Main_Screen_Width * 2, 0, Main_Screen_Width, _mainScrollView.mj_h);
    _Zenctl.deleGate = self;
    _Zenctl.seleIndex = _indeSele;

    [_mainScrollView addSubview:_Zenctl.view];

    [_Zenctl loadData2];

    
}
-(void)addAllSelect{
    //选择框
    _SegmentView = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 44)];
    _SegmentView.sectionTitles = @[@"全部", @"采点",@"赠点"];
    _SegmentView.selectedSegmentIndex = 0;
    _SegmentView.backgroundColor = [UIColor whiteColor];
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

-(void)prepareCurrentScrollView{
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64+44, Main_Screen_Width, Main_Screen_Height - 44 - 64)];
    _mainScrollView.contentSize = CGSizeMake(Main_Screen_Width * 3, 0);
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.backgroundColor = [UIColor whiteColor];
    _mainScrollView.bounces = NO;
    _mainScrollView.delegate =self;
    _mainScrollView.tag = 700;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_mainScrollView];
    
    
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
