//
//  MakeshaidanViewController.m
//  MCCWYJ
//
//  Created by MC on 16/5/25.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MakeshaidanViewController.h"
#import "HMSegmentedControl.h"
#import "MCshaidanView.h"
#import "MCLblView.h"
#import "tiezhiView.h"
#import "XTPasterStageView.h"
#import "XTPasterView.h"
#import "DecalsModel.h"
#import "ReleaseMakeSellViewController.h"
@interface MakeshaidanViewController ()<UIScrollViewDelegate,UIAlertViewDelegate>
{
    
    UIView * _labelView;
    UILabel *_label;
    tiezhiView * _tagsView;

    
    UIScrollView* _mainScrollView;
    HMSegmentedControl *_SegmentView;

    MCshaidanView * _shaidanView;
    
    
    NSMutableDictionary *_commodityDic;
    NSInteger _lblViewCount;
    NSTimer *_gameTimer;
    NSMutableArray *_shanBtnArray;
    
    
    CGRect _imgViewRect;
    NSMutableArray * _decalsArray;
    
    
    CGFloat _lblView_x;
    CGFloat _lblView_y;

    NSString * _lblViewAlignmen;
    
//    UIView * _lblView;
//    
//    
//    UIButton * _shanBtn;
    
}
@property (strong, nonatomic)        XTPasterStageView *imgView ;

@end

@implementation MakeshaidanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑照片";
    
    _decalsArray = [NSMutableArray array];
    CGFloat imgw = _img.size.width;
    CGFloat imgh = _img.size.height;
    CGFloat w1 = Main_Screen_Width;
    CGFloat h1 = Main_Screen_Width;
    _shanBtnArray = [NSMutableArray array];
    if (imgh>imgw) {
       w1 = Main_Screen_Width *imgw /imgh;

    }
    else if(imgh<imgw)
    {
        h1 = Main_Screen_Width *imgh /imgw;

    }
    _imgView = [[XTPasterStageView alloc] initWithFrame:CGRectMake((Main_Screen_Width - w1)/2, 64, w1, h1)] ;
    _imgView.isLbl = YES;
    _imgView.originImage = _img;//self.imageWillHandle ;
    _imgView.delegate = self;
    
    
    _imgView.backgroundColor = AppTextCOLOR;
    _imgViewRect = CGRectMake((Main_Screen_Width - w1)/2, 64, w1, h1);
    
    
    _imgView.userInteractionEnabled = YES;
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionTapimg)];
//    [_imgView addGestureRecognizer:tap];
//    
    [self.view addSubview:_imgView];
    

    
    
    
    
    [self prepareCurrentScrollView];
    [self addAllSelect];
    [self addLabelView];
    [self addTagsView];
