//
//  ReleaseMakeSellViewController.m
//  MCCWYJ
//
//  Created by MC on 16/6/23.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "ReleaseMakeSellViewController.h"
#import "zhizuoTextTableViewCell.h"
#import "zhizuoText2TableViewCell.h"
#import "MCLblView.h"
#import "RESideMenu.h"
@interface ReleaseMakeSellViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate>
{
    UIImageView *_imgView;
    UITableView * _tableView;
    
    UIPlaceHolderTextView * _holderText;
    UILabel *_countText;
    
    NSString *_holderTextStr;
    NSString *_countTextStr;
    NSString * _diaotiStr;
    MCLblView* _lblView;
}

@end

@implementation ReleaseMakeSellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"制作晒单";
    
     _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64-50) style:UITableViewStylePlain];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self preparefooerView];
    [self prepareHeadview];
    [self prepareLblview:4 Dic:_commodityDic];
    // Do any additional setup after loading the view.
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
-(void)prepareLblview:(NSInteger)count Dic:(NSDictionary*)dic{
    
    _lblView = [[MCLblView alloc]initWithFrame:CGRectMake(_lblView_x, _lblView_y - 64, 150 , 20 * 4 + 20 * 3 + 1 * 4)];
    _lblView.index = 0;
    if (count == 3) {
        
        _lblView.frame = CGRectMake(Main_Screen_Width/2, 20 + 64, 150 , 20 * 3 + 20 * 2 + 1 * 3);
        
    }
    
    
    [_imgView addSubview:_lblView];
    
    CGFloat x  = 20;
    CGFloat  y = 0;
    CGFloat w = 150 - x ;
    CGFloat h = 20;
    w = [MCIucencyView heightforString:dic[@"commodity"] andHeight:20 fontSize:18];
    
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.text = dic[@"commodity"];//@"法国";
    lbl.tag = 800;

    lbl.textColor = [UIColor whiteColor];
    [_lblView addSubview:lbl];
    
    y += h;
    h = 1;
    x = 10;
    w = 50;
    w = [MCIucencyView heightforString:dic[@"commodity"] andHeight:20 fontSize:18] + 5;
    
    UIImageView * lineImg = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lineImg.backgroundColor = [UIColor whiteColor];
    [_lblView addSubview:lineImg];
    
    w = 1;
    h = _lblView.mj_h - 20 - 1;
    lineImg = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lineImg.backgroundColor = [UIColor whiteColor];
    [_lblView addSubview:lineImg];
    
    y = _lblView.mj_h  - 1;
    w = 100;
    h = 1;
    
    w = [MCIucencyView heightforString:[NSString stringWithFormat:@"%@ %@",dic[@"model"],dic[@"colour"]] ? [NSString stringWithFormat:@"%@ %@",dic[@"model"],dic[@"colour"]] : @"ewq" andHeight:20 fontSize:18] + 5;
    
    lineImg = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lineImg.backgroundColor = [UIColor whiteColor];
    [_lblView addSubview:lineImg];
    
    
    w = 20;
    h = w;
    y = (_lblView.mj_h+20 - w )/2;
    x = 0;
    UIButton*  _shanBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [_shanBtn setImage:[UIImage imageNamed:@"icon_lable2"] forState:0];
    [_shanBtn setImage:[UIImage imageNamed:@"icon_lable"] forState:UIControlStateSelected];
//    [_shanBtn addTarget:self action:@selector(actionShanbtn:) forControlEvents:UIControlEventTouchUpInside];
    [_lblView addSubview:_shanBtn];
    _shanBtn.tag = 700;
    [_shanBtnArray addObject:_shanBtn];
    
    
    
    
    
    x = lbl.mj_x;
    y = lbl.mj_y + 20 + 1 + 20;
    w = 150 - x;
    h = 20;
    w = [MCIucencyView heightforString:[NSString stringWithFormat:@"%@ %@",dic[@"price"],dic[@"num"]] ? [NSString stringWithFormat:@"%@ %@",dic[@"price"],dic[@"num"]] : @"ewqewqe" andHeight:20 fontSize:18] ;
    
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.text = [NSString stringWithFormat:@"%@ %@",dic[@"price"],dic[@"num"] ];//@"10CNY  6";
    lbl.textColor = [UIColor whiteColor];
    lbl.tag = 801;
    
    [_lblView addSubview:lbl];
    
    lineImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, y +h, w+5, 1)];
    lineImg.backgroundColor = [UIColor whiteColor];
    [_lblView addSubview:lineImg];
    w = [MCIucencyView heightforString:[NSString stringWithFormat:@"%@ %@",dic[@"brand"],dic[@"name"]] ? [NSString stringWithFormat:@"%@ %@",dic[@"brand"],dic[@"name"]] : @"ewqewqe" andHeight:20 fontSize:18] ;

    
    
    y += h + 1 + 20;
    lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    lbl.text = [NSString stringWithFormat:@"%@ %@",dic[@"brand"],dic[@"name"] ];//@"kebo7 wqwqwq";
    lbl.tag = 802;
    
    lbl.textColor = [UIColor whiteColor];
    [_lblView addSubview:lbl];
    lineImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, y +h, w+5, 1)];
    lineImg.backgroundColor = [UIColor whiteColor];
    [_lblView addSubview:lineImg];
