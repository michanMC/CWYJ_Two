//
//  MakeBuyViewController.m
//  MCCWYJ
//
//  Created by MC on 16/5/21.
//  Copyright © 2016年 MC. All rights reserved.
//
#define NUMBERS @"0123456789.\n"

#import "MakeBuyViewController.h"
#import "ZYQAssetPickerController.h"
#import "MCdeleteImgView.h"
#import "MakeBuyTableViewCell.h"
#import "SearchViewController.h"
#import "AddressViewController.h"
#import "LTPickerView.h"
#import "AddressModel.h"
#import "PaymentViewController.h"
#import "ContactListViewController.h"
#import "PayOfPickModel.h"
@interface MakeBuyViewController ()<ZYQAssetPickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UITextFieldDelegate,UIAlertViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,SearchViewControllerDelegate,AddressViewSeleDegate>
{
    
    UITableView *_tableview;
 
    NSMutableArray *_imgViewArray;
    NSMutableArray * _proTitleList;
    NSInteger _proindex;
    NSMutableArray *_seleFirIDArray1;
    NSMutableArray *_seleFirIDArray2;

    
    NSString * _brandStr;
    NSString * _commodityStr;
    NSString * _modelStr;
    NSString * _colourStr;
    NSString * _priceStr;

    NSString * _countStr;
    
    
    NSString * _percentStr;
    NSString * _addser1Str;

    NSString * _countnumStr;
    NSString * _describefeildStr;

    NSString * _caidianStr;
    
    NSString * _caidianPikcerStr;

    NSString * _juri2Str;

    NSString * _addser2Str;
    
    NSString * _proNameStr;
    
    
    
    
    MCIucencyView*_juriView;

    
    NSInteger _seleindex;
    NSString * _addserid;
    
    
    NSInteger _jiaoyifanshi;
    
    
    
    
    
    BOOL _isercifabu;
    

}

@end

@implementation MakeBuyViewController
static inline CGSize CWSizeReduce(CGSize size, CGFloat limit)   // 按比例减少尺寸
{
    CGSize imgSize = size;
    
    if (size.width > limit) {
        imgSize = CGSizeMake(limit, limit*size.height / size.width);
        
        if (imgSize.height > limit) {
            
            imgSize = CGSizeMake(limit*imgSize.width / imgSize.height, limit );
            
            
        }
        
        
    }
    
    else if (size.height > limit) {
        imgSize = CGSizeMake(limit*size.width / size.height, limit );
        
        if (imgSize.width > limit) {
            imgSize = CGSizeMake(limit, limit*imgSize.height / imgSize.width);
            
        }
        
        
    }
    
    NSLog(@"====%f,%f",imgSize.width,imgSize.height);
    
    
    return imgSize;
    
    
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _proTitleList = [NSMutableArray array];
        _seleFirIDArray1 = [NSMutableArray array];
        _seleFirIDArray2 = [NSMutableArray array];

        for (NSInteger i = 1; i <= 10; i++) {
            NSString * ss = [NSString stringWithFormat:@"%ld",i];
            [_proTitleList addObject:ss];
        }
        _proindex = 2;
        
        _countStr = @"1";
        _percentStr = @"1";
        _proNameStr = @"3";
        _imgViewArray = [NSMutableArray array];
        

    }
    
    return self;
    
}
-(void)setBuyModlel2:(MCBuyModlel *)BuyModlel2
{
    _BuyModlel2 = BuyModlel2;

    NSLog(@"BuyModlel2==%@",BuyModlel2);
    
    NSLog(@"BuyModlel2.imageUrl==%@",BuyModlel2.imageUrl);
    _isercifabu = YES;
    
    if (BuyModlel2.imageUrl.count && BuyModlel2.imageUrl.count <5) {
        
        NSString *url = BuyModlel2.imageUrl[0];
        
        UIImageView * imgview = [[UIImageView alloc]init];
        
        
        [imgview sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            if (image) {
                [_imgViewArray addObject:image];
                
            }
        }];

        
    }

    NSLog(@"_imgViewArray  ===== %@",_imgViewArray);
    
    
    
    _countStr = BuyModlel2.count;
    _brandStr = BuyModlel2.brand;
    _commodityStr = BuyModlel2.name;
    _modelStr = BuyModlel2.model;
    _colourStr = BuyModlel2.color;
    _priceStr = BuyModlel2.price;
    _addser1Str = BuyModlel2.chAddress;
    _addser2Str = BuyModlel2.deliveryAddress;
    _describefeildStr = BuyModlel2.MCdescription;
    _addserid = BuyModlel2.addressId;
    _caidianStr = [NSString stringWithFormat:@"%.2f",[_priceStr floatValue]*[_countStr integerValue]*([_proNameStr floatValue]/100)];

    [_tableview reloadData];
 
    
    
}
-(void)setBuyModlel:(MCBuyModlel *)BuyModlel
{
    
    
    NSLog(@"BuyModlel2.YJphotos==%@",BuyModlel.YJphotos);
    _isercifabu = YES;
    
    if (BuyModlel.YJphotos.count && BuyModlel.YJphotos.count <5) {
        for (YJphotoModel * modle in BuyModlel.YJphotos) {
            UIImageView * imgview = [[UIImageView alloc]init];
            
            [imgview sd_setImageWithURL:[NSURL URLWithString:modle.raw] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                if (image) {
                    [_imgViewArray addObject:image];
                    
                }
            }];
            
            
            
        }
        
        
    }

    
    
    _BuyModlel = BuyModlel;

    _countStr = BuyModlel.Buyjson.count;
    _brandStr = BuyModlel.Buyjson.brand;
    _commodityStr = BuyModlel.Buyjson.name;
    _modelStr = BuyModlel.Buyjson.model;
    _colourStr = BuyModlel.Buyjson.color;
    _priceStr = BuyModlel.Buyjson.price;
    _addser1Str = BuyModlel.Buyjson.address;
   _addser2Str = BuyModlel.deliveryAddress;
