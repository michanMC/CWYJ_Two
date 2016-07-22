//
//  MCDrawBackViewController.m
//  MCCWYJ
//
//  Created by MC on 16/7/14.
//  Copyright © 2016年 MC. All rights reserved.
//
#define NUMBERS @"0123456789.\n"

#import "MCDrawBackViewController.h"
#import "MLSelectPhotoAssets.h"
#import "MLSelectPhotoPickerAssetsViewController.h"
#import "MLSelectPhotoBrowserViewController.h"
#import "HClActionSheet.h"
#import "MCDrawBackTableViewCell.h"
@interface MCDrawBackViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
{
    UITableView *_tableView;
    UIButton * _imgBtn1;
    UIButton * _imgBtn2;
    UIButton * _imgBtn3;
    BOOL _is1has;
    BOOL _is2has;
    BOOL _is3has;
    
    UIButton * _delete1Btn;
    UIButton * _delete2Btn;
    UIButton * _delete3Btn;
    NSMutableArray *_selectAssets;
    NSMutableArray * imgArray ;
    NSMutableArray * imgurlArray ;

    NSString * _tukuanStr;
    NSString * _jieStr;
    NSString * _textViewStr;
    NSInteger _count;

    
}
@property (nonatomic , strong) NSMutableArray *assets;
@end

