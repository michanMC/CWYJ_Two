//
//  ShoppingQXViewController.m
//  MCCWYJ
//
//  Created by MC on 16/6/15.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "ShoppingQXViewController.h"
#import "JT3DScrollView.h"
#import "UIImageView+LBBlurredImage.h"
#import "HcCustomKeyboard.h"
#import "HZPhotoBrowser.h"
#import "CarteViewController.h"
#import "fenxianView.h"
#import "ShoppingView.h"
#import "ShoppingViewTableViewCell.h"
#import "ShoppingFillViewController.h"
#import "PaymentViewController.h"
#import "MakeBuyViewController.h"
#import "OrderReceivViewController.h"
#import "MakeSellViewController.h"
#import "ShoppingManViewController.h"
#import "WNImagePicker.h"
@interface ShoppingQXViewController ()<UIScrollViewDelegate,zuopinDataViewDeleGate,HcCustomKeyboardDelegate,UITextViewDelegate,HZPhotoBrowserDelegate,UIAlertViewDelegate>
{
    JT3DScrollView *_scrollView;
    UIButton * _backBtn;
    UIButton * _fenxianBtn;
    NSMutableArray * _viewArray;
    BOOL _iszuozhe;
 
    
    BOOL _ishuifu;
    MCBuyModlel * _BuyModlel2;
    
    pinglunModel *_pinglunModel;
    
    
    NSInteger _viewidex;
    
    UIView * _bgView;
    
    CGFloat btnmaxw;
    CGFloat btnminw;
    CGFloat btnw;
    
    

    
}
@property(nonatomic,strong)UIImageView *bgimgView;

@end

@implementation ShoppingQXViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        _viewArray = [NSMutableArray array];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectjubaoObj:) name:@"didSQjubaoObjNotification" object:nil];
//
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didshowTupianjubaoObj:) name:@"didshowShoppingObjNotification" object:nil];
//        
//        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didCarteObj:) name:@"didCarteObjNotification" object:nil];
//        
    }
    
    return self;
}
#pragma mark- 举报
-(void)didSelectjubaoObj:(NSNotification*)Notification{
    MCBuyModlel * model = Notification.object;
    
    jubaoViewController * ctl = [[jubaoViewController alloc]init];
    if ([model.type isEqualToString:@"show" ]) {
        ctl._typeindex = @"3";

    }
    else  if ([model.type isEqualToString:@"sell" ]) {
        ctl._typeindex = @"2";

    }
    else  if ([model.type isEqualToString:@"pick" ]) {
        ctl._typeindex = @"1";

    }
    ctl._youjiId = model.id;
    
    [self pushNewViewController:ctl];
    
    
}

#pragma mark-浏览图片监听
-(void)didshowTupianjubaoObj:(NSNotification*)Notification{
    //发送通知
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"disyemianjisuanObjNotification" object:@"6"];
    //  NSLog(@"%@",Notification.object);
    NSInteger index = [Notification.object integerValue] - 400;
    
    //启动图片浏览器
    HZPhotoBrowser *browserVc = [[HZPhotoBrowser alloc] init];
    browserVc.sourceImagesContainerView = self.view; // 原图的父控件
    NSInteger x = (_scrollView.contentOffset.x )/(Main_Screen_Width-80);
    NSLog(@"===%ld",x);
    
    homeYJModel * model =[[homeYJModel alloc]init];// _dataArray[_index];
    MCBuyModlel * model2 = _dataArray[_index];

    model.YJphotos =model2.YJphotos;
    
    browserVc.model =model;
    browserVc.buymodel =model2;

    NSLog(@"---------%ld",model.YJphotos.count);
    
    browserVc.imageCount = model.YJphotos.count; // 图片总数
    browserVc.currentImageIndex =(int)index;
    browserVc.delegate = self;
    [browserVc show];
    
}
#pragma mark - photobrowser代理方法
- (UIImage *)photoBrowser:(HZPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return [UIImage imageNamed:@"home_banner_default-chart"];
}

- (NSURL *)photoBrowser:(HZPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSInteger x = (_scrollView.contentOffset.x )/(Main_Screen_Width-80);
    
    
    homeYJModel * model =[[homeYJModel alloc]init];// _dataArray[_index];
    MCBuyModlel * model2 = _dataArray[_index];
    
    model.YJphotos =model2.YJphotos;

    if (model.YJphotos.count) {
        YJphotoModel * photoModel = model.YJphotos[index];
        NSString * imgurl = photoModel.raw;//[NSString stringWithFormat:@"%@%@",];
        
        return [NSURL URLWithString:[NSString stringWithFormat:@"%@",imgurl]];
    }
    return [NSURL URLWithString:@""];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"zuopinXQView"];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"zuopinXQView"];
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [[HcCustomKeyboard customKeyboard]textViewShowView:self customKeyboardDelegate:self];
    [[HcCustomKeyboard customKeyboard].zuozheBtn addTarget:self action:@selector(actionzhezhe:) forControlEvents:UIControlEventTouchUpInside];
    [HcCustomKeyboard customKeyboard].mTextView.tag = 808;
    
    _bgimgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    [self.view addSubview:_bgimgView];
    
    if (_bgimg) {
        [_bgimgView setImageToBlur:_bgimg completionBlock:^{
            
        }];
  
    }