//    [self prepareLblview:3 Dic:nil];
    _gameTimer= [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    if (_commodity_Dic) {
        [self commodityDic:_commodity_Dic];

    }
    

    // Do any additional setup after loading the view.
}
- (void)rightBarAction
{
    UIImage *imgResult = [_imgView doneEdit] ;

    if (!_commodityDic) {
        [self showHint:@"请给商品添加标签"];
        return;
    }
    NSLog(@"_commodityDic == %@",_commodityDic);
    NSLog(@"_lblView_x == %f",_lblView_x);
    NSLog(@"_lblView_y == %f",_lblView_y);
    NSLog(@"_lblViewAlignmen == %@",_lblViewAlignmen);

    ReleaseMakeSellViewController * ctl = [[ReleaseMakeSellViewController alloc]init];
    ctl.imgViewRect = _imgViewRect;//_imgView.frame;
    //_imgView
    ctl.commodityDic = _commodityDic;
    ctl.lblView_x = _lblView_x;
    ctl.lblView_y = _lblView_y;
    ctl.lblViewAlignmen = _lblViewAlignmen;
    ctl.shanBtnArray = _shanBtnArray;
    ctl.img =imgResult;
    [self pushNewViewController:ctl];
    
    
    
    
    
    
}
// 时钟触发执行的方法
- (void)updateTimer:(NSTimer *)sender
{

    for (UIButton *btn in _shanBtnArray) {
        
        btn.selected = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            btn.selected = NO;

            
        });

        
        
    }
    
    
}
#pragma mark-点击图片
-(void)MCactionTapimg{
    
    if (!_commodityDic) {
    [_imgView clearAllOnFirst];

    if (!_shaidanView) {
        _shaidanView = [[MCshaidanView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
        _shaidanView.delegate =self;
        [_shaidanView showInWindow];

    }
}
    
}

-(void)addteizhi:(UIButton*)btn{
//    NSInteger i = index-300;
    DecalsModel * model = _decalsArray[btn.tag - 300];
        UIImage*img = btn.imageView.image;

        [_imgView addPasterWithImg:img] ;

    
    
}



-(void)prepareCurrentScrollView{
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64+_imgView.mj_h, Main_Screen_Width, Main_Screen_Height - 64-_imgView.mj_h - 49)];
    _mainScrollView.contentSize = CGSizeMake(Main_Screen_Width * 2, 0);
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.backgroundColor = [UIColor whiteColor];
    _mainScrollView.bounces = NO;
    _mainScrollView.delegate =self;
    _mainScrollView.tag = 900;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_mainScrollView];
    
    
}
-(void)addLabelView{
    
    _labelView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, _mainScrollView.mj_h)];
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, _mainScrollView.mj_h)];
    _label.text = @"点击照片选择添加商品相关信息";
    _label.textColor=  AppTextCOLOR;
    _label.textAlignment = NSTextAlignmentCenter;
    [_labelView addSubview:_label];
    _label.font = [UIFont systemFontOfSize:16];
    
    [_mainScrollView addSubview:_labelView];

    
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if (scrollView != _mainScrollView) {
        return;
    }
    NSInteger currentPage = scrollView.contentOffset.x/_mainScrollView.frame.size.width;
    
    _SegmentView.selectedSegmentIndex = currentPage;
    
    if (currentPage == 0) {
        _imgView.isLbl = YES;
        [_imgView clearAllOnFirst];


    }
    else
    {
        _imgView.isLbl = NO;;

    }
    
    
//    [_imgView addPasterWithImg:[UIImage imageNamed:@"贴纸"]] ;

}

-(void)addTagsView{
    
    //20+64 + 40 +20
    
    
    _tagsView = [[tiezhiView alloc]initWithFrame:CGRectMake(Main_Screen_Width, _mainScrollView.mj_h - 20 - 64 - 20 -10-40, Main_Screen_Width, 20 +64 + 20 +10)];
//    _tagsView.backgroundColor = AppTextCOLOR;
    _tagsView.delegate = self;
    [_mainScrollView addSubview:_tagsView];

    [self loadTagsData];
}
-(void)loadTagsData{
    
        [self showLoading];
    NSDictionary * dic = @{
                         
                           };
    [self.requestManager postWithUrl:@"api/decals/query.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
        for (NSDictionary * dic in resultDic[@"object"]) {
            DecalsModel * model = [DecalsModel mj_objectWithKeyValues:dic];
            [_decalsArray addObject:model];
        }
        _tagsView.dataArray = _decalsArray;
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
    }];

    
}
-(void)addAllSelect{
    //选择框
    _SegmentView = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, Main_Screen_Height - 49, Main_Screen_Width, 49)];
    _SegmentView.sectionTitles = @[@"标签", @"贴纸"];
    _SegmentView.selectedSegmentIndex = 0;
    _SegmentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _SegmentView.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor darkTextColor], NSFontAttributeName : [UIFont systemFontOfSize:16]};
    _SegmentView.selectedTitleTextAttributes = @{NSForegroundColorAttributeName :       RGBCOLOR(232, 48, 17),NSFontAttributeName : [UIFont systemFontOfSize:16]};
    
    _SegmentView.selectionIndicatorHeight = 3;
    _SegmentView.selectionIndicatorColor = AppCOLOR;//[UIColor orangeColor];
    _SegmentView.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    _SegmentView.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    __weak typeof(UIScrollView*) weakScrollView = _mainScrollView;
    __weak typeof(XTPasterStageView*) weakimgview = _imgView;

    [_SegmentView setIndexChangeBlock:^(NSInteger index) {
        weakScrollView.contentOffset =CGPointMake(index * Main_Screen_Width, 0);
        if (index == 0) {
            weakimgview.isLbl = YES;
            [weakimgview clearAllOnFirst];
            
        }
        else
        {
            weakimgview.isLbl = NO;;
            
        }

        
        
    }];
    
    
    [self.view addSubview:_SegmentView];
    
}
-(void)removeMCshaidanView{
    
    [_shaidanView removeFromSuperview];
    _shaidanView = nil;
    
    
}
#pragma mark-commodityDic
-(void)commodityDic:(NSDictionary*)dic
{
    
    NSLog(@"dic == %@",dic);
    _commodityDic = dic;
    
//    _label.text = @"点击◉可改变标签样式，长按删除标签";
    _label.text = @"点击标签可修改，长按删除标签";
    NSInteger count = 4;
    if ([dic[@"colour"] length]||[dic[@"model"] length]) {
        count = 4;
    }
    else
    {
        count = 3;

    }
    [self prepareLblview:count Dic:dic];
    
    
}