//    _brandStr = BuyModlel.Buyjson.brand;
    
    _addserid = BuyModlel.addressId;
    _describefeildStr = BuyModlel.MCdescription;
    
 _caidianStr = [NSString stringWithFormat:@"%.2f",[_priceStr floatValue]*[_countStr integerValue]*([_proNameStr floatValue]/100)];
    
    [_tableview reloadData];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布代购单";
    _jiaoyifanshi = 0;
       [self prepareUI];
    _juriView = [[MCIucencyView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    [_juriView setBgViewColor:[UIColor blackColor]];
    [_juriView setBgViewAlpha:0.5];
    [self.view addSubview:_juriView];
    
    CGFloat x = 40;
    CGFloat h = 180 + 30;
    CGFloat w = Main_Screen_Width - 80;
    CGFloat y = (Main_Screen_Height - 64 - h)/2;
    
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    bgView.backgroundColor = [UIColor whiteColor];
    ViewRadius(bgView, 5);
    [_juriView addSubview:bgView];
    
    y -= 15;
    x = Main_Screen_Width - 40 - 15;
    w = 30;
    h = 30;
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [btn setImage:[UIImage imageNamed:@"icon_close"] forState:0];
    [btn addTarget:self action:@selector(aCtionDele) forControlEvents:UIControlEventTouchUpInside];
    [_juriView addSubview:btn];

    
    x = 10;
    y = 20;
    w = bgView.mj_w - 20;
    h = 60;
    UIView * seleview = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [bgView addSubview:seleview];
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 100, 20)];
    lbl.text = @"公开";
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:16];
    [seleview addSubview:lbl];
    
    
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, 100, 20)];
    lbl.text = @"所有朋友可见";
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:14];
    [seleview addSubview:lbl];
    
    UIButton * seleBtn = [[UIButton alloc]initWithFrame:CGRectMake(seleview.mj_w - 30, 15, 30, 30)];
    [seleBtn setImage:[UIImage imageNamed:@"list_checkbox_normal"] forState:UIControlStateNormal];
    seleBtn.tag = 800;
    [seleBtn addTarget:self action:@selector(actionseleBtn:) forControlEvents:UIControlEventTouchUpInside];
    [seleBtn setImage:[UIImage imageNamed:@"list_checkbox_checked"] forState:UIControlStateSelected];
    seleBtn.selected = YES;
    [seleview addSubview:seleBtn];
    
    
    
    
    
    UIButton * selebtn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, seleview.mj_w - 30, seleview.mj_h)];
    selebtn2.tag = 900;
//    [selebtn2 addTarget:self action:@selector(actionselebtn2:) forControlEvents:UIControlEventTouchUpInside];
    [seleview addSubview:selebtn2];

    
    UIView * lineview =[[UIView alloc]initWithFrame:CGRectMake(0, 59, seleview.mj_w, 1)];
    lineview.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [seleview addSubview:lineview];

    y += h;
    
    
    seleview = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [bgView addSubview:seleview];
     lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 100, 20)];
    lbl.text = @"不给谁看";
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:16];
    [seleview addSubview:lbl];
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, 150, 20)];
    lbl.text = @"选中的朋友不可见";
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:14];
    [seleview addSubview:lbl];
    
    
    
    seleBtn = [[UIButton alloc]initWithFrame:CGRectMake(seleview.mj_w - 30, 15, 30, 30)];
    [seleBtn setImage:[UIImage imageNamed:@"list_checkbox_normal"] forState:UIControlStateNormal];
    seleBtn.tag = 801;
    [seleBtn addTarget:self action:@selector(actionseleBtn:) forControlEvents:UIControlEventTouchUpInside];
    [seleBtn setImage:[UIImage imageNamed:@"list_checkbox_checked"] forState:UIControlStateSelected];
    
    [seleview addSubview:seleBtn];
    
    
    selebtn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, seleview.mj_w - 30, seleview.mj_h)];
    selebtn2.tag = 901;