@implementation MCDrawBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请退款";
    _count = 200;
    _jieStr = _priceStr;
    self.view.backgroundColor = AppMCBgCOLOR;
    [self prepareUI];
    // Do any additional setup after loading the view.
}
-(void)prepareUI{
    
     _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = AppMCBgCOLOR;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self prepareFooter];
}
-(void)prepareFooter{
    
    
    CGFloat w = (Main_Screen_Width -10*4)/3;
    CGFloat x = 10;
    CGFloat y =40;
    CGFloat offx =10;
    CGFloat h = w;
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 10 + 20 + 10 + h + 200)];
    _tableView.tableFooterView = view;
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, Main_Screen_Width - 10, 20)];
    lbl.text = @"相关照片";
    lbl.textColor = AppTextCOLOR;
    lbl.font = [UIFont systemFontOfSize:16];
    [view addSubview:lbl];
    
    
    
    _imgBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [_imgBtn1 setBackgroundImage:[UIImage imageNamed:@"image_add"] forState:0];
    _delete1Btn = [[UIButton alloc]initWithFrame:CGRectMake(w-15, -5, 20, 20)];
    _delete1Btn.tag = 300;
    [_delete1Btn addTarget:self action:@selector(actionDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_delete1Btn setImage:[UIImage imageNamed:@"icon_close"] forState:0];
    
    [_imgBtn1 addSubview:_delete1Btn];
    [view addSubview:_imgBtn1];
    [_imgBtn1 addTarget:self action:@selector(selectPhotos:) forControlEvents:UIControlEventTouchUpInside];
    _imgBtn1.tag = 800;
    
    
    
    
    x += w + offx;
    _imgBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [_imgBtn2 setBackgroundImage:[UIImage imageNamed:@"image_add"] forState:0];
    _delete2Btn = [[UIButton alloc]initWithFrame:CGRectMake(w-15, -5, 20, 20)];
    
    [_delete2Btn setImage:[UIImage imageNamed:@"icon_close"] forState:0];
    _delete2Btn.tag = 301;
    [_delete2Btn addTarget:self action:@selector(actionDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_imgBtn2 addSubview:_delete2Btn];
    
    [view addSubview:_imgBtn2];
    _imgBtn2.tag = 801;
    [_imgBtn2 addTarget:self action:@selector(selectPhotos:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    x += w + offx;
    _imgBtn3 = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [_imgBtn3 setBackgroundImage:[UIImage imageNamed:@"image_add"] forState:0];
    _delete3Btn = [[UIButton alloc]initWithFrame:CGRectMake(w-15, -5, 20, 20)];
    
    [_delete3Btn setImage:[UIImage imageNamed:@"icon_close"] forState:0];
    _delete3Btn.tag = 302;
    [_delete3Btn addTarget:self action:@selector(actionDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_imgBtn3 addSubview:_delete3Btn];
    
    [view addSubview:_imgBtn3];
    _imgBtn3.tag = 802;
    [_imgBtn3 addTarget:self action:@selector(selectPhotos:) forControlEvents:UIControlEventTouchUpInside];
    
    _delete1Btn.hidden = YES;
    _imgBtn1.hidden = NO;
    _imgBtn2.hidden = YES;
    _imgBtn3.hidden = YES;
    
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(40, y+w + 30, Main_Screen_Width - 80, 40)];
    [btn setBackgroundImage:[UIImage imageNamed:@"login_red_btn"] forState:0];
    [btn setTitle:@"提交退款申请" forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn addTarget:self action:@selector(Actionsub) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    

    
}
-(void)Actionsub{
    UITextField * text = [self.view viewWithTag:500];
    UITableView * text1 = [self.view viewWithTag:501];
    [text1 resignFirstResponder];
    [text resignFirstResponder];
    NSLog(@"_tukuanStr ==%@",_tukuanStr);
    NSLog(@"_jieStr ==%@",_jieStr);
    NSLog(@"_textViewStr ==%@",_textViewStr);

    if (!_orderId.length) {
        [self showHint:@"无效id"];
        
        return;

    }
    if (!_tukuanStr.length) {
        [self showHint:@"请选择退款原因"];
        
        return;
    }
    if (!_jieStr.length) {
        [self showHint:@"请输入退款金额"];
        
        return;
    }
//    if (!_jieStr.length) {
//        [self showHint:@"请输入退款金额"];
//        
//        return;
//    }
    
    if (![self.assets count]) {
        [self showHint:@"请添加相关照片"];
        
        return;
    }
    NSMutableArray * img_Array= [NSMutableArray array];
    for (MLSelectPhotoAssets *asset in self.assets) {
        
        UIImage * img= [MLSelectPhotoPickerViewController getImageWithImageObj:asset];
        
        [img_Array addObject:img];
        
        
    }
    
    NSLog(@" img_Array ==%@",img_Array);
    
    NSDictionary * dic = @{
                           @"orderNumber":_orderId,
                           @"reason":_tukuanStr,
                           @"price":_jieStr,
                           @"description":_textViewStr
                           
                           };
    
    [self showLoading];
    [self.requestManager uploadWithImage:img_Array url:@"api/refund/addRefund.json" filename:nil name:@"file" mimeType:@"image/png" parameters:dic progress:^(int64_t bytesWritten, int64_t totalBytesWritten) {
        
        NSLog(@"bytesWritten =%zd",bytesWritten);
        
        NSLog(@"totalBytesWritten =%zd",totalBytesWritten);
        
    } success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ====  %@",resultDic);
        
        [self showHint:@"已发送申请"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"didPurchaseViewObjNotification" object:@""];
            [self.navigationController popViewControllerAnimated:YES];
        });

        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        NSLog(@"description === %@",description);
        
    }];
    
    

//    dispatch_queue_t _globalQueue;
//    dispatch_queue_t _mainQueue;
//    _mainQueue = dispatch_get_main_queue();
//    _globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    [self showLoading];
//    dispatch_async(_globalQueue, ^{
//        
//        
//        for (MLSelectPhotoAssets *asset in self.assets) {
//            
//            UIImage * img= [MLSelectPhotoPickerViewController getImageWithImageObj:asset];
//            
//            [imgArray addObject:img];
//            
//            
//        }
//        
//        
//        
//        dispatch_async(_mainQueue, ^{
//            
//            
//            [self stopshowLoading];
//            
//        });
//        
//    });
//
    
}
- (NSMutableArray *)assets{
    if (!_assets) {
        _assets = [NSMutableArray array];
    }
    return _assets;
}
- (NSMutableArray *)selectAssets{
    if (!_selectAssets) {
        _selectAssets = [NSMutableArray array];
    }
    return _selectAssets;
}

#pragma mark - 选择相册
- (void)selectPhotos:(UIButton*)btn {
    //    self.navigationController.navigationBarHidden = NO;
//    [_textView resignFirstResponder];
    UITextField * text = [self.view viewWithTag:500];
    UITableView * text1 = [self.view viewWithTag:501];
    [text1 resignFirstResponder];
    [text resignFirstResponder];
    NSInteger  count = 0;
    if (!_is1has) {
        count ++;
    }
    if(!_is2has){
        
        count ++;
        
    }
    if(!_is3has){
        count ++;
        
        
    }
    
    NSInteger tabindex = btn.tag ;
    if (tabindex == 800) {
        if (_is1has) {
            MLSelectPhotoBrowserViewController *browserVc = [[MLSelectPhotoBrowserViewController alloc] init];
            browserVc.isliulan = YES;
            browserVc.delgetView = self;
            
            browserVc.currentPage = 0;
            browserVc.photos = self.assets;
            
            [self.navigationController pushViewController:browserVc animated:YES];
            return;
        }
        
    }
    else if(tabindex == 801){
        if (_is2has) {
            MLSelectPhotoBrowserViewController *browserVc = [[MLSelectPhotoBrowserViewController alloc] init];
            browserVc.isliulan = YES;
            browserVc.delgetView = self;
            browserVc.currentPage = 1;
            browserVc.photos = self.assets;
            [self.navigationController pushViewController:browserVc animated:YES];
            return;
            
        }
    }
    else if(tabindex == 802){
        if (_is3has) {
            MLSelectPhotoBrowserViewController *browserVc = [[MLSelectPhotoBrowserViewController alloc] init];
            browserVc.isliulan = YES;
            browserVc.delgetView = self;
            
            browserVc.currentPage = 2;
            browserVc.photos = self.assets;
            [self.navigationController pushViewController:browserVc animated:YES];
            return;
            
        }
    }
//    else if(tabindex == 803){
//        if (_is4has) {
//            MLSelectPhotoBrowserViewController *browserVc = [[MLSelectPhotoBrowserViewController alloc] init];
//            browserVc.isliulan = YES;
//            browserVc.delgetView = self;
//            
//            browserVc.currentPage = 3;
//            browserVc.photos = self.assets;
//            [self.navigationController pushViewController:browserVc animated:YES];
//            return;
//            
//        }
//    }
//    
    
    HClActionSheet * actionSheet = [[HClActionSheet alloc] initWithTitle:@"" style:HClSheetStyleDefault itemTitles:@[@"拍照",@"从手机相册选择"]];
    actionSheet.delegate = self;
    actionSheet.tag = 100;
    // actionSheet.titleTextColor = [UIColor redColor];
    actionSheet.itemTextColor = [UIColor blackColor];
    actionSheet.cancleTextColor = [UIColor redColor];//RGBCOLOR(36, 149, 221);
    actionSheet.cancleTitle = @"取消";
    __weak typeof(self) weakSelf = self;
    __block typeof (NSInteger)weakCount = count;
    
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        
        NSLog(@"block----%ld----%@", (long)index, title);
        if (index == 1) {
            [weakSelf selectsystemPhotos:weakCount];
            
        }
        else if(index == 0 ){
            [weakSelf pickerCollectionViewDidCameraSelect:weakCount];
            
            
        }
        
        
        
        
    }];
    
    
    
}
-(void)selectsystemPhotos:(NSInteger)count{
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc]init];
    
    [library writeImageToSavedPhotosAlbum:nil orientation:nil completionBlock:^(NSURL *asSetUrl,NSError *error){
        
//        if (error) {
//            
//            NSLog(@"======%ld",(long)authStatus);
//            
//            //无权限
//            kAlertMessage(@"启动失败，请检查你相册权限 设置-隐私-照片 来进行设置");
//            return ;
//            
//        }else{
            NSLog(@"=====2=%ld",(long)authStatus);
            
            // 创建控制器
            MLSelectPhotoPickerViewController *pickerVc = [[MLSelectPhotoPickerViewController alloc] init];
            // 默认显示相册里面的内容SavePhotos
            pickerVc.topShowPhotoPicker = YES;
            pickerVc.status = PickerViewShowStatusSavePhotos;
            pickerVc.maxCount = count;
            [pickerVc showPickerVc:self];
            __weak typeof(self) weakSelf = self;
            pickerVc.callBack = ^(NSArray *assets){
                
                
                
                [weakSelf.assets addObjectsFromArray:assets];
                
                
                [weakSelf setPhotos];
            };
            
            
        //}
        
    }];
    
    
    
    
}

