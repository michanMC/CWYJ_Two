//
//  MCDimensionViewController.m
//  MCCWYJ
//
//  Created by MC on 16/6/29.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MCDimensionViewController.h"
#import "MCScanViewController.h"
#import "CommonFunc.h"
#import "GTMBase64.h"
@interface MCDimensionViewController ()
{
    
    
    
    UIView * _bgView;
    UIImageView *_DimensionImgView;
    
    
}

@end

@implementation MCDimensionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"二维码";
    [self Datadetail];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_code"] style:UIBarButtonItemStylePlain target:self action:@selector(actionR)];
    
    // Do any additional setup after loading the view.
}
-(void)actionR{
    
    MCScanViewController * ctl = [[MCScanViewController alloc]init];
    [self pushNewViewController:ctl];
    
}
-(void)Datadetail{
    [self showLoading];
    [self.requestManager postWithUrl:@"api/user/detail.json" refreshCache:NO params:nil IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        
        NSLog(@"查询资料resultDic == %@",resultDic);
        _usermodel  = [YJUserModel mj_objectWithKeyValues:resultDic[@"object"]];
        
        [self prepareUI];
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        NSLog(@"失败");
        
    }];
    
}
-(void)prepareUI{
    
    self.view.backgroundColor = AppMCBgCOLOR;//a[UIColor groupTableViewBackgroundColor];
    
    
    CGFloat x = 40;
    CGFloat w = Main_Screen_Width - 80;
    CGFloat imgw = w - 80;
    CGFloat imgh = imgw;
    CGFloat h = 80 + imgh + 64;
    
    
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(x, 40+64, w, h)];
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _bgView.layer.borderWidth = .5;
    ViewRadius(_bgView, 1);
    [self.view addSubview:_bgView];
    
    x = 10;
    CGFloat y = 10;
    w = 35;
    h = w;
    
    UIImageView * imgView= [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [imgView sd_setImageWithURL:[NSURL URLWithString:_usermodel.raw] placeholderImage:[UIImage imageNamed:@"home_Avatar_60"]];
    [_bgView addSubview:imgView];
    ViewRadius(imgView, w/2);
    x += w + 10;
    w = _bgView.mj_w - x;
    h = 20;
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.text = _usermodel.nickname;
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:16];
    [_bgView addSubview:lbl];
    y += h + 5;
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.text = [NSString stringWithFormat:@"ID:%@",_usermodel.userno];
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:14];
    [_bgView addSubview:lbl];
    
    y = 80;
    x = 40;
    _DimensionImgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, imgw, imgh)];
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:_usermodel.id forKey:@"id"];
    NSString * hid = [MCUserDefaults objectForKey:@"hid"];
    _usermodel.hid =hid;
    if (hid) {
        [dic setObject:_usermodel.hid forKey:@"hid"];

    }
    [dic setObject:_usermodel.nickname forKey:@"nickname"];
    
    ///api/qrcode/error.jhtml?code= + base64加密原json
    
    NSString *ss = [dic mj_JSONString];
    
    NSData *data = [ss dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString* base64Str = [[NSString alloc] initWithData:[GTMBase64 encodeData:data] encoding:NSUTF8StringEncoding];
    
    NSString * datastr = [NSString stringWithFormat:@"%@api/qrcode/error.jhtml?code=%@",AppURL,base64Str];
    NSLog(@"datastr ===== %@",datastr);
        
    
    UIImage *img = [self qrImageForString:datastr imageSize:_DimensionImgView.mj_w waterImageSize:30];
    
    _DimensionImgView.image = img;
    
    [_bgView addSubview:_DimensionImgView];
    
    y += imgh;
    w = _bgView.mj_w;
    h = 64;
    x = 0;
    
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.text = @"扫一扫上面的二维码，加我好友";
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:16];
    [_bgView addSubview:lbl];
    

}
- (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)Imagesize waterImageSize:(CGFloat)waterImagesize{
    
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    CIImage *outPutImage = [filter outputImage];
    
    return [self createNonInterpolatedUIImageFormCIImage:outPutImage withSize:Imagesize waterImageSize:waterImagesize];
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size waterImageSize:(CGFloat)waterImagesize{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef); CGImageRelease(bitmapImage);
    
    //原图
    UIImage *outputImage = [UIImage imageWithCGImage:scaledImage];
    
    UIGraphicsBeginImageContextWithOptions(outputImage.size, NO, [[UIScreen mainScreen] scale]);
    [outputImage drawInRect:CGRectMake(0,0 , size, size)];
    //水印图
    UIImage *waterimage = [UIImage imageNamed:@"icon_imgApp"];
    [waterimage drawInRect:CGRectMake((size-waterImagesize)/2.0, (size-waterImagesize)/2.0, waterImagesize, waterImagesize)];
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newPic;
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