-(void)prepareLblview:(NSInteger)count Dic:(NSDictionary*)dic{
    
    
    MCLblView*lblView;//&& touch.view == _lblView
    lblView = [self.view viewWithTag:600];
    [lblView removeFromSuperview];
    
   MCLblView* _lblView = [[MCLblView alloc]initWithFrame:CGRectMake(Main_Screen_Width/2, 20 + 64, 150 , 20 * 4 + 20 * 3 + 1 * 4)];
    
    _lblView.index = 0;
    if (count == 3) {
        
         _lblView.frame = CGRectMake(Main_Screen_Width/2, 20 + 64, 150 , 20 * 3 + 20 * 2 + 1 * 3);

    }
    _lblView.tag = 600+0;
//    _lblView.backgroundColor  = AppCOLOR;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionTap:)];
    [_lblView addGestureRecognizer:tap];
    
    
    UILongPressGestureRecognizer * longTap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longTap:)];
    [_lblView addGestureRecognizer:longTap];

    
    
    
    [self.view addSubview:_lblView];
    
    CGFloat x  = 20;
    CGFloat  y = 0;
    CGFloat w = 150 - x ;
    CGFloat h = 20;
    w = [MCIucencyView heightforString:dic[@"commodity"] andHeight:20 fontSize:18];

    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.text = dic[@"commodity"];//@"法国";
    lbl.textColor = [UIColor whiteColor];
    lbl.tag = 800+_lblViewCount;
    [_lblView addSubview:lbl];
    
    y += h;
    h = 1;
    x = 10;
    w = 50;
    w = [MCIucencyView heightforString:dic[@"commodity"] andHeight:20 fontSize:18] + 5;

    UIImageView * lineImg = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lineImg.backgroundColor = [UIColor whiteColor];
    [_lblView addSubview:lineImg];

    w = 1;
    h = _lblView.mj_h - 20 - 1;
    lineImg = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lineImg.backgroundColor = [UIColor whiteColor];
    [_lblView addSubview:lineImg];

    y = _lblView.mj_h  - 1;
    w = 100;
    h = 1;
    
    w = [MCIucencyView heightforString:[NSString stringWithFormat:@"%@ %@",dic[@"model"],dic[@"colour"]] ? [NSString stringWithFormat:@"%@ %@",dic[@"model"],dic[@"colour"]] : @"ewq" andHeight:20 fontSize:18] + 5;
//最后
    lineImg = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lineImg.backgroundColor = [UIColor whiteColor];
    [_lblView addSubview:lineImg];
    

    w = 20;
    h = w;
    y = (_lblView.mj_h+20 - w )/2;
    x = 0;
  UIButton*  _shanBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [_shanBtn setImage:[UIImage imageNamed:@"icon_lable2"] forState:0];
    [_shanBtn setImage:[UIImage imageNamed:@"icon_lable"] forState:UIControlStateSelected];
//    [_shanBtn addTarget:self action:@selector(actionShanbtn:) forControlEvents:UIControlEventTouchUpInside];
    [_lblView addSubview:_shanBtn];
    _shanBtn.tag = 700+_lblViewCount;
    [_shanBtnArray addObject:_shanBtn];
    
    
    
    
    
    x = lbl.mj_x;
    y = lbl.mj_y + 20 + 1 + 20;
    w = 150 - x;
    h = 20;
    w = [MCIucencyView heightforString:[NSString stringWithFormat:@"%@ %@",dic[@"price"],dic[@"num"]] ? [NSString stringWithFormat:@"%@ %@",dic[@"price"],dic[@"num"]] : @"ewqewqe" andHeight:20 fontSize:18] ;

    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.text = [NSString stringWithFormat:@"%@ %@",dic[@"price"],dic[@"num"] ];//@"10CNY  6";
    lbl.textColor = [UIColor whiteColor];
    lbl.tag = 801+_lblViewCount;

    [_lblView addSubview:lbl];
    
    lineImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, y +h, w + 5, 1)];
    lineImg.backgroundColor = [UIColor whiteColor];
    [_lblView addSubview:lineImg];
    
    
    
    w = [MCIucencyView heightforString:[NSString stringWithFormat:@"%@ %@",dic[@"brand"],dic[@"name"]] ? [NSString stringWithFormat:@"%@ %@",dic[@"brand"],dic[@"name"]] : @"ewqewqe" andHeight:20 fontSize:18] ;

    y += h + 1 + 20;
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.text = [NSString stringWithFormat:@"%@ %@",dic[@"brand"],dic[@"name"] ];//@"kebo7 wqwqwq";
    lbl.tag = 802+_lblViewCount;

    lbl.textColor = [UIColor whiteColor];
    [_lblView addSubview:lbl];
    lineImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, y +h, w+5, 1)];
    lineImg.backgroundColor = [UIColor whiteColor];
    [_lblView addSubview:lineImg];