-(void)deletearray:(NSMutableArray*)arr{
    
    self.assets = arr;
    [_imgBtn1 setBackgroundImage:[UIImage imageNamed:@"image_add"] forState:0];
    [_imgBtn2 setBackgroundImage:[UIImage imageNamed:@"image_add"] forState:0];
    [_imgBtn3 setBackgroundImage:[UIImage imageNamed:@"image_add"] forState:0];
    _is1has = NO;
    _is2has = NO;
    _is3has = NO;
    
    [self setPhotos];
    
}
-(void)actionDeleteBtn:(UIButton*)btn{
    
    NSInteger index= btn.tag - 300;
    [_assets removeObjectAtIndex:index];
    [self deletearray:_assets];
    
    
    
    
}

- (void)pickerCollectionViewDidCameraSelect:(NSInteger )count{
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
    {
        //无权限
        kAlertMessage(@"启动失败，请检查你相机权限设置");
        return;
    }
    
    
    
    if (self.assets.count >= 4) {
        kAlertMessage(@"选择的图片个数不能大于4张");
        //        [self.view showMessageWithText:[NSString stringWithFormat:@"选择的图片个数不能大于%ld",KPhotoShowMaxCount]];
        return ;
    }
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *ctrl = [[UIImagePickerController alloc] init];
        ctrl.delegate = self;
        ctrl.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:ctrl animated:YES completion:nil];
    }else{
        NSLog(@"请在真机使用!");
    }
    
    
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        
        
        
        
        //        NSInteger count = self.selectAssets.count;
        
        //        [self done];
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        // 处理
        UIImage * image = [[UIImage alloc]init];
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        
        
        [self.selectAssets addObject:image];
        
        
        [self.assets addObjectsFromArray:self.selectAssets];
        
        
        
        
        [_selectAssets removeAllObjects];
        [self setPhotos];
        
        
        
        
        
    }else{
        NSLog(@"请在真机使用!");
    }
    
}
-(void)setPhotos{
    
    if (self.assets.count > 0) {
        
        MLSelectPhotoAssets *asset = self.assets[0];
        
        UIImage * img= [MLSelectPhotoPickerViewController getImageWithImageObj:asset];
        
        if (!_is1has) {
            [_imgBtn1 setBackgroundImage:img forState:0];
            _is1has = YES;
        }
        
    }
    if (self.assets.count > 1) {
        
        MLSelectPhotoAssets *asset = self.assets[1];
        UIImage * img= [MLSelectPhotoPickerViewController getImageWithImageObj:asset];
        
        if (!_is2has) {
            [_imgBtn2 setBackgroundImage:img forState:0];
            _is2has = YES;
        }
        
    }
    if (self.assets.count > 2) {
        
        MLSelectPhotoAssets *asset = self.assets[2];
        UIImage * img= [MLSelectPhotoPickerViewController getImageWithImageObj:asset];
        
        if (!_is3has) {
            [_imgBtn3 setBackgroundImage:img forState:0];
            _is3has = YES;
        }
        
    }
//    if (self.assets.count > 3) {
//        
//        MLSelectPhotoAssets *asset = self.assets[3];
//        UIImage * img= [MLSelectPhotoPickerViewController getImageWithImageObj:asset];
//        
//        if (!_is4has) {
//            [_imgBtn4 setBackgroundImage:img forState:0];
//            _is4has = YES;
//        }
//        
//    }
    
    [self aa];
    
}
-(void)aa{
    
    _delete1Btn.hidden = YES;
    _imgBtn1.hidden = NO;
    _imgBtn2.hidden = YES;
    _imgBtn3.hidden = YES;
    
    if (_is1has) {
        
        _imgBtn2.hidden = NO;
        _imgBtn3.hidden = YES;
        
        
        _delete1Btn.hidden = NO;
        _delete2Btn.hidden = YES;
        
        
        
        
    }
    else {
        _imgBtn1.hidden = NO;
        _delete1Btn.hidden = YES;
        
        
        
    }
    
    if (_is2has) {
        
        _delete1Btn.hidden = NO;
        _delete2Btn.hidden = NO;
        _delete3Btn.hidden = YES;
        
        
        _imgBtn3.hidden = NO;
        
        
    }
    else if(_is1has){
        
        _delete1Btn.hidden = NO;
        _delete2Btn.hidden = YES;
        
        _imgBtn2.hidden = NO;
        _imgBtn3.hidden = YES;
        
        
    }
    
    
    if (_is3has) {
        _delete1Btn.hidden = NO;
        _delete2Btn.hidden = NO;
        _delete3Btn.hidden = NO;
        
        
        
    }    else if(_is1has&&_is2has){
        
        _delete1Btn.hidden = NO;
        _delete2Btn.hidden = NO;
        _delete3Btn.hidden = YES;
        
        
        _imgBtn3.hidden = NO;
        
        
    }
    
//    if (_is4has) {
//        _delete1Btn.hidden = NO;
//        _delete2Btn.hidden = NO;
//        _delete3Btn.hidden = NO;
//        _delete4Btn.hidden = NO;
//        
//        
//        _imgBtn4.hidden = NO;
//        
//    }    else if(_is1has&&_is2has&&_is3has){
//        _delete1Btn.hidden = NO;
//        _delete2Btn.hidden = NO;
//        _delete3Btn.hidden = NO;
//        _delete4Btn.hidden = YES;
//        
//        
//        _imgBtn4.hidden = NO;
//        
//        
//    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 158 + 200;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MCDrawBackTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mc"];
    if (!cell) {
        cell = [[MCDrawBackTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mc"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell prepareUI];
    if (_tukuanStr.length) {
        cell.lbl1.text = _tukuanStr;
    }
    else
    {
       cell.lbl1.text = @"请选择退款原因";
    }
    
//    cell.text1.delegate = self;
//    cell.text1.tag = 500;
//        cell.text1.text = _jieStr;
    
//    cell.text1.placeholder = [NSString stringWithFormat:@"最多%@",_priceStr];
    cell.text1.text = _priceStr;
   cell.text1.userInteractionEnabled = NO;
    
    cell.textView1.text = _textViewStr;
    cell.textView1.delegate = self;
    cell.textView1.tag = 501;

    NSString * conutStr = [NSString stringWithFormat:@"还可输入%ld字",_count];
    cell.lblcount.text = conutStr;
    cell.lblcount.tag = 600;
    [cell.seleBtn addTarget:self action:@selector(actionSeleBtn) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"textField1 ===%.2f",[textField.text floatValue]);
    CGFloat max = [_priceStr floatValue];
    
    if ([textField.text floatValue]>max) {
        textField.text = [NSString stringWithFormat:@"%.2f",max];
    }
    else if([textField.text floatValue]<1){
        textField.text = @"";
        
    }
    NSLog(@"textField1 ===%.2f",[textField.text floatValue]);
    NSString *str1 = [NSString stringWithFormat:@"%.2f",[textField.text floatValue]];
    
    CGFloat str = [textField.text floatValue];
    
    _jieStr = str1;
    textField.text = _jieStr;
    NSLog(@"textField = %@",textField.text);

    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
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
    CGFloat max = [_priceStr floatValue];

    if ([aString floatValue]>max) {
//        textField.text = @"100000";
        textField.text = [NSString stringWithFormat:@"%.2f",max];

        return NO;
    }
    else if([aString floatValue]<1){
        textField.text = @"";
        
    }
    
    
    return YES;
    
    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]){
        return NO;
    }
    UILabel * lbl = (UILabel*)[self.view viewWithTag:600];
    
    NSString * aString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    if ([aString length] > 200) {
        //[_tableview reloadData];
        
        _count = 200;
        lbl.text = [NSString stringWithFormat:@"已满200字"];
        
        
        
        return NO;
    }
    //[_tableview reloadData];
    _count = aString.length;

    lbl.text = [NSString stringWithFormat:@"还可输入%ld",200 -aString.length];

    
    return YES;
    
    
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    _textViewStr = textView.text;
    
//    [_tableView reloadData];
    
}

-(void)actionSeleBtn{
    
    UITableView * text1 = [self.view viewWithTag:501];
    [text1 resignFirstResponder];
    
    NSArray * array = @[@"虚假发货",@"快递问题",@"空包裹/少货",@"未按约定时间发货",@"卖家发错货",@"多拍/拍错/不想要",@"其他"];
    HClActionSheet * actionSheet = [[HClActionSheet alloc] initWithTitle:@"选择退款原因" style:HClSheetStyleDefault itemTitles:array];
    actionSheet.delegate = self;
    actionSheet.tag = 100;
    // actionSheet.titleTextColor = [UIColor redColor];
    actionSheet.itemTextColor = [UIColor blackColor];
    actionSheet.cancleTextColor = [UIColor redColor];//RGBCOLOR(36, 149, 221);
    actionSheet.cancleTitle = @"取消";
    __weak typeof(self) weakSelf = self;
    
    __block typeof(NSString*) weakseleStr = _tukuanStr;
    __weak typeof(UITableView*) weaktabeview = _tableView;

    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        
        NSLog(@"block----%ld----%@", (long)index, title);
            _tukuanStr = title;
            
            [weaktabeview reloadData];
            
        
        
    }];

    
    
    
    
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
