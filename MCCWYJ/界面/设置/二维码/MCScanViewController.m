//
//  MCScanViewController.m
//  MCCWYJ
//
//  Created by MC on 16/6/29.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MCScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "homeYJModel.h"
#import "AddFriendViewController.h"
#import "CommonFunc.h"
#import "GTMBase64.h"
#import "ZHScanView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScanWidth [UIScreen mainScreen].bounds.size.width - 80
#define lineTop   ([[UIScreen mainScreen] bounds].size.height - [UIScreen mainScreen].bounds.size.width - 80)/2
#define PreviewWidth [UIScreen mainScreen].bounds.size.width - 80

@interface MCScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>
{
    UIImageView *_scanView;
    UITextView *_resultTextView;
    UIImageView *_line;
    
    BOOL _upOrdown;
    NSTimer *_timer;
    int _num;
    
    AVCaptureDevice * device;
    AVCaptureDeviceInput * input;
    AVCaptureMetadataOutput * output;
    AVCaptureSession * session;
    AVCaptureVideoPreviewLayer * preview;

}

@end

@implementation MCScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫描二维码";
//    if ([_teypIndex isEqualToString:@"1"]) {
//        self.title = @"扫描二维码条形码";
//
//    }
    ZHScanView *scanf = [ZHScanView scanViewWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, Main_Screen_Height )];
    scanf.promptMessage = @"扫描二维码";
    if ([_teypIndex isEqualToString:@"1"]) {
        scanf.promptMessage = @"扫描二维码或条形码";

        
    }

    [self.view addSubview:scanf];
    
    [scanf startScaning];
    
    [scanf outPutResult:^(NSString *result) {
        
        NSLog(@"%@",result);
        if ([_teypIndex isEqualToString:@"1"]) {
            if (_delegate) {
                [_delegate MCScanViewStr:result];
                [self.navigationController popViewControllerAnimated:YES ];
                return ;
            }
            
            
            
        }else{

        
        NSString * datastr = [NSString stringWithFormat:@"%@api/qrcode/error.jhtml?code=",AppURL];
        
        NSInteger countstr = datastr.length;
        if (result.length>=countstr) {
            
        }
        else
        {
            return;
        }
        
        NSString * datastringValue = [result substringFromIndex:countstr];
        
        
        NSLog(@"datastringValue == %@",datastringValue);
        
        
        if (!datastringValue.length) {
            return;
        }
        
        NSString *responseString1 =  [datastringValue stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSString *responseString2 = [responseString1 stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        NSString *responseString3 = [responseString2 stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        
        
        NSString* base64Str = [[NSString alloc] initWithData:[GTMBase64 decodeString:responseString3] encoding:NSUTF8StringEncoding];
        
        //    NSString *base64Str =  [CommonFunc textFromBase64String:datastringValue];
        
        NSLog(@"base64Str === %@",[GTMBase64 decodeString:responseString3]);
        
        
        if (!base64Str.length) {
            [self showHint:@"二维码有误！"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
                
            });
            
            
            return;
        }
        
        id r = [self analysis:base64Str];
        NSLog(@"r ==== %@",r);
        
        
        YJUserModel * usermodel = [YJUserModel mj_objectWithKeyValues:r];
        
        NSString *buddyName = usermodel.hid;//[self.dataSource objectAtIndex:indexPath.row];
        AddFriendViewController * ctl = [[AddFriendViewController alloc]init];
        
        ctl.addHid = buddyName;
        ctl.uid = usermodel.id;
        [self pushNewViewController:ctl];
        

        }
        
        
    }];

//    [self initSubviews];
//    [self buildCamera];

    // Do any additional setup after loading the view.
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
//    [session stopRunning];
}
-(void)initSubviews{
    
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.000];
    
    _scanView = [[UIImageView alloc] init];
    _scanView.frame = CGRectMake(40, (Main_Screen_Height - ScanWidth - 64)/2, ScanWidth, ScanWidth);
    _scanView.image = [UIImage imageNamed:@"bg_scanner"];
  //  [self.view addSubview:_scanView];
    
    _upOrdown = NO;
    _num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(40, lineTop,ScanWidth , 1)];
    _line.backgroundColor = [UIColor greenColor];
    _line.layer.cornerRadius = 8;
    [self.view addSubview:_line];
    
    
    
}