//    else
//    [_bgimgView setImageToBlur:[UIImage imageNamed:@"login_bg_720"] completionBlock:^{
//        
//    }];
    
    
    
    [self showLoading];
    dispatch_queue_t _globalQueue;
    dispatch_queue_t _mainQueue;
    _mainQueue = dispatch_get_main_queue();
    _globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(_globalQueue, ^{
        dispatch_async(_mainQueue, ^{
            [self stopshowLoading];
            
            [self prepareUI2];
            
        });
        
    });

    // Do any additional setup after loading the view.
}
-(void)prepareUI2{
    _bgView= [[UIView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height - 49, Main_Screen_Width, 49)];

    
    _scrollView = [[JT3DScrollView alloc]initWithFrame:CGRectMake(40, 64, Main_Screen_Width - 80, Main_Screen_Height - 64-50)];
    //295+80//375
    _scrollView.effect = JT3DScrollViewEffectDepth;
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    for (int i = 0; i < _dataArray.count; i ++) {
        [self createCardWithColor:i];
    }
    _scrollView.contentOffset = CGPointMake(_index * (Main_Screen_Width - 80), 0);
    if (_index==0) {
        _scrollView.contentOffset = CGPointMake(0, 0);
        
    }
    
    _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 23, 35, 35)];
    [_backBtn setImage:[UIImage imageNamed:@"nav_icon_back"] forState:UIControlStateNormal];
    [self.view addSubview:_backBtn];
    [_backBtn addTarget:self action:@selector(actionBackBtn) forControlEvents:UIControlEventTouchUpInside];
    
    _fenxianBtn = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width - 35 - 10, 23, 35, 35)];
    [_fenxianBtn setImage:[UIImage imageNamed:@"nav_icon_share"] forState:UIControlStateNormal];
    [self.view addSubview:_fenxianBtn];
    [_fenxianBtn addTarget:self action:@selector(action_Fenxian:) forControlEvents:UIControlEventTouchUpInside];
    
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bgView];
    
    
}

- (void)createCardWithColor:(NSInteger)index
{
    CGFloat width = CGRectGetWidth(_scrollView.frame);
    CGFloat height = CGRectGetHeight(_scrollView.frame);
    
    CGFloat x = _scrollView.subviews.count * width;
    
    // contr = [[zuopinDataViewController alloc] initFrame:CGRectMake(x, 0, width, height)];
    ShoppingView * zuoView = [[ShoppingView alloc]initWithFrame:CGRectMake(x, 0, width, height)];
    ViewRadius(zuoView, 10);
    zuoView.isHot = _isHot;
    MCBuyModlel * model = _dataArray[index];
    
    zuoView.indexId = index;
    
    zuoView.classifyDic = self.classifyDic;
    zuoView.BuyModlel = model;
    zuoView.deleGate = self;
    zuoView.selfViewCtl = self;
    
    [_viewArray addObject:zuoView];
    if (index == _index ) {
        if (zuoView.bg_imgView.image) {
            [_bgimgView setImageToBlur:zuoView.bg_imgView.image completionBlock:^{
                
            }];
            
        }

//        if ( model.YJphotos.count) {
//            
//            //  NSDictionary * dicimg = model.photos[0];
//            __weak typeof(UIImageView*)bg_imgView = _bgimgView;
//            UIImageView * imgViewmc = [[UIImageView alloc]init];
//            YJphotoModel * photoModel = model.YJphotos[0]?model.YJphotos[0]:[[YJphotoModel alloc]init];
//            
//            
//            [imgViewmc sd_setImageWithURL:[NSURL URLWithString:photoModel.raw] placeholderImage:[UIImage imageNamed:@"login_bg_720"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                //                bg_imgView.alpha = 0;
//                
//                [bg_imgView setImageToBlur:image completionBlock:^{
//                    
//                }];
//                
//                
//                
//                
//            }];
//        }
//        else
//        {
//
//            [_bgimgView setImageToBlur:[UIImage imageNamed:@"login_bg_720"] completionBlock:^{
//                
//            }];
//        }
        
        
        [zuoView loadData:YES];
        [zuoView loadModle:YES];
        [self modeltype:_BuyModlel];
        
        
        
    }
    
    // contr.view.backgroundColor = [UIColor yellowColor];//
    [_scrollView addSubview:zuoView];
    _scrollView.contentSize = CGSizeMake(x + width, height);
}

