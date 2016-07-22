//
//  ShoppingView.m
//  MCCWYJ
//
//  Created by MC on 16/6/15.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "ShoppingView.h"
#import "UIButton+WebCache.h"
#import "zuopinQxTableViewCell.h"
#import "zuopinQx2TableViewCell.h"
#import "zuopinQx3TableViewCell.h"
#import "pinglunModel.h"
#import "MCbackButton.h"
#import "UIImageView+LBBlurredImage.h"
#import "ShoppingViewTableViewCell.h"
#import "MCLblView.h"
#import "MakeBuyViewController.h"
@interface ShoppingView ()<UITableViewDelegate,UITableViewDataSource>
{
    
    BOOL _iszuozhe;
    BOOL _ispinglun;
    BOOL _isloadImg;
    CGRect _viewFrame;
    BOOL _isjiagengduo;
    
    UIImageView * _jinView;

//    NSInteger _lblViewCount;

    NSTimer *_gameTimer;
    NSMutableArray *_shanBtnArray;
    MCLblView* _lblView;

}

@end



@implementation ShoppingView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _viewFrame = frame;
        _dataPingLunArray = [NSMutableArray array];
        _pagrStr = 1;
        //        _requestManager = [NetworkManager instanceManager];
        //        _requestManager.needSeesion = YES;
        _requestManager = [MCNetworkManager instanceManager];
        
        _isjiagengduo = NO;
        _shanBtnArray = [NSMutableArray array];
    }
    
    return self;
}
-(void)setBuyModlel:(MCBuyModlel *)BuyModlel
{
    _BuyModlel = BuyModlel;
    self.frame = _viewFrame;
    //  self.backgroundColor = [UIColor yellowColor];
    _bg_imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    [self prepareUI];
    [self loadModle:NO];

}
-(void)prepareUI{
//    _BuyModlel.MCdescription = @"王企鹅王企鹅王企鹅王企鹅王企鹅请问请问去问问企鹅我去";
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, _viewFrame.size.width, _viewFrame.size.height ) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate= self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    
    
    _tableView.tableHeaderView = [self addHeadView:_BuyModlel.YJphotos.count];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(fooershuaxin)];
    [self addSubview:_tableView];
    
}
-(void)fooershuaxin{
    _pagrStr++;
    [self loadData:NO];
}
-(UIView*)addHeadView:(NSInteger)indexCount{
    
    UIView * bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.mj_w, self.mj_w)];
    if (indexCount == 0) {
        UIImageView * imgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.mj_w, self.mj_w)];
        imgView2.image = [UIImage imageNamed:@"矢量智能对象"];
        [bgview addSubview:imgView2];
        
    }
    
    UIView *imgbgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.mj_w, self.mj_w)];
    
    [bgview addSubview:imgbgView];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imgbgView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = imgbgView.bounds;
    maskLayer.path = maskPath.CGPath;
    imgbgView.layer.mask = maskLayer;
    
    // NSDictionary * dicimg = [NSDictionary dictionary] ;
    YJphotoModel * photomodel;
    CGRect imgfram;
    if (indexCount == 1) {
        imgfram = CGRectMake(0, 0, self.mj_w, self.mj_w);
        //295
       photomodel = _BuyModlel.YJphotos[0];
        UIButton * imgView =[self addImgView:imgfram ImgStr:@"home_default-photo" ImgUrlStr:photomodel.raw];
        imgView.tag = 400;
        [imgView addTarget:self action:@selector(showTupian:) forControlEvents:UIControlEventTouchUpInside];
        [imgbgView addSubview:imgView];
        
        
        [_bg_imgView sd_setImageWithURL:[NSURL URLWithString:photomodel.raw] placeholderImage:[UIImage imageNamed:@"login_bg_720"]];
        
    }
    else if(indexCount == 2){
        
        for (int  i = 0; i < 2 ; i++) {
            photomodel = _BuyModlel.YJphotos[i];
            imgfram = CGRectMake(((self.mj_w - 2)/2 + 2) *i, 0, (self.mj_w - 2)/2, self.mj_w);
            UIButton * imgView =[self addImgView:imgfram ImgStr:@"home_default-photo" ImgUrlStr:photomodel.raw];
            imgView.tag = 400 +i;
            [imgView addTarget:self action:@selector(showTupian:) forControlEvents:UIControlEventTouchUpInside];
            
            [imgbgView addSubview:imgView];
            if (i == 0) {
                [_bg_imgView sd_setImageWithURL:[NSURL URLWithString:photomodel.raw] placeholderImage:[UIImage imageNamed:@"login_bg_720"]];
            }
            
        }
        
    }
    else if(indexCount == 3){
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat width = (self.mj_w- 2 )/2;
        CGFloat height = self.mj_w;
        for (int  i = 0; i < 3 ; i++) {
            photomodel = _BuyModlel.YJphotos[i];
            imgfram = CGRectMake(x, y, width, height);
            if (i==0) {
                UIButton * imgView =[self addImgView:imgfram ImgStr:@"home_default-photo" ImgUrlStr:photomodel.raw];
                [imgbgView addSubview:imgView];
                x +=width + 2;
                height = (height-2)/2;
                imgView.tag = 400 +i;
                [imgView addTarget:self action:@selector(showTupian:) forControlEvents:UIControlEventTouchUpInside];
                [_bg_imgView sd_setImageWithURL:[NSURL URLWithString:photomodel.raw] placeholderImage:[UIImage imageNamed:@"login_bg_720"]];
                
                
                
            }
            else
            {
                photomodel = _BuyModlel.YJphotos[i];
                
                UIButton * imgView =[self addImgView:imgfram ImgStr:@"home_default-photo" ImgUrlStr:photomodel.raw];
                imgView.tag = 400 +i;
                [imgbgView addSubview:imgView];
                [imgView addTarget:self action:@selector(showTupian:) forControlEvents:UIControlEventTouchUpInside];
                
                if (i == 1) {
                    y += height + 2;
                }
                
            }
            
        }
    }
    else if(indexCount == 4){
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat width = (self.mj_w - 2)/2;
        CGFloat height = (self.mj_w - 2) / 2;
        
        for (int  i = 0; i < 4 ; i++) {
            photomodel = _BuyModlel.YJphotos[i];
            
            imgfram = CGRectMake(x, y, width, height);
            UIButton * imgView =[self addImgView:imgfram ImgStr:@"home_default-photo" ImgUrlStr:photomodel.raw];
            imgView.tag = 400 +i;
            [imgbgView addSubview:imgView];
            [imgView addTarget:self action:@selector(showTupian:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0) {
                [_bg_imgView sd_setImageWithURL:[NSURL URLWithString:photomodel.raw] placeholderImage:[UIImage imageNamed:@"login_bg_720"]];
                
            }
            x += width + 2;
            if (i == 1) {
                y += height + 2;
                x = 0;
            }
            
        }
        
    }
    [self getjinViewBgview:bgview];
    return bgview;
    
}
-(UIImageView*)getjinViewBgview:(UIView*)bgview{
    if (_jinView) {
        return _jinView;
    }

    if (![_BuyModlel.type isEqualToString:@"show"]) {
        CGFloat w = [MCIucencyView heightforString:_BuyModlel.chAddress andHeight:15 fontSize:14] + 35;
        NSLog(@"_BuyModlel.chAddress ===%@",_BuyModlel.chAddress);
        
        if (!_BuyModlel.chAddress.length) {
            w = 50;
        }
        _jinView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,w , 40)];
        _jinView.image = [UIImage imageNamed:@"bg_location"];
        
        UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, w/2, 15)];