//    _lblViewCount++;

    if (count >3) {
        
        w = [MCIucencyView heightforString:[NSString stringWithFormat:@"%@ %@",dic[@"model"],dic[@"colour"]] ? [NSString stringWithFormat:@"%@ %@",dic[@"model"],dic[@"colour"]] : @"ewq" andHeight:20 fontSize:18] + 5;

    y += h + 1 + 20;
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
        lbl.text = [NSString stringWithFormat:@"%@ %@",dic[@"model"]?dic[@"model"] :@"未知",dic[@"colour"]?dic[@"colour"]:@"未知" ];//@"LL 红色";
        lbl.tag = 803+_lblViewCount;

    lbl.textColor = [UIColor whiteColor];
    [_lblView addSubview:lbl];
    }

    
    _lblView_x = _lblView.mj_x;
    _lblView_y = _lblView.mj_y;
    _lblViewAlignmen = @"左";
}

-(void)longTap:(UILongPressGestureRecognizer*)tap{
    
//    UIView * view = [self.view viewWithTag:tap.view.tag];
    if (tap.state == UIGestureRecognizerStateBegan) {
        

    UIAlertView * al = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确认删除此标签吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    al.tag = 800 + tap.view.tag - 600;
    [al show];
    
    }
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if (buttonIndex == 1) {
        UIButton * btn = [self.view viewWithTag:alertView.tag - 100];

        if ([_shanBtnArray containsObject:btn]) {
            [_shanBtnArray removeObject:btn];
        }

        UIView * view = [self.view viewWithTag:alertView.tag - 200];
        [view removeFromSuperview];
        _commodityDic = nil;
        _lblViewAlignmen = @"";

        if (_shanBtnArray.count == 0) {
            _label.text = @"点击照片选择添加商品相关信息";

        }
    
    }
    
    
    
}
-(void)actionTap:(UITapGestureRecognizer*)tap{
  NSLog(@"%zd",tap.view.tag);
    MCLblView * lblView = [self.view viewWithTag:tap.view.tag];
    NSLog(@"_commodityDic ====%@",_commodityDic);
//    _commodityDic ===={
//        colour = 123;
//        price = 12;
//        model = 213;
//        brand = nike;
//        commodity = 广州;
//        num = 32;
//        name = 123;
//    }
    
    
    [_imgView clearAllOnFirst];
    if (!_shaidanView) {
        _shaidanView = [[MCshaidanView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
        _shaidanView.delegate =self;
        _shaidanView.commodityDic = _commodityDic;
        [_shaidanView showInWindow];
        
    }

    
//    if (!_commodityDic) {
//        
//        
//    }

    
    
    

    NSLog(@"=======%zd",lblView.index);
    
    
    
}
-(void)actionShanbtn:(UIButton*)btn{
    MCLblView * lblView = [self.view viewWithTag:btn.tag - 100];

    NSLog(@"=======%zd",lblView.index);
    lblView.transform= CGAffineTransformScale(lblView.transform, -1.0, 1.0);
    
    UILabel * lbl1 = [self.view viewWithTag:btn.tag + 100];
    lbl1.transform= CGAffineTransformScale(lbl1.transform, -1.0, 1.0);
    
    if (lblView.index==0) {
        lbl1.textAlignment= NSTextAlignmentRight;
    }
    else
    {
        lbl1.textAlignment= NSTextAlignmentLeft;
 
    }
    
    
    UILabel * lbl2 = [self.view viewWithTag:btn.tag + 101];
    lbl2.transform= CGAffineTransformScale(lbl2.transform, -1.0, 1.0);
    
    if (lblView.index==0) {
        lbl2.textAlignment= NSTextAlignmentRight;
        NSLog(@"右");
        _lblViewAlignmen = @"右";

    }
    else
    {
        lbl2.textAlignment= NSTextAlignmentLeft;
        NSLog(@"左");
        _lblViewAlignmen = @"左";


        
    }

    
    
    UILabel * lbl3 = [self.view viewWithTag:btn.tag + 102];
    lbl3.transform= CGAffineTransformScale(lbl3.transform, -1.0, 1.0);
    if (lblView.index==0) {
        lbl3.textAlignment= NSTextAlignmentRight;
    }
    else
    {
        lbl3.textAlignment= NSTextAlignmentLeft;
        
    }


    
    UILabel * lbl4 = [self.view viewWithTag:btn.tag + 103];
    lbl4.transform= CGAffineTransformScale(lbl4.transform, -1.0, 1.0);
    if (lblView.index==0) {
        lbl4.textAlignment= NSTextAlignmentRight;
    }
    else
    {
        lbl4.textAlignment= NSTextAlignmentLeft;
        
    }

    
    if (lblView.index == 0) {
        lblView.index = 1;
    }
    else
    {
        lblView.index = 0;

    }

    
}
//当触摸结束时,调用这个方法
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //让飞机复位
    //_lblView.center = CGPointMake(160, 240);
    CGFloat x = 0;
    CGFloat y = 0;
    UITouch * touch = [touches anyObject];
    NSLog(@"当在屏幕上进行滑动时,调用这个方法");
    MCLblView*_lblView;//&& touch.view == _lblView
    _lblView = [self.view viewWithTag:touch.view.tag];

    if ((touch.phase == UITouchPhaseEnded) ) {
        if (touch.view.tag >= 600) {

            _lblView.center = [touch locationInView:self.view];
            
            
            if (_lblView.mj_x > _imgView.mj_x+_imgView.mj_w- _lblView.mj_w) {
                x = _imgView.mj_x+_imgView.mj_w-_lblView.mj_w ;
                
                _lblView.frame = CGRectMake(x, _lblView.mj_y, _lblView.mj_w, _lblView.mj_h);
            }
            if (_lblView.mj_x < _imgView.mj_x) {
                x = _imgView.mj_x;
                _lblView.frame = CGRectMake(x, _lblView.mj_y, _lblView.mj_w, _lblView.mj_h);
                
            }
            
            if (_lblView.mj_y > _imgView.mj_h-_lblView.mj_h) {
                y = _imgView.mj_h - _lblView.mj_h - 1 + 64;
                _lblView.frame = CGRectMake(_lblView.mj_x, y, _lblView.mj_w, _lblView.mj_h);
                
            }
            if (_lblView.mj_y < 64) {
                y = 64;
                _lblView.frame = CGRectMake(_lblView.mj_x, y, _lblView.mj_w, _lblView.mj_h);
                
            }

            
            
            
        }
        
    }

//[self.view viewWithTag:]
    
    NSLog(@"%f,%f",_lblView.mj_x,_lblView.mj_y);
    _lblView_x = _lblView.mj_x;
    _lblView_y = _lblView.mj_y;

    NSLog(@"当触摸结束时,调用这个方法");
}

//当在屏幕上进行滑动时,调用这个方法
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    NSLog(@"当在屏幕上进行滑动时,调用这个方法");
    MCLblView *_lblView;//&& touch.view == _lblView
    if ((touch.phase == UITouchPhaseMoved) ) {
        if (touch.view.tag >= 600) {
            _lblView = [self.view viewWithTag:touch.view.tag];
            _lblView.center = [touch locationInView:self.view];

        }
        
    }
    
    NSLog(@"window:%@",touch.window);
    NSLog(@"view: %@",touch.view);
}
//当触摸被打断时,调用这个方法(比如,进来电话,短信,或调用了通知栏)
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"当触摸被打断时,调用这个方法");
    UITouch * touch = [touches anyObject];
    NSLog(@"当在屏幕上进行滑动时,调用这个方法");
    MCLblView*_lblView;//&& touch.view == _lblView
    _lblView = [self.view viewWithTag:touch.view.tag];

    _lblView_x = _lblView.mj_x;
    _lblView_y = _lblView.mj_y;
    

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
