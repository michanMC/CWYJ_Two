//
//  zuopinDataView.m
//  CWYouJi
//
//  Created by MC on 15/11/25.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "zuopinDataView.h"
#import "UIButton+WebCache.h"
#import "zuopinQxTableViewCell.h"
#import "zuopinQx2TableViewCell.h"
#import "zuopinQx3TableViewCell.h"
#import "pinglunModel.h"
#import "MCbackButton.h"
#import "UIImageView+LBBlurredImage.h"

@interface zuopinDataView ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>{
    
//    RGFadeView * rgFadeView;
    BOOL _iszuozhe;
    BOOL _ispinglun;
    BOOL _isloadImg;
    CGRect _viewFrame;
    BOOL _isjiagengduo;
    
    
    
}

@end


@implementation zuopinDataView
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
    }
    
    return self;
}
-(void)setHome_model:(homeYJModel *)home_model{
    _home_model = home_model;
    self.frame = _viewFrame;
  //  self.backgroundColor = [UIColor yellowColor];
    _bg_imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    [self prepareUI];
    
}
-(void)prepareUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, _viewFrame.size.width, _viewFrame.size.height ) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate= self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    
    _tableView.tableHeaderView = [self addHeadView:_home_model.photos.count];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //[_tableView addFooterWithTarget:self action:@selector(fooershuaxin)];
    [self addSubview:_tableView];
    
    
    
    
    
    
}
-(void)fooershuaxin{
    _pagrStr++;
    [self loadData:NO];
}