//       lbl.backgroundColor = [UIColor yellowColor];
        lbl.tag = 9999;
        lbl.adjustsFontSizeToFitWidth = YES;
        lbl.text = _BuyModlel.chAddress;
        //chAddress
        lbl.textColor = [UIColor whiteColor];
        lbl.font = AppFont;
        [_jinView addSubview:lbl];
        
        [bgview addSubview:_jinView];

    }
    else
    {

        if (_BuyModlel.Buyjson){
            _gameTimer= [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
            NSInteger count = 4;
            if ([_BuyModlel.Buyjson.color length]||[_BuyModlel.Buyjson.model length]) {
                count = 4;
            }
            else
            {
                count = 3;
                
            }

            
            [self prepareLblview:count Dic:_BuyModlel.Buyjson addView:bgview];
        }
        _jinView = [[UIImageView alloc]initWithFrame:CGRectMake(bgview.mj_w - 10 - 50, 10,50, 50)];
        _jinView.image = [UIImage imageNamed:@"转单"];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionZhuandan)];
        [_jinView addGestureRecognizer:tap];
        _jinView.userInteractionEnabled = YES;
        [bgview addSubview:_jinView];


    }

    
    return _jinView;
}
-(void)actionZhuandan{
    MakeBuyViewController * ctl = [[MakeBuyViewController alloc]init];
    ctl.BuyModlel = _BuyModlel;
    [_selfViewCtl pushNewViewController:ctl];
    
}
-(void)prepareLblview:(NSInteger)count Dic:(MCBuyjson*)dic addView:(UIView*)bgview{
    NSLog(@"coordinates == %@",dic.coordinates);
    NSLog(@"shapeType == %@",dic.shapeType);
    NSString * coordinates = dic.coordinates;
    NSArray * aaa = [coordinates componentsSeparatedByString:@","];
    NSString* xs  = @"30";//=aaa[0]?aaa[0]:@"30";
    if (aaa.count) {
        xs=aaa[0]?aaa[0]:@"30";
        
    }
    NSString* ys = @"84";
    if (aaa.count>=2) {
        ys=aaa[1]?aaa[1]:@"84";

    }
    CGFloat lx = [xs floatValue];
    CGFloat ly = [ys floatValue];

    CGFloat vw =bgview.mj_w*(lx/Main_Screen_Width);
    
    CGFloat vh =bgview.mj_h*(ly/(Main_Screen_Height - 64));

    CGFloat viewMaxW = 150;
    
    if (vh + 20 * 4 + 20 * 3 + 1 * 4 >= self.mj_w ) {
       vh = self.mj_w - (20 * 4 + 20 * 3 + 1 * 4 + 10);
    }
    
    
     _lblView= [[MCLblView alloc]initWithFrame:CGRectMake(vw, vh, 150 , 20 * 4 + 20 * 3 + 1 * 4)];
    _lblView.index = 0;
    if (count == 3) {
        
        _lblView.frame = CGRectMake(Main_Screen_Width/2, 20 + 64, 150 , 20 * 3 + 20 * 2 + 1 * 3);
        
    }
    _lblView.tag = 600;
    
    [bgview addSubview:_lblView];
    
    CGFloat x  = 20;
    CGFloat  y = 0;
    CGFloat w = 150 - x ;
    CGFloat h = 20;
    w = [MCIucencyView heightforString:dic.address andHeight:20 fontSize:18];
    viewMaxW = viewMaxW<w ?w :viewMaxW;
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.text = dic.address;
    lbl.textColor = [UIColor whiteColor];
    lbl.tag = 800;
    lbl.layer.shadowOpacity = .8;
    lbl.layer.shadowColor = [UIColor blackColor].CGColor;
    lbl.layer.shadowRadius = 3;// 阴影扩散的范围控制
    lbl.layer.shadowOffset  = CGSizeMake(2, 2);// 阴影的范围

    [_lblView addSubview:lbl];
    
    y += h;
    h = 1;
    x = 10;
    w = 50;
    //dic.address;
    w = [MCIucencyView heightforString:dic.address andHeight:20 fontSize:18] + 5;
    viewMaxW = viewMaxW<w ?w :viewMaxW;
    UIImageView * lineImg = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lineImg.backgroundColor = [UIColor whiteColor];
    [_lblView addSubview:lineImg];
    
    w = 1;
    h = _lblView.mj_h - 20 - 1;
    lineImg = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lineImg.backgroundColor = [UIColor whiteColor];
    [_lblView addSubview:lineImg];
    
    y = _lblView.mj_h  - 1;
//    w = 100;
    ////[NSString stringWithFormat:@"%@ %@",dic.price,dic.count]
    w = [MCIucencyView heightforString:[NSString stringWithFormat:@"%@ %@",dic.price,dic.count] ? [NSString stringWithFormat:@"%@ %@",dic.price,dic.count] : @"ewqewqe" andHeight:20 fontSize:18] + 5;

    h = 1;
w = [MCIucencyView heightforString:[NSString stringWithFormat:@"%@ %@",dic.model,dic.color] ? [NSString stringWithFormat:@"%@ %@",dic.model,dic.color] : @"ewqewqe" andHeight:20 fontSize:18] ;
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
    _shanBtn.tag = 700;
    [_shanBtnArray addObject:_shanBtn];
    
    
    
    
    
    x = lbl.mj_x;
    y = lbl.mj_y + 20 + 1 + 20;
    w = 150 - x;
    h = 20;
    w = [MCIucencyView heightforString:[NSString stringWithFormat:@"%@ %@",dic.price,dic.count] ? [NSString stringWithFormat:@"%@ %@",dic.price,dic.count] : @"ewqewqe" andHeight:20 fontSize:18] ;
    viewMaxW = viewMaxW<w ?w :viewMaxW;

    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.text = [NSString stringWithFormat:@"%@ %@",dic.price,dic.count];//@"10CNY  6";
    lbl.textColor = [UIColor whiteColor];
    lbl.tag = 801;
    lbl.layer.shadowOpacity = .8;
    lbl.layer.shadowColor = [UIColor blackColor].CGColor;
    lbl.layer.shadowRadius = 3;// 阴影扩散的范围控制
    lbl.layer.shadowOffset  = CGSizeMake(2, 2);// 阴影的范围

    [_lblView addSubview:lbl];
    
    lineImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, y +h, w+5, 1)];
    lineImg.backgroundColor = [UIColor whiteColor];
    [_lblView addSubview:lineImg];
    
    
    
    y += h + 1 + 20;
    w = [MCIucencyView heightforString:[NSString stringWithFormat:@"%@ %@",dic.brand,dic.name] ? [NSString stringWithFormat:@"%@ %@",dic.brand,dic.name] : @"ewqewqe" andHeight:20 fontSize:18] + 5;
    viewMaxW = viewMaxW<w ?w :viewMaxW;

    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.text = [NSString stringWithFormat:@"%@ %@",dic.brand,dic.name];//@"kebo7 wqwqwq";
    lbl.tag = 802;
    
    lbl.textColor = [UIColor whiteColor];
    lbl.layer.shadowOpacity = .8;
    lbl.layer.shadowColor = [UIColor blackColor].CGColor;
    lbl.layer.shadowRadius = 3;// 阴影扩散的范围控制
    lbl.layer.shadowOffset  = CGSizeMake(2, 2);// 阴影的范围

    [_lblView addSubview:lbl];

    lineImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, y +h, w+5, 1)];
    lineImg.backgroundColor = [UIColor whiteColor];
    [_lblView addSubview:lineImg];
