//
//  zhizuoZP2ViewController.m
//  CWYouJi
//
//  Created by MC on 15/11/8.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "zhizuoZP2ViewController.h"
#import "MCdeleteImgView.h"
#import "ZYQAssetPickerController.h"
#import "zhizuoTextTableViewCell.h"
#import "zhizuoText2TableViewCell.h"
#import "UIPlaceHolderTextView.h"
#import "liulanViewController.h"
#import "TYAlertController+BlurEffects.h"
#import "ShareView.h"
#import "UIView+TYAlertView.h"
//#import "HClActionSheet.h"
#import "homeYJModel.h"
@interface zhizuoZP2ViewController ()<ZYQAssetPickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    UITableView *_tableview;
    NSMutableArray *_imgViewArray;
    
    UIPlaceHolderTextView * _holderText;
    UILabel *_countText;
    
    NSString *_holderTextStr;
    NSString *_countTextStr;
    NSString * _diaotiStr;
    
    
}

@end

@implementation zhizuoZP2ViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"faBuYJ"];

    self.navigationController.navigationBarHidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"faBuYJ"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _imgViewArray = [NSMutableArray array];
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(89,40,100,35)];
    
    UIButton *navigationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [navigationButton setFrame:CGRectMake(100 - 35,0,30,30)];
    //fabu
    [navigationButton setImage:[UIImage imageNamed:@"nav_release_pressed"] forState:UIControlStateNormal];
    navigationButton.tag = 202;
    [navigationButton addTarget:self action:@selector(actionnavigationButton:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:navigationButton];

    
    navigationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [navigationButton setFrame:CGRectMake(100 - 35 - 35,0,30,30)];
    [navigationButton setImage:[UIImage imageNamed:@"nav_preview_pressed"] forState:UIControlStateNormal];
    navigationButton.tag = 203;
    [navigationButton addTarget:self action:@selector(actionnavigationButton:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:navigationButton];
    
    
    navigationButton = [UIButton buttonWithType:UIButtonTypeCustom];

    [navigationButton setFrame:CGRectMake(100 -3 * 35,0,30,30)];
    [navigationButton setImage:[UIImage imageNamed:@"nav_delete_pressed"] forState:UIControlStateNormal];
    navigationButton.tag = 201;
    //navigationButton.hidden = YES;
    [navigationButton addTarget:self action:@selector(actionnavigationButton:) forControlEvents:UIControlEventTouchUpInside];


    [containerView addSubview:navigationButton];

    
    
    
    UIBarButtonItem *navigationBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:containerView];
    
    self.navigationItem.rightBarButtonItem = navigationBarButtonItem;
    
    [self prepareUI];
    
    // Do any additional setup after loading the view.
}
#pragma mark-发布
-(void)fabu{
    UITextField * text = [self.view viewWithTag:500];
    [text resignFirstResponder];
    UITextView * textv = [self.view viewWithTag:900];
    [textv resignFirstResponder];

    NSLog(@"classify =====%@",_dataDic[@"classify"]);

    NSMutableArray *imgArray = [NSMutableArray array];
    for (int i = 0; i < _imgViewArray.count; i ++) {
        
        UIImage *tempImg;
        if([_imgViewArray[i]isKindOfClass:[UIImage class]]){
            tempImg = _imgViewArray[i];
        }
        else{
            ALAsset *asset=_imgViewArray[i];
            tempImg =[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        }
        
        [imgArray addObject:tempImg];
        
    }

    if (!imgArray.count) {
        kAlertMessage(@"亲，有图有真相哦");
        return;
    }
    
    if (!_diaotiStr.length) {
        kAlertMessage(@"请输入标题");
        return;
    }
    
    if (!_holderTextStr.length) {
        kAlertMessage(@"请输入你要说的内容");
        return;
    }

    NSLog(@"发布");
    NSLog(@">>>>%@",_dataDic);
    NSInteger  isRecommend = 0;
    NSInteger classify = 0;
    NSString *startTime;
    NSInteger spotId;
    if ([[_dataDic objectForKey:@"isRecommend"] integerValue] == 700) {
        isRecommend = 1;
        //            _titlearray = @[@"东西好吃得不要不要的",@"三星级的价格，五星级的享受",@"景美，我和我的小伙伴都惊呆了",@"买买买"];
        
        
        
    }
    else
    {
        // [@"我有100钟方法让你吃不下去",@"住宿环境差，感觉不会再爱了",@"看到这景色，我的内心几乎是崩溃",@"青岛大虾，38元一只"];
        isRecommend = 0;
        
    }
    NSString *classifyStr = [_dataDic objectForKey:@"classify"];
   NSArray* zanTitleArray = @[
                       @"东西好吃得不要不要的",
                       @"三星级的价格，五星级的享受",
                       @"景美，我和我的小伙伴都惊呆了！",
                       @"买买买"
                       ];
    NSArray*caiTitleArray = @[
                       @"食之无味，弃之也不浪费",
                       @"除了不淋雨，其实就是天桥底",
                       @"世界有多大，此景有多差！",
                       @"钱包好空虚，宝宝好委屈"
                       ];

    if ([zanTitleArray[0] isEqualToString:classifyStr]||[caiTitleArray[0] isEqualToString:classifyStr]) {
        classify = 0;

        
    }
    if ([zanTitleArray[1] isEqualToString:classifyStr]||[caiTitleArray[1] isEqualToString:classifyStr]) {
        classify = 1;
        
        
    }
    if ([zanTitleArray[2] isEqualToString:classifyStr]||[caiTitleArray[2] isEqualToString:classifyStr]) {
        classify = 2;
        
        
    }
    if ([zanTitleArray[3] isEqualToString:classifyStr]||[caiTitleArray[3] isEqualToString:classifyStr]) {
        classify = 3;
        
        
    }

    
    
//    if ([[_dataDic objectForKey:@"classify"] isEqualToString:@"东西好吃得不要不要的"]||[[_dataDic objectForKey:@"classify"] isEqualToString:@"食之无味，弃之也不浪费"])
//        
//        classify = 0;
//    if ([[_dataDic objectForKey:@"classify"] isEqualToString:@"三星级的价格，五星级的享受"]||[[_dataDic objectForKey:@"classify"] isEqualToString:@"除了不淋雨，其实就是天桥底"])
//        classify = 1;
//    if ([[_dataDic objectForKey:@"classify"] isEqualToString:@"景美，我和我的小伙伴都惊呆了"]||[[_dataDic objectForKey:@"classify"] isEqualToString:@"世界有多大，此景有多差！"])
//        classify = 2;
//    if ([[_dataDic objectForKey:@"classify"] isEqualToString:@"买买买"]||[[_dataDic objectForKey:@"classify"] isEqualToString:@"钱包好空虚，宝宝好委屈"])
//        classify = 3;
//    
    
    
    startTime =   [[_dataDic objectForKey:@"startTime"] substringToIndex:10];
    spotId = [[_dataDic objectForKey:@"spotId"] integerValue];
    
    
    // NSLog(@">>>>>%@",imgArray);
    NSMutableDictionary * imgDic = [NSMutableDictionary dictionary];
    for (int i = 0; i < imgArray.count; i++) {
        
        UIImage *img = imgArray[i];
        NSData *imageData = UIImageJPEGRepresentation(img, 0.2);
        NSString *base64Image=[imageData base64Encoding];
        [imgDic setObject:base64Image forKey:[NSString stringWithFormat:@"%d",i+1]];
        
        
    }
    NSLog(@"<<<<<%@",imgDic);
    
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:imgDic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    NSString * photoes = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    
    
    
    
    
    NSDictionary * Parameterdic = @{
                                    @"title":_diaotiStr,
                                    @"content":_holderTextStr,
                                    @"spotId":@(spotId),
                                    @"classify":@(classify),//classify,
                                    @"startTime":startTime,
                                    @"isRecommend":@(isRecommend),//isRecommend,
                                    @"photoes":photoes
//                                    @"user_session":self.userSessionId
                                    };
    
    
    [self showLoading];
    [self.requestManager postWithUrl:@"api/travel/add.json" refreshCache:NO params:Parameterdic IsNeedlogin:YES success:^(id resultDic) {
        
        [self stopshowLoading];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        homeYJModel * model = [homeYJModel mj_objectWithKeyValues:resultDic[@"object"]];
        //发送通知刷新
        [[NSNotificationCenter defaultCenter] postNotificationName:@"disqueryObjNotification" object:@""];
        

        ShareView *shareView = [ShareView createViewFromNib];
        shareView.titleLbl.textColor = AppTextCOLOR;
        ViewRadius(shareView.bgView, 5);
        
        __weak zhizuoZP2ViewController *weakSelf = self;
        [shareView.detebtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
            [shareView hideView];
            
            for (UIViewController *vc in weakSelf.navigationController.viewControllers) {
                
                if ([vc isKindOfClass:objc_getClass("MCplayViewController")]) {
                    
                    [weakSelf.navigationController popToViewController:vc animated:YES];
                    
                    return;
                }
            }

           // [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            
            
        }];

        
        [shareView.weiboBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
            [shareView hideView];
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            NSMutableDictionary * dic = [NSMutableDictionary dictionary];
            NSString * url = [NSString stringWithFormat:@"%@api/travel/travelDetailOfH5.jhtml?travelId=%@",AppURL,model.id];
            [dic setObject:url forKey:@"url"];
            [dic setObject:model.title forKey:@"title"];
            [dic setObject:@"分享游记详情" forKey:@"titlesub"];
            
            [weakSelf actionFenxian:SSDKPlatformTypeSinaWeibo PopToRoot:NO SsDic:dic];
            
            
            NSLog(@"微博");
        }];
        [shareView.QQBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
            [shareView hideView];
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            NSMutableDictionary * dic = [NSMutableDictionary dictionary];
            NSString * url = [NSString stringWithFormat:@"%@api/travel/travelDetailOfH5.jhtml?travelId=%@",AppURL,model.id];
            [dic setObject:url forKey:@"url"];
            [dic setObject:model.title forKey:@"title"];
            [dic setObject:@"分享游记详情" forKey:@"titlesub"];
            
            [weakSelf actionFenxian:SSDKPlatformTypeQQ PopToRoot:NO SsDic:dic];
            
            NSLog(@"QQ");
        }];
        [shareView.weixin handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
            [shareView hideView];
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            NSMutableDictionary * dic = [NSMutableDictionary dictionary];
            NSString * url = [NSString stringWithFormat:@"%@api/travel/travelDetailOfH5.jhtml?travelId=%@",AppURL,model.id];
            [dic setObject:url forKey:@"url"];
            [dic setObject:model.title forKey:@"title"];
            [dic setObject:@"分享游记详情" forKey:@"titlesub"];
            
            [weakSelf actionFenxian:SSDKPlatformSubTypeWechatSession PopToRoot:NO SsDic:dic];
            NSLog(@"weixin");
        }];
        [shareView.toudouBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
            [shareView hideView];
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            NSMutableDictionary * dic = [NSMutableDictionary dictionary];
            NSString * url = [NSString stringWithFormat:@"%@api/travel/travelDetailOfH5.jhtml?travelId=%@",AppURL,model.id];
            [dic setObject:url forKey:@"url"];
            [dic setObject:model.title forKey:@"title"];
            [dic setObject:@"分享游记详情" forKey:@"titlesub"];
            
            [weakSelf actionFenxian:SSDKPlatformSubTypeWechatTimeline PopToRoot:NO SsDic:dic];
            
            
            
            NSLog(@"土豆");
        }];
        [shareView showInWindow];

        
        
        
        
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        if ([description isEqualToString:@"30008"]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                LoginController * ctl = [[LoginController alloc]init];
                [self pushNewViewController:ctl];

                
            });

        }
        else
        {
            if (description.length > 30) {
                NSRange r = {17,5};
                NSString *ss = [description substringWithRange:r];
                description = ss;
                
            }
            [self showAllTextDialog:description];
        }
    }];
    
    
    
}
#pragma mark-点击事件
-(void)actionnavigationButton:(UIButton*)btn{
    UITextField * text = (UITextField *)[self.view viewWithTag:500];
    [text resignFirstResponder];
    UITextView * textview = (UITextView *)[self.view viewWithTag:600];
    [textview resignFirstResponder];
    
    if(btn.tag == 202){//
          [self fabu];
        
        
        return;
 
    }
    
    
    
    if (btn.tag == 201) {
        
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"删除后的游记将不会保存"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:@"取消", nil];
        
        [alertView show];
        alertView.tag = 610;
        NSLog(@"删除");
        return;
    }
    
    
    
    NSMutableArray *imgArray = [NSMutableArray array];
    for (int i = 0; i < _imgViewArray.count; i ++) {
        
        UIImage *tempImg;
        if([_imgViewArray[i]isKindOfClass:[UIImage class]]){
            tempImg = _imgViewArray[i];
        }
        else{
            ALAsset *asset=_imgViewArray[i];
            tempImg =[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        }
        
        [imgArray addObject:tempImg];
        
    }
    if (!imgArray.count) {
        kAlertMessage(@"亲，有图有真相哦");
        return;
    }

    if (!_diaotiStr.length) {
        kAlertMessage(@"请输入标题");
        return;
    }
    
    if (!_holderTextStr.length) {
        kAlertMessage(@"请输入你要说的内容");
        return;
    }

    if (btn.tag == 203) {
        NSLog(@"浏览");
        
      
        NSMutableArray *imgArray = [NSMutableArray array];
        for (int i = 0; i < _imgViewArray.count; i ++) {
        
        UIImage *tempImg;
        if([_imgViewArray[i]isKindOfClass:[UIImage class]]){
            tempImg = _imgViewArray[i];
        }
        else{
            ALAsset *asset=_imgViewArray[i];
            tempImg =[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        }
            
            [imgArray addObject:tempImg];
            
        }
        if (!imgArray.count) {
            kAlertMessage(@"亲，有图有真相哦");
            return;
        }
          liulanViewController * ctl = [[liulanViewController alloc]init];
        ctl.imgViewArray= imgArray;
        ctl.titleStr = _diaotiStr;
        ctl.title2Str = _holderTextStr;
        ctl.dataDic = _dataDic;
        ctl.jingdianStr =  [_dataDic objectForKey:@"jingdianStr"];
        [self pushNewViewController:ctl];
        
        
        
    }

    
}
-(void)prepareUI{
    self.view.backgroundColor = AppMCBgCOLOR;

    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableview.tableHeaderView = [self headView];
    _tableview.delegate =self;
    _tableview.dataSource = self;
    [self.view addSubview:_tableview];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 1) {
        return 126;
    }
    
    return 44;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid1 = @"zhizuoTextTableViewCell";
    if (indexPath.row == 0) {
        zhizuoTextTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"zhizuoTextTableViewCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.mctext.delegate= self;
        cell.mctext.text = _diaotiStr;
        cell.mctext.tag = 500;
        //设置清除按钮
        cell.mctext.clearButtonMode = UITextFieldViewModeAlways;        return cell;
    }
    else if(indexPath.row == 1){
        
        zhizuoText2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mc1"];
        if (!cell) {
            cell = [[zhizuoText2TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mc1"];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.holderTex.delegate = self;
        cell.holderTex.tag = 900;
        cell.countLbl.tag = 600;
        cell.countLbl.text = _countTextStr;
        
        
        return cell;
        
    }
    
    
    return [[UITableViewCell alloc]init];
    
    
    
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    
    _diaotiStr = textField.text;
    //[_tableview reloadData];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    
    if ([textField.text length] > 20&&![string isEqualToString:@""]) {
        //[_tableview reloadData];
        
        return NO;
    }
    //[_tableview reloadData];
    
    return YES;
 
    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]){
        return NO;
    }
    UILabel * lbl = (UILabel*)[self.view viewWithTag:600];
    
    NSString * aString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    if ([aString length] > 500) {
//        //[_tableview reloadData];
//        lbl.text = [NSString stringWithFormat:@"%ld/500",aString.length];
//        _countTextStr = lbl.text;

        return NO;
    }
    //[_tableview reloadData];
    lbl.text = [NSString stringWithFormat:@"%ld/500",aString.length];
//    _countTextStr = lbl.text;
    return YES;

    
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    _holderTextStr = textView.text;
    
//    [_tableview reloadData];
    
}
-(UIView*)headView{
    CGFloat width = (Main_Screen_Width - 30)/2;
    CGFloat hieght = width + 20;
    
    UIView * view =[[ UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, hieght)];
    view.backgroundColor =[UIColor groupTableViewBackgroundColor];
    UIButton *noView = [[UIButton alloc]initWithFrame:CGRectMake((Main_Screen_Width - 80)/2, 30, 80, 80)];
    [noView setImage:[UIImage imageNamed:@"-travel-notes_addpicture"] forState:0];
    [noView addTarget:self action:@selector(actionImgTap) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:noView];
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, hieght - 20 - 20, Main_Screen_Width , 20)];
    
    lbl.text = @"有图有真相，点我上传图片";
    lbl.textColor = [UIColor grayColor];
    lbl.font = AppFont;
    lbl.textAlignment = NSTextAlignmentCenter;
    [view addSubview:lbl];
    
    return view;
}
-(UIView *)addHeadView:(NSInteger)count{
   
    CGFloat width = (Main_Screen_Width - 30)/2;
    CGFloat hieght = width + 20;
    
    UIView * view =[[ UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, hieght)];
    view.backgroundColor =[UIColor groupTableViewBackgroundColor];
    //一张时
    if (count == 1) {
      MCdeleteImgView * imgView =  [self addImgView:CGRectMake(10, 10, Main_Screen_Width - 20, hieght - 20) Iszuihuo:YES Tag:1];
        
        [view addSubview:imgView];
    }
    //2
    if (count == 2) {
        
        hieght -=20;
      CGFloat  y = 10;
        CGFloat  x = 10;
        for (int i =0 ; i < 2; i++) {
            
            MCdeleteImgView * imgView =  [self addImgView:CGRectMake(x, y, width, hieght) Iszuihuo:i==1?YES:NO Tag:i + 1];
            [view addSubview:imgView];
  
            x += width + 10;
            
        }
    }
    //3
    if (count == 3) {
        
        hieght -=20;
        CGFloat  y = 10;
        CGFloat  x = 10;
        
        for (int i =0 ; i < 3; i++) {
            
            if (i == 0) {
                MCdeleteImgView * imgView =  [self addImgView:CGRectMake(x, y, width, hieght) Iszuihuo:NO Tag:i + 1];
                [view addSubview:imgView];
                
                x += width + 10;
                hieght = (hieght - 10)/2;
  
            }
            else
            {
                
                MCdeleteImgView * imgView =  [self addImgView:CGRectMake(x, y, width, hieght) Iszuihuo:i==2?YES:NO Tag:i + 1];
                [view addSubview:imgView];
                y += hieght + 10;
  
            }
            
            
        }
    }
    //4

    if (count == 4) {
        
        hieght -=20;
        CGFloat  y = 10;
        CGFloat  x = 10;
        hieght = (hieght - 10)/2;
        
        for (int i =0 ; i < 4; i++) {
            
                MCdeleteImgView * imgView =  [self addImgView:CGRectMake(x, y, width, hieght) Iszuihuo:i==3?YES:NO Tag:i + 1];
                [view addSubview:imgView];
                x += width + 10;
            if (i == 1) {
                x = 10;
                y += hieght + 10;
            }
    }
    }
    
    return view;
}
-(MCdeleteImgView*)addImgView:(CGRect)frame Iszuihuo:(BOOL)iszuihuo Tag:(NSInteger)tag{
    MCdeleteImgView * imgView = [[MCdeleteImgView alloc]initWithFrame:frame];
    imgView.deleteBtn.tag = tag;
#pragma mark-删除图片
    [imgView.deleteBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
        UIButton * btn =(UIButton*)sender;
        [_imgViewArray removeObjectAtIndex:btn.tag - 1];
        if (_imgViewArray.count) {
            _tableview.tableHeaderView = nil;
            _tableview.tableHeaderView = [self addHeadView:_imgViewArray.count];
        }
        else
        {
            _tableview.tableHeaderView = nil;
            _tableview.tableHeaderView = [self headView];
        }

        
    }];
    UIImage *tempImg;
    if([_imgViewArray[tag - 1]isKindOfClass:[UIImage class]]){
        tempImg = _imgViewArray[tag - 1];
    }
    else{
       ALAsset *asset=_imgViewArray[tag - 1];
       tempImg =[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
    }

    

    
    imgView.imgView.image =tempImg;
    if (iszuihuo) {
        UIButton * addBtn = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width - 40 - 5, frame.size.height - 40 -5, 40, 40)];
        [addBtn setImage:[UIImage imageNamed:@"-travel-notes_addpicture02"] forState:0];
        [imgView addSubview:addBtn];
        imgView.userInteractionEnabled = YES;
        [addBtn addTarget:self action:@selector(actionImgTap) forControlEvents:UIControlEventTouchUpInside];
    }
   // imgView.imgView.contentMode = UIViewContentModeScaleAspectFit;
    return imgView;
 
}