-(void)scanAnimation
{
    if (_upOrdown == NO) {
        _num ++;
        [UIView animateWithDuration:.1 animations:^{
            
            _line.frame = CGRectMake(40, lineTop+2*_num, ScanWidth, 1);
        }];
        
        
        if (2*_num >= ScanWidth) {
            _upOrdown = YES;
        }
    }
    else {
        _num --;
        [UIView animateWithDuration:.1 animations:^{
            
            _line.frame = CGRectMake(40, lineTop+2*_num, ScanWidth, 1);
        }];
        
        
        if (_num == 0) {
            _upOrdown = NO;
        }
    }
    
}

- (void)buildCamera
{
    if (!device) {
        device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    
    if (!input) {
        input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    }
    
    if (!output) {
        output = [[AVCaptureMetadataOutput alloc]init];
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    }
    
    if (!session) {
        session = [[AVCaptureSession alloc]init];
        [session setSessionPreset:AVCaptureSessionPresetHigh];
    }
    
    if ([session canAddInput:input])
    {
        [session addInput:input];
    }
    
    if ([session canAddOutput:output])
    {
        [session addOutput:output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    // 预览层
    if (!preview) {
        

        
        
        preview = [AVCaptureVideoPreviewLayer layerWithSession:session];
        preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
        preview.frame = CGRectMake(40,
                                   lineTop,
                                   PreviewWidth,
                                   PreviewWidth);
        
        preview.backgroundColor = [UIColor clearColor].CGColor;
        [self.view.layer insertSublayer:preview atIndex:0];
        
        
        
        
       AVCaptureDevice* device2 = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
       AVCaptureDeviceInput* input2 = [AVCaptureDeviceInput deviceInputWithDevice:device2 error:nil];
       AVCaptureMetadataOutput* output2 = [[AVCaptureMetadataOutput alloc]init];
        [output2 setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
      AVCaptureSession*  session2 = [[AVCaptureSession alloc]init];
        [session2 setSessionPreset:AVCaptureSessionPresetHigh];
        [session2 addInput:input2];
        [session2 addOutput:output2];
        // 条码类型 AVMetadataObjectTypeQRCode
        output2.metadataObjectTypes =@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
        
        
        AVCaptureVideoPreviewLayer*  preview2 = [AVCaptureVideoPreviewLayer layerWithSession:session];
        
        preview2.videoGravity = AVLayerVideoGravityResizeAspectFill;
        
        preview2.frame = CGRectMake(0,
                                    0,
                                    Main_Screen_Width,
                                    Main_Screen_Height);
        
        preview2.backgroundColor = [UIColor clearColor].CGColor;

        [self.view.layer insertSublayer:preview2 atIndex:0];
        

    }
    
    
    _resultTextView.text = @"";
    if (!_timer.isValid) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(scanAnimation) userInfo:nil repeats:YES];
    }
    
    [session startRunning];
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    NSString *stringValue;
    
    if ([metadataObjects count] >0){
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    
    [session stopRunning];
    
    _resultTextView.text = stringValue;
    _line.hidden = YES;
    [_timer invalidate];
    
    NSString * datastr = [NSString stringWithFormat:@"%@api/qrcode/error.jhtml?code=",AppURL];
    
    NSInteger countstr = datastr.length;
    if (stringValue.length>=countstr) {
        
    }
    else
    {
        return;
    }
    
    NSString * datastringValue = [stringValue substringFromIndex:countstr];
    
    
    NSLog(@"datastringValue == %@",datastringValue);
    
    
    if (!datastringValue.length) {
        return;
    }
    
    NSString *responseString1 =  [datastringValue stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *responseString2 = [responseString1 stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    NSString *responseString3 = [responseString2 stringByReplacingOccurrencesOfString:@"\t" withString:@""];

    
    NSString* base64Str = [[NSString alloc] initWithData:[GTMBase64 decodeString:responseString3] encoding:NSUTF8StringEncoding];

//    NSString *base64Str =  [CommonFunc textFromBase64String:datastringValue];
    
    NSLog(@"base64Str === %@",[GTMBase64 decodeString:responseString3]);

    
    if (!base64Str.length) {
        if ([_teypIndex isEqualToString:@"1"]) {
            [self showHint:@"二维码或条形码有误！"];

        }
        else
        [self showHint:@"二维码有误！"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
            
        });

        
        return;
    }
    
   id r = [self analysis:base64Str];
    NSLog(@"r ==== %@",r);
    
    
    YJUserModel * usermodel = [YJUserModel mj_objectWithKeyValues:r];
    
    NSString *buddyName = usermodel.hid;//[self.dataSource objectAtIndex:indexPath.row];
    AddFriendViewController * ctl = [[AddFriendViewController alloc]init];
    
    ctl.addHid = buddyName;
    ctl.uid = usermodel.id;
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