//    _lblViewCount++;
    
    if (count >3) {
        
        
        y += h + 1 + 20;
        w = [MCIucencyView heightforString:[NSString stringWithFormat:@"%@ %@",dic.model,dic.color] ? [NSString stringWithFormat:@"%@ %@",dic.model,dic.color] : @"ewqewqe" andHeight:20 fontSize:18] ;

        lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
        lbl.text = [NSString stringWithFormat:@"%@ %@",dic.model,dic.color];//@"LL 红色";
        lbl.tag = 803;
        lbl.layer.shadowOpacity = .8;
        lbl.layer.shadowColor = [UIColor blackColor].CGColor;
        lbl.layer.shadowRadius = 3;// 阴影扩散的范围控制
        lbl.layer.shadowOffset  = CGSizeMake(2, 2);// 阴影的范围

        lbl.textColor = [UIColor whiteColor];
        [_lblView addSubview:lbl];
    }
    if ([dic.shapeType isEqualToString:@"FourLeft"]) {

   lx = (lx+viewMaxW) > bgview.mj_w ? bgview.mj_w-viewMaxW :lx;
    }
    else
    {
        lx =  lx < viewMaxW ? 0 : lx;
        lx += 15;
    }
    lx -=5;
  lx =lx <0 ?0:lx;
    _lblView.frame = CGRectMake(lx, _lblView.mj_y, _lblView.mj_w, _lblView.mj_h);
    
    
    
    [self actionShanbtn:_shanBtn Dic:dic];
    
    
    
}
-(void)actionShanbtn:(UIButton*)btn Dic:(MCBuyjson*)dic{
    //    _lblView = [self.view viewWithTag:btn.tag - 100];
    
    //0zou
    if ([dic.shapeType isEqualToString:@"FourLeft"]) {
        _lblView.index = 1;
    }
    else
    {
        _lblView.index = 0;
        _lblView.transform= CGAffineTransformScale(_lblView.transform, -1.0, 1.0);
        
    }
    
    
    
    
    UILabel * lbl1 = [_lblView viewWithTag:btn.tag + 100];
    
    
    if (_lblView.index == 0)
        lbl1.transform= CGAffineTransformScale(lbl1.transform, -1.0, 1.0);
    
    
    if (_lblView.index==0) {
        lbl1.textAlignment= NSTextAlignmentRight;
    }
    else
    {
        lbl1.textAlignment= NSTextAlignmentLeft;
        
    }
    
    
    UILabel * lbl2 = [_lblView viewWithTag:btn.tag + 101];
    if (_lblView.index == 0)
        lbl2.transform= CGAffineTransformScale(lbl2.transform, -1.0, 1.0);
    
    if (_lblView.index==0) {
        lbl2.textAlignment= NSTextAlignmentRight;
        NSLog(@"右");
        
    }
    else
    {
        lbl2.textAlignment= NSTextAlignmentLeft;
        NSLog(@"左");
        
        
        
    }
    
    
    
    UILabel * lbl3 = [_lblView viewWithTag:btn.tag + 102];
    if (_lblView.index == 0)
        
        lbl3.transform= CGAffineTransformScale(lbl3.transform, -1.0, 1.0);
    if (_lblView.index==0) {
        lbl3.textAlignment= NSTextAlignmentRight;
    }
    else
    {
        lbl3.textAlignment= NSTextAlignmentLeft;
        
    }
    
    UILabel * lbl4 = [_lblView viewWithTag:btn.tag + 103];
    if (_lblView.index == 0)
        lbl4.transform= CGAffineTransformScale(lbl4.transform, -1.0, 1.0);
    if (_lblView.index==0) {
        lbl4.textAlignment= NSTextAlignmentRight;
    }
    else
    {
        lbl4.textAlignment= NSTextAlignmentLeft;
        
    }
    
    
    
    
}


