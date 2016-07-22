//
//  liulanViewController.m
//  CWYouJi
//
//  Created by MC on 15/11/9.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "liulanViewController.h"
#import "UIImageView+LBBlurredImage.h"
#import "UIButton+WebCache.h"
#import "zuopinQxTableViewCell.h"
#import "zuopinQx2TableViewCell.h"
#import "HZPhotoBrowser.h"
@interface liulanViewController ()<UITableViewDataSource,UITableViewDelegate,HZPhotoBrowserDelegate>{
    UIButton * _backBtn;
    UILabel *_titleLbl;
    UITableView *_tableView;
    
}
@property(nonatomic,strong)UIImageView *imgview;

@end

@implementation liulanViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       // _imgViewArray = [NSArray array];
        
    }
    return self;
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    
   }

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self prepareUI];
    // Do any additional setup after loading the view.
}

-(void)prepareUI{
    _imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    [self.view addSubview:_imgview];
    UIImage *bgimg;
    
    if (_imgViewArray.count) {
        bgimg = _imgViewArray[0];
    }
    else{
        bgimg = [UIImage imageNamed:@"login_bg_720"];
    }
    
    NSLog(@">>>%@",_imgViewArray);
    
    
    
    [self.imgview setImageToBlur:bgimg Url:@""
                      blurRadius:kLBBlurredImageDefaultBlurRadius
                 completionBlock:^(){
                     NSLog(@"The blurred image has been set");
                 }];
    
    
    _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 23, 35, 35)];
    [_backBtn setImage:[UIImage imageNamed:@"nav_icon_back"] forState:UIControlStateNormal];
    [self.view addSubview:_backBtn];
    [_backBtn addTarget:self action:@selector(actionBackBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, Main_Screen_Width, 20)];
    lbl.text = @"游记浏览";
    lbl.textColor = [UIColor whiteColor];
    lbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lbl];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(40, 0, Main_Screen_Width - 80, Main_Screen_Height ) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate= self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.tableHeaderView = [self addHeadView:_imgViewArray.count];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];

    
    
}
-(UIView*)addHeadView:(NSInteger)indexCount{
    UIView * bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width - 80, Main_Screen_Width - 80 + 80)];
    
    UIView *imgbgView = [[UIView alloc]initWithFrame:CGRectMake(0, 80, Main_Screen_Width - 80, Main_Screen_Width - 80)];
    
    [bgview addSubview:imgbgView];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imgbgView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = imgbgView.bounds;
    maskLayer.path = maskPath.CGPath;
    imgbgView.layer.mask = maskLayer;
    
    
    
    CGRect imgfram;
    if (indexCount == 1) {
        imgfram = CGRectMake(0, 0, Main_Screen_Width - 80, Main_Screen_Width - 80);
        UIButton * imgView =[self addImgView:imgfram ImgStr:@"travels-details_default-chart01" ImgUrlStr:_imgViewArray[0]];
        imgView.tag = 400;
        [imgView addTarget:self action:@selector(showTupian:) forControlEvents:UIControlEventTouchUpInside];

        [imgbgView addSubview:imgView];
    }
    else if(indexCount == 2){
        
        for (int  i = 0; i < 2 ; i++) {
            
            imgfram = CGRectMake(((Main_Screen_Width - 80 - 2)/2 + 2) *i, 0, (Main_Screen_Width - 80 - 2)/2, Main_Screen_Width - 80);
            UIButton * imgView =[self addImgView:imgfram ImgStr:@"travels-details_default-chart02" ImgUrlStr:_imgViewArray[i]];
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
            
            imgfram = CGRectMake(x, y, width, height);
            if (i==0) {
                UIButton * imgView =[self addImgView:imgfram ImgStr:@"travels-details_default-chart02" ImgUrlStr:_imgViewArray[i]];
                [imgbgView addSubview:imgView];
                x +=width + 2;
                height = (height-2)/2;
                imgView.tag = 400 +i;
                [imgView addTarget:self action:@selector(showTupian:) forControlEvents:UIControlEventTouchUpInside];

            }
            else
            {
                UIButton * imgView =[self addImgView:imgfram ImgStr:@"home_banner_default-chart" ImgUrlStr:_imgViewArray[i]];
                imgView.tag = 400 +i;
                [imgView addTarget:self action:@selector(showTupian:) forControlEvents:UIControlEventTouchUpInside];

                [imgbgView addSubview:imgView];
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
            
            imgfram = CGRectMake(x, y, width, height);
            
            UIButton * imgView =[self addImgView:imgfram ImgStr:@"home_banner_default-chart" ImgUrlStr:_imgViewArray[i]];
            imgView.tag = 400 +i;
            [imgView addTarget:self action:@selector(showTupian:) forControlEvents:UIControlEventTouchUpInside];

            [imgbgView addSubview:imgView];
            x += width + 2;
            if (i == 1) {
                y += height + 2;
                x = 0;
            }
            
        }
        
    }
    return bgview;
    
}