-(void)modeltype:(MCBuyModlel*)model{
    
    for (UIView * view in _bgView.subviews) {
        [view removeFromSuperview];
    }
    _bgView.hidden = NO;
    
   btnmaxw  = [MCIucencyView heightforString:@"关闭订单" andHeight:30 fontSize:14] + 20;
    btnminw  = [MCIucencyView heightforString:@"再来" andHeight:30 fontSize:14] + 20;
    btnw  = [MCIucencyView heightforString:@"去支付" andHeight:30 fontSize:14] + 20;

    CGFloat x;
    CGFloat y = 10;
    CGFloat h = 30;
    UIButton *btn;
    
    if ([model.type isEqualToString:@"pick"]) {//求
        
//        if ([[MCUserDefaults objectForKey:@"id"] integerValue] ==[_BuyModlel.userId integerValue]) 
            if (model.status  == 3){//没接单
                if ([[MCUserDefaults objectForKey:@"id"] integerValue] ==[model.userId integerValue]){
                x = Main_Screen_Width - 10 - btnmaxw;
                btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, btnmaxw, h)];
                btn = [self settitel:@"关闭订单" Btn:btn Type:0];
                    [btn addTarget:self action:@selector(actionTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
                [_bgView addSubview:btn];
                
                x -= (btnminw + 10);
                btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, btnminw, h)];
                btn = [self settitel:@"再来" Btn:btn Type:0];
                    [btn setTitleColor:[UIColor grayColor] forState:0];
                    btn.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;

                    [btn addTarget:self action:@selector(actionTypeBtn:) forControlEvents:UIControlEventTouchUpInside];

                [_bgView addSubview:btn];
                }
                else
                {
                    x = Main_Screen_Width - 10 - btnminw;
                    btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, btnminw, h)];
                    btn = [self settitel:@"再来" Btn:btn Type:0];
                    [btn addTarget:self action:@selector(actionTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
                    [_bgView addSubview:btn];

                    x -= (btnminw +10);
                    btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, btnminw, h)];
                    btn = [self settitel:@"接单" Btn:btn Type:0];
                    [btn setTitleColor:[UIColor grayColor] forState:0];
                    btn.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
                    [btn addTarget:self action:@selector(actionTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [_bgView addSubview:btn];

                    
                    
                }
                
            }
            else if (model.status  == 2 ||model.status  == 6)//已关闭
            {
                if ([[MCUserDefaults objectForKey:@"id"] integerValue] ==[model.userId integerValue]){
                x = Main_Screen_Width - btnminw - 10;
                btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, btnminw, h)];
                btn = [self settitel:@"再来" Btn:btn Type:0];
                    [btn addTarget:self action:@selector(actionTypeBtn:) forControlEvents:UIControlEventTouchUpInside];

                [_bgView addSubview:btn];
                }
                else
                {
                    x = Main_Screen_Width - btnminw - 10;
                    btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, btnminw, h)];
                    btn = [self settitel:@"再来" Btn:btn Type:0];
                    [btn addTarget:self action:@selector(actionTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [_bgView addSubview:btn];

//                    _bgView.hidden = YES;
                    
                }
            }
            else if (model.status  == 4)//已接单
            {
                if ([[MCUserDefaults objectForKey:@"id"] integerValue] ==[model.userId integerValue]){
                x = Main_Screen_Width - 10 - btnmaxw;
                btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, btnmaxw, h)];
                btn = [self settitel:@"完成订单" Btn:btn Type:0];
                    [btn addTarget:self action:@selector(actionTypeBtn:) forControlEvents:UIControlEventTouchUpInside];

                [_bgView addSubview:btn];
                
                x -= (btnminw +10);
                btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, btnminw, h)];
                btn = [self settitel:@"再来" Btn:btn Type:0];
                    [btn setTitleColor:[UIColor grayColor] forState:0];
                    btn.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
                    [btn addTarget:self action:@selector(actionTypeBtn:) forControlEvents:UIControlEventTouchUpInside];

                [_bgView addSubview:btn];
            }
        else
        {
            x = Main_Screen_Width - 10 - btnmaxw;
            btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, btnmaxw, h)];
            btn = [self settitel:@"放弃订单" Btn:btn Type:0];
            [btn addTarget:self action:@selector(actionTypeBtn:) forControlEvents:UIControlEventTouchUpInside];

            [_bgView addSubview:btn];

            x -= (btnminw + 10);