//    _lblViewCount++;
    
    if (count >3) {
        
        w = [MCIucencyView heightforString:[NSString stringWithFormat:@"%@ %@",dic[@"model"],dic[@"colour"]] ? [NSString stringWithFormat:@"%@ %@",dic[@"model"],dic[@"colour"]] : @"ewq" andHeight:20 fontSize:18] + 5;

        y += h + 1 + 20;
        lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
        lbl.text = [NSString stringWithFormat:@"%@ %@",dic[@"model"]?dic[@"model"] :@"未知",dic[@"colour"]?dic[@"colour"]:@"未知" ];//@"LL 红色";
        lbl.tag = 803;
        
        lbl.textColor = [UIColor whiteColor];
        [_lblView addSubview:lbl];
    }
    [self actionShanbtn:_shanBtn];
//    
//    _lblView_x = _lblView.mj_x;
//    _lblView_y = _lblView.mj_y;
//    _lblViewAlignmen = @"左";
}
-(void)actionShanbtn:(UIButton*)btn{
//    _lblView = [self.view viewWithTag:btn.tag - 100];
    
    NSLog(@"=======%zd",_lblView.index);
    //0zou
    if ([_lblViewAlignmen isEqualToString:@"左"]) {
        _lblView.index = 1;
    }
    else
    {
        _lblView.index = 0;
        _lblView.transform= CGAffineTransformScale(_lblView.transform, -1.0, 1.0);

    }

    UILabel * lbl1 = [self.view viewWithTag:btn.tag + 100];
    if (_lblView.index == 0)
    lbl1.transform= CGAffineTransformScale(lbl1.transform, -1.0, 1.0);
    
    
    if (_lblView.index==0) {
        lbl1.textAlignment= NSTextAlignmentRight;
    }
    else
    {
        lbl1.textAlignment= NSTextAlignmentLeft;
        
    }
    
    
    UILabel * lbl2 = [self.view viewWithTag:btn.tag + 101];
    if (_lblView.index == 0)
    lbl2.transform= CGAffineTransformScale(lbl2.transform, -1.0, 1.0);
    
    if (_lblView.index==0) {
        lbl2.textAlignment= NSTextAlignmentRight;
        NSLog(@"右");
        
    }
    else
    {
        lbl2.textAlignment= NSTextAlignmentLeft;
        NSLog(@"左");
        
        
        
    }
    
    
    
    UILabel * lbl3 = [self.view viewWithTag:btn.tag + 102];
    if (_lblView.index == 0)

    lbl3.transform= CGAffineTransformScale(lbl3.transform, -1.0, 1.0);
    if (_lblView.index==0) {
        lbl3.textAlignment= NSTextAlignmentRight;
    }
    else
    {
        lbl3.textAlignment= NSTextAlignmentLeft;
        
    }
    
    UILabel * lbl4 = [self.view viewWithTag:btn.tag + 103];
    if (_lblView.index == 0)
    lbl4.transform= CGAffineTransformScale(lbl4.transform, -1.0, 1.0);
    if (_lblView.index==0) {
        lbl4.textAlignment= NSTextAlignmentRight;
    }
    else
    {
        lbl4.textAlignment= NSTextAlignmentLeft;
        
    }
    
    
    
    
}


