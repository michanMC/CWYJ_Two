//
//  zuopinXQViewController.m
//  CWYouJi
//
//  Created by MC on 15/11/7.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "zuopinXQViewController.h"
#import "UIImageView+LBBlurredImage.h"
#import "DMLazyScrollView.h"
#import "zuopinDataViewController.h"
#import "HZPhotoBrowser.h"
#define ARC4RANDOM_MAX	0x100000000
#import "homeYJModel.h"
#import "fenxianView.h"
#import "JT3DScrollView.h"
#import "zuopinDataView.h"
#import <Accelerate/Accelerate.h>
#import "HcCustomKeyboard.h"

@interface zuopinXQViewController ()<UITableViewDataSource,UITableViewDelegate,DMLazyScrollViewDelegate,HZPhotoBrowserDelegate,zuopinDataViewDeleGate,UITextViewDelegate,HcCustomKeyboardDelegate>
{
    DMLazyScrollView* _lazyScrollView;

    UIButton * _backBtn;
    UIButton * _fenxianBtn;

    UILabel *_titleLbl;
    NSMutableArray*   _viewControllerArray;
    
    JT3DScrollView *_scrollView;
    
//   zuopinDataViewController *contr;
    RGFadeView * rgFadeView;
    BOOL _iszuozhe;

    NSMutableArray * _viewArray;
    NSInteger _viewidex;
    homeYJModel * _homeNodel2;
    pinglunModel *_pinglunModel;
    BOOL _ishuifu;
    
    

    
}



@property(nonatomic,strong)UIImageView *bgimgView;

@end

@implementation zuopinXQViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectjubaoObj:) name:@"didjubaoObjNotification" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didshowTupianjubaoObj:) name:@"didshowObjNotification" object:nil];

        _viewArray = [NSMutableArray array];
            [[HcCustomKeyboard customKeyboard]textViewShowView:self customKeyboardDelegate:self];
        [[HcCustomKeyboard customKeyboard].zuozheBtn addTarget:self action:@selector(actionzhezhe:) forControlEvents:UIControlEventTouchUpInside];
        [HcCustomKeyboard customKeyboard].mTextView.tag = 808;
    }
    
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"zuopinXQView"];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"zuopinXQView"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"disyemianjisuanObjNotification" object:@"2"];
    self.view.backgroundColor = [UIColor whiteColor];
    _bgimgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    [self.view addSubview:_bgimgView];
//    homeYJModel * model = _dataArray[_index];
//    if (model.photos.count) {
//        
//    }
//
    
[self showLoading:YES AndText:nil];
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
        if ( model.photos) {
        
     //  NSDictionary * dicimg = model.photos[0];
        __weak typeof(UIImageView*)bg_imgView = _bgimgView;
        UIImageView * imgViewmc = [[UIImageView alloc]init];
            YJphotoModel * photoModel = model.YJphotos[0];
        [imgViewmc sd_setImageWithURL:[NSURL URLWithString:photoModel.raw] placeholderImage:[UIImage imageNamed:@"login_bg_720"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [bg_imgView setImageToBlur:imgViewmc.image completionBlock:^{
                
            }];

            
        }];
        }
        else
        {
           // _bgimgView.image = [self blurryImage:[UIImage imageNamed:@"login_bg_720"]  withBlurLevel:44];
            [_bgimgView setImageToBlur:[UIImage imageNamed:@"login_bg_720"] completionBlock:^{
                
            }];
        }
         [zuoView loadData:YES];
    }

   // contr.view.backgroundColor = [UIColor yellowColor];//
    [_scrollView addSubview:zuoView];
    _scrollView.contentSize = CGSizeMake(x + width, height);
}