//            x = Main_Screen_Width - btnminw - 10;
            btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, btnminw, h)];
            btn = [self settitel:@"再来" Btn:btn Type:0];
            [btn addTarget:self action:@selector(actionTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitleColor:[UIColor grayColor] forState:0];
            btn.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
            [_bgView addSubview:btn];

            
        }
            }

            else if (model.status  == 5)//已完成
            {
                
                x = Main_Screen_Width - btnminw - 10;
                btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, btnminw, h)];
                btn = [self settitel:@"再来" Btn:btn Type:0];
                [btn addTarget:self action:@selector(actionTypeBtn:) forControlEvents:UIControlEventTouchUpInside];

                [_bgView addSubview:btn];
                x -= (btnminw + 10);
                btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, btnminw, h)];
                btn = [self settitel:@"晒单" Btn:btn Type:0];
                [btn addTarget:self action:@selector(actionTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
                
                [_bgView addSubview:btn];

                

                
                
            }
  
            else if (model.status  == 7)//没支付
            {
                if ([[MCUserDefaults objectForKey:@"id"] integerValue] ==[model.userId integerValue]){

                x = Main_Screen_Width - btnw - 10;
                btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, btnw, h)];
                btn = [self settitel:@"去支付" Btn:btn Type:0];
                    [btn addTarget:self action:@selector(actionTypeBtn:) forControlEvents:UIControlEventTouchUpInside];

                [_bgView addSubview:btn];
                    x -= (btnmaxw + 10);
                    
                    //            x = Main_Screen_Width - btnminw - 10;
                    btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, btnmaxw, h)];
                    btn = [self settitel:@"取消订单" Btn:btn Type:0];
                    [btn addTarget:self action:@selector(actionTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
                    [btn setTitleColor:[UIColor grayColor] forState:0];
                    btn.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
                    [_bgView addSubview:btn];

                }
                else
                {
                    _bgView.hidden = YES;
                    
                }
            }

        
        
    }
    else if ([model.type isEqualToString:@"show"])//晒
    {
        _bgView.hidden = YES;
    }
    else if ([model.type isEqualToString:@"sell"])//售
    {
       
        
        if (model.status  == 0)//可售
        {
            if ([[MCUserDefaults objectForKey:@"id"] integerValue] ==[model.userId integerValue]){
                x = Main_Screen_Width - 10 - btnmaxw;
                btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, btnmaxw, h)];
              UIView*  MCpageview = [[UIView alloc]initWithFrame:CGRectMake(x, y, btnmaxw, h)];

                btn = [self settitel:@"购买的人" Btn:btn Type:0];
                [btn addTarget:self action:@selector(actionTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
                JSBadgeView * pageView = [[JSBadgeView alloc]initWithParentView:MCpageview alignment:JSBadgeViewAlignmentTopRight];
                NSLog(@"MCdescription ==%@",_BuyModlel.MCdescription);
                NSLog(@"buyCount ==%@",_BuyModlel.buyCount);
                
                
                if([model.buyCount integerValue]){
                pageView.badgeText = model.buyCount;
                }
                else
                {
                    pageView.badgeText = @"";
  
                }
                
                [_bgView addSubview:MCpageview];

                [_bgView addSubview:btn];

                x -= (btnmaxw + 10);
                btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, btnmaxw, h)];
                btn = [self settitel:@"关闭订单" Btn:btn Type:0];
                [btn addTarget:self action:@selector(actionTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
                [btn setTitleColor:[UIColor grayColor] forState:0];
                btn.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
                [_bgView addSubview:btn];


            }
            else
            {
                x = Main_Screen_Width - btnminw - 10;
                btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, btnminw, h)];
                btn = [self settitel:@"购买" Btn:btn Type:0];
                [btn addTarget:self action:@selector(actionTypeBtn:) forControlEvents:UIControlEventTouchUpInside];

                [_bgView addSubview:btn];
   
            }
            
        }
        if (model.status  == 1)//售罄
        {
            if ([[MCUserDefaults objectForKey:@"id"] integerValue] ==[model.userId integerValue]){
                x = Main_Screen_Width - 10 - btnmaxw;
                btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, btnmaxw, h)];
                btn = [self settitel:@"购买的人" Btn:btn Type:0];
                [btn addTarget:self action:@selector(actionTypeBtn:) forControlEvents:UIControlEventTouchUpInside];

                [_bgView addSubview:btn];
                
                x -= (btnmaxw + 10);
                btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, btnmaxw, h)];
                btn = [self settitel:@"再次发布" Btn:btn Type:0];
                [btn addTarget:self action:@selector(actionTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
                [btn setTitleColor:[UIColor grayColor] forState:0];
                btn.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
                [_bgView addSubview:btn];
                
                
            }
            else
            {
                x = Main_Screen_Width - btnw - 10;
                btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, btnw, h)];
                btn = [self settitel:@"制作求" Btn:btn Type:0];
                [btn addTarget:self action:@selector(actionTypeBtn:) forControlEvents:UIControlEventTouchUpInside];

                [_bgView addSubview:btn];
                
            }
  
            
            
        }
        if (model.status  == 2||model.status  == 6)//已关闭
        {
            
            if ([[MCUserDefaults objectForKey:@"id"] integerValue] ==[model.userId integerValue]){
                x = Main_Screen_Width - 10 - btnmaxw;
                btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, btnmaxw, h)];
                btn = [self settitel:@"购买的人" Btn:btn Type:0];
                [btn addTarget:self action:@selector(actionTypeBtn:) forControlEvents:UIControlEventTouchUpInside];

                [_bgView addSubview:btn];
                
                x -= (btnmaxw + 10);
                btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, btnmaxw, h)];
                btn = [self settitel:@"再次发布" Btn:btn Type:0];
                [btn addTarget:self action:@selector(actionTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
                [btn setTitleColor:[UIColor grayColor] forState:0];
                btn.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
                [_bgView addSubview:btn];
                
                
            }
            else
            {
                x = Main_Screen_Width - btnw - 10;
                btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, btnw, h)];
                btn = [self settitel:@"制作求" Btn:btn Type:0];
                [btn addTarget:self action:@selector(actionTypeBtn:) forControlEvents:UIControlEventTouchUpInside];

                [_bgView addSubview:btn];
                
            }
        }
        
        
    }
    
}
-(void)actionTypeBtn:(UIButton*)btn{
  NSString *sessionId = [MCUserDefaults objectForKey:@"sessionId"];
    if (!sessionId.length) {
        [self showHint:@"亲，请登录才能做此操作哦"];
        return;
    }
    
    if ([btn.titleLabel.text isEqualToString:@"购买"]) {
        if (_isHot)
        if ([_BuyModlel.isFriend isEqualToString:@"0"]) {
            [self showHint:@"只有好友才能使用该功能"];
            return;
        }
        ShoppingFillViewController * ctl = [[ShoppingFillViewController alloc]init];
        ctl.BuyModlel = _BuyModlel;
        [self pushNewViewController:ctl];
    }
   else if ([btn.titleLabel.text isEqualToString:@"去支付"]) {
       
        PaymentViewController * ctl = [[PaymentViewController alloc]init];
        ctl.BuyModlel = _BuyModlel;
        NSMutableDictionary * pamDic = [NSMutableDictionary dictionary];
        
        
        [pamDic setObject:_BuyModlel.count forKey:@"count"];
        [pamDic setObject:_BuyModlel.deliveryAddress forKey:@"address"];
        [pamDic setObject:_BuyModlel.id forKey:@"buyId"];

        ctl.datadic = pamDic;
        [self pushNewViewController:ctl];

    }
   else  if ([btn.titleLabel.text isEqualToString:@"取消订单"]) {
       UIAlertView * al = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"你是否要取消该订单" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
       al.tag = 4002;
       [al show];
       
   }
   else  if ([btn.titleLabel.text isEqualToString:@"完成订单"]) {
       UIAlertView * al = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"确认完成订单？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
       al.tag = 4003;
       [al show];
       
   }

  else  if ([btn.titleLabel.text isEqualToString:@"再来"]) {

        MakeBuyViewController * ctl = [[MakeBuyViewController alloc]init];
        ctl.BuyModlel2 = _BuyModlel;
        
        [self pushNewViewController:ctl];
        
    }
  else  if ([btn.titleLabel.text isEqualToString:@"晒单"]) {
      
      WNImagePicker *pickerVC  = [[WNImagePicker alloc]init];
      
      
      //    _commodityDic ===={
      //        colour = 123;
      //        price = 12;
      //        model = 213;
      //        brand = nike;
      //        commodity = 广州;
      //        num = 32;
      //        name = 123;
      //    }
      NSLog(@"brand ==%@",_BuyModlel.brand);
      NSLog(@"model ==%@",_BuyModlel.model);
      NSLog(@"name ==%@",_BuyModlel.name);
      NSLog(@"color ==%@",_BuyModlel.color);
      NSLog(@"price ==%@",_BuyModlel.price);
      NSLog(@"count ==%@",_BuyModlel.count);

      
      
      NSMutableDictionary * dic = [NSMutableDictionary dictionary];
      [dic setObject:_BuyModlel.color ? _BuyModlel.color :@"" forKey:@"colour"];
      
      [dic setObject:_BuyModlel.price?_BuyModlel.price :@"" forKey:@"price"];
      
      [dic setObject:_BuyModlel.model?_BuyModlel.model:@"" forKey:@"model"];
      
      [dic setObject:_BuyModlel.brand?_BuyModlel.brand:@"" forKey:@"brand"];
      
      [dic setObject:_BuyModlel.chPickAddress ?_BuyModlel.chPickAddress:@"" forKey:@"commodity"];
      
      [dic setObject:_BuyModlel.pickAddresId ?_BuyModlel.pickAddresId:@"" forKey:@"commodityid"];
      
      
      [dic setObject:_BuyModlel.count ?_BuyModlel.count :@"" forKey:@"num"];
      
      [dic setObject:_BuyModlel.name ? _BuyModlel.name : @"" forKey:@"name"];
      
      pickerVC.commodityDic = dic;

      if (_BuyModlel.YJphotos.count) {
          NSLog(@"=====%@",_BuyModlel.YJphotos[0]);
          if (_BuyModlel.YJphotos[0]) {
           YJphotoModel* photomodel = _BuyModlel.YJphotos[0];

              pickerVC.isshaiDan = YES;
              pickerVC.imgViewUrl =photomodel.raw;//_BuyModlel.imageUrl[0];
              
              
          }
          
      }
      
      [self pushNewViewController:pickerVC];
      
 
//      MakeBuyViewController * ctl = [[MakeBuyViewController alloc]init];
//      ctl.BuyModlel2 = _BuyModlel;
//      
//      [self pushNewViewController:ctl];
      
  }

  else  if ([btn.titleLabel.text isEqualToString:@"制作求"]) {
        
        MakeBuyViewController * ctl = [[MakeBuyViewController alloc]init];
        ctl.BuyModlel2 = _BuyModlel;
        
        [self pushNewViewController:ctl];
        
    }

  else  if ([btn.titleLabel.text isEqualToString:@"接单"]) {
      OrderReceivViewController * ctl = [[OrderReceivViewController alloc]init];
      ctl.BuyModlel = _BuyModlel;
      ctl.delegate = self;
      [self pushNewViewController:ctl];
      
        
    }
  else  if ([btn.titleLabel.text isEqualToString:@"再次发布"]) {
      MakeSellViewController * ctl = [[MakeSellViewController alloc]init];
      ctl.BuyModlel = _BuyModlel;
      
      [self pushNewViewController:ctl];
      
      
  }
    
  else  if ([btn.titleLabel.text isEqualToString:@"购买的人"]) {
      ShoppingManViewController * ctl = [[ShoppingManViewController alloc]init];
      ctl.BuyModlel = _BuyModlel;
      
      [self pushNewViewController:ctl];
      
      
  }
  else  if ([btn.titleLabel.text isEqualToString:@"关闭订单"]) {
      UIAlertView * al = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"你是否要关闭该订单" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
      al.tag = 4001;
      [al show];
      
  }

   else if ([btn.titleLabel.text isEqualToString:@"放弃订单"]) {
        
        UIAlertView * al = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"你是否要放弃该订单" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        al.tag = 4000;
        [al show];
        
    }

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 4000) {//
        if (buttonIndex== 0) {
            
                [self showLoading];
    NSDictionary * dic = @{
                         @"buyId":_BuyModlel.id
                           };
    [self.requestManager postWithUrl:@"api/buy/cancelPick.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
        [self showHint:@"该订单已放弃"];
        _index = (_scrollView.contentOffset.x  )/(Main_Screen_Width - 80);
        
        ShoppingView * view = _viewArray[_index];

        [view loadModle:YES];
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didMCMyshoppingObjNotification" object:@""];
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
    }];

            
        }
    }
    else if (alertView.tag == 4001) {
        
        if (buttonIndex== 0) {
            
            [self showLoading];
            NSDictionary * dic = @{
                                   @"buyId":_BuyModlel.id
                                   };
            [self.requestManager postWithUrl:@"api/buy/closeSell.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
                [self stopshowLoading];
                NSLog(@"resultDic ===%@",resultDic);
                [self showHint:@"该订单已关闭"];
                [self refreshSubmodel];
                
            } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
                [self stopshowLoading];
                [self showAllTextDialog:description];
            }];
        }
    }
    else if (alertView.tag == 4002) {
        
        if (buttonIndex== 0) {
            
            [self showLoading];
            NSDictionary * dic = @{
                                   @"orderId":_BuyModlel.id,
                                   @"type":@"pick",
                                   };
            [self.requestManager postWithUrl:@"api/buy/deleteNoPayOrder.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
                [self stopshowLoading];
                NSLog(@"resultDic ===%@",resultDic);
                [self showHint:@"该订单已取消"];
//                [self refreshSubmodel];

                //我的购（首）
                [[NSNotificationCenter defaultCenter] postNotificationName:@"didMCMyshoppingObjNotification" object:@""];

                //发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"didBillViewObjNotification" object:@""];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                    
                });

                
                
            } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
                [self stopshowLoading];
                [self showAllTextDialog:description];
            }];
        }
    }
    else if (alertView.tag == 4003) {
        
        if (buttonIndex== 0) {
            
            [self showLoading];
            NSDictionary * dic = @{
                                   @"buyId":_BuyModlel.id
                                   };
            [self.requestManager postWithUrl:@"api/buy/finishPick.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
                [self stopshowLoading];
                NSLog(@"resultDic ===%@",resultDic);
                [self showHint:@"该订单已完成"];
                //                [self refreshSubmodel];
                [self refreshSubmodel];

                
            } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
                [self stopshowLoading];
                [self showAllTextDialog:description];
            }];
        }
    }


}
-(void)refreshSubmodel
{
    
    //出售
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didSellObjNotification" object:@""];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didMCMyshoppingObjNotification" object:@""];
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didBillViewObjNotification" object:@""];

    
    
    _index = (_scrollView.contentOffset.x  )/(Main_Screen_Width - 80);
    
    ShoppingView * view = _viewArray[_index];
    [view loadModle:YES];

    
}
-(UIButton*)settitel:(NSString*)str Btn:(UIButton*)btn Type:(NSInteger)index{
    [btn setTitle:str forState:0];
    [btn setTitleColor:RGBCOLOR(232, 48, 17) forState:0];
    btn.titleLabel.font = AppFont;
    btn.layer.borderColor = RGBCOLOR(232, 48, 17).CGColor;
    btn.layer.borderWidth = 1;
    ViewRadius(btn, 3);

    return btn;
}
#pragma mark-返回
-(void)actionBackBtn{
    
    [_scrollView removeFromSuperview];
    if (_isback) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _index = (scrollView.contentOffset.x  )/(Main_Screen_Width - 80);
    
    ShoppingView * view = _viewArray[_index];
    
    if ( !view.isLoda) {
        
        view.pagrStr = 1;
        [view loadData:YES];
        //[view.tableView reloadData];
    }
    MCBuyModlel * model = _dataArray[_index];
    _BuyModlel =model;
    [self modeltype:model];
    if (view.bg_imgView.image) {
        
        float kCompressionQuality = 0.3;
        NSData *photo = UIImageJPEGRepresentation(view.bg_imgView.image, kCompressionQuality);
        UIImage * img = [UIImage imageWithData:photo];
        [_bgimgView setImageToBlur:img completionBlock:^{
            
        }];
        
        
    }
    else
    {
        [_bgimgView setImageToBlur:[UIImage imageNamed:@"login_bg_720"] completionBlock:^{
            
        }];
        
    }
    
    
}
-(void)action_Fenxian:(UIButton*)btn{
    if (_dataArray.count > _index) {
        
        MCBuyModlel *model = _dataArray[_index];
        
        fenxianView *shareView = [fenxianView createViewFromNib];
        shareView.backgroundColor = [UIColor clearColor];
        
        shareView.titleLbl.textColor = AppTextCOLOR;
        ViewRadius(shareView.bgView, 5);
        
        __weak ShoppingQXViewController * weakSelf = self;
        [shareView.deleBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
            [shareView hideView];
            
            // [self.navigationController popToRootViewControllerAnimated:YES];
            
            
        }];
        [shareView.weibobtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
            [shareView hideView];
            NSMutableDictionary * dic = [NSMutableDictionary dictionary];
            
            
            NSString * url = @"";//[NSString stringWithFormat:@"%@api/travel/travelDetailOfH5.jhtml?travelId=%@",AppURL,model.id];
            
            
            
            
            [dic setObject:model.title forKey:@"title"];
            if ([model.type isEqualToString:@"show"]) {
                url = [NSString stringWithFormat:@"%@api/buy/shareShow.jhtml?buyId=%@",AppURL,model.id];

                
                [dic setObject:@"分享晒单详情" forKey:@"titlesub"];
                
 
            }
            else if ([model.type isEqualToString:@"sell"]){
                url = [NSString stringWithFormat:@"%@api/buy/shareSell.jhtml?buyId=%@",AppURL,model.id];

                [dic setObject:@"分享售单详情" forKey:@"titlesub"];

            }
            else if ([model.type isEqualToString:@"pick"]){
                url = [NSString stringWithFormat:@"%@api/buy/sharePick.jhtml?buyId=%@",AppURL,model.id];

                [dic setObject:@"分享求单详情" forKey:@"titlesub"];
                
            }
            
            [dic setObject:url forKey:@"url"];

            [weakSelf actionFenxian:SSDKPlatformTypeSinaWeibo PopToRoot:NO SsDic:dic];
//               [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            NSLog(@"微博");
        }];
        [shareView.qqbtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
            [shareView hideView];
            NSMutableDictionary * dic = [NSMutableDictionary dictionary];
            NSString * url = @"";
            
            
            [dic setObject:model.title forKey:@"title"];
            if ([model.type isEqualToString:@"show"]) {
                
                url = [NSString stringWithFormat:@"%@api/buy/shareShow.jhtml?buyId=%@",AppURL,model.id];

                [dic setObject:@"分享晒单详情" forKey:@"titlesub"];
                
            }
            else if ([model.type isEqualToString:@"sell"]){
                url = [NSString stringWithFormat:@"%@api/buy/shareSell.jhtml?buyId=%@",AppURL,model.id];

                [dic setObject:@"分享售单详情" forKey:@"titlesub"];
                
            }
            else if ([model.type isEqualToString:@"pick"]){
                url = [NSString stringWithFormat:@"%@api/buy/sharePick.jhtml?buyId=%@",AppURL,model.id];

                [dic setObject:@"分享求单详情" forKey:@"titlesub"];
                
            }
            
            [dic setObject:url forKey:@"url"];

            [weakSelf actionFenxian:SSDKPlatformTypeQQ PopToRoot:NO SsDic:dic];
//             [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            NSLog(@"QQ");
        }];
        [shareView.weixinbtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
            [shareView hideView];
            NSMutableDictionary * dic = [NSMutableDictionary dictionary];
            NSString * url = @"";//[NSString stringWithFormat:@"%@api/travel/travelDetailOfH5.jhtml?travelId=%@",AppURL,model.id];
            [dic setObject:model.title forKey:@"title"];
            if ([model.type isEqualToString:@"show"]) {
                url = [NSString stringWithFormat:@"%@api/buy/shareShow.jhtml?buyId=%@",AppURL,model.id];

                [dic setObject:@"分享晒单详情" forKey:@"titlesub"];
                
            }
            else if ([model.type isEqualToString:@"sell"]){
                url = [NSString stringWithFormat:@"%@api/buy/shareSell.jhtml?buyId=%@",AppURL,model.id];

                [dic setObject:@"分享售单详情" forKey:@"titlesub"];
                
            }
            else if ([model.type isEqualToString:@"pick"]){
                url = [NSString stringWithFormat:@"%@api/buy/sharePick.jhtml?buyId=%@",AppURL,model.id];

                [dic setObject:@"分享求单详情" forKey:@"titlesub"];
                
            }
            
            [dic setObject:url forKey:@"url"];

            [weakSelf actionFenxian:SSDKPlatformSubTypeWechatSession PopToRoot:NO SsDic:dic];
//              [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            NSLog(@"weixin");
        }];
        [shareView.tubtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
            [shareView hideView];
            NSMutableDictionary * dic = [NSMutableDictionary dictionary];
            NSString * url =@"";// [NSString stringWithFormat:@"%@api/travel/travelDetailOfH5.jhtml?travelId=%@",AppURL,model.id];
            [dic setObject:model.title forKey:@"title"];
            if ([model.type isEqualToString:@"show"]) {
                url = [NSString stringWithFormat:@"%@api/buy/shareShow.jhtml?buyId=%@",AppURL,model.id];

                [dic setObject:@"分享晒单详情" forKey:@"titlesub"];
                
            }
            else if ([model.type isEqualToString:@"sell"]){
                url = [NSString stringWithFormat:@"%@api/buy/shareSell.jhtml?buyId=%@",AppURL,model.id];

                [dic setObject:@"分享售单详情" forKey:@"titlesub"];
                
            }
            else if ([model.type isEqualToString:@"pick"]){
                url = [NSString stringWithFormat:@"%@api/buy/sharePick.jhtml?buyId=%@",AppURL,model.id];

                [dic setObject:@"分享求单详情" forKey:@"titlesub"];
                
            }
            
            [dic setObject:url forKey:@"url"];

            [weakSelf actionFenxian:SSDKPlatformSubTypeWechatTimeline PopToRoot:NO SsDic:dic];
//            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            NSLog(@"土豆");
        }];
        [shareView showInWindow];
        
        
        // NSLog(@"%@",_dataArray[])
        
    }
    
    
}
#pragma mark-评论
-(void)pinglun_Model:(MCBuyModlel *)model Index:(NSInteger)index IsHuifu:(BOOL)ishuifu PinglunModel:(pinglunModel *)pinglunModel
{
    
    
    _ishuifu = ishuifu;
    _pinglunModel = pinglunModel;
    
    _BuyModlel2 = model;
    _viewidex = index;
    
    [[HcCustomKeyboard customKeyboard].mTextView becomeFirstResponder];
    [HcCustomKeyboard customKeyboard].mTextView.delegate = self;
    if (_ishuifu){
        [HcCustomKeyboard customKeyboard].zuozheBtn.hidden = YES;
        
        
        NSString *ss = [NSString stringWithFormat:@"回复 %@ :",_pinglunModel.nickname];
        
        //        [HcCustomKeyboard customKeyboard].mTextView.text = [NSString stringWithFormat:@"回复 %@ :",_pinglunModel.userModel.nickname];
        NSMutableAttributedString *btn_arrstring = [[NSMutableAttributedString alloc] initWithString:ss];
        
        [btn_arrstring addAttributes:@{NSForegroundColorAttributeName : RGBCOLOR(75, 142, 244),	NSFontAttributeName : [UIFont systemFontOfSize:12]} range:NSMakeRange(3, _pinglunModel.nickname.length)];
        
        [[HcCustomKeyboard customKeyboard].mTextView setAttributedText:btn_arrstring];
        //  [HcCustomKeyboard customKeyboard].mTextView.;
        
    }
    else
    {
        [HcCustomKeyboard customKeyboard].zuozheBtn.hidden = NO;
        //                [HcCustomKeyboard customKeyboard].mTextView.text = @"";
        
    }
    
    
}
-(void)actionzhezhe:(UIButton*)btn{
    UITextView *  TextView = (UITextView*)[self.view viewWithTag:808];
    
    if(btn.selected){
        btn.selected = NO;
        _iszuozhe = NO;
        if (IOS8) {
            
            if ([TextView.text containsString:@"@作者"]) {
                NSMutableString * ss = [NSMutableString stringWithString:TextView.text];
                NSRange rr = {0,3};
                [ss deleteCharactersInRange:rr];
                TextView.text = ss;
                
                
            }
            else
            {
            }
        }
        else
        {
            NSRange range = [TextView.text rangeOfString:@"@作者"];//判断字符串是否包含
            if (range.length >0)//包含
            {
                NSMutableString * ss = [NSMutableString stringWithString:TextView.text];
                NSRange rr = {0,3};
                [ss deleteCharactersInRange:rr];
                TextView.text = ss;
                
                
            }
            else//不包含
            {
                // _titleLbl.text = titleStr;
            }
        }
        
        
        //        if ([textStr containsString:@"@作者"]) {
        //            NSLog(@"you");
        //        }
        //        rgFadeView.msgTextView.text = textStr;
    }
    else
    {
        btn.selected = YES;
        _iszuozhe = YES;
        if (IOS8) {
            
            if ([TextView.text containsString:@"@作者"]) {
                
                
            }
            else
            {
                NSMutableString * ss = [NSMutableString stringWithString:TextView.text];
                [ss insertString:@"@作者" atIndex:0];
                TextView.text = ss;
                
                //                _titleLbl.text = titleStr;
                //                // [_titleLbl setAttributedText:titleStr];
                //
            }
        }
        else
        {
            NSRange range = [TextView.text rangeOfString:@"@作者"];//判断字符串是否包含
            if (range.length >0)//包含
            {
                
            }
            else//不包含
            {
                NSMutableString * ss = [NSMutableString stringWithString:TextView.text];
                [ss insertString:@"@作者" atIndex:0];
                TextView.text = ss;
                // _titleLbl.text = titleStr;
            }
        }
        
        
        //        textStr =[NSString stringWithFormat:@"@作者%@",textStr];
        //        rgFadeView.msgTextView.text = textStr;
    }
    
}
-(void)talkBtnClick:(UITextView *)textViewGet
{
    NSLog(@"%@",textViewGet.text);
    if (!textViewGet.text.length) {
        //        textViewGet.text = nil;
        //        // [rgFadeView removeFromSuperview];
        //        // [self showAllTextDialog:@"请输入你评论内容"];
        return;
    }
    if (_iszuozhe) {
        NSMutableString * ss = [NSMutableString stringWithString:textViewGet.text];
        
        NSRange range = [ss rangeOfString:@"@作者"];//判断字符串是否包含
        if (range.length >0)//包含
        {
            NSRange rr = {0,3};
            [ss deleteCharactersInRange:rr];
            textViewGet.text = ss;
            
        }
        else//不包含
            
        {
            
        }
        
        
        
        
    }
    else
    {
        
    }
    NSString * uid = [MCUserDefaults objectForKey:@"id"];
    if (!uid) {
        [self showHint:@"请登录"];
        return;
    }
    NSDictionary * Parameterdic = @{
                                    @"isRemindAuthor":@(_iszuozhe),
                                    @"buyId":_BuyModlel2.id,
                                    @"content":textViewGet.text,
                                    @"userId":uid
                                    };
    
    
    [self showLoading];
    [self.requestManager postWithUrl:@"api/buy/addComment.json" refreshCache:NO params:Parameterdic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"评论成功");
        NSLog(@"返回==%@",resultDic);
        [self showAllTextDialog:@"评论成功"];
        textViewGet.text = @"";
        ShoppingView * view = _viewArray[_viewidex];
        view.pagrStr = 1;
        [view.dataPingLunArray removeAllObjects];
        [view loadData:YES];
        //[self loadData:YES];
        _iszuozhe = NO;
        [[HcCustomKeyboard customKeyboard].zuozheBtn setSelected:NO];
        
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
        NSLog(@"失败");
        
        
    }];
    
    
    
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSLog(@"%d",textView.text.length);
    
    if (_ishuifu) {
        NSString *ss = [NSString stringWithFormat:@"回复 %@ :",_pinglunModel.nickname];
        NSString * aString = [textView.text stringByReplacingCharactersInRange:range withString:text];
        if (aString.length < ss.length) {
            
            return NO;
        }
    }
    
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        //[textView resignFirstResponder];
        // [self actionsend];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}

-(void)zhuan:(NSString *)str
{
    [self showLoading];
}
-(void)stop:(NSString *)str
{
    [self stopshowLoading];
    if (str) {
        [self showHint:str];
    }

    
}
-(void)Carte_model:(YJUserModel *)model
{
    NSString *sessionId = [MCUserDefaults objectForKey:@"sessionId"];
    if (!sessionId.length) {
        LoginController * ctl = [[LoginController alloc]init];
        [self pushNewViewController:ctl];
        return;
    }

    CarteViewController * ctl = [[CarteViewController alloc]init];
    ctl.userModel = model;
    [self pushNewViewController:ctl];
    
    
    
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