#pragma mark-点击头像
-(void)actionImgTap{
    UIActionSheet *myActionSheet = [[UIActionSheet alloc]
                                    initWithTitle:nil
                                    delegate:self
                                    cancelButtonTitle:@"取消"
                                    destructiveButtonTitle:nil
                                    otherButtonTitles: @"从相册选择", @"拍照",nil];
    
    [myActionSheet showInView:self.view];
}
#pragma mark-选择从哪里拿照片
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(buttonIndex==2) return;
    
    
    UIImagePickerControllerSourceType sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    if(buttonIndex==1){//拍照
        sourceType=UIImagePickerControllerSourceTypeCamera;
        if (![UIImagePickerController isSourceTypeAvailable:sourceType]){
            kAlertMessage(@"检测到无效的摄像头设备");
            return ;
        }
        
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing=YES;
        picker.sourceType=sourceType;
        picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        
        [self presentViewController:picker animated:YES completion:nil];

        
        
    }
   
    [self btnClick];
    
    
    
}
//图像选取器的委托方法，选完图片后回调该方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image=[info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    //当图片不为空时显示图片并保存图片
    if (image != nil) {
        
        
        
        if (_imgViewArray.count<4) {
            [_imgViewArray addObject:image];
        }
        // _imgViewArray = [NSMutableArray arrayWithArray:assets];
        if (_imgViewArray.count && _imgViewArray.count <5) {
            _tableview.tableHeaderView = nil;
            _tableview.tableHeaderView = [self addHeadView:_imgViewArray.count];
        }

            
            
    }
    

}




-(void)btnClick{
    
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
    picker.maximumNumberOfSelection = 4;
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showEmptyGroups=NO;
    picker.delegate=self;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        
        
        if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
            NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
            return duration >= 4;
        } else {
            return YES;
        }
        
        
        
    }];
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

#pragma mark - ZYQAssetPickerController Delegate
-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    
    NSLog(@"%ld",assets.count);
    for (ALAsset *asset in assets) {
        
        if (_imgViewArray.count <4) {
            [_imgViewArray addObject:asset];
        }
    }
   // _imgViewArray = [NSMutableArray arrayWithArray:assets];
    if (_imgViewArray.count && _imgViewArray.count <5) {
        _tableview.tableHeaderView = nil;
        _tableview.tableHeaderView = [self addHeadView:_imgViewArray.count];
    }
    
}


-(void)assetPickerControllerDidMaximum:(ZYQAssetPickerController *)picker{
    NSLog(@"到达上限");
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 610)
    if (buttonIndex == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
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