-(UIView*)addHeadView:(NSInteger)indexCount{
    
    UIView * bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.mj_w, self.mj_w)];
    
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
        photomodel = _home_model.YJphotos[0];
        UIButton * imgView =[self addImgView:imgfram ImgStr:@"travels-details_default-chart01" ImgUrlStr:photomodel.raw];
        imgView.tag = 400;
        [imgView addTarget:self action:@selector(showTupian:) forControlEvents:UIControlEventTouchUpInside];
        [imgbgView addSubview:imgView];
        
        
        [_bg_imgView sd_setImageWithURL:[NSURL URLWithString:photomodel.raw] placeholderImage:[UIImage imageNamed:@"login_bg_720"]];

    }
    else if(indexCount == 2){
        
        for (int  i = 0; i < 2 ; i++) {
            photomodel = _home_model.YJphotos[i];
            imgfram = CGRectMake(((self.mj_w - 2)/2 + 2) *i, 0, (self.mj_w - 2)/2, self.mj_w);
            UIButton * imgView =[self addImgView:imgfram ImgStr:@"travels-details_default-chart02" ImgUrlStr:photomodel.raw];
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
            photomodel = _home_model.YJphotos[i];
            imgfram = CGRectMake(x, y, width, height);
            if (i==0) {
                UIButton * imgView =[self addImgView:imgfram ImgStr:@"travels-details_default-chart02" ImgUrlStr:photomodel.raw];
                [imgbgView addSubview:imgView];
                x +=width + 2;
                height = (height-2)/2;
                imgView.tag = 400 +i;
                [imgView addTarget:self action:@selector(showTupian:) forControlEvents:UIControlEventTouchUpInside];
                  [_bg_imgView sd_setImageWithURL:[NSURL URLWithString:photomodel.raw] placeholderImage:[UIImage imageNamed:@"login_bg_720"]];
                    
                
                
            }
            else
            {
                photomodel = _home_model.YJphotos[i];
                
                UIButton * imgView =[self addImgView:imgfram ImgStr:@"home_banner_default-chart" ImgUrlStr:photomodel.raw];
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
            photomodel = _home_model.YJphotos[i];
            
            imgfram = CGRectMake(x, y, width, height);
            UIButton * imgView =[self addImgView:imgfram ImgStr:@"home_banner_default-chart" ImgUrlStr:photomodel.raw];
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
    return bgview;
    
}
-(UIButton*)addImgView:(CGRect)imgFrame ImgStr:(NSString*)imgStr ImgUrlStr:(NSString*)imgUrlStr{
    
    UIButton * imgView = [[UIButton alloc]initWithFrame:imgFrame];
    imgView.imageView.contentMode = UIViewContentModeScaleAspectFill;

   // imgView.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    //[imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imgUrlStr]] forState:0 placeholderImage:[UIImage imageNamed:imgStr]];
   [imgView sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imgUrlStr]] forState:0 placeholderImage:[UIImage imageNamed:imgStr]];
    
    
    
    
    return imgView;
}
#pragma mark-浏览图片
-(void)showTupian:(UIButton*)btn{
    
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didshowObjNotification" object:@(btn.tag)];
    
    
    
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
        CGFloat h = [MCIucencyView heightforString:_home_model.content andWidth:Main_Screen_Width - 80 - 30 fontSize:13];//内容的高
        
        
        if (_isjiagengduo) {
            return  185 - 20 + h;

        }
        return 185;

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
                    if ([_home_model.userModel.id integerValue] == idstr) {
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
        zuopinQxTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
        if (!cell) {
            cell = [[zuopinQxTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid1];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        CGFloat h = [MCIucencyView heightforString:_home_model.content andWidth:self.mj_w - 30 fontSize:13];
        
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
        

      cell.isgengduan = _isjiagengduo  ;
        if (_isjiagengduo) {
            cell.gengduoBtn.hidden = YES;
            
        }
        else
        {
            cell.gengduoBtn.hidden = NO;
        }
        cell.dataStr = _home_model.content;

        //头像
        if(_home_model.userModel.thumbnail)
        {
            cell.headimgStr = _home_model.userModel.thumbnail;
            
        }
        //姓名
        if (_home_model.userModel.nickname) {
            cell.nameLStr = _home_model.userModel.nickname;
        }
        else
        {
            cell.nameLStr = @"游客";
        }
        
        if (_home_model.title.length > 11) {//第一行大概11个字
            cell.titleStr = [_home_model.title substringToIndex:11];
            cell.subTitleStr = [_home_model.title substringFromIndex:11];
            
        }
        else
        {
            cell.titleStr = _home_model.title;
            cell.subTitleStr = @"";
            
        }
        cell.dingweiStr = _home_model.spotName;
        [cell.shouchangBtn addTarget:self action:@selector(actionShouchang:) forControlEvents:UIControlEventTouchUpInside];
        //NSLog(@"======%d",[_home_model.collection boolValue]);
        
        cell.isshouchang = _home_model.collection;
        
        cell.timeStr =   [CommonUtil getStringWithLong:_home_model.createDate Format:@"MM-dd"];
        
        
        
        
        //游记类型
        //NSLog(@">>>>%@",[self.classifyDic objectForKey:model[@"classify"]]);
        cell.keyImgStr = [self.classifyDic objectForKey:[NSString stringWithFormat:@"%ld",_home_model.classify]] ;
        
        
        
        //游记推荐
        BOOL isRecommend = [_home_model.isRecommend boolValue];
        if (isRecommend) {
            cell.tuijanImgStr = @"荐";
        }
        else
        {
            cell.tuijanImgStr = @"踩";
            
        }
        [cell.gengduoBtn addTarget:self action:@selector(ActionGengduo:) forControlEvents:UIControlEventTouchUpInside];
        
        /*
        CGFloat h = [MCIucencyView heightforString:_home_model.content andWidth:Main_Screen_Width - 80 - 30 fontSize:13];
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, Main_Screen_Width - 80, 85 + h + 55) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame =CGRectMake(0, 0, Main_Screen_Width - 80, 85 + h + 55);
        maskLayer.path = maskPath.CGPath;
        cell.layer.mask = maskLayer;
        */
        return cell;
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
           cell.BgView.hidden = !_ispinglun;
            cell.pinglunBtn.tag = 880;
            [cell.pinglunBtn addTarget:self action:@selector(ActionPinjia:) forControlEvents:UIControlEventTouchUpInside];
           [cell.jubaoBtn addTarget:self action:@selector(ActionjubaoBtn) forControlEvents:UIControlEventTouchUpInside];
           [cell.showBtn addTarget:self action:@selector(actionShow:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            
            
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
                cell.headStr =[NSString stringWithFormat:@"%@%@",@"", model.userModel.raw];

                cell.nameStr = model.userModel.nickname;
                NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                NSInteger idstr =[[defaults objectForKey:@"id"] integerValue];
                                NSString *titleStr ;
               // NSMutableAttributedString *btn_arrstring;
                cell.huifuBtn.tag =indexPath.row - 1 + 9000;
                [cell.huifuBtn addTarget:self action:@selector(ActionPinjia:) forControlEvents:UIControlEventTouchUpInside];
                if ([model.isRemindAuthor boolValue]) {
                    //自己游记
                    if ([_home_model.userModel.id integerValue] ==idstr) {
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
#pragma mark-获取游记
-(void)loadModle:(BOOL)iszhuan{
    NSDictionary * Parameterdic = @{
                                    @"travelId":_home_model.id,
                                    
                                    };
    
    /*
   // [self showLoading:iszhuan AndText:nil];
    [self.requestManager requestWebWithParaWithURL:@"api/travel/detail.json" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        //[self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        
        
        _home_model = [homeYJModel mj_objectWithKeyValues:resultDic[@"object"]];
        _home_model.userModel = [YJUserModel mj_objectWithKeyValues:resultDic[@"object"][@"user"]];
        [_tableView reloadData];
        
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
//        [self hideHud];
//        [self showAllTextDialog:description];
        
        NSLog(@"失败");
    }];
    
    
    */
    
}

#pragma mark-收藏
-(void)actionShouchang:(UIButton*)btn{
    
    
    
    NSDictionary * Parameterdic = @{
                                    
                                    @"targetId":_home_model.id,
                                    
                                    };
    
    
    NSString * collection;
    if (_home_model.collection ) {
        Parameterdic = @{
                         
                         @"travelId":_home_model.id,
                         
                         };
        collection = @"api/travle/collection/deleteByTravelId.json";
    }
    else
    {
        collection = @"api/travle/collection/add.json";
        
    }
    /*
    [_deleGate zhuan:nil];
    //[self showLoading:YES AndText:nil];
    [self.requestManager requestWebWithParaWithURL:collection Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
       // [self hideHud];
        [_deleGate stop:nil];
        NSLog(@"成功");
        [self loadModle:YES];
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dishuaxinObjNotification" object:@""];
        // dishoucangshuaxinObjNotification
        //发送通知刷新我制作的作品
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didzuopingshuaxinObjNotification" object:@""];
        //发送通知刷新我收藏的作品
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dishoucangshuaxinObjNotification" object:@""];
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
//        [self hideHud];
//        [self showAllTextDialog:description];
//
        [_deleGate stop:description];
        NSLog(@"失败");
    }];
    
    */
    
    
}
#pragma mark-获取评论
-(void)loadData:(BOOL)iszhuan{
    _isLoda = YES;
    NSDictionary * Parameterdic = @{
                                    @"page":@(_pagrStr),
                                    @"travelId":_home_model.id,
                                    
                                    };
    
    
    if (iszhuan)
    [_deleGate zhuan:nil];

    //[self showLoading:iszhuan AndText:nil];
    [_requestManager postWithUrl:@"api/travel/comment/query.json" refreshCache:NO params:Parameterdic IsNeedlogin:NO success:^(id resultDic) {
        [_deleGate stop:nil];
        NSLog(@"成功");
        NSLog(@"评论列表返回==%@",resultDic);
        for (NSDictionary * dic in resultDic[@"object"]) {
            pinglunModel * model = [pinglunModel mj_objectWithKeyValues:dic];
            
            model.userModel = [YJUserModel mj_objectWithKeyValues:dic[@"user"]];
            [_dataPingLunArray addObject:model];
            
        }
        
//        [_tableView footerEndRefreshing];
        [_tableView reloadData];
        

    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
//        [_tableView footerEndRefreshing];
        //        [self hideHud];
        //        [self showAllTextDialog:description];
        [_deleGate stop:nil];
        NSLog(@"失败");

    }];
    
    
    
    
}
#pragma mark-评价
-(void)ActionPinjia:(UIButton*)btn{
    
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

    
    if (btn.tag == 880) {
        if (_deleGate)
    [_deleGate pinglunModel:_home_model Index:_indexId IsHuifu:NO PinglunModel:nil];
    
    }else
    {
        if (btn.tag - 9000 < _dataPingLunArray.count) {
            
            pinglunModel * model = _dataPingLunArray[btn.tag - 9000];
            [_deleGate pinglunModel:_home_model Index:_indexId IsHuifu:YES PinglunModel:model];

        NSLog(@">>>%ld",btn.tag);
        
        
        
        }
        
    }
}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSLog(@"%d",textView.text.length);
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        //[textView resignFirstResponder];
        [self actionsend];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}
#pragma mark-评论发送
-(void)actionsend{
    
    /*
    [rgFadeView.msgTextView resignFirstResponder];
    rgFadeView.hidden = YES;
    
    if (!rgFadeView.msgTextView.text.length) {
        rgFadeView = nil;
        [rgFadeView removeFromSuperview];
       // [self showAllTextDialog:@"请输入你评论内容"];
        return;
    }
    
    
    NSDictionary * Parameterdic = @{
                                    @"isRemindAuthor":@(_iszuozhe),
                                    @"targetId":_home_model.id,
                                    @"content":rgFadeView.msgTextView.text
                                    };
     */
    /*
    
    [_deleGate zhuan:nil];
    //[self showLoading:YES AndText:nil];
    [_requestManager requestWebWithParaWithURL:@"api/travel/comment/add.json" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
       // [self hideHud];
        [_deleGate stop:@"评论成功"];
        NSLog(@"评论成功");
        NSLog(@"返回==%@",resultDic);
        //[self showHint:@"评论成功"];
        
        rgFadeView.msgTextView.text = @"";
        
        rgFadeView = nil;
        
        _pagrStr = 1;
        [_dataPingLunArray removeAllObjects];
        
        [self loadData:YES];
        
        
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
//        [self hideHud];
//        [self showAllTextDialog:description];
        [_deleGate stop:description];
        NSLog(@"失败");
    }];
     */
    
}
-(void)tap:(UITapGestureRecognizer*)tap{
    
    [self actionclose];
}
-(void)actionzhezhe:(UIButton*)btn{
    if(btn.selected){
        btn.selected = NO;
        _iszuozhe = NO;
        //        if ([textStr containsString:@"@作者"]) {
        //            NSLog(@"you");
        //        }
        //        rgFadeView.msgTextView.text = textStr;
    }
    else
    {
        btn.selected = YES;
        _iszuozhe = YES;
        
        //        textStr =[NSString stringWithFormat:@"@作者%@",textStr];
        //        rgFadeView.msgTextView.text = textStr;
    }
    
}
-(void)actionclose{
    /*
    [rgFadeView.msgTextView resignFirstResponder];
    rgFadeView.msgTextView.text = @"";
    
    rgFadeView.hidden = YES;
    rgFadeView = nil;
    [rgFadeView removeFromSuperview];
     */
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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didjubaoObjNotification" object:_home_model.id];
    
    
    // [self pushNewViewController:ctl];
    
    
}

#pragma mark-加载更多
-(void)ActionGengduo:(UIButton*)btn{
    
    
    _isjiagengduo = YES;
    [_tableView reloadData];
    
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
