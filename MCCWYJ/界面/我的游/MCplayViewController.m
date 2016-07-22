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
@interface MCplayViewController ()<UIScrollViewDelegate,MCscreenViewDelegate,SearchViewControllerDelegate>
{
    UITextField *_searchtext;
    HMSegmentedControl *_SegmentView;
    UIScrollView* _mainScrollView;
    AllPalyViewController *_allViewCtl;
    friendPlayViewController *_friendViewCtl;


    BOOL _isShowScree;
    MCscreenView * _screenview;
    
    NSDictionary *_all2Dic;
    NSDictionary *_fri2Dic;

    NSMutableDictionary * _allDic;
    NSMutableDictionary * _friDic;

    
    
    

}

@end

@implementation MCplayViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [(LCTabBarController*) self.tabBarController removeOriginControls];
    self.navigationController.navigationBarHidden = NO;

}

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
    _allDic = [NSMutableDictionary dictionary];
    [_allDic setObject:@"" forKey:@"isRecommend"];
    [_allDic setObject:@"" forKey:@"classify"];
    [_allDic setObject:@"" forKey:@"distance"];
    _friDic = [NSMutableDictionary dictionary];
    [_friDic setObject:@"" forKey:@"isRecommend"];
    [_friDic setObject:@"" forKey:@"classify"];
    [_friDic setObject:@"" forKey:@"distance"];

    _all2Dic = @{
                 @"like":@"0",
                 @"classify":@"0",
                 @"distance":@"0"
                 };
    _fri2Dic = @{
                 @"like":@"0",
                 @"classify":@"0",
                 @"distance":@"0"
                 };

    
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
    NSString *sessionId = [MCUserDefaults objectForKey:@"sessionId"];
    if (!sessionId.length) {
//        [self showHint:@"亲，请登录才能做此操作哦"];
       
        LoginController * ctl = [[LoginController alloc]init];
        [self pushNewViewController:ctl];

        return;
    }

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
//     _searchtext.clearButtonMode = UITextFieldViewModeAlways;
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
//        NSDictionary * dic = @{
//                               @"like":@"0",
//                               @"classify":@"0",
//                               @"distance":@"0"
//                               };
        
        
        _screenview.delegate = self;
        NSInteger currentPage = _mainScrollView.contentOffset.x/_mainScrollView.frame.size.width;

        if (currentPage == 0) {
            NSLog(@"_all2Dic == %@",_all2Dic);

            [_screenview IsMYBuy:NO DataDic:_all2Dic];

        }
        else
        {
            NSLog(@"_fri2Dic == %@",_fri2Dic);

            [_screenview IsMYBuy:NO DataDic:_fri2Dic];

        }
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
    
    NSInteger currentPage = _mainScrollView.contentOffset.x/_mainScrollView.frame.size.width;

    
    NSLog(@"selectDic ==%@",selectDic);
    
    
    
    
    if (currentPage == 0) {
        _all2Dic = selectDic;
        
        
        if ([selectDic[@"distance"] integerValue]==0) {
            [_allDic setObject:@"" forKey:@"distance"];
        }
        else
        {
            if ([selectDic[@"distance"] integerValue] == 1) {
                [_allDic setObject:@"5000" forKey:@"distance"];

            }
            if ([selectDic[@"distance"] integerValue] == 2) {
                [_allDic setObject:@"10000" forKey:@"distance"];
                
            }
            if ([selectDic[@"distance"] integerValue] == 3) {
                [_allDic setObject:@"50000" forKey:@"distance"];
                
            }
            if ([selectDic[@"distance"] integerValue] == 4) {
                [_allDic setObject:@"100000" forKey:@"distance"];
                
            }

        }
        
        
        if ([selectDic[@"like"] integerValue]==0) {
            [_allDic setObject:@"" forKey:@"isRecommend"];

        }
        else
        {
            [_allDic setObject:selectDic[@"like"] forKey:@"isRecommend"];

        }
        
        
        
        if ([selectDic[@"classify"] integerValue]==0) {
            [_allDic setObject:@"" forKey:@"classify"];

        }
        else
        {
            [_allDic setObject:selectDic[@"classify"] forKey:@"classify"];

        }

        
        [_allViewCtl selectAlldic:_allDic];
        
        
    }
    else//好友游记
    {
        _fri2Dic = selectDic;
        
        if ([selectDic[@"distance"] integerValue]==0) {
            [_friDic setObject:@"" forKey:@"distance"];
        }
        else
        {
            if ([selectDic[@"distance"] integerValue] == 1) {
                [_friDic setObject:@"5000" forKey:@"distance"];
                
            }
            if ([selectDic[@"distance"] integerValue] == 2) {
                [_friDic setObject:@"10000" forKey:@"distance"];
                
            }
            if ([selectDic[@"distance"] integerValue] == 3) {
                [_friDic setObject:@"50000" forKey:@"distance"];
                
            }
            if ([selectDic[@"distance"] integerValue] == 4) {
                [_friDic setObject:@"100000" forKey:@"distance"];
                
            }
            
        }
        
        
        if ([selectDic[@"like"] integerValue]==0) {
            [_friDic setObject:@"" forKey:@"isRecommend"];
            
        }
        else
        {
            [_friDic setObject:selectDic[@"like"] forKey:@"isRecommend"];
            
        }
        
        
        
        if ([selectDic[@"classify"] integerValue]==0) {
            [_friDic setObject:@"" forKey:@"classify"];
            
        }
        else
        {
            [_friDic setObject:selectDic[@"classify"] forKey:@"classify"];
            
        }
        
        
        [_friendViewCtl selectfridic:_friDic];
        

        
        
        
    }
    
    
    
    
    
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
    __weak typeof(MCplayViewController*) weakSelf = self;

    [_SegmentView setIndexChangeBlock:^(NSInteger index) {
        weakScrollView.contentOffset =CGPointMake(index * Main_Screen_Width, 0);
        if (index == 1) {
            
            
            [weakSelf MyshoppingGoin];
            
        }

        
    }];
    


    [self.view addSubview:_SegmentView];

}
#pragma mark-点搜索
-(void)ActionsearchBtn{
    [self MCscreenhidden];
    SearchViewController  * ctl = [[SearchViewController alloc]init];
    ctl.SearchType = SearchType_scenic;
    ctl.delegate = self;
    ctl.Search_Str = _searchtext.text;
    [self pushNewViewController:ctl];
    
}
-(void)selectTitleModel:(jingdianModel *)model
{
    
    
    NSInteger currentPage = _mainScrollView.contentOffset.x/_mainScrollView.frame.size.width;
    
    
    
    
    
    
    if (currentPage == 0) {
    if (model) {
        _searchtext.text = model.nameCH;
        [_allDic setObject:model.id forKey:@"spotId"];
 
    }
    else
    {
        _searchtext.text = @"";
        [_allDic setObject:@"" forKey:@"spotId"];
 
    }
    
    [_allViewCtl selectAlldic:_allDic];
    }
    else
    {
        if (model) {
            _searchtext.text = model.nameCH;
            [_friDic setObject:model.id forKey:@"spotId"];
            
        }
        else
        {
            _searchtext.text = @"";
            [_friDic setObject:@"" forKey:@"spotId"];
            
        }
        
        [_friendViewCtl selectfridic:_friDic];
 
    }

}
-(void)prepareCurrentScrollView{
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64+44, Main_Screen_Width, Main_Screen_Height - 44 - 64 - 49)];
    _mainScrollView.contentSize = CGSizeMake(Main_Screen_Width * 2, 0);
    _mainScrollView.backgroundColor = [UIColor whiteColor];
    _mainScrollView.bounces = NO;
    _mainScrollView.delegate =self;
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.tag = 700;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_mainScrollView];
    
    
}
-(void)addallView{
    
    _allViewCtl = [[AllPalyViewController alloc]init];
    _allViewCtl.view.frame = CGRectMake(0, 0, Main_Screen_Width, _mainScrollView.mj_h);
    _allViewCtl.delegate = self;
    [_mainScrollView addSubview:_allViewCtl.view];
    
}
-(void)addfriendView{
    _friendViewCtl = [[friendPlayViewController alloc]init];
    _friendViewCtl.view.frame = CGRectMake(Main_Screen_Width, 0, Main_Screen_Width, _mainScrollView.mj_h);
    _friendViewCtl.delegate = self;

    [_mainScrollView addSubview:_friendViewCtl.view];

    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if (scrollView != _mainScrollView) {
        return;
    }
    NSInteger currentPage = scrollView.contentOffset.x/_mainScrollView.frame.size.width;

    _SegmentView.selectedSegmentIndex = currentPage;
    if (currentPage == 1) {
        [self MyshoppingGoin];
    }

}
-(void)MyshoppingGoin{
    
    NSString *sessionId = [MCUserDefaults objectForKey:@"sessionId"];
    if (!sessionId.length) {
        _mainScrollView.contentOffset =CGPointMake(0, 0);
        _SegmentView.selectedSegmentIndex = 0;
        LoginController * ctl = [[LoginController alloc]init];
        [self pushNewViewController:ctl];
        return;
    }
    
    
    
    
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
