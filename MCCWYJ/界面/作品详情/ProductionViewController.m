//
//  ProductionViewController.m
//  MCCWYJ
//
//  Created by MC on 16/5/8.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "ProductionViewController.h"
#import "JT3DScrollView.h"
#import "zuopinDataView.h"
#import "homeYJModel.h"
#import "UIImageView+LBBlurredImage.h"
#import "HcCustomKeyboard.h"
#import "HZPhotoBrowser.h"
#import "CarteViewController.h"
#import "fenxianView.h"

@interface ProductionViewController ()<zuopinDataViewDeleGate,UIScrollViewDelegate,UITextViewDelegate,HcCustomKeyboardDelegate,HZPhotoBrowserDelegate>
{
    JT3DScrollView *_scrollView;
    UIButton * _backBtn;
    UIButton * _fenxianBtn;
    NSMutableArray * _viewArray;
    BOOL _iszuozhe;

    
    BOOL _ishuifu;
    homeYJModel * _homeNodel2;
    pinglunModel *_pinglunModel;
    NSInteger _viewidex;



}
@property(nonatomic,strong)UIImageView *bgimgView;

@end

@implementation ProductionViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        _viewArray = [NSMutableArray array];

                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectjubaoObj:) name:@"didjubaoObjNotification" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didshowTupianjubaoObj:) name:@"didshowObjNotification" object:nil];
        
        
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didCarteObj:) name:@"didCarteObjNotification" object:nil];

    }
    
    return self;
}
-(void)didCarteObj:(NSNotification*)Notification{
    NSString *sessionId = [MCUserDefaults objectForKey:@"sessionId"];
    if (!sessionId.length) {
        LoginController * ctl = [[LoginController alloc]init];
        [self pushNewViewController:ctl];
        return;
    }

    homeYJModel * model =Notification.object;
    CarteViewController *ctl = [[CarteViewController alloc]init];
    ctl.userModel = model.userModel;
    [self pushNewViewController:ctl];

    
}
#pragma mark-浏览图片监听
-(void)didshowTupianjubaoObj:(NSNotification*)Notification{
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"disyemianjisuanObjNotification" object:@"6"];
    //  NSLog(@"%@",Notification.object);
    NSInteger index = [Notification.object integerValue] - 400;
    
    //启动图片浏览器
    HZPhotoBrowser *browserVc = [[HZPhotoBrowser alloc] init];
    browserVc.sourceImagesContainerView = self.view; // 原图的父控件
    NSInteger x = (_scrollView.contentOffset.x )/(Main_Screen_Width-80);
    NSLog(@"===%ld",x);
    
    homeYJModel * model = _dataArray[_index];
    browserVc.model =model;
    
    NSLog(@"---------%ld",model.photos.count);
    browserVc.imageCount = model.photos.count; // 图片总数
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
    
    
    homeYJModel * model =_dataArray[_index];
    if (model.photos.count) {
        YJphotoModel * photoModel = model.YJphotos[index];
        NSString * imgurl = photoModel.raw;//[NSString stringWithFormat:@"%@%@",];
        
        return [NSURL URLWithString:[NSString stringWithFormat:@"%@",imgurl]];
    }
    return [NSURL URLWithString:@""];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"zuopinXQView"];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"zuopinXQView"];
    self.navigationController.navigationBarHidden = NO;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[HcCustomKeyboard customKeyboard]textViewShowView:self customKeyboardDelegate:self];
    [[HcCustomKeyboard customKeyboard].zuozheBtn addTarget:self action:@selector(actionzhezhe:) forControlEvents:UIControlEventTouchUpInside];
    [HcCustomKeyboard customKeyboard].mTextView.tag = 808;

    _bgimgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    [self.view addSubview:_bgimgView];
    if (_bgimg) {
        [_bgimgView setImageToBlur:_bgimg completionBlock:^{
            
        }];
        
    }
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
    
    
    
    _scrollView = [[JT3DScrollView alloc]initWithFrame:CGRectMake(40, 64, Main_Screen_Width - 80, Main_Screen_Height - 64-1)];
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
    
    
    
    
}