-(UIButton*)addImgView:(CGRect)imgFrame ImgStr:(NSString*)imgStr ImgUrlStr:(UIImage*)imgUrlStr{
    UIButton * imgView = [[UIButton alloc]initWithFrame:imgFrame];
     imgView.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [imgView setImage:imgUrlStr forState:0];
    
    //[imgView sd_setBackgroundImageWithURL:[NSURL URLWithString:imgUrlStr] forState:0 placeholderImage:[UIImage imageNamed:imgStr]];
    
    return imgView;
}
#pragma mark-浏览图片
-(void)showTupian:(UIButton*)btn{
    
    NSInteger index = btn.tag - 400;
    
    //启动图片浏览器
    HZPhotoBrowser *browserVc = [[HZPhotoBrowser alloc] init];
    browserVc.sourceImagesContainerView = self.view; // 原图的父控件
    browserVc.imageCount = _imgViewArray.count; // 图片总数
    browserVc.currentImageIndex =(int)index;
    browserVc.delegate = self;
    [browserVc show];
    
    
}
#pragma mark - photobrowser代理方法
- (UIImage *)photoBrowser:(HZPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return _imgViewArray[index];//[UIImage imageNamed:@"login_bg_720"];
}

//- (NSURL *)photoBrowser:(HZPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
//{
//    // NSString * imgurl = [NSString stringWithFormat:@"%@%@",AppURL,imgArray[index]];
//    
//    return [NSURL URLWithString:@""];
//}
//

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
        return 1;
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        CGFloat h = [MCIucencyView heightforString:_title2Str andWidth:Main_Screen_Width - 80 - 30 fontSize:13];
        
        return 185 - 20 + h;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static  NSString * cellid1 = @"mc1";
        zuopinQxTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
        if (!cell) {
            cell = [[zuopinQxTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid1];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_titleStr.length > 11) {//第一行大概11个字
        cell.titleStr = [_titleStr substringToIndex:11];
        cell.subTitleStr = [_titleStr substringFromIndex:11];
        
    }
    else
    {
        cell.titleStr = _titleStr;
        cell.subTitleStr = @"";
 
    }
    cell.dataStr = _title2Str;
        
    cell.dingweiStr= _jingdianStr;
    if ([[_dataDic objectForKey:@"isRecommend"] integerValue] == 700) {
        cell.tuijanImgStr= @"荐";
    }
    else
    {
        cell.tuijanImgStr= @"踩";

    }
    cell.ishiddenShouC = YES;
    
//    cell.timeStr = [[_dataDic objectForKey:@"startTime"] substringToIndex:10];
    NSRange  Range = {5,5};
  cell.timeStr =  [[_dataDic objectForKey:@"startTime"] substringWithRange:Range];
    
    NSString* classify = @"";

    if ([[_dataDic objectForKey:@"classify"] isEqualToString:@"东西好吃得不要不要的"]||[[_dataDic objectForKey:@"classify"] isEqualToString:@"食之无味，弃之也不浪费"])
        classify = @"食1";
    if ([[_dataDic objectForKey:@"classify"] isEqualToString:@"三星级的价格，五星级的享受"]||[[_dataDic objectForKey:@"classify"] isEqualToString:@"除了不淋雨，其实就是天桥底"])
        classify = @"住1";
    if ([[_dataDic objectForKey:@"classify"] isEqualToString:@"景美，我和我的小伙伴都惊呆了！"]||[[_dataDic objectForKey:@"classify"] isEqualToString:@"世界有多大，此景有多差！"])
        classify = @"景1";
    if ([[_dataDic objectForKey:@"classify"] isEqualToString:@"买买买"]|[[_dataDic objectForKey:@"classify"] isEqualToString:@"钱包好空虚，宝宝好委屈"])
        classify = @"购";

    
    
    cell.keyImgStr = classify;
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];

    cell.nameLStr = [defaults objectForKey:@"nickname"];
    NSLog(@"%@",[defaults objectForKey:@"nickname"]);
    
    cell.headimgStr =[defaults objectForKey:@"thumbnail"];
    
    
    
    
    
    
    
        CGFloat h = [MCIucencyView heightforString:_title2Str andWidth:Main_Screen_Width - 80 - 30 fontSize:13];
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, Main_Screen_Width - 80, 185 - 20 + h) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame =CGRectMake(0, 0, Main_Screen_Width - 80, 185 - 20 + h);
        maskLayer.path = maskPath.CGPath;
        cell.layer.mask = maskLayer;
        
        return cell;
}

#pragma mark-返回
-(void)actionBackBtn{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