-(UIButton*)addImgView:(CGRect)imgFrame ImgStr:(NSString*)imgStr ImgUrlStr:(NSString*)imgUrlStr{
    
    UIButton * imgView = [[UIButton alloc]initWithFrame:imgFrame];
//    imgView.b
   imgView.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    imgView.clipsToBounds = YES; // 裁剪边缘

    [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imgUrlStr]] forState:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            [imgView setBackgroundImage:[UIImage imageNamed:@"矢量智能对象"] forState:0];
        }else
        {
            if((image.size.width < imgView.mj_w)||(image.size.height < imgView.mj_h)){
                [imgView setImage:[UIImage imageNamed:@""] forState:0];
                [imgView setBackgroundImage:image forState:0];
                
            }
        }
        
        
    }];

    
    
    
//    imgView.contentMode = UIViewContentModeScaleAspectFill;
//    imgView.clipsToBounds = YES; // 裁剪边缘
//    [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imgUrlStr]] forState:0 placeholderImage:[UIImage imageNamed:@"矢量智能对象"]];

   // [imgView sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imgUrlStr]] forState:0 placeholderImage:[UIImage imageNamed:imgStr]];
    
    
    
    
    return imgView;
}
#pragma mark-浏览图片
-(void)showTupian:(UIButton*)btn{
    
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didshowShoppingObjNotification" object:@(btn.tag)];
    
    
    
}

