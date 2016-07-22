//
//  MySellViewController.m
//  MCCWYJ
//
//  Created by MC on 16/6/3.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MySellViewController.h"
#import "HMSegmentedControl.h"
#import "Sell_ViewController.h"
#import "PurchaseViewController.h"
#import "SellCollectViewController.h"

@interface MySellViewController ()<UIScrollViewDelegate>

{
    HMSegmentedControl *_SegmentView;
    UIScrollView* _mainScrollView;
    Sell_ViewController  *_sellView;
    PurchaseViewController * _PurchaseView;
    SellCollectViewController * _SellCollectView;

    UIView * _hongDianView;

}

@end

@implementation MySellViewController
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    if (_sellView) {
        [_sellView.tableView reloadData];
        _hongDianView.hidden = [MCIucencyView sellRemind];
        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的售";
  //  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(actionButtonItem:)];
    [self prepareCurrentScrollView];
    [self addAllSelect];
    [self addSellView];
    [self addPurchaseView];
    [self addSellCollectView];

    // Do any additional setup after loading the view.
}
-(void)actionButtonItem:(UIBarButtonItem*)item{
    
    NSInteger currentPage = _mainScrollView.contentOffset.x/_mainScrollView.frame.size.width;
    
    NSLog(@"%@",item.title);
    
    if ([item.title isEqualToString:@"编辑"]) {
        item.title = @"完成";
        self.title = @"编辑";
        if (currentPage == 0) {
            [_sellView actionEdit];
        }
        else  if (currentPage == 1)
        {
            [_PurchaseView actionEdit];
        }
        else  if (currentPage == 2)
        {
            [_SellCollectView actionEdit];
        }
        _SegmentView.userInteractionEnabled = NO;
        _mainScrollView.contentSize = CGSizeMake( 0, 0);
        _mainScrollView.contentOffset =CGPointMake(currentPage * Main_Screen_Width, 0);
        
    }
    else
    {
        self.title = @"我的求";
        item.title = @"编辑";
        if (currentPage == 0) {
            [_sellView actionEdit];
        }
        else if (currentPage == 1)
        {
            [_PurchaseView actionEdit];
        }
        else  if (currentPage == 2)
        {
            [_SellCollectView actionEdit];
        }
        
        _SegmentView.userInteractionEnabled = YES;
        
        _mainScrollView.contentSize = CGSizeMake(Main_Screen_Width * 3, 0);
        
        
    }
    
    
    
}


-(void)addSellCollectView{
    _SellCollectView = [[ SellCollectViewController alloc]init];
    _SellCollectView.view.frame = CGRectMake(2*Main_Screen_Width, 0, Main_Screen_Width, _mainScrollView.mj_h);
    _SellCollectView.delegate = self;
    
    [_mainScrollView addSubview:_SellCollectView.view];
    
}
-(void)addPurchaseView{
    
    _PurchaseView = [[ PurchaseViewController alloc]init];
    _PurchaseView.view.frame = CGRectMake(Main_Screen_Width, 0, Main_Screen_Width, _mainScrollView.mj_h);
    _PurchaseView.delegate = self;
    
    [_mainScrollView addSubview:_PurchaseView.view];
    
}
-(void)addSellView{
    _sellView = [[Sell_ViewController alloc]init];
    _sellView.view.frame = CGRectMake(0, 0, Main_Screen_Width, _mainScrollView.mj_h);
    _sellView.delegate = self;
    [_mainScrollView addSubview:_sellView.view];
    
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

-(void)addAllSelect{
    //选择框
    _SegmentView = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 44)];
    _SegmentView.sectionTitles = @[@"出售", @"购买",@"收藏"];
    _SegmentView.selectedSegmentIndex = 0;
    _SegmentView.backgroundColor = [UIColor whiteColor];
    _SegmentView.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor darkTextColor], NSFontAttributeName : [UIFont systemFontOfSize:16]};
    _SegmentView.selectedTitleTextAttributes = @{NSForegroundColorAttributeName :       RGBCOLOR(232, 48, 17),NSFontAttributeName : [UIFont systemFontOfSize:16]};
    
    //    _SegmentView.selectionIndicatorHeight = 3;
    _SegmentView.selectionIndicatorColor = AppCOLOR;//[UIColor orangeColor];
    //    _SegmentView.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    _SegmentView.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone;
    __weak typeof(UIScrollView*) weakScrollView = _mainScrollView;
    __weak typeof (BaseViewController*)weakself =  self;

    [_SegmentView setIndexChangeBlock:^(NSInteger index) {
        weakScrollView.contentOffset =CGPointMake(index * Main_Screen_Width, 0);
        if (index == 2) {
            
            
            //            if (typeissNOEdit) {
            //                weakself.navigationItem.rightBarButtonItem = nil;
            //
            //            }
            //            else
            weakself.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:weakself action:@selector(actionButtonItem:)];
            
        }
        else
        {
//            _isNOEdit = NO;
            weakself.navigationItem.rightBarButtonItem = nil;
            
        }

        
    }];
    
    
    
    [self.view addSubview:_SegmentView];
    CGFloat w = [MCIucencyView heightforString:@"出售" andHeight:44 fontSize:16];
    CGFloat x = ( Main_Screen_Width/3 - w) / 2;
    _hongDianView = [[UIView alloc]initWithFrame:CGRectMake(x + w + 5, _SegmentView.mj_y + 10, 6, 6)];
    _hongDianView.backgroundColor = AppCOLOR;
    ViewRadius(_hongDianView, 3);
    [self.view addSubview:_hongDianView];
    
    _hongDianView.hidden = [MCIucencyView sellRemind];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if (scrollView != _mainScrollView) {
        return;
    }
    NSInteger currentPage = scrollView.contentOffset.x/_mainScrollView.frame.size.width;
    if (currentPage == 2) {
//        if (_isNOEdit) {
//            self.navigationItem.rightBarButtonItem = nil;
//            
//        }
//        else
        
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(actionButtonItem:)];
        
    }
    else
    {
//        _isNOEdit = NO;
        
        self.navigationItem.rightBarButtonItem = nil;
        
    }

    _SegmentView.selectedSegmentIndex = currentPage;
    
}
-(void)finishEdit{
    //    self.navigationItem.rightBarButtonItem.title = @"编辑";
    [self actionButtonItem:self.navigationItem.rightBarButtonItem];
    
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