- (void)createCardWithColor:(NSInteger)index
{
    CGFloat width = CGRectGetWidth(_scrollView.frame);
    CGFloat height = CGRectGetHeight(_scrollView.frame);
    
    CGFloat x = _scrollView.subviews.count * width;
    
    // contr = [[zuopinDataViewController alloc] initFrame:CGRectMake(x, 0, width, height)];
    zuopinDataView * zuoView = [[zuopinDataView alloc]initWithFrame:CGRectMake(x, 0, width, height)];
    ViewRadius(zuoView, 10);
    homeYJModel * model = _dataArray[index];
    zuoView.indexId = index;
    zuoView.classifyDic = self.classifyDic;
    zuoView.home_model = model;
    zuoView.deleGate = self;
    

   [_viewArray addObject:zuoView];
    if (index == _index ) {
//        NSLog(@"bg_imgView == %@",zuoView.bg_imgView.image);
        if (zuoView.bg_imgView.image) {
            [_bgimgView setImageToBlur:zuoView.bg_imgView.image completionBlock:^{
                
            }];
            
        }
        [zuoView loadData:YES];
    }
    
    // contr.view.backgroundColor = [UIColor yellowColor];//
    [_scrollView addSubview:zuoView];
    _scrollView.contentSize = CGSizeMake(x + width, height);
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
#pragma mark-返回
-(void)actionBackBtn{
    [_scrollView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _index = (scrollView.contentOffset.x  )/(Main_Screen_Width - 80);
    
    zuopinDataView * view = _viewArray[_index];
    
    if ( !view.isLoda) {
        
        view.pagrStr = 1;
        [view loadData:YES];
        //[view.tableView reloadData];
    }
    homeYJModel * model = _dataArray[_index];
//    [MCIucencyView travelStr:model.id];

    if (view.bg_imgView.image) {
        
        float kCompressionQuality = 0.3;
        NSData *photo = UIImageJPEGRepresentation(view.bg_imgView.image, kCompressionQuality);
        UIImage * img = [UIImage imageWithData:photo];
        //_bgimgView.image = [self blurryImage:img withBlurLevel:44];
        
        
        // _bgimgView.image  = img;
//        _bgimgView.alpha = 0;

        [_bgimgView setImageToBlur:img completionBlock:^{
            
        }];
//        [UIView animateWithDuration:1 animations:^{
//            _bgimgView.alpha = 1;
//
//        }];
        
        
    }
    else
    {
        // _bgimgView.image = [self blurryImage:[UIImage imageNamed:@"login_bg_720"]  withBlurLevel:44];
        [_bgimgView setImageToBlur:[UIImage imageNamed:@"login_bg_720"] completionBlock:^{
            
        }];
        
    }
    
    
}
#pragma mark-评论
-(void)pinglunModel:(homeYJModel *)model Index:(NSInteger)index IsHuifu:(BOOL)ishuifu PinglunModel:(pinglunModel *)pinglunModel
{
    _ishuifu = ishuifu;
    _pinglunModel = pinglunModel;
    
    _homeNodel2 = model;
    _viewidex = index;
    
    [[HcCustomKeyboard customKeyboard].mTextView becomeFirstResponder];
    [HcCustomKeyboard customKeyboard].mTextView.delegate = self;
    if (_ishuifu){
        [HcCustomKeyboard customKeyboard].zuozheBtn.hidden = YES;
        
        
        NSString *ss = [NSString stringWithFormat:@"回复 %@ :",_pinglunModel.userModel.nickname];
        
        //        [HcCustomKeyboard customKeyboard].mTextView.text = [NSString stringWithFormat:@"回复 %@ :",_pinglunModel.userModel.nickname];
        NSMutableAttributedString *btn_arrstring = [[NSMutableAttributedString alloc] initWithString:ss];
        
        [btn_arrstring addAttributes:@{NSForegroundColorAttributeName : RGBCOLOR(75, 142, 244),	NSFontAttributeName : [UIFont systemFontOfSize:12]} range:NSMakeRange(3, _pinglunModel.userModel.nickname.length)];
        
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
    
    NSDictionary * Parameterdic = @{
                                    @"isRemindAuthor":@(_iszuozhe),
                                    @"targetId":_homeNodel2.id,
                                    @"content":textViewGet.text
                                    };
    
    
    [self showLoading];
    [self.requestManager postWithUrl:@"api/travel/comment/add.json" refreshCache:NO params:Parameterdic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"评论成功");
        NSLog(@"返回==%@",resultDic);
        [self showAllTextDialog:@"评论成功"];
        textViewGet.text = @"";
        zuopinDataView * view = _viewArray[_viewidex];
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
        NSString *ss = [NSString stringWithFormat:@"回复 %@ :",_pinglunModel.userModel.nickname];
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
#pragma mark- 举报
-(void)didSelectjubaoObj:(NSNotification*)Notification{
    NSString * youjiid = Notification.object;
    
    jubaoViewController * ctl = [[jubaoViewController alloc]init];
    ctl._typeindex = @"0";
    ctl._youjiId = youjiid;
    
    [self pushNewViewController:ctl];
    
    
}
-(void)action_Fenxian:(UIButton*)btn{
    if (_dataArray.count > _index) {
        
        homeYJModel *model = _dataArray[_index];
        
        fenxianView *shareView = [fenxianView createViewFromNib];
        shareView.backgroundColor = [UIColor clearColor];
        
        shareView.titleLbl.textColor = AppTextCOLOR;
        ViewRadius(shareView.bgView, 5);
        
        __weak ProductionViewController * weakSelf = self;
        [shareView.deleBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
            [shareView hideView];
            
            // [self.navigationController popToRootViewControllerAnimated:YES];
            
            
        }];
        [shareView.weibobtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
            [shareView hideView];
            NSMutableDictionary * dic = [NSMutableDictionary dictionary];
            NSString * url = [NSString stringWithFormat:@"%@api/travel/travelDetailOfH5.jhtml?travelId=%@",AppURL,model.id];
            [dic setObject:url forKey:@"url"];
            [dic setObject:model.title forKey:@"title"];
            [dic setObject:@"分享游记详情" forKey:@"titlesub"];
            
            [weakSelf actionFenxian:SSDKPlatformTypeSinaWeibo PopToRoot:NO SsDic:dic];
            //   [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            NSLog(@"微博");
        }];
        [shareView.qqbtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
            [shareView hideView];
            NSMutableDictionary * dic = [NSMutableDictionary dictionary];
            NSString * url = [NSString stringWithFormat:@"%@api/travel/travelDetailOfH5.jhtml?travelId=%@",AppURL,model.id];
            [dic setObject:url forKey:@"url"];
            [dic setObject:model.title forKey:@"title"];
            [dic setObject:@"分享游记详情" forKey:@"titlesub"];
            
            [weakSelf actionFenxian:SSDKPlatformTypeQQ PopToRoot:NO SsDic:dic];
            // [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            NSLog(@"QQ");
        }];
        [shareView.weixinbtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
            [shareView hideView];
            NSMutableDictionary * dic = [NSMutableDictionary dictionary];
            NSString * url = [NSString stringWithFormat:@"%@api/travel/travelDetailOfH5.jhtml?travelId=%@",AppURL,model.id];
            [dic setObject:url forKey:@"url"];
            [dic setObject:model.title forKey:@"title"];
            [dic setObject:@"分享游记详情" forKey:@"titlesub"];
            
            [weakSelf actionFenxian:SSDKPlatformSubTypeWechatSession PopToRoot:NO SsDic:dic];
            //  [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            NSLog(@"weixin");
        }];
        [shareView.tubtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
            [shareView hideView];
            NSMutableDictionary * dic = [NSMutableDictionary dictionary];
            NSString * url = [NSString stringWithFormat:@"%@api/travel/travelDetailOfH5.jhtml?travelId=%@",AppURL,model.id];
            [dic setObject:url forKey:@"url"];
            [dic setObject:model.title forKey:@"title"];
            [dic setObject:@"分享游记详情" forKey:@"titlesub"];
            
            [weakSelf actionFenxian:SSDKPlatformSubTypeWechatTimeline PopToRoot:NO SsDic:dic];
            //[weakSelf.navigationController popToRootViewControllerAnimated:YES];
            NSLog(@"土豆");
        }];
        [shareView showInWindow];
        
        
        // NSLog(@"%@",_dataArray[])
        
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
