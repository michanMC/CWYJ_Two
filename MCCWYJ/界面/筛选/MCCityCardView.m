//
//  MCCityCardView.m
//  MCCWYJ
//
//  Created by MC on 16/6/8.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MCCityCardView.h"
#import "MCCityCardTableViewCell.h"
#import <Accelerate/Accelerate.h>

@interface MCCityCardView ()<UITableViewDelegate,UITableViewDataSource>{
    
    MCIucencyView *_bgView;
    UITableView * _tableView;
    UIView *_bg2View;
    
    UIButton * _modebtn;
    UIImageView * modeImgview;
    
    CGFloat bg2H;
    
    UIButton * deleteBtn;
    CGRect selfViewframe;
    
    UIImageView * _bgimgView;
    
    
}

@end


@implementation MCCityCardView


-(instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {

        selfViewframe = frame;
//        _bgView =[[MCIucencyView alloc]init];
       _bgView = [[MCIucencyView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
        [_bgView setBgViewColor:[UIColor blackColor]];
        [_bgView setBgViewAlpha:.5];
        
//        _bgView.contentMode = UIViewContentModeScaleAspectFit ;
        [self addSubview:_bgView];
        
        
        
        CGFloat x = 50;
        CGFloat w = Main_Screen_Width -100;
        CGFloat h = 272;
        CGFloat y = (Main_Screen_Height - h)/2;
        
        _bg2View = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
        _bg2View.backgroundColor = [UIColor yellowColor];
        ViewRadius(_bg2View, 3);
        [_bgView addSubview:_bg2View];
        
        _bgimgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, w, h)];
        _bgimgView.contentMode = UIViewContentModeScaleAspectFill;
        _bgimgView.clipsToBounds = YES; // 裁剪边缘

        _bgimgView.image = [self blurryImage:[UIImage imageNamed:@"广州.jpg"] withBlurLevel:0.2];
        
        [_bg2View addSubview:_bgimgView];

        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, w, h - 30)];
        _tableView.delegate= self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.userInteractionEnabled = NO;
        [_bg2View addSubview:_tableView];


        modeImgview = [[UIImageView alloc]initWithFrame:CGRectMake((Main_Screen_Width - 100 - 20)/2, _bg2View.mj_h - 30, 20, 20)];
        modeImgview.image = [UIImage imageNamed:@"icon_more"];
        
        [_bg2View addSubview:modeImgview];
        _modebtn = [[UIButton alloc]initWithFrame:CGRectMake(0, _bg2View.mj_h - 30, _bg2View.mj_w, 30)];
        [_modebtn addTarget:self action:@selector(action_modebtn) forControlEvents:UIControlEventTouchUpInside];
        
        [_bg2View addSubview:_modebtn];
        [self tableViewreloadData];
        
        deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(_bg2View.mj_w - 28, -3, 30, 30)];
        [deleteBtn setImage:[UIImage imageNamed: @"icon_close"] forState:0];
        [_bg2View addSubview:deleteBtn];
        [deleteBtn addTarget:self action:@selector(actionDelete) forControlEvents:UIControlEventTouchUpInside];

        [self action_modebtn];

        
    }
    return self;
}
-(void)actionDelete
{
    
    
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;

    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self removeFromSuperview];
        
    }];
    
    
}
-(void)action_modebtn{
    
    _modebtn.hidden = YES;
    modeImgview.hidden = YES;

    if (bg2H > Main_Screen_Height - _bg2View.mj_y ) {
        
        _tableView.userInteractionEnabled = YES;
        
        [UIView animateWithDuration:0.5 animations:^{
            _bg2View.frame = CGRectMake(_bg2View.mj_x, (Main_Screen_Height - ( Main_Screen_Height - _bg2View.mj_y))/2, _bg2View.mj_w, Main_Screen_Height - _bg2View.mj_y);
            
            _tableView .frame = CGRectMake(0, 0,_bg2View.mj_w, _bg2View.mj_h);
            _bgimgView.frame = CGRectMake(0, 0,_bg2View.mj_w, _bg2View.mj_h);
        }];

    }
    else
    {


        _tableView.userInteractionEnabled = NO;
        [UIView animateWithDuration:0.5 animations:^{
            _bg2View.frame = CGRectMake(_bg2View.mj_x, _bg2View.mj_y, _bg2View.mj_w, bg2H + 30);
            
            _tableView .frame = CGRectMake(0, 0,_bg2View.mj_w, _bg2View.mj_h);
            _bgimgView.frame = CGRectMake(0, 0,_bg2View.mj_w, _bg2View.mj_h);

        }];

 
    }
    
    
    
    
    
    
}
-(void)tableViewreloadData{
    bg2H = 50;
    NSArray * array = @[@"汽车",@"石油化工",@"电子产品",];//dic[@"array"];

    for (NSInteger j = 0; j < 4; j++) {
        
    
    CGFloat x = 10 + 10 + 10;
    CGFloat y  = 30;
    CGFloat w = 10;
    CGFloat h = 24;
    
    CGFloat offx = 10;
    CGFloat offy = 10;
    CGFloat offw = x;
    CGFloat overy = y;
    w = Main_Screen_Width - 100 - x - 10;
    for (NSInteger i = 0; i < array.count; i ++) {
        NSString * str2 = array[i];
        
        CGFloat lblw = [MCIucencyView heightforString:str2 andHeight:h fontSize:14] + 15;
        
        overy = y;
        
        x+=lblw + offx;
        
        
        if (i+1 <array.count) {
            str2 = array[i+1];
            lblw = [MCIucencyView heightforString:str2 andHeight:h fontSize:14] + 15;
            if (x + lblw > w) {
                x = offw;
                y += offy + h;
            }
            
        }
        
    }
    overy +=h + 9;
    

    bg2H+=  15 + overy + 1;
    
    }
    if (bg2H > 272) {
        _tableView.userInteractionEnabled = NO;
        
        

    }
    else
    {
        _modebtn.hidden = YES;
        modeImgview.hidden = YES;
 
        
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count +1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 50;
    }
    NSArray * array = @[@"汽车",@"石油化工",@"电子产品",];//dic[@"array"];
    if (_dataArray.count > indexPath.row - 1) {
        array = _dataArray[indexPath.row - 1];
    }
    else
    {
        return 0;
    }
    

    CGFloat x = 10 + 10 + 10;
    CGFloat y  = 30;
    CGFloat w = 10;
    CGFloat h = 24;
    
    CGFloat offx = 10;
    CGFloat offy = 10;
    CGFloat offw = x;
    CGFloat overy = y;
    w = Main_Screen_Width - 100 - x - 10;
    for (NSInteger i = 0; i < array.count; i ++) {
        NSString * str2 = array[i];
        
        CGFloat lblw = [MCIucencyView heightforString:str2 andHeight:h fontSize:14] + 15;

        
        overy = y;

        
        x+=lblw + offx;
        
        
        if (i+1 <array.count) {
            str2 = array[i+1];
            lblw = [MCIucencyView heightforString:str2 andHeight:h fontSize:14] + 15;
            if (x + lblw > w) {
                x = offw;
                y += offy + h;
            }
            
        }
        
    }
    overy +=h + 9;

    
    return  15 + overy + 1;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MCCityCardTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MCCityCardTableViewCell"];
    if (!cell) {
        cell = [[MCCityCardTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MCCityCardTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row == 0) {
        [cell prepareUI1:_Citystr];
        return cell;

    }
    if (_dataArray.count > indexPath.row - 1) {
      NSArray*  array = _dataArray[indexPath.row - 1];
        
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        [dic setObject:array forKey:@"array"];
        if (indexPath.row == 1) {
            [dic setObject:@"支柱产业" forKey:@"str"];

        }
        if (indexPath.row == 2) {
            [dic setObject:@"艺术" forKey:@"str"];
            
        }
        if (indexPath.row == 3) {
            [dic setObject:@"特产" forKey:@"str"];
            
        }
        if (indexPath.row == 4) {
            [dic setObject:@"名人/历史事件" forKey:@"str"];
            
        }

        
        
        
        [cell prepareUI2:dic];

        
    }
   
    return cell;
    
//    return [[UITableViewCell alloc]init];
}

-(void)setDataArray:(NSMutableArray *)dataArray
{
    
    _dataArray = dataArray;
    
    [_tableView reloadData];
    
    
    
}
- (void)showInWindow{
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app.window addSubview:self];
    self.alpha = 0;
 [UIView animateWithDuration:0.5 animations:^{
//     
     self.alpha = 1;

//
//     
 }];
//
    
    
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
    NSLog(@"boxSize:%i",boxSize);
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
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
