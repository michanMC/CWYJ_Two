//
//  zuopinDataViewController.m
//  CWYouJi
//
//  Created by MC on 15/11/7.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "zuopinDataViewController.h"
#import "UIButton+WebCache.h"
#import "zuopinQxTableViewCell.h"
#import "zuopinQx2TableViewCell.h"
#import "zuopinQx3TableViewCell.h"
#import "pinglunModel.h"
#import "MCbackButton.h"
#import "UIImageView+LBBlurredImage.h"

@interface zuopinDataViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
{
    
    RGFadeView * rgFadeView;
    BOOL _iszuozhe;
    NSMutableArray * _dataPingLunArray;
    NSInteger pagrStr;
    BOOL _ispinglun;
    BOOL _isloadImg;
    
    CGRect _viewFrame;
}

@end

@implementation zuopinDataViewController
//-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        _dataPingLunArray = [NSMutableArray array];
//        pagrStr = 1;
//    }
//    return self;
//    
//    
//}
-(id)initFrame:(CGRect)frame{
    self = [super init];
    if (self) {
        _viewFrame = frame;
        _dataPingLunArray = [NSMutableArray array];
        pagrStr = 1;

    }
    
    return self;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (rgFadeView) {
        [rgFadeView removeFromSuperview];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = _viewFrame;
    self.view.backgroundColor = [UIColor yellowColor];
    
//    rgFadeView = [[RGFadeView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
//    [self.view addSubview:rgFadeView];

   [self prepareUI];
//    [self loadData:YES];
    // Do any additional setup after loading the view.
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
    [_tableView addFooterWithTarget:self action:@selector(fooershuaxin)];
     [self.view addSubview:_tableView];
    
    
    
    
//    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(120, 10, 80, 80)];
//    view2.backgroundColor = [UIColor redColor];
//    [self.view addSubview:view2];
    
    
    
    

}
-(void)fooershuaxin{
    pagrStr++;
    [self loadData:NO];
}
-(UIView*)addHeadView:(NSInteger)indexCount{
    UIView * bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width - 80, Main_Screen_Width - 80)];
    
    UIView *imgbgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width - 80, Main_Screen_Width - 80)];
    
    [bgview addSubview:imgbgView];
    
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imgbgView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = imgbgView.bounds;
        maskLayer.path = maskPath.CGPath;
        imgbgView.layer.mask = maskLayer;
    
    NSDictionary * dicimg = [NSDictionary dictionary] ;
    
    CGRect imgfram;
    if (indexCount == 1) {
        imgfram = CGRectMake(0, 0, Main_Screen_Width - 80, Main_Screen_Width - 80);
        dicimg = _home_model.photos[0];
     UIButton * imgView =[self addImgView:imgfram ImgStr:@"travels-details_default-chart01" ImgUrlStr:dicimg[@"raw"]];
        imgView.tag = 400;
        [imgView addTarget:self action:@selector(showTupian:) forControlEvents:UIControlEventTouchUpInside];
        [imgbgView addSubview:imgView];
    }
    else if(indexCount == 2){
        
        for (int  i = 0; i < 2 ; i++) {
            dicimg = _home_model.photos[i];
            imgfram = CGRectMake(((Main_Screen_Width - 80 - 2)/2 + 2) *i, 0, (Main_Screen_Width - 80 - 2)/2, Main_Screen_Width - 80);
            UIButton * imgView =[self addImgView:imgfram ImgStr:@"travels-details_default-chart02" ImgUrlStr:dicimg[@"raw"]];
            imgView.tag = 400 +i;
            [imgView addTarget:self action:@selector(showTupian:) forControlEvents:UIControlEventTouchUpInside];

            [imgbgView addSubview:imgView];
            
        }
        
    }
    else if(indexCount == 3){
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat width = (Main_Screen_Width- 2 - 80)/2;
        CGFloat height = Main_Screen_Width - 80;
        for (int  i = 0; i < 3 ; i++) {
            dicimg = _home_model.photos[i];
            imgfram = CGRectMake(x, y, width, height);
            if (i==0) {
            UIButton * imgView =[self addImgView:imgfram ImgStr:@"travels-details_default-chart02" ImgUrlStr:dicimg[@"raw"]];
            [imgbgView addSubview:imgView];
                x +=width + 2;
                height = (height-2)/2;
                imgView.tag = 400 +i;
                [imgView addTarget:self action:@selector(showTupian:) forControlEvents:UIControlEventTouchUpInside];

            }
            else
            {
                dicimg = _home_model.photos[i];

                UIButton * imgView =[self addImgView:imgfram ImgStr:@"home_banner_default-chart" ImgUrlStr:dicimg[@"raw"]];
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
        CGFloat width = (Main_Screen_Width- 2 - 80)/2;
        CGFloat height = (Main_Screen_Width - 80 - 2) / 2;
        
        for (int  i = 0; i < 4 ; i++) {
            dicimg = _home_model.photos[i];

            imgfram = CGRectMake(x, y, width, height);
            UIButton * imgView =[self addImgView:imgfram ImgStr:@"home_banner_default-chart" ImgUrlStr:dicimg[@"raw"]];
            imgView.tag = 400 +i;
            [imgbgView addSubview:imgView];
            [imgView addTarget:self action:@selector(showTupian:) forControlEvents:UIControlEventTouchUpInside];

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
    return 10;
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
        CGFloat h = [MCIucencyView heightforString:_home_model.content andWidth:Main_Screen_Width - 80 - 30 fontSize:13];
        
        return 85 + h + 55;
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0){
        return 44;
        }
     else
        {
            
            
            if (_dataPingLunArray.count > indexPath.row - 1) {
                
            pinglunModel * model = _dataPingLunArray[indexPath.row - 1];
                NSString *titleStr ;
                if ([model.isRemindAuthor boolValue]) {
                    titleStr = [NSString stringWithFormat:@"@作者%@",model.content];
                }
                else
                {
                    titleStr = model.content;
                }

               CGFloat h = [MCIucencyView heightforString:titleStr andWidth:Main_Screen_Width - 80 - 30 fontSize:13];
            
            return h + 38 + 10;
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

        if (_home_model.title.length > 9) {//第一行大概9个字
            cell.titleStr = [_home_model.title substringToIndex:9];
            cell.subTitleStr = [_home_model.title substringFromIndex:9];
            
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
    
        
        CGFloat h = [MCIucencyView heightforString:_home_model.content andWidth:Main_Screen_Width - 80 - 30 fontSize:13];

        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, Main_Screen_Width - 80, 85 + h + 55) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame =CGRectMake(0, 0, Main_Screen_Width - 80, 85 + h + 55);
        maskLayer.path = maskPath.CGPath;
        cell.layer.mask = maskLayer;

        return cell;
    }
    else if(indexPath.section == 1)
    {
        static NSString * cellid2 = @"zuopinQx2TableViewCell";
        static NSString * cellid3 = @"zuopinQx3TableViewCell";

        if (indexPath.row == 0) {
            zuopinQx2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid2];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:cellid2 owner:self options:nil]lastObject];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.pinglunShuLbl.text = [NSString stringWithFormat:@"(%ld)",_dataPingLunArray.count];
            
            cell.BgView.tag = 888;
            cell.BgView.hidden = !_ispinglun;
            [cell.pinglunBtn addTarget:self action:@selector(ActionPinjia:) forControlEvents:UIControlEventTouchUpInside];
            [cell.jubaoBtn addTarget:self action:@selector(ActionjubaoBtn) forControlEvents:UIControlEventTouchUpInside];
            [cell.showBtn addTarget:self action:@selector(actionShow:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            
    
            UIBezierPath *maskPath;
            if (_dataPingLunArray.count == 0) {
                
                              maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(10, 10)];
                
            }
            else
            {
                maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
                

                

            }

            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame =cell.bounds;
            maskLayer.path = maskPath.CGPath;
            cell.layer.mask = maskLayer;
           
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
                cell.headStr =[NSString stringWithFormat:@"%@%@",AppImgURL, model.userModel.thumbnail];

                cell.nameStr = model.userModel.nickname;
            
                NSString *titleStr ;
                if ([model.isRemindAuthor boolValue]) {
                    titleStr = [NSString stringWithFormat:@"@作者%@",model.content];
                }
                else
                {
                    titleStr = model.content;
                }
                
                cell.titleStr = titleStr;//model.content;
                
                
                
            
            if (indexPath.row == _dataPingLunArray.count) {
                CGFloat h = [MCIucencyView heightforString:model.content andWidth:Main_Screen_Width - 80 - 30 fontSize:13];
                
                UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, Main_Screen_Width - 80, 38 + h + 10) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight  cornerRadii:CGSizeMake(10, 10)];
                CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
                maskLayer.frame =CGRectMake(0, 0, Main_Screen_Width - 80, 38 + h + 10);
                maskLayer.path = maskPath.CGPath;
                cell.layer.mask = maskLayer;
                

            }
            else
            {
                CGFloat h = [MCIucencyView heightforString:model.content andWidth:Main_Screen_Width - 80 - 30 fontSize:13];
                
                UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, Main_Screen_Width - 80, 38 + h + 10) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(0, 0)];
                CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
                maskLayer.frame =CGRectMake(0, 0, Main_Screen_Width - 80, 38 + h + 10);
                maskLayer.path = maskPath.CGPath;
                cell.layer.mask = maskLayer;
 
            }
              return cell;
            }
            
        }
    }
    
    return [[UITableViewCell alloc]init];
}
-(void)actionShow:(UIButton*)btn{
    UIView * view = (UIView*)[self.view viewWithTag:888];
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
    
    [self showLoading:YES AndText:nil];
    [self.requestManager requestWebWithParaWithURL:collection Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
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
        [self hideHud];
        [self showAllTextDialog:description];
        
        NSLog(@"失败");
    }];
    
 
    
    
}
#pragma mark-获取游记
-(void)loadModle:(BOOL)iszhuan{
    NSDictionary * Parameterdic = @{
                                    @"travelId":_home_model.id,
                                    
                                    };
    
    
    [self showLoading:iszhuan AndText:nil];
    [self.requestManager requestWebWithParaWithURL:@"api/travel/detail.json" Parameter:Parameterdic IsLogin:YES Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        
        
        _home_model = [homeYJModel mj_objectWithKeyValues:resultDic[@"object"]];
        _home_model.userModel = [YJUserModel mj_objectWithKeyValues:resultDic[@"object"][@"user"]];
        [_tableView reloadData];
        
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
        
        NSLog(@"失败");
    }];
    
    

    
}
#pragma mark-获取评论
-(void)loadData:(BOOL)iszhuan{
    return;
    NSDictionary * Parameterdic = @{
                                    @"page":@(pagrStr),
                                    @"travelId":_home_model.id,

                                    };
    
    
    [self showLoading:iszhuan AndText:nil];
    [self.requestManager requestWebWithParaWithURL:@"api/travel/comment/query.json" Parameter:Parameterdic IsLogin:NO Finish:^(NSDictionary *resultDic) {
        [self hideHud];
        NSLog(@"成功");
        NSLog(@"评论列表返回==%@",resultDic);
        
        
//        [_dataPingLunArray removeAllObjects];
        
        for (NSDictionary * dic in resultDic[@"object"]) {
            pinglunModel * model = [pinglunModel mj_objectWithKeyValues:dic];
            
            model.userModel = [YJUserModel mj_objectWithKeyValues:dic[@"user"]];
            [_dataPingLunArray addObject:model];
            
        }
        
        [_tableView footerEndRefreshing];
        [_tableView reloadData];
        
        
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [_tableView footerEndRefreshing];
        [self hideHud];
        [self showAllTextDialog:description];
        
        NSLog(@"失败");
    }];

    
    
    
}
#pragma mark-评价
-(void)ActionPinjia:(UIButton*)btn{
    
    if (!rgFadeView) {
        rgFadeView = [[RGFadeView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
        rgFadeView.msgTextView.delegate = self;
        
        [rgFadeView.sendBtn addTarget:self action:@selector(actionsend) forControlEvents:UIControlEventTouchUpInside];
        
        
        [rgFadeView.closeBtn addTarget:self action:@selector(actionclose) forControlEvents:UIControlEventTouchUpInside];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [rgFadeView._maskView addGestureRecognizer:tap];
        [rgFadeView.zuozheBtn addTarget:self action:@selector(actionzhezhe:) forControlEvents:UIControlEventTouchUpInside];
        [rgFadeView.zuozheBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];

        [self.view addSubview:rgFadeView];
   }
   // rgFadeView.placeLabel.text = @"请输入评论信息";
    [rgFadeView.msgTextView becomeFirstResponder];

    
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
    
    [rgFadeView.msgTextView resignFirstResponder];
    rgFadeView.hidden = YES;
    
    if (!rgFadeView.msgTextView.text.length) {
        rgFadeView = nil;
        [self showAllTextDialog:@"请输入你评论内容"];
        return;
    }
    
    
    NSDictionary * Parameterdic = @{
                                    @"isRemindAuthor":@(_iszuozhe),
                                    @"targetId":_home_model.id,
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
        
        pagrStr = 1;
        [_dataPingLunArray removeAllObjects];

        [self loadData:YES];
        
        
        
    } Error:^(AFHTTPRequestOperation *operation, NSError *error, NSString *description) {
        [self hideHud];
        [self showAllTextDialog:description];
        
        NSLog(@"失败");
    }];
    
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
    
    
    [rgFadeView.msgTextView resignFirstResponder];
    rgFadeView.msgTextView.text = @"";
    
    rgFadeView.hidden = YES;
    rgFadeView = nil;
    
}
#pragma mark-举报
-(void)ActionjubaoBtn{
    
    
    
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didjubaoObjNotification" object:_home_model.id];
    

   // [self pushNewViewController:ctl];
    
    
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