//    selebtn2.backgroundColor = [UIColor yellowColor];
    [selebtn2 addTarget:self action:@selector(actionselebtn2:) forControlEvents:UIControlEventTouchUpInside];
    [seleview addSubview:selebtn2];
    
    lineview =[[UIView alloc]initWithFrame:CGRectMake(0, 59, seleview.mj_w, 1)];
    lineview.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [seleview addSubview:lineview];
    
    y += h;
    
    seleview = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [bgView addSubview:seleview];
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 100, 20)];
    lbl.text = @"定向发布";
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:16];
    [seleview addSubview:lbl];
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, 150, 20)];
    lbl.text = @"选中的朋友可接单";
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:14];
    [seleview addSubview:lbl];
    seleBtn = [[UIButton alloc]initWithFrame:CGRectMake(seleview.mj_w - 30, 15, 30, 30)];
    [seleBtn setImage:[UIImage imageNamed:@"list_checkbox_normal"] forState:UIControlStateNormal];
    
    [seleBtn setImage:[UIImage imageNamed:@"list_checkbox_checked"] forState:UIControlStateSelected];
    seleBtn.tag = 802;
    
    
    
    [seleBtn addTarget:self action:@selector(actionseleBtn:) forControlEvents:UIControlEventTouchUpInside];
    [seleview addSubview:seleBtn];
    
    
    
    selebtn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, seleview.mj_w - 30, seleview.mj_h)];
//    selebtn2.backgroundColor = [UIColor redColor];

    selebtn2.tag = 903;
    [selebtn2 addTarget:self action:@selector(actionselebtn2:) forControlEvents:UIControlEventTouchUpInside];
    [seleview addSubview:selebtn2];
    
    
    
    
    lineview =[[UIView alloc]initWithFrame:CGRectMake(0, 59, seleview.mj_w, 1)];
    lineview.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [seleview addSubview:lineview];

    _juriView.hidden = YES;
        [self loaddata];

    if (_isercifabu) {
        if (_imgViewArray.count) {
            
            _tableview.tableHeaderView = nil;
            _tableview.tableHeaderView = [self addHeadView:_imgViewArray.count];
        }
        
        
    }
    // Do any additional setup after loading the view.
}
-(void)loaddata{
    
    [self showLoading];
    NSDictionary * dic = @{
                           
                           };
    [self.requestManager postWithUrl:@"api/logistics_address/list.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
        for (NSDictionary * dic in resultDic[@"object"]) {
            
            AddressModel *model = [AddressModel mj_objectWithKeyValues:dic];
            model.MCdescription = dic[@"description"];
            if ([model.status isEqualToString:@"1"]) {
                _addser2Str = [NSString stringWithFormat:@"%@%@%@%@ %@ %@",model.province,model.city,model.region,model.MCdescription ,model.name,model.mobile];
                [_tableview reloadData];
                break;
            }
            
        }
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
    }];
    
    
    
    
    
}