-(void)actionnext{
    UIPlaceHolderTextView * textview = [self.view viewWithTag:600];
    [textview resignFirstResponder];
    
    
    UITextField * text = [self.view viewWithTag:500];
    [text resignFirstResponder];

    
    
    if (!_diaotiStr.length) {
        [self showHint:@"请输入标题"];
        return;
    }
    if (!_holderTextStr.length) {
        [self showHint:@"请输入描述"];
        return;
    }
    NSString * commodityid = _commodityDic[@"commodityid"];
    if (!commodityid.length) {
        [self showHint:@"无效的代购点id"];
        return;

    }
    
    [self showLoading];
    NSLog(@"_commodityDic == %@",_commodityDic);
    NSLog(@"_lblView_x == %f",_lblView_x);
    NSLog(@"_lblView_y == %f",_lblView_y);
    NSLog(@"_lblViewAlignmen == %@",_lblViewAlignmen);
    NSLog(@"_diaotiStr == %@",_diaotiStr);
    NSLog(@"_holderTextStr == %@",_holderTextStr);
    NSMutableDictionary * jsondic = [NSMutableDictionary dictionary];
    [jsondic setObject:_commodityDic[@"colour"]?_commodityDic[@"colour"]:@"" forKey:@"color"];
    [jsondic setObject:_commodityDic[@"model"]?_commodityDic[@"model"]:@"" forKey:@"model"];
    [jsondic setObject:_commodityDic[@"name"] forKey:@"name"];
    [jsondic setObject:_commodityDic[@"brand"] forKey:@"brand"];
    [jsondic setObject:_commodityDic[@"num"] forKey:@"count"];
    [jsondic setObject:_commodityDic[@"price"] forKey:@"price"];
    [jsondic setObject:_commodityDic[@"commodity"] forKey:@"address"];
    
    [jsondic setObject:_commodityDic[@"commodityid"] forKey:@"addressId"];


    if ([_lblViewAlignmen isEqualToString:@"左"]) {
        [jsondic setObject:@"FourLeft" forKey:@"shapeType"];

    }
    else
    {
        [jsondic setObject:@"FourLeft" forKey:@"shapeType"];

    }
    
    ;
    NSString * ss = [NSString stringWithFormat:@"%.0f,%.0f",_lblView_x,_lblView_y-64];
    [jsondic setObject:ss forKey:@"coordinates"];
    NSString *jsonStr=[jsondic mj_JSONString];

    
    
    NSMutableArray *imgArray = [NSMutableArray array];
    [imgArray addObject:_img];
    
    
    NSDictionary * dic = @{
                           @"title":_diaotiStr,
                           @"description":_holderTextStr,
                           @"json":jsonStr
                           
                           };
    
    [self.requestManager uploadWithImage:imgArray url:@"api/buy/addShow.json" filename:nil name:@"file" mimeType:@"image/png" parameters:dic progress:^(int64_t bytesWritten, int64_t totalBytesWritten) {
        
        
        
    } success:^(id resultDic) {
        [self stopshowLoading];
//        
//        if([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
//            UIImageWriteToSavedPhotosAlbum(_img, nil, nil, nil);
//            NSLog(@"MLSelectPhoto : 保存成功");
//            
//            
//            
//        }else{
//            
//            
//            NSLog(@"MLSelectPhoto : 没有用户权限,保存失败");
//        }
        
        [self showHint:@"发布成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            for (UIViewController *vc in self.navigationController.viewControllers) {
                
                if ([vc isKindOfClass:objc_getClass("MySellViewController")]) {
                    
                    [self.navigationController popToViewController:vc animated:YES];
                    
                    return;
                }
            }

            
            
            
            
            [self.navigationController popToRootViewControllerAnimated:YES];

            
            if (IOS8) {
                [(LCTabBarController*) self.tabBarController removeOriginControls];
//                [(RESideMenu *)[UIApplication sharedApplication].keyWindow.rootViewController removeOriginControls];
            }
            else{

            }

            
            

        });

        
        
        NSLog(@"resultDic == %@",resultDic);
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showHint:description];
        
    }];

    
    
    
    
    
    
}
-(void)prepareHeadview{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, _imgViewRect.size.height)];
    
   CGFloat h = _imgViewRect.size.height;
    CGFloat x =(Main_Screen_Width- _imgViewRect.size.width)/2;
    
    
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, _imgViewRect.size.width, h)] ;
    _imgView.image = _img;//self.imageWillHandle ;
    
    
    _imgView.backgroundColor = AppTextCOLOR;
    _imgView.userInteractionEnabled = YES;
    //    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionTapimg)];
    //    [_imgView addGestureRecognizer:tap];
    //
//    [self.view addSubview:_imgView];
    [view addSubview:_imgView];
    
    _tableView.tableHeaderView = view;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 1) {
        return 426;
    }
    
    return 44;

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellid1 = @"zhizuoTextTableViewCell";
    if (indexPath.row == 0) {
        zhizuoTextTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"zhizuoTextTableViewCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.mctext.delegate= self;
        cell.mctext.placeholder = @"标题那么多，我想去写写";
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
        //[_tableview reloadData];
        lbl.text = [NSString stringWithFormat:@"%ld/500",aString.length];
        _countTextStr = lbl.text;
        
        return NO;
    }
    //[_tableview reloadData];
    lbl.text = [NSString stringWithFormat:@"%ld/500",aString.length];
    _countTextStr = lbl.text;
    return YES;
    
    
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    _holderTextStr = textView.text;
    
    [_tableView reloadData];
    
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
