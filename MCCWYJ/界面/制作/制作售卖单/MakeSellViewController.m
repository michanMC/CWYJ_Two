//
//  MakeSellViewController.m
//  MCCWYJ
//
//  Created by MC on 16/6/23.
//  Copyright © 2016年 MC. All rights reserved.
//
#define NUMBERS @"0123456789.\n"

#import "MakeSellViewController.h"
#import "ZYQAssetPickerController.h"
#import "MCdeleteImgView.h"
#import "MakeBuyTableViewCell.h"
#import "SearchViewController.h"
@interface MakeSellViewController ()<ZYQAssetPickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate,SearchViewControllerDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    
    UITableView *_tableview;
    NSMutableArray *_imgViewArray;

    NSString * _brandStr;
    NSString * _commodityStr;
    NSString * _modelStr;
    NSString * _colourStr;
    NSString * _priceStr;
    NSString * _countStr;
    NSString * _countnumStr;
    NSString * _describefeildStr;
    NSString * _addser1Str;
    NSString * _addserid;

    
    
    
    
    NSInteger _seleindex;
    BOOL _isercifabu;

    
}

@end

@implementation MakeSellViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _countStr = @"1";
        _imgViewArray = [NSMutableArray array];
        
        
    }
    
    return self;
    
}

-(void)setBuyModlel:(MCBuyModlel *)BuyModlel
{
    
    
    
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
    
    

    
    _countStr = BuyModlel.count;
    _brandStr = BuyModlel.brand;
    _commodityStr = BuyModlel.name;
    _modelStr = BuyModlel.model;
    _colourStr = BuyModlel.color;
    _priceStr = BuyModlel.price;
    _addser1Str = BuyModlel.chAddress;
    NSLog(@"_addser1Str ==== %@",_addser1Str);
//    chAddress
//    _addser2Str = BuyModlel.deliveryAddress;
    _addserid = BuyModlel.addressId;
    _describefeildStr = BuyModlel.MCdescription;
    
    [_tableview reloadData];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"制作售卖单";
//    _countStr = @"1";
//    _imgViewArray = [NSMutableArray array];
    [self prepareUI];

    
    
    // Do any additional setup after loading the view.
}
-(void)prepareUI{
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64 -50)];
    _tableview.tableHeaderView = [self headView];
    _tableview.delegate =self;
    _tableview.dataSource = self;
    [self.view addSubview:_tableview];
    [self preparefooerView];
    
    
    if (_isercifabu) {
        if (_imgViewArray.count) {
            _tableview.tableHeaderView = nil;
            _tableview.tableHeaderView = [self addHeadView:_imgViewArray.count];
        }

        
    }

    
}
-(void)preparefooerView{
    //    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 200)];
    //    _tableview.tableFooterView = view;
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, Main_Screen_Height - 44, Main_Screen_Width, 44)];
    btn.backgroundColor = AppCOLOR;
    [btn setTitle:@"发布" forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(actionnext) forControlEvents:UIControlEventTouchUpInside];
    //    [view addSubview:btn];
    
    
}
-(void)actionnext{
    //    [self showLoading];
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
        
    NSLog(@"_addser1Str = %@",_addser1Str);
    //    _addser1Str = @"广州";
    if (!_addser1Str.length) {
        [self showHint:@"请选择购买地点"];
        return;
    }
    if (!_addserid.length) {
        [self showHint:@"无效的购买点id"];
        return;
    }

    NSLog(@"_describefeildStr = %@",_describefeildStr);
    if (!_describefeildStr.length) {
        _describefeildStr = @"";
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
        
        [imgArray addObject:tempImg];
        
    }
    
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
                           @"addressId":_addserid?_addserid:@""
                           
                           };
    
    [self.requestManager uploadWithImage:imgArray url:@"api/buy/addSell.json" filename:nil name:@"file" mimeType:@"image/png" parameters:dic progress:^(int64_t bytesWritten, int64_t totalBytesWritten) {
        
        
        
    } success:^(id resultDic) {
        [self stopshowLoading];
        [self showHint:@"发布成功"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        });

        
        
        NSLog(@"resultDic == %@",resultDic);
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        
        
    }];
    
    
    
    
    
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
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
//    if (indexPath.row == 3) {
//        CGFloat selfViewH = 20 + 20 + 100 +10;
//        return selfViewH;
//        
//    }
//    if (indexPath.row == 5) {
//        CGFloat selfViewH = 20 + 44;
//        return selfViewH;
//        
//    }
    
    
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
        [cell prepareUI7];
        
        
        
//        [cell.percentBtn setTitle:[NSString stringWithFormat:@"%@%@",_percentStr,@"%"] forState:0];
//        [cell.percentBtn addTarget:self action:@selector(actionpercentBtn) forControlEvents:UIControlEventTouchUpInside];
        
        
        cell.addserBtn.tag = 600;
        [cell.addserBtn addTarget:self action:@selector(actionaddserBtnBtn:) forControlEvents:UIControlEventTouchUpInside];
        if (_addser1Str.length) {
            [cell.addserBtn setTitle:_addser1Str forState:0];
            
        }
        else
        {
            [cell.addserBtn setTitle:@"购买地点" forState:0];
            
        }
        
        if ( _addser1Str.length) {
            
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
    
    
    
    return cell;
    
    
    return [[UITableViewCell alloc]init];
 
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