-(void)loadData:(BOOL)iszhuan{
    _isLoda = YES;
    NSDictionary * Parameterdic = @{
                                    @"pageNumber":@(_pagrStr),
                                    @"buyId":_BuyModlel.id,
                                    @"pageSize":@(5)
                                    
                                    };
    
    
    if (iszhuan)
        [_deleGate zhuan:nil];
    
    //[self showLoading:iszhuan AndText:nil];
    [_requestManager postWithUrl:@"api/buy/getComments.json" refreshCache:NO params:Parameterdic IsNeedlogin:NO success:^(id resultDic) {
        
        [_deleGate stop:nil];
        NSLog(@"成功");
        NSLog(@"评论列表返回==%@",resultDic);
        if ([resultDic[@"object"] isKindOfClass:[NSDictionary class]]) {
            
        for (NSDictionary * dic in resultDic[@"object"][@"comments"]) {
            pinglunModel * model = [pinglunModel mj_objectWithKeyValues:dic];
            if (dic[@"user"]) {
                model.userModel = [YJUserModel mj_objectWithKeyValues:dic[@"user"]];

            }
            [_dataPingLunArray addObject:model];
            
        }
        }
        [_tableView.mj_footer endRefreshing];
        [_tableView reloadData];
        
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [_tableView.mj_footer endRefreshing];
        
        [_deleGate stop:nil];
        [_tableView reloadData];
        NSLog(@"失败");
        
    }];
    

//    [_tableView reloadData];
    
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    if (section == 0) {
        return 1;
    }
    return _dataPingLunArray.count + 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        if ([_BuyModlel.type isEqualToString:@"show"]) {
            CGFloat h = [MCIucencyView heightforString:_BuyModlel.MCdescription andWidth:Main_Screen_Width - 80 - 30 fontSize:13];//内容的高
            if (h < 20) {
                h = 20;
            }
            
            if (_isjiagengduo) {
                return  185 - 20 + h;
                
            }
            return 185;
        }
        if ([_BuyModlel.type isEqualToString:@"pick"]||_BuyModlel.pickDate.length) {
            
            NSString * ss = [NSString stringWithFormat:@"描述: %@",_BuyModlel.MCdescription];
        CGFloat w = self.mj_w - 2 * 10;

            CGFloat h = [MCIucencyView heightforString:ss andWidth:w fontSize:14];
            
            if (h < 20) {
                h = 20;
            }
            if (!_BuyModlel.MCdescription.length) {
                h = 0;
            }
            //260 + 10  +h
            
            CGFloat addH = 260 + 10 +h +10 + 20  + 15 + 20 + 5 + 20;
            if (_BuyModlel.pickDate.length) {
                addH = 260 + 10 +h +10 + 20  + 15 + 20 + 5 + 20;
            }
            else
            {
                addH = 260 + 10 +h  + 20;
            }
            if (!_BuyModlel.brand.length) {
                addH -= 20;
            }
            if (!_BuyModlel.model.length) {
                addH -= 20;
            }
            if (!_BuyModlel.color.length) {
                addH -= 20;
            }
            if (!_BuyModlel.MCdescription.length) {
                addH -= 20;
            }

           return addH;
        }

        
        
        
        NSString * ss = [NSString stringWithFormat:@"描述: %@",_BuyModlel.MCdescription];
        CGFloat w = self.mj_w - 2 * 10;
        
        CGFloat h = [MCIucencyView heightforString:ss andWidth:w fontSize:14];
        
        if (h < 20) {
            h = 20;
        }
        
        CGFloat addH = 260 + 10  +h;
        if (!_BuyModlel.brand.length) {
            addH -= 20;
        }
        if (!_BuyModlel.model.length) {
            addH -= 20;
        }
        if (!_BuyModlel.color.length) {
            addH -= 20;
        }
        if (!_BuyModlel.MCdescription.length) {
            addH -= 20;
        }


        
        
        return  addH;
        

        
        
        
//        return 260 + 10;
        
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0){
            return 44;
        }
        else
        {
            
            
            if (_dataPingLunArray.count > indexPath.row - 1) {
                
                pinglunModel * model = _dataPingLunArray[indexPath.row - 1];
                NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                NSInteger idstr =[[defaults objectForKey:@"id"] integerValue];
                
                NSString *titleStr ;
                if ([model.isRemindAuthor boolValue]) {
                    //自己游记
                    if ([_BuyModlel.userModel.id integerValue] == idstr) {
                        titleStr = model.content;
                        
                        
                    }
                    else
                    {
                        
                        titleStr = [NSString stringWithFormat:@"@作者:%@",model.content];
                        
                    }
                    
                    
                    
                }
                else
                {
                    titleStr = model.content;
                }
                
                CGFloat h = [MCIucencyView heightforString:titleStr andWidth:Main_Screen_Width - 80 - 30 fontSize:13];
                return h + 38 + 15;
                
                
                // return 38 + 10;
            }
            //38
        }
    }
    return 44;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static  NSString * cellid1 = @"mc1";
    if (indexPath.section==0) {
        
        
        ShoppingViewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
        if (!cell) {
            cell = [[ShoppingViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.BuyModlel = _BuyModlel;
        if ([_BuyModlel.type isEqualToString:@"show"]) {
            [cell prepareUIshai];
            
            CGFloat h = [MCIucencyView heightforString:_BuyModlel.MCdescription andWidth:self.mj_w - 30 fontSize:13];
            
            if (h > 20) {
                
                cell.gengimg.hidden = NO;
                if (_isjiagengduo) {
                    cell.gengimg.hidden = YES;
                }
            }
            else
            {
                cell.gengimg.hidden = YES;
                
                
            }
            
            if (_isjiagengduo) {
                cell.gengduoBtn.hidden = YES;
                
            }
            else
            {
                cell.gengduoBtn.hidden = NO;
            }
            
            cell.isgengduan = _isjiagengduo  ;

            [cell.gengduoBtn addTarget:self action:@selector(ActionGengduo:) forControlEvents:UIControlEventTouchUpInside];


        }
        else
        [cell prepareUI];
        
        
        [cell.headerBtn addTarget:self action:@selector(actionHeaderBtn) forControlEvents:UIControlEventTouchUpInside];
        [cell.jiedanrenBtn addTarget:self action:@selector(actionjiedanrenHeaderBtn) forControlEvents:UIControlEventTouchUpInside];

        [cell.collectBtn addTarget:self action:@selector(actionShouchang:) forControlEvents:UIControlEventTouchUpInside];

        return cell;//[[UITableViewCell alloc]init];
        
        
        
        
    }
    else if(indexPath.section == 1)
    {
        static NSString * cellid2 = @"zuopinQx2TableViewCell";
        static NSString * cellid3 = @"zuopinQx3TableViewCell";
        
        if (indexPath.row == 0) {
            zuopinQx2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid2];
            if (!cell) {
                cell = [[zuopinQx2TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid2];
                
                //  cell = [[[NSBundle mainBundle]loadNibNamed:cellid2 owner:self options:nil]lastObject];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell prepareUI:[NSString stringWithFormat:@"(%ld)",_dataPingLunArray.count]];
            
            
            cell.BgView.tag = 888;
            cell.BgView.hidden =YES; //!_ispinglun;
//            cell.pinglunBtn.tag = 880;
            
//            [cell.pinglunBtn addTarget:self action:@selector(ActionPinjia:) forControlEvents:UIControlEventTouchUpInside];
//            
//            
//            
//            [cell.jubaoBtn addTarget:self action:@selector(ActionjubaoBtn) forControlEvents:UIControlEventTouchUpInside];
            
            cell.showBtn.tag = 880;

            [cell.showBtn addTarget:self action:@selector(ActionPinjia:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            
            
            UIBezierPath *maskPath;
            if (_dataPingLunArray.count == 0) {
                
                maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
                CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
                maskLayer.frame =cell.bounds;
                maskLayer.path = maskPath.CGPath;
                cell.layer.mask = maskLayer;
                
                return cell;
                
                
            }
            else
            {
                maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds byRoundingCorners: UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(0, 0)];
                
                CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
                maskLayer.frame =cell.bounds;
                maskLayer.path = maskPath.CGPath;
                cell.layer.mask = maskLayer;
                
                
                
            }
            
            
            
            return cell;
        }
        else
        {
            
            
            zuopinQx3TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid3];
            if (!cell) {
                cell = [[zuopinQx3TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid3];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (_dataPingLunArray.count > indexPath.row - 1) {
                pinglunModel * model = _dataPingLunArray[indexPath.row - 1];
                cell.headStr =model.imageUrl;//[NSString stringWithFormat:@"%@%@",@"", model.userModel.raw];
                cell.headerBtn.tag = indexPath.row - 1 + 450;
                [cell.headerBtn addTarget:self action:@selector(actionHeaderBtn:) forControlEvents:UIControlEventTouchUpInside];
                cell.nameStr = model.nickname;
                NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                NSInteger idstr =[[defaults objectForKey:@"id"] integerValue];
                NSString *titleStr ;
                // NSMutableAttributedString *btn_arrstring;
                cell.huifuBtn.tag =indexPath.row - 1 + 9000;
                [cell.huifuBtn addTarget:self action:@selector(ActionPinjia:) forControlEvents:UIControlEventTouchUpInside];
                if ([model.isRemindAuthor boolValue]) {
                    //自己游记
                    if ([_BuyModlel.userModel.id integerValue] ==idstr) {
                        cell.huifuBtn.hidden = NO;
                        titleStr = model.content;
                        
                        
                    }
                    else
                    {
                        cell.huifuBtn.hidden = YES;
                        
                        titleStr = [NSString stringWithFormat:@"@作者:%@",model.content];
                        
                    }
                    
                    
                    
                }
                else
                {
                    cell.huifuBtn.hidden = YES;
                    
                    titleStr = model.content;
                    
                }
                
                cell.titleStr = titleStr;//model.content;
                
                
                
                
                if (indexPath.row == _dataPingLunArray.count) {
                    CGFloat h = [MCIucencyView heightforString:titleStr andWidth:Main_Screen_Width - 80 - 30 fontSize:13];
                    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, Main_Screen_Width - 80, 38 + h + 15) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight  cornerRadii:CGSizeMake(10, 10)];
                    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
                    
                    maskLayer.frame =CGRectMake(0, 0, Main_Screen_Width - 80, 38 + h + 15);
                    maskLayer.path = maskPath.CGPath;
                    cell.layer.mask = maskLayer;
                    return cell;
                    
                }
                else
                {
                    
                    CGFloat h = [MCIucencyView heightforString:titleStr andWidth:Main_Screen_Width - 80 - 30 fontSize:13];
                    
                    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, Main_Screen_Width - 80, 38 + h + 15) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight  cornerRadii:CGSizeMake(0, 0)];
                    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
                    
                    maskLayer.frame =CGRectMake(0, 0, Main_Screen_Width - 80, 38 + h + 15);
                    maskLayer.path = maskPath.CGPath;
                    cell.layer.mask = maskLayer;
                    return cell;
                }
                return cell;
            }
            
        }
    }
    
    return [[UITableViewCell alloc]init];
}
-(void)actionShow:(UIButton*)btn{
    
    
    
    
    UIView * view = (UIView*)[self viewWithTag:888];
    if (view.hidden) {
        view.hidden = NO;
        _ispinglun = YES;
    }
    else
    {
        view.hidden = YES;
        _ispinglun = NO;
    }
    
    
    
}
#pragma mark-评价
-(void)ActionPinjia:(UIButton*)btn{
    
    NSString *sessionId = [MCUserDefaults objectForKey:@"sessionId"];
    if (!sessionId.length) {
        [_deleGate stop:@"亲，请登录才能做此操作哦"];
        return;
    }
    if (_isHot)

    if ([_BuyModlel.isFriend isEqualToString:@"0"]) {

        [_deleGate stop:@"只有好友才能使用该功能"];
        return;
    }

    _ispinglun = YES;

    UIView * view = (UIView*)[self viewWithTag:888];
    view.hidden = YES;

//    if (view.hidden) {
//        view.hidden = NO;
//        _ispinglun = YES;
//    }
//    else
//    {
//        view.hidden = YES;
//        _ispinglun = NO;
//    }
//    
    
    if (btn.tag == 880) {
        if (_deleGate)
            [_deleGate pinglun_Model:_BuyModlel Index:_indexId IsHuifu:NO PinglunModel:nil];
        
    }else
    {
        if (btn.tag - 9000 < _dataPingLunArray.count) {
            
            pinglunModel * model = _dataPingLunArray[btn.tag - 9000];
            [_deleGate pinglun_Model:_BuyModlel Index:_indexId IsHuifu:YES PinglunModel:model];
            
            NSLog(@">>>%ld",btn.tag);
            
            
            
        }
        
    }
}

#pragma mark-头像
-(void)actionHeaderBtn{
    
    
    if (_deleGate) {
        YJUserModel * modle = [[YJUserModel alloc]init];
        modle.id = _BuyModlel.userId;
        [_deleGate Carte_model:modle];
    }
    
    
}
-(void)actionjiedanrenHeaderBtn{
    if (_deleGate) {
        YJUserModel * modle = [[YJUserModel alloc]init];
        modle.id = _BuyModlel.pickerId;
        [_deleGate Carte_model:modle];
    }
    
}
#pragma mark-加载更多
-(void)ActionGengduo:(UIButton*)btn{
    
    
    _isjiagengduo = YES;
    [_tableView reloadData];
    
    
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

-(id)analysis:(NSString*)str{
    if (!str) {
        return str;
    }

    NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    
    id result = [NSJSONSerialization JSONObjectWithData:jsonData
                                                options:NSJSONReadingMutableContainers
                                                  error:&err];
    NSLog(@"result == ======%@",result);
    return result;
    
}
#pragma mark-收藏
-(void)actionShouchang:(UIButton*)btn{
    NSString *sessionId = [MCUserDefaults objectForKey:@"sessionId"];
    if (!sessionId.length) {
        [_deleGate stop:@"亲，请登录才能做此操作哦"];
        return;
    }
    
    
    if (_isHot)

    if ([_BuyModlel.isFriend isEqualToString:@"0"]) {
        
        [_deleGate stop:@"只有好友才能使用该功能"];
        return;
    }


    
    
    NSDictionary * Parameterdic = @{
                                    
                                    @"buyId":_BuyModlel.id,
                                    
                                    };
    
    
    NSString * collection;
    if (_BuyModlel.isCollect ) {
        Parameterdic = @{
                         
                         @"buyIds":_BuyModlel.id,
                         
                         };
        collection = @"api/buy/cancelCollect.json";
    }
    else
    {
        collection = @"api/buy/addCollect.json";
        
    }
    
    [_deleGate zhuan:nil];
    
    //[self showLoading:YES AndText:nil];
    [self.requestManager postWithUrl:collection refreshCache:NO params:Parameterdic IsNeedlogin:NO success:^(id resultDic) {
        [_deleGate stop:nil];
        NSLog(@"成功");
        
        [self loadModle:YES];
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didMCMyshoppingObjNotification" object:@""];
//        
//        
//        // dishoucangshuaxinObjNotification
//        //发送通知刷新我制作的作品
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"didzuopingshuaxinObjNotification" object:@""];
//        //发送通知刷新我收藏的作品
       [[NSNotificationCenter defaultCenter] postNotificationName:@"didBillCollectObjNotification" object:@""];
        
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
//        [_deleGate ]
//        if ([description isEqualToString:@"30008"]) {
//            description
//        }
        [_deleGate stop:description];
        NSLog(@"失败");
        [self loadModle:YES];
        
    }];
    
    
    
    
}
#pragma mark-获取详情
-(void)loadModle:(BOOL)iszhuan{
    NSDictionary * Parameterdic = @{
                                    @"buyId":_BuyModlel.id,
                                    
                                    };
    
    
    // [self showLoading:iszhuan AndText:nil];
    
    [self.requestManager postWithUrl:@"api/buy/getBuyDetail.json" refreshCache:NO params:Parameterdic IsNeedlogin:YES success:^(id resultDic) {
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        NSDictionary * dic = resultDic[@"object"];
        _BuyModlel = [MCBuyModlel mj_objectWithKeyValues:dic];
        NSString * imageUrl = dic[@"imageUrl"];
        id result = [self analysis:imageUrl];
        if ([result isKindOfClass:[NSArray class]]) {
            _BuyModlel.imageUrl = result;
        }
        id json = [self analysis:_BuyModlel.json];
        _BuyModlel.Buyjson = [MCBuyjson mj_objectWithKeyValues:json];
        for (NSString * url in _BuyModlel.imageUrl) {
            YJphotoModel*   photoModel =[[YJphotoModel alloc]init];
            photoModel.raw = url;
            [_BuyModlel.YJphotos addObject:photoModel];
            
        }
        
        
        _BuyModlel.MCdescription = dic[@"description"];
        _BuyModlel.userModel = [YJUserModel mj_objectWithKeyValues:_BuyModlel.user];

//        _BuyModlel = [MCBuyModlel mj_objectWithKeyValues:resultDic[@"object"]];
//        _BuyModlel.userModel = [YJUserModel mj_objectWithKeyValues:resultDic[@"object"][@"user"]];
        [_tableView reloadData];
//       [_selfViewCtl modeltype:_BuyModlel];

       if (iszhuan)
//        
            [_selfViewCtl modeltype:_BuyModlel];

        
        
        if (![_BuyModlel.type isEqualToString:@"show"]) {
            
            
            CGFloat w = [MCIucencyView heightforString:_BuyModlel.chAddress andHeight:15 fontSize:14] + 35;
            NSLog(@"_BuyModlel.chAddress ===%@",_BuyModlel.chAddress);
            if (!_BuyModlel.chAddress.length) {
                w = 50;
            }
            _jinView.frame = CGRectMake(0, 0,w , 40);
            
            UILabel * lbl = [self viewWithTag:9999];// [[UILabel alloc]initWithFrame:CGRectMake(5, 0, w, 20)];
            
//            lbl.frame = CGRectMake(lbl.mj_x, lbl.mj_y, w, lbl.mj_h);
            lbl.text = _BuyModlel.chAddress;
            
        }

        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        NSLog(@"失败");
    }];
    
    
    
}
#pragma mark-举报
-(void)ActionjubaoBtn{
    
    UIView * view = (UIView*)[self viewWithTag:888];
    if (view.hidden) {
        view.hidden = NO;
        _ispinglun = YES;
    }
    else
    {
        view.hidden = YES;
        _ispinglun = NO;
    }
    
    
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didSQjubaoObjNotification" object:_BuyModlel];
    
    
    // [self pushNewViewController:ctl];
    
    
}

#pragma mark-点击游记评论头像
-(void)actionHeaderBtn:(UIButton*)btn{
    if (_deleGate) {
        pinglunModel * model1 = _dataPingLunArray[btn.tag - 450];
        

       YJUserModel * modle = [[YJUserModel alloc]init];
        modle.id = model1.userId;
       [_deleGate Carte_model:modle];
    }

    //发送通知
   // [[NSNotificationCenter defaultCenter] postNotificationName:@"didCarteObjNotification" object:_home_model];
    
    
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