-(void)actionselebtn2:(UIButton*)btn{
    
    
    ContactListViewController * ctl = [[ContactListViewController alloc]init];
    ctl.isSelect = YES;
    ctl.issfabu = YES;

    if (btn.tag == 901) {//选中的朋友不可见
        [_seleFirIDArray1 removeAllObjects];
        ctl.seleFirIDArray = _seleFirIDArray1;

    }
    else if (btn.tag == 903){//定向
        [_seleFirIDArray2 removeAllObjects];

        ctl.seleFirIDArray = _seleFirIDArray2;

        
    }
//    _userModel.raw = _userModel.thumbnail;
//    ctl.userDatamodle = _userModel;
    [self pushNewViewController:ctl];

    
}
-(void)actionseleBtn:(UIButton*)btn{
    for (NSInteger i = 800; i < 803; i++) {
        UIButton * btn1 = [self.view viewWithTag:i];
        btn1.selected = NO;
    }
    if (btn.tag == 800) {
        _juri2Str = @"公开";
    }
    else if (btn.tag == 801){
        _juri2Str = @"选中的朋友不可见";

    }
    else if (btn.tag == 802){
        _juri2Str = @"选中的朋友可接单";
        
    }

    btn.selected = YES;
    [_tableview reloadData];
}
-(void)aCtionDele{
    _juriView.hidden = YES;
}
-(void)prepareUI{
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64 -50)];
    _tableview.tableHeaderView = [self headView];
    _tableview.delegate =self;
    _tableview.dataSource = self;
    [self.view addSubview:_tableview];
    [self preparefooerView];
    

    
}
-(void)preparefooerView{
//    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 200)];
//    _tableview.tableFooterView = view;
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, Main_Screen_Height - 44, Main_Screen_Width, 44)];
    btn.backgroundColor = AppCOLOR;
    [btn setTitle:@"下一步" forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(actionnext) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:btn];
    
    
}
-(UIView*)headView{
    CGFloat width = (Main_Screen_Width - 30)/2;
    CGFloat hieght = width + 20;
    
    UIView * view =[[ UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, hieght)];
    view.backgroundColor =AppMCBgCOLOR;//[UIColor groupTableViewBackgroundColor];
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
-(void)actionnext{
//    [self showLoading];

    if (!_imgViewArray.count) {
        [self showHint:@"亲，至少上传一张图片哦"];
        return;

    }
    NSLog(@"_brandStr = %@",_brandStr);
//    if (!_brandStr.length) {
//        [self showHint:@"请输入品牌"];
//        return;
//    }
    NSLog(@" _commodityStr  =%@",_commodityStr);
    if (!_commodityStr.length) {
        [self showHint:@"请输入商品名"];
        return;
    }

    NSLog(@" _modelStr == %@",_modelStr);
//    if (!_modelStr.length) {
//        [self showHint:@"请输入型号"];
//        return;
//    }

    NSLog(@"_colourStr = %@",_colourStr);
//    if (!_colourStr.length) {
//        [self showHint:@"请输入颜色"];
//        return;
//    }

    NSLog(@" _priceStr  = %@",_priceStr);
    if (!_priceStr.length) {
        [self showHint:@"请输入单价"];
        return;
    }

    NSLog(@"_countStr = %@",_countStr);
    if (!_countStr.length) {
        [self showHint:@"请输入数量"];
        return;
    }


    NSLog(@"_percentStr = %@",_percentStr);
    if (!_percentStr.length) {
        [self showHint:@"请选择价钱浮动"];
        return;
    }
    

    NSLog(@"_addser1Str = %@",_addser1Str);
//    _addser1Str = @"广州";
    if (!_addser1Str.length) {
        [self showHint:@"请选择代购点"];
        return;
    }
    if (!_addserid.length) {
        [self showHint:@"无效的代购点id"];
        return;
    }


    NSLog(@"_describefeildStr = %@",_describefeildStr);
    if (!_describefeildStr.length) {
        _describefeildStr = @"";
    }

    NSLog(@"_caidianStr = %@",_caidianStr);
    if (!_caidianStr.length) {
        [self showHint:@"请选择采点范围"];
        return;
    }

    NSLog(@"_addser2Str = %@",_addser2Str);
    if (_jiaoyifanshi == 0) {
        
    if (!_addser2Str.length) {
        [self showHint:@"请设置地址"];
        return;
    }
    }
    else
    {
        
    }
    NSString * josnStr = @"";
    NSInteger seleindex = 800;
    for (NSInteger i = 800; i < 803; i++) {
        UIButton * btn1 = [self.view viewWithTag:i];
        if (btn1.selected) {
            seleindex = i;
            break;
        }
    }
    if (seleindex == 801) {
        NSLog(@"_seleFirIDArray1 == %@",_seleFirIDArray1);
                if (_seleFirIDArray1.count) {
        NSString * str = [_seleFirIDArray1 componentsJoinedByString:@","];
        NSDictionary * dic = @{
                               @"type":@"see",
                               @"ids":str?str:@""
                               };
        josnStr = [dic mj_JSONString];
                }
                else{
        josnStr = @"";
                }
        
    }
    else if (seleindex == 802){
        NSLog(@"_seleFirIDArray2 == %@",_seleFirIDArray2);
        if (_seleFirIDArray2.count) {

        NSString * str = [_seleFirIDArray2 componentsJoinedByString:@","];
        
        NSDictionary * dic = @{
                               @"type":@"pick",
                               @"ids":str?str:@""
                               };
        josnStr = [dic mj_JSONString];
        }
        else
        {
           josnStr = @"";
        }
        
    }
    else
    {
        josnStr = @"";
    }

    [self showLoading];

    
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
        UIImage *img2 = [[UIImage alloc]init];;

        CGSize imgSize = CWSizeReduce(tempImg.size, 1000);
        
        img2 = [self imageCompressForSize:tempImg targetSize:imgSize];
        
        
        
        [imgArray addObject:img2];
        
    }
    NSString * _proNameStrF = [NSString stringWithFormat:@"%.2f", [_proNameStr floatValue]/100];
    
    
    NSDictionary * dic = @{
                         @"address":_addser1Str,
                         @"brand":_brandStr?_brandStr:@"",
                         @"title":_commodityStr,
                         @"model":_modelStr?_modelStr:@"",
                         @"name":_commodityStr,
                         @"color":_colourStr?_colourStr:@"",
                         @"price":_priceStr,
                         @"count":_countStr,
                         @"description":_describefeildStr,
                         @"priceFloat":_percentStr,
                         @"deliveryAddress":_addser2Str?_addser2Str:@"",
                         @"percent":_proNameStrF,
                         @"addressId":_addserid?_addserid:@"",
                         @"json":josnStr
                         
                         };
    if (josnStr.length) {
        dic = @{
                @"address":_addser1Str,
                @"brand":_brandStr?_brandStr:@"",
                @"title":_commodityStr,
                @"model":_modelStr?_modelStr:@"",
                @"name":_commodityStr,
                @"color":_colourStr?_colourStr:@"",
                @"price":_priceStr,
                @"count":_countStr,
                @"description":_describefeildStr,
                @"priceFloat":_percentStr,
                @"deliveryAddress":_addser2Str,
                @"percent":_proNameStrF,
                @"addressId":_addserid?_addserid:@"",
                @"json":josnStr
                
                };

    }
    else
    {
        dic = @{
                @"address":_addser1Str,
                @"brand":_brandStr?_brandStr:@"",
                @"title":_commodityStr,
                @"model":_modelStr?_modelStr:@"",
                @"name":_commodityStr,
                @"color":_colourStr?_colourStr:@"",
                @"price":_priceStr,
                @"count":_countStr,
                @"description":_describefeildStr,
                @"priceFloat":_percentStr,
                @"deliveryAddress":_addser2Str,
                @"percent":_proNameStrF,
                @"addressId":_addserid?_addserid:@""
                
                };

    }
    
    NSLog(@"_caidianStr === %@",_caidianStr);
    NSMutableDictionary * pamDic = [NSMutableDictionary dictionary];
    
    
    [pamDic setObject:_countStr forKey:@"count"];
    [pamDic setObject:_addser2Str forKey:@"address"];
    [pamDic setObject:_caidianStr forKey:@"caidianStr"];

    

[self.requestManager uploadWithImage:imgArray url:@"api/buy/addPick.json" filename:nil name:@"file" mimeType:@"image/png" parameters:dic progress:^(int64_t bytesWritten, int64_t totalBytesWritten) {
    
    NSLog(@"bytesWritten =%zd",bytesWritten);
    
    NSLog(@"totalBytesWritten =%zd",totalBytesWritten);

} success:^(id resultDic) {
        [self stopshowLoading];
    NSLog(@"resultDic ====  %@",resultDic);
    /*
    object = {
        userIntetral = 0;
        subSystemIntegral = 4;
        targetId = 194;
        totalPrice = 42.75;
        remainPrice = 38.75;
        systemIntegral = 55;
        subUserIntegral = 0;
     */
    PayOfPickModel * model = [PayOfPickModel mj_objectWithKeyValues:resultDic[@"object"]];
    
        PaymentViewController * ctl = [[PaymentViewController alloc]init];
//    MCBuyModlel * modle = [[MCBuyModlel alloc]init];
//    modle.price =_priceStr;
//   ctl.BuyModlel = modle;
//   ctl.datadic = pamDic;
//    MCBuyModlel * model = [MCBuyModlel alloc]init;
//    model.id = _PickModel.targetId;
//    ctl.BuyModlel = model;

    ctl.typeIndex = @"1";
    ctl.buyIdStr = model.targetId;
    
    
    
    [self pushNewViewController:ctl];

    
    NSLog(@"resultDic == %@",resultDic);
} fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
           [self stopshowLoading];
    NSLog(@"description === %@",description);
    
}];
    
    
    

    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        CGFloat selfViewH1 = 44 * 3 + 10 + 10 +20 +5;
        return selfViewH1;
    }
    if (indexPath.row == 1) {
        CGFloat selfViewH = 44 * 1 + 10 +20;
        return selfViewH;

    }
    if (indexPath.row == 2) {
        return 150;
        
    }
    if (indexPath.row == 3) {
        CGFloat selfViewH = 20 + 20 + 100 +10 + 20;
        return selfViewH;

    }
    if (indexPath.row == 5) {
        CGFloat selfViewH = 20 + 44 + 44 + 30;
        return selfViewH;
        
    }


    return 44;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellid1 = @"MakeBuyTableViewCell";
    MakeBuyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
    if (!cell) {
        cell = [[MakeBuyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (indexPath.row == 0) {
        [cell prepareUI1];
        NSString * str = _brandStr?_brandStr:@"品牌";
        [cell.brandBtn setTitle:str forState:0];
        cell.brandBtn.tag = 200;
        [cell.brandBtn addTarget:self action:@selector(actionbrandBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [cell.addBtn addTarget:self action:@selector(actionaddBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell.minBtn addTarget:self action:@selector(actionaddBtn:) forControlEvents:UIControlEventTouchUpInside];
        cell.addBtn.tag = 90;
        cell.minBtn.tag = 91;


        
        cell.commodityfield.tag = 300;
        cell.commodityfield.text = _commodityStr;
        cell.commodityfield.delegate = self;
        
        cell.modelfield.tag = 301;
        cell.modelfield.text = _modelStr;
        cell.modelfield.delegate = self;

        
        cell.colourfield.tag = 302;
        cell.colourfield.text = _colourStr;
        cell.colourfield.delegate = self;

        
        cell.pricefield.tag = 303;
        cell.pricefield.text = _priceStr;
        cell.pricefield.delegate = self;

        cell.countfield.tag = 304;
        cell.countfield.text = _countStr?_countStr:@"1";
        cell.countfield.delegate = self;
        
        
        if (_commodityStr.length && _modelStr.length&&_colourStr.length&&_priceStr.length&&_countStr.length&&_brandStr.length) {
            
            cell.hongdianView.backgroundColor = AppCOLOR;
        }
        else
        {
            cell.hongdianView.backgroundColor = [UIColor groupTableViewBackgroundColor];

        }
        return cell;


    }
    if (indexPath.row == 1) {
        [cell prepareUI2];
        [cell.percentBtn setTitle:[NSString stringWithFormat:@"%@%@",_percentStr,@"%"] forState:0];
        [cell.percentBtn addTarget:self action:@selector(actionpercentBtn) forControlEvents:UIControlEventTouchUpInside];
        cell.addserBtn.tag = 600;
        [cell.addserBtn addTarget:self action:@selector(actionaddserBtnBtn:) forControlEvents:UIControlEventTouchUpInside];
        if (_addser1Str) {
            [cell.addserBtn setTitle:_addser1Str forState:0];

        }
        else
        {
            [cell.addserBtn setTitle:@"代购点" forState:0];

        }
        
        if (_percentStr.length && _addser1Str.length) {
            
            cell.hongdianView.backgroundColor = AppCOLOR;
        }
        else
        {
            cell.hongdianView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            
        }
        

        return cell;

        

    }
    if (indexPath.row == 2) {
        [cell prepareUI3];
        cell.caidianPikcerView.dataSource = self;
        cell.caidianPikcerView.delegate = self;
        
        cell.describefeildView.tag = 201;
        cell.describefeildView.text = _describefeildStr;
        _countnumStr = [NSString stringWithFormat:@"%ld/500",_describefeildStr.length];
        
        cell.countLbl.text = _countnumStr?_countnumStr:@"0/500";
        
        cell.countLbl.tag = 20;
        
        cell.describefeildView.delegate = self;
        
        cell.hongdianView.tag = 30;
        if (_describefeildStr.length) {
            
            cell.hongdianView.backgroundColor = AppCOLOR;
        }
        else
        {
            cell.hongdianView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            
        }

        return cell;
  
    }
    if (indexPath.row == 3) {
        
        [cell prepareUI4];
        NSString*  _proNameStr = [_proTitleList objectAtIndex:_proindex];
        if (_priceStr.length &&_countStr.length ) {
            NSLog(@">>>>>>>>>>>%.2f",[_priceStr floatValue]*[_countStr integerValue]*([_proNameStr floatValue]/100));
            
            _caidianStr = [NSString stringWithFormat:@"%.2f",[_priceStr floatValue]*[_countStr integerValue]*([_proNameStr floatValue]/100)];
        }

        cell.caidianLbl.text = _caidianStr?_caidianStr:@"0";
        
        
        cell.caidianLbl.adjustsFontSizeToFitWidth = YES;
            cell.caidianPikcerView.dataSource = self;
           cell.caidianPikcerView.delegate = self;
        
        [cell.caidianPikcerView selectRow:_proindex inComponent:0 animated:NO];
        
        if (_caidianStr.length) {
            
            cell.hongdianView.backgroundColor = AppCOLOR;
        }
        else
        {
            cell.hongdianView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            
        }
        return cell;

    }
    if (indexPath.row == 4) {
        
        [cell prepareUI5];
        
        cell.juri2Lbl.text = _juri2Str?_juri2Str:@"公开";
       
        return cell;
    }
    if (indexPath.row == 5) {
        
        [cell prepareUI6];
        cell.addserLbl.text = _addser2Str?_addser2Str:@"请设置地址";
        
        [cell.seleBtn addTarget:self action:@selector(actionJoaoyi) forControlEvents:UIControlEventTouchUpInside];
        if (_jiaoyifanshi == 0) {
            cell.seleBtn1.selected = NO;
            cell.adderbgView.hidden = NO;
        }
        else
        {
            cell.seleBtn1.selected = YES;
            cell.adderbgView.hidden = YES;


        }
        [cell.adderseleBtn addTarget:self action:@selector(seleAdderBtn) forControlEvents:UIControlEventTouchUpInside];
        
        if (_addser2Str.length) {
            
            cell.hongdianView.backgroundColor = AppCOLOR;
        }
        else
        {
            cell.hongdianView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            
        }
        
    }




    return cell;
    
    
    return [[UITableViewCell alloc]init];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row == 4) {
        [self shoujianpan];
        _juriView.hidden = NO;
        
        
    }
    if (indexPath.row == 5) {
        [self shoujianpan];

//        AddressViewController * ctl = [[AddressViewController alloc]init];
//        
//        ctl.isSele = YES;
//        ctl.degate = self;
//        [self pushNewViewController:ctl];

    }
    
    
    
}
-(void)seleAdderBtn{
    [self shoujianpan];
    
            AddressViewController * ctl = [[AddressViewController alloc]init];
    
            ctl.isSele = YES;
            ctl.degate = self;
            [self pushNewViewController:ctl];

}
-(void)actionJoaoyi{
    [self shoujianpan];

    if (_jiaoyifanshi == 0) {
        _jiaoyifanshi = 1;
    }
    else
    {
        _jiaoyifanshi = 0;

    }
    [_tableview reloadData];
}
-(void)seleAddressModel:(AddressModel *)modle
{
    _addser2Str = [NSString stringWithFormat:@"%@%@%@%@ %@ %@",modle.province,modle.city,modle.region,modle.MCdescription ,modle.name,modle.mobile];
    [_tableview reloadData];
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }
    
    
    NSString * aString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    if ([aString length] > 500) {
        //[_tableview reloadData];
        
        
        return NO;
    }
//    NSInteger count = 500 -aString.length;
    NSInteger count = aString.length;
    UILabel * cc = [self.view viewWithTag:20];
    cc.text = [NSString stringWithFormat:@"%zd/500",count];
    UIView * view = [self.view viewWithTag:30];

    if (count) {
        view.backgroundColor = AppCOLOR;
 
    }
    else
    {
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
 
    }
    
    return YES;
    
    
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    
    _describefeildStr = textView.text;
    UIView * view = [self.view viewWithTag:30];
    
    if (_describefeildStr.length) {
        view.backgroundColor = AppCOLOR;
        
    }
    else
    {
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
    }

//   [_tableview reloadData];
    
}
-(void)actionpercentBtn{
    [self shoujianpan];
    
    LTPickerView* pickerView = [LTPickerView new];
    NSMutableArray * array = [NSMutableArray array];
    for (NSInteger i = 1; i <= 100; i++) {
        NSString * ss = [NSString stringWithFormat:@"%ld",i];
        [array addObject:ss];
    }
    pickerView.dataSource = array;//@[@"1",@"2",@"3",@"4",@"5"];//设置要显示的数据
    pickerView.defaultStr = _percentStr;//默认选择的数据
    [pickerView show];//显示
    __block NSString * weakStr = _percentStr;
    __weak UITableView * weaktableView = _tableview;

    //回调block
    pickerView.block = ^(LTPickerView* obj,NSString* str,int num){
        //obj:LTPickerView对象
        //str:选中的字符串
        //num:选中了第几行
        NSLog(@"选择了第%d行的%@",num,str);
        
        _percentStr = str;
        [weaktableView reloadData];
    
    };
 
    
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self shoujianpan];
    return YES;
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField.tag ==303) {
        
    
    NSCharacterSet *cs;
    
    cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    
    if(!basicTest)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请输入数字"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        
        [alert show];
        return NO;
    }
    
    
    
    
    
    if ([string isEqualToString:@"\n"]){
        [textField resignFirstResponder];
        return NO;
    }
    NSString * aString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    
    if ([string isEqualToString:@"."]) {
        if([textField.text rangeOfString:@"."].location !=NSNotFound)//_roaldSearchText
        {
            
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"输入有误"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            
            [alert show];
            return NO;
            
        }
        else
        {
            
            
            
        }
    }
    
    
    NSLog(@"aString ===%.2f",[aString floatValue]);
    
//    if ([aString floatValue]>100000.00) {
//        textField.text = @"100000";
//        return NO;
//    }
     if([aString floatValue]<1){
        textField.text = @"1";
//         UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                         message:@"单价金额一元以上"
//                                                        delegate:nil
//                                               cancelButtonTitle:@"确定"
//                                               otherButtonTitles:nil];
//         
//         [alert show];
        
    }
    
    
    return YES;
    }
    return YES;
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 300) {
        _commodityStr = textField.text;
    }
    else if(textField.tag == 301){
        _modelStr = textField.text;
        
    }
    else if(textField.tag == 302){
        _colourStr = textField.text;
        
    }
    else if(textField.tag == 303){
        _priceStr = textField.text;
        
    }
    else if(textField.tag == 304){
        if ([textField.text isEqualToString:@"0"]||!textField.text.length) {
            textField.text = @"1";
        }
        
        NSInteger textStr = [textField.text integerValue];
        
        
        NSInteger goodsMaxCount = [[MCUserDefaults objectForKey:@"goodsMaxCount"] integerValue];
        if (goodsMaxCount < textStr ) {
            [self showHint:@"亲，超过了最大限数"];
            textField.text = @"200";
        }

        
        
        _countStr = textField.text;
        
    }


    [_tableview reloadData];
}
-(void)actionaddBtn:(UIButton*)btn{
    [self shoujianpan];
    UITextField * text = [self.view viewWithTag:304];

    if (btn.tag == 90) {
       
       NSInteger i = [_countStr integerValue];
        i ++;
       NSInteger goodsMaxCount = [[MCUserDefaults objectForKey:@"goodsMaxCount"] integerValue];
        if (goodsMaxCount < i ) {
            [self showHint:@"亲，超过了最大限数"];
            i = 200;
        }
        _countStr = [NSString stringWithFormat:@"%ld",i];
        text.text = _countStr;

    }
    else
    {
        NSInteger i = [_countStr integerValue];
        i --;
        if (i <=0) {
            i = 1;
        }
        _countStr = [NSString stringWithFormat:@"%ld",i];
        text.text = _countStr;
  
    }
    [_tableview reloadData];
}
-(void)actionbrandBtn:(UIButton*)btn{
    [self shoujianpan];
    _seleindex = 1;
    SearchViewController  * ctl = [[SearchViewController alloc]init];
    ctl.delegate = self;
    ctl.SearchType = SearchType_brand;
    [self pushNewViewController:ctl];

    
}
-(void)actionaddserBtnBtn:(UIButton*)btn{
    
    [self shoujianpan];
    _seleindex = 2;
    SearchViewController  * ctl = [[SearchViewController alloc]init];
    ctl.delegate = self;
    ctl.SearchType = SearchType_POP;
    [self pushNewViewController:ctl];

    
}
-(void)selectTitleModel:(jingdianModel *)model
{
    if (_seleindex == 1) {
        _brandStr = model.nameChs;

    }
    else
    {
        _addser1Str = model.nameChs;
        _addserid = model.id;

    }
    [_tableview reloadData];
    
}
-(void)selectTitleStr:(NSString *)str
{
    _brandStr = str;
    UIButton * btn = [self.view viewWithTag:200];
    [btn setTitle:str forState:0];
}
-(void)shoujianpan{
    
    for (NSInteger i = 0; i < 5; i++) {
        NSInteger tag = i + 300;
        UITextField * text = [self.view viewWithTag:tag];
        [text resignFirstResponder];
        
    }
    UITextView * textv = [self.view viewWithTag:201];
    [textv resignFirstResponder];

    
}
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [_proTitleList count];
}
// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    

    return 60;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 20;
    
}
//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    
        return [_proTitleList objectAtIndex:row];
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self shoujianpan];
    _proNameStr = [_proTitleList objectAtIndex:row];
    NSLog(@"====%@",_proNameStr);
    
    _proindex = row;
    [self pickerStr];
    
    
    
}
-(void)pickerStr{
    [self shoujianpan];

    
    NSString*  _proNameStr = [_proTitleList objectAtIndex:_proindex];

    if (_priceStr.length &&_countStr.length ) {
        NSLog(@">>>>>>>>>>>%.2f",[_priceStr floatValue]*[_countStr integerValue]*([_proNameStr floatValue]/100));
        
        _caidianStr = [NSString stringWithFormat:@"%.2f",[_priceStr floatValue]*[_countStr integerValue]*([_proNameStr floatValue]/100)];
        [_tableview reloadData];
    }
  
    
    
    
}
-(UIView *)addHeadView:(NSInteger)count{
    
    CGFloat width = (Main_Screen_Width - 30)/2;
    CGFloat hieght = width + 20;
    
    UIView * view =[[ UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, hieght)];
    view.backgroundColor =AppMCBgCOLOR;//[UIColor groupTableViewBackgroundColor];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//等比例压缩
-(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
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