#pragma mark- 举报
-(void)didSelectjubaoObj:(NSNotification*)Notification{
    NSString * youjiid = Notification.object;
    
    jubaoViewController * ctl = [[jubaoViewController alloc]init];
    ctl._youjiId = youjiid;
    [self pushNewViewController:ctl];
    //[self.navigationController presentViewController:ctl animated:YES completion:nil];
   
    
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


-(void)action_Fenxian:(UIButton*)btn{
    if (_dataArray.count > _index) {

    homeYJModel *model = _dataArray[_index];

    fenxianView *shareView = [fenxianView createViewFromNib];
    shareView.backgroundColor = [UIColor clearColor];
    
    shareView.titleLbl.textColor = AppTextCOLOR;
    ViewRadius(shareView.bgView, 5);
    
    __weak zuopinXQViewController * weakSelf = self;
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

#pragma mark-返回
-(void)actionBackBtn{
    [_scrollView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
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
//    if (!rgFadeView) {
//        rgFadeView = [[RGFadeView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
//        rgFadeView.msgTextView.delegate = self;
//        
//        [rgFadeView.sendBtn addTarget:self action:@selector(actionsend) forControlEvents:UIControlEventTouchUpInside];
//        
//        
//        [rgFadeView.closeBtn addTarget:self action:@selector(actionclose) forControlEvents:UIControlEventTouchUpInside];
//        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
//        [rgFadeView._maskView addGestureRecognizer:tap];
//        [rgFadeView.zuozheBtn addTarget:self action:@selector(actionzhezhe:) forControlEvents:UIControlEventTouchUpInside];
//        [rgFadeView.zuozheBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
//        
//        [self.view addSubview:rgFadeView];
//    }
//    // rgFadeView.placeLabel.text = @"请输入评论信息";
//    [rgFadeView.msgTextView becomeFirstResponder];
// 
    
    
    
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
    
    
    [self showLoading:YES AndText:nil];
    [self.requestManager requestWebWithParaWithURL:@"api/travel/comment/add.json" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"评论成功");
        NSLog(@"返回==%@",resultDic);
        [self showHint:@"评论成功"];
        
        textViewGet.text = @"";
        
        // [rgFadeView removeFromSuperview];
        
        zuopinDataView * view = _viewArray[_viewidex];
        view.pagrStr = 1;
        [view.dataPingLunArray removeAllObjects];
        [view loadData:YES];
        //[self loadData:YES];
        _iszuozhe = NO;
             [[HcCustomKeyboard customKeyboard].zuozheBtn setSelected:NO];
        
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
//        rgFadeView.msgTextView.text = @"";
//        
//        rgFadeView = nil;
        
        NSLog(@"失败");
    }];

    
    
}

#pragma mark-评论发送
-(void)actionsend{
    
    [rgFadeView.msgTextView resignFirstResponder];
    rgFadeView.hidden = YES;
    
    if (!rgFadeView.msgTextView.text.length) {
        rgFadeView = nil;
       // [rgFadeView removeFromSuperview];
        // [self showAllTextDialog:@"请输入你评论内容"];
        return;
    }
    
    
    NSDictionary * Parameterdic = @{
                                    @"isRemindAuthor":@(_iszuozhe),
                                    @"targetId":_homeNodel2.id,
                                    @"content":rgFadeView.msgTextView.text
                                    };
    
    
    [self showLoading:YES AndText:nil];
    [self.requestManager requestWebWithParaWithURL:@"api/travel/comment/add.json" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
         [self hideHud];
        NSLog(@"评论成功");
        NSLog(@"返回==%@",resultDic);
        [self showHint:@"评论成功"];
        
        rgFadeView.msgTextView.text = @"";
        
        rgFadeView = nil;
       // [rgFadeView removeFromSuperview];
        
        zuopinDataView * view = _viewArray[_viewidex];
        view.pagrStr = 1;
        [view.dataPingLunArray removeAllObjects];
        [view loadData:YES];
        //[self loadData:YES];
        
        
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
                [self hideHud];
                [self showAllTextDialog:description];
        rgFadeView.msgTextView.text = @"";
        
        rgFadeView = nil;

        NSLog(@"失败");
    }];
    
}
-(void)tap:(UITapGestureRecognizer*)tap{
    
    [self actionclose];
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
//                NSMutableAttributedString*  btn_arrstring = [[NSMutableAttributedString alloc] initWithString:titleStr];
//
//                [btn_arrstring setAttributes:@{NSForegroundColorAttributeName : RGBCOLOR(249, 77, 33),	NSFontAttributeName : [UIFont systemFontOfSize:13]} range:NSMakeRange(0, 4)];
//                [_titleLbl setAttributedText:btn_arrstring];
                
            }
            else
            {
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
                NSMutableString * ss = [NSMutableString stringWithString:TextView.text];
                NSRange rr = {0,3};
                [ss deleteCharactersInRange:rr];
                TextView.text = ss;

//                NSMutableAttributedString*  btn_arrstring = [[NSMutableAttributedString alloc] initWithString:titleStr];
//                
//                [btn_arrstring setAttributes:@{NSForegroundColorAttributeName : RGBCOLOR(249, 77, 33),	NSFontAttributeName : [UIFont systemFontOfSize:13]} range:NSMakeRange(0, 4)];
//                [_titleLbl setAttributedText:btn_arrstring];
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
                //                NSMutableAttributedString*  btn_arrstring = [[NSMutableAttributedString alloc] initWithString:titleStr];
                //
                //                [btn_arrstring setAttributes:@{NSForegroundColorAttributeName : RGBCOLOR(249, 77, 33),	NSFontAttributeName : [UIFont systemFontOfSize:13]} range:NSMakeRange(0, 4)];
                //                [_titleLbl setAttributedText:btn_arrstring];
                
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
//                NSMutableString * ss = [NSMutableString stringWithString:TextView.text];
//                NSRange rr = {0,3};
//                [ss deleteCharactersInRange:rr];
//                TextView.text = ss;
                
                //                NSMutableAttributedString*  btn_arrstring = [[NSMutableAttributedString alloc] initWithString:titleStr];
                //
                //                [btn_arrstring setAttributes:@{NSForegroundColorAttributeName : RGBCOLOR(249, 77, 33),	NSFontAttributeName : [UIFont systemFontOfSize:13]} range:NSMakeRange(0, 4)];
                //                [_titleLbl setAttributedText:btn_arrstring];
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
-(void)actionclose{
    
    [rgFadeView.msgTextView resignFirstResponder];
    rgFadeView.msgTextView.text = @"";
    
    rgFadeView.hidden = YES;
    rgFadeView = nil;
    //[rgFadeView removeFromSuperview];
}
-(void)zhuan:(NSString *)str
{
    [self showLoading:YES AndText:nil];
}
-(void)stop:(NSString *)str
{
    [self stopshowLoading];
    if (str) {
        [self showHint:str];
    }
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _index = (scrollView.contentOffset.x  )/(Main_Screen_Width - 80);
    
//    NSInteger x = (scrollView.contentOffset.x  + 80 )/Main_Screen_Width;
//    NSLog(@">>>>>%ld",x);
//    
//    
    zuopinDataView * view = _viewArray[_index];

    if ( !view.isLoda) {
        
        view.pagrStr = 1;
        [view loadData:YES];
        //[view.tableView reloadData];
    }
     homeYJModel * model = _dataArray[_index];
    //value	__NSCFString *	@"http://203.195.168.151:9000/hedgehogTravels/upload/image/201512/c0aff07a-cd50-498a-ac82-503c111df40f.jpg"
    //[2]	(null)	@"raw" : @"http://203.195.168.151:9000/hedgehogTravels/upload/image/201512/147924ac-30fa-435f-bdc5-dead98eed56b.jpg"	0x14f88850
    //value	__NSCFString *	@"http://203.195.168.151:9000/hedgehogTravels/upload/image/201511/a1a4a4cd-ae60-40ac-9170-4c37e8261315.jpg"	0x1607f760//value	__NSCFString *	@"http://203.195.168.151:9000/hedgehogTravels/upload/image/201512/11b0a710-083f-4543-b5dd-c046a63647b2.jpg"	0x14e05dd0
//    [_bgimgView setImageToBlur:[UIImage imageNamed:@"login_bg_720"] completionBlock:^{
//        
//                    }];
//
    
        if (view.bg_imgView.image) {
            
            float kCompressionQuality = 0.3;
            NSData *photo = UIImageJPEGRepresentation(view.bg_imgView.image, kCompressionQuality);
            UIImage * img = [UIImage imageWithData:photo];
             //_bgimgView.image = [self blurryImage:img withBlurLevel:44];
           

           // _bgimgView.image  = img;
            [_bgimgView setImageToBlur:img completionBlock:^{
                
            }];
            
            
        }
        else
        {
            // _bgimgView.image = [self blurryImage:[UIImage imageNamed:@"login_bg_720"]  withBlurLevel:44];
            [_bgimgView setImageToBlur:[UIImage imageNamed:@"login_bg_720"] completionBlock:^{
                
            }];

        }
    
    
}
//加模糊效果，image是图片，blur是模糊度
- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    
    
    //模糊度,
    if ((blur < 0.1f) || (blur > 2.0f)) {
        blur = 0.5f;
    }
    
    //boxSize必须大于0
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    boxSize = 45;
    NSLog(@"boxSize:%i",boxSize);//45
    //图像处理
    CGImageRef img = image.CGImage;
    //需要引入
    /*
     This document describes the Accelerate Framework, which contains C APIs for vector and matrix math, digital signal processing, large number handling, and image processing.
     本文档介绍了Accelerate Framework，其中包含C语言应用程序接口（API）的向量和矩阵数学，数字信号处理，大量处理和图像处理。
     */
    
    //图像缓存,输入缓存，输出缓存
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    //像素缓存
    void *pixelBuffer;
    
    //数据源提供者，Defines an opaque type that supplies Quartz with data.
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    // provider’s data.
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    //宽，高，字节/行，data
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //像数缓存，字节行*图片高
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    
    // 第三个中间的缓存区,抗锯齿的效果
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    
    //Convolves a region of interest within an ARGB8888 source image by an implicit M x N kernel that has the effect of a box filter.
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
  //  error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    //    NSLog(@"字节组成部分：%zu",CGImageGetBitsPerComponent(img));
    //颜色空间DeviceRGB
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //用图片创建上下文,CGImageGetBitsPerComponent(img),7,8
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(image.CGImage));
    
    //根据上下文，处理过的图片，重新组件
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
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
