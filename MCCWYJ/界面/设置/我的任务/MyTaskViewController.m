//
//  MyTaskViewController.m
//  MCCWYJ
//
//  Created by MC on 16/6/3.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MyTaskViewController.h"
#import "MyTaskViewTableViewCell.h"
#import "taskModel.h"
#import "verifyViewController.h"
#import "MakeViewController.h"
#import "MakeBuyViewController.h"
#import "WNImagePicker.h"
#import "MakeSellViewController.h"
#import "MCShareView.h"
@interface MyTaskViewController ()<UITableViewDelegate,UITableViewDataSource,MCShareViewViewDelegate>
{
    UITableView * _tableView;
    NSArray * _titleArray;
    NSArray * _imgArray;
    NSMutableArray * _dataArray;
    NSString * modifyDateStr;
}

@end

@implementation MyTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的任务";
    _dataArray = [NSMutableArray array];
    _titleArray = @[@"绑定手机",@"分享给朋友赚采点",@"首次发布游记",@"发布游记",@"首次发布代购单",@"首次完成购买",@"首次晒单",@"首次完成接单",@"首次发布出售买单"];
    _imgArray = @[@"绑定手机",@"分享",@"发布游记-",@"发布游记-",@"发布代购单-",@"完成购买--",@"首次晒单-----",@"完成接单-",@"发布售卖单"];

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = AppMCBgCOLOR;

    [self loadata];
    // Do any additional setup after loading the view.
}
-(void)loadata{
    
        [self showLoading];
    NSDictionary * dic = @{
                         
                           };
    [self.requestManager postWithUrl:@"api/task/query.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
        [_dataArray removeAllObjects];
        for (NSDictionary*dic in resultDic[@"object"]) {
            taskModel * model = [taskModel mj_objectWithKeyValues:dic];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
    }];

    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat viewH = 10 + 20 + 5 + 5 + 5+ 20 + 10;

    return viewH;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"MyTaskViewTableViewCell";
    MyTaskViewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[MyTaskViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    CGFloat x  = 10 + 30 + 10;
    
    CGFloat w  = Main_Screen_Width - x - 10 - 60 - 60-10;
    if (_dataArray.count>indexPath.row) {
        [cell prepareUI];
        cell.TaskBtn.tag = 500 + indexPath.row;
        [cell.TaskBtn addTarget:self action:@selector(actionTaskBtn:) forControlEvents:UIControlEventTouchUpInside];
        taskModel * modle = _dataArray[indexPath.row];
        
        if ([modle.type isEqualToString:@"0"]) {
            cell.ImgView.image = [UIImage imageNamed:_imgArray[0]];
            cell.titelLbl.text = _titleArray[0];
            if ([modle.complete boolValue]) {
                
                [cell.TaskBtn setTitle:@"已完成" forState:0];
                cell.TaskBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
//                [cell.TaskBtn setTitleColor:[UIColor whiteColor] forState:0];
 
            }
            else
            {
                
                [cell.TaskBtn setTitle:@"去完成" forState:0];
                cell.TaskBtn.backgroundColor = AppCOLOR;
                [cell.TaskBtn setTitleColor:[UIColor whiteColor] forState:0];

                
            }
            
            cell.countLbl.text = [NSString stringWithFormat:@"%@/%@",modle.times,modle.askTimes];


            cell.ysView.progressValue = [modle.times floatValue]/[modle.askTimes floatValue]*w;
            return cell;
        }
        if ([modle.type isEqualToString:@"1"]) {
            cell.ImgView.image = [UIImage imageNamed:_imgArray[1]];
            cell.titelLbl.text = _titleArray[1];
            if ([modle.complete boolValue]) {
                
                [cell.TaskBtn setTitle:@"已完成" forState:0];
                cell.TaskBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
                //                [cell.TaskBtn setTitleColor:[UIColor whiteColor] forState:0];
                
            }
            else
            {
                [cell.TaskBtn setTitle:@"去完成" forState:0];
                cell.TaskBtn.backgroundColor = AppCOLOR;
                [cell.TaskBtn setTitleColor:[UIColor whiteColor] forState:0];
                
                
            }
            cell.countLbl.text = [NSString stringWithFormat:@"%@/%@",modle.times,modle.askTimes];
            
            cell.ysView.progressValue = [modle.times floatValue]/[modle.askTimes floatValue]*w;
            modifyDateStr = modle.modifyDate;
            return cell;
        }

        if ([modle.type isEqualToString:@"2"]) {
            cell.ImgView.image = [UIImage imageNamed:_imgArray[2]];
            cell.titelLbl.text = _titleArray[2];
            if ([modle.complete boolValue]) {
                
                [cell.TaskBtn setTitle:@"已完成" forState:0];
                cell.TaskBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
                //                [cell.TaskBtn setTitleColor:[UIColor whiteColor] forState:0];
                
            }
            else
            {
                [cell.TaskBtn setTitle:@"去完成" forState:0];
                cell.TaskBtn.backgroundColor = AppCOLOR;
                [cell.TaskBtn setTitleColor:[UIColor whiteColor] forState:0];
                
                
            }
            cell.countLbl.text = [NSString stringWithFormat:@"%@/%@",modle.times,modle.askTimes];
            cell.ysView.progressValue = [modle.times floatValue]/[modle.askTimes floatValue]*w;

            return cell;
        }
        if ([modle.type isEqualToString:@"3"]) {
            cell.ImgView.image = [UIImage imageNamed:_imgArray[3]];
            cell.titelLbl.text = _titleArray[3];
            if ([modle.complete boolValue]) {
                
                [cell.TaskBtn setTitle:@"已完成" forState:0];
                cell.TaskBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
                //                [cell.TaskBtn setTitleColor:[UIColor whiteColor] forState:0];
                
            }
            else
            {
                [cell.TaskBtn setTitle:@"去完成" forState:0];
                cell.TaskBtn.backgroundColor = AppCOLOR;
                [cell.TaskBtn setTitleColor:[UIColor whiteColor] forState:0];
                
                
            }
            cell.countLbl.text = [NSString stringWithFormat:@"%@/%@",modle.times,modle.askTimes];
            cell.ysView.progressValue = [modle.times floatValue]/[modle.askTimes floatValue]*w;

            return cell;
        }
        if ([modle.type isEqualToString:@"4"]) {
            cell.ImgView.image = [UIImage imageNamed:_imgArray[4]];
            cell.titelLbl.text = _titleArray[4];
            if ([modle.complete boolValue]) {
                
                [cell.TaskBtn setTitle:@"已完成" forState:0];
                cell.TaskBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
                //                [cell.TaskBtn setTitleColor:[UIColor whiteColor] forState:0];
                
            }
            else
            {
                [cell.TaskBtn setTitle:@"去完成" forState:0];
                cell.TaskBtn.backgroundColor = AppCOLOR;
                [cell.TaskBtn setTitleColor:[UIColor whiteColor] forState:0];
                
                
            }
            cell.countLbl.text = [NSString stringWithFormat:@"%@/%@",modle.times,modle.askTimes];
            cell.ysView.progressValue = [modle.times floatValue]/[modle.askTimes floatValue]*w;

            return cell;
        }
        if ([modle.type isEqualToString:@"5"]) {
            cell.ImgView.image = [UIImage imageNamed:_imgArray[5]];
            cell.titelLbl.text = _titleArray[5];
            if ([modle.complete boolValue]) {
                
                [cell.TaskBtn setTitle:@"已完成" forState:0];
                cell.TaskBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
                //                [cell.TaskBtn setTitleColor:[UIColor whiteColor] forState:0];
                
            }
            else
            {
                [cell.TaskBtn setTitle:@"去完成" forState:0];
                cell.TaskBtn.backgroundColor = AppCOLOR;
                [cell.TaskBtn setTitleColor:[UIColor whiteColor] forState:0];
                
                
            }

            cell.countLbl.text = [NSString stringWithFormat:@"%@/%@",modle.times,modle.askTimes];
            cell.ysView.progressValue = [modle.times floatValue]/[modle.askTimes floatValue]*w;

            return cell;
        }
        if ([modle.type isEqualToString:@"6"]) {
            cell.ImgView.image = [UIImage imageNamed:_imgArray[6]];
            cell.titelLbl.text = _titleArray[6];
            if ([modle.complete boolValue]) {
                
                [cell.TaskBtn setTitle:@"已完成" forState:0];
                cell.TaskBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
                //                [cell.TaskBtn setTitleColor:[UIColor whiteColor] forState:0];
                
            }
            else
            {
                [cell.TaskBtn setTitle:@"去完成" forState:0];
                cell.TaskBtn.backgroundColor = AppCOLOR;
                [cell.TaskBtn setTitleColor:[UIColor whiteColor] forState:0];
                
                
            }
            cell.countLbl.text = [NSString stringWithFormat:@"%@/%@",modle.times,modle.askTimes];
            cell.ysView.progressValue = [modle.times floatValue]/[modle.askTimes floatValue]*w;

            return cell;
        }
        if ([modle.type isEqualToString:@"7"]) {
            cell.ImgView.image = [UIImage imageNamed:_imgArray[7]];
            cell.titelLbl.text = _titleArray[7];
            if ([modle.complete boolValue]) {
                
                [cell.TaskBtn setTitle:@"已完成" forState:0];
                cell.TaskBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
                //                [cell.TaskBtn setTitleColor:[UIColor whiteColor] forState:0];
                
            }
            else
            {
                [cell.TaskBtn setTitle:@"去完成" forState:0];
                cell.TaskBtn.backgroundColor = AppCOLOR;
                [cell.TaskBtn setTitleColor:[UIColor whiteColor] forState:0];
                
                
            }
            cell.countLbl.text = [NSString stringWithFormat:@"%@/%@",modle.times,modle.askTimes];
            cell.ysView.progressValue = [modle.times floatValue]/[modle.askTimes floatValue]*w;

            return cell;
        }
        if ([modle.type isEqualToString:@"8"]) {
            cell.ImgView.image = [UIImage imageNamed:_imgArray[8]];
            cell.titelLbl.text = _titleArray[8];
            if ([modle.complete boolValue]) {
                
                [cell.TaskBtn setTitle:@"已完成" forState:0];
                cell.TaskBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
                //                [cell.TaskBtn setTitleColor:[UIColor whiteColor] forState:0];
                
            }
            else
            {
                [cell.TaskBtn setTitle:@"去完成" forState:0];
                cell.TaskBtn.backgroundColor = AppCOLOR;
                [cell.TaskBtn setTitleColor:[UIColor whiteColor] forState:0];
                
                
            }
            cell.countLbl.text = [NSString stringWithFormat:@"%@/%@",modle.times,modle.askTimes];
            cell.ysView.progressValue = [modle.times floatValue]/[modle.askTimes floatValue]*w;

            return cell;
        }
        

    }
    return cell;
//    return [[UITableViewCell alloc]init];
}
-(void)actionTaskBtn:(UIButton*)btn{
    UIViewController * _ctl;
    taskModel * modle = _dataArray[btn.tag - 500];
    if ([modle.type isEqualToString:@"0"]) {//手机
        verifyViewController * ctl = [[verifyViewController alloc]init];
        
        ctl.verifyStr = @"3";
        _ctl =ctl;
        
    }
    else if([modle.type isEqualToString:@"1"]){//分享
        if (![modle.complete boolValue]) {

        MCShareView * view = [[MCShareView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
        view.delegate = self;
        [view showInWindow];
        }
        
    }
    else if([modle.type isEqualToString:@"2"]){//游记
       MakeViewController* ctl = [[MakeViewController alloc]init];
        _ctl =ctl;

        
    }
    else if([modle.type isEqualToString:@"3"]){//游记
        MakeViewController * ctl = [[MakeViewController alloc]init];
        _ctl =ctl;


    }
    else if([modle.type isEqualToString:@"4"]){//代够
        MakeBuyViewController * ctl = [[MakeBuyViewController alloc]init];
        _ctl =ctl;

    }
    else if([modle.type isEqualToString:@"5"]){//购买
        if (![modle.complete boolValue]) {

        self.tabBarController.selectedIndex = 1;
         [self.navigationController popToRootViewControllerAnimated:YES];
        
        }
    }
    else if([modle.type isEqualToString:@"6"]){//晒单
        WNImagePicker *pickerVC  = [[WNImagePicker alloc]init];
        _ctl =pickerVC;

    }
    else if([modle.type isEqualToString:@"7"]){//接单
        if (![modle.complete boolValue]) {

        self.tabBarController.selectedIndex = 1;
        [self.navigationController popToRootViewControllerAnimated:YES];
        }

    }
    else if([modle.type isEqualToString:@"8"]){//售
        MakeSellViewController * ctl = [[MakeSellViewController alloc]init];
        _ctl =ctl;

    }
    
    
    if (![modle.complete boolValue]&&_ctl) {
        [self pushNewViewController:_ctl];
 
    }

    
    
}
-(void)MCShareViewselsctStr:(NSString *)selectStr
{
    if ([selectStr isEqualToString:@"微博"]) {
        [self actionFenxian:SSDKPlatformTypeSinaWeibo];
    }
    else if ([selectStr isEqualToString:@"QQ"]){
        [self actionFenxian:SSDKPlatformTypeQQ];

    }
    else if ([selectStr isEqualToString:@"微信"]){
        [self actionFenxian:SSDKPlatformSubTypeWechatSession];
        
    }
    else if ([selectStr isEqualToString:@"朋友圈"]){
        [self actionFenxian:SSDKPlatformSubTypeWechatTimeline];
        
    }

}
#pragma mark-点击某个分享按钮
-(void)actionFenxian:(SSDKPlatformType)PlatformType {
    
//    if (!ssdic) {
//        return;
//    }
    /**
     * 在简单分享中，只要设置共有分享参数即可分享到任意的社交平台
     **/
    __weak BaseViewController *theController = self;
    // [self showLoadingView:YES];
    [self showLoading];
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    NSString * url = [NSString stringWithFormat:@"%@api/share/share.jhtml?userId=%@&shareTaskId=%@",AppURL,[MCUserDefaults objectForKey:@"id"],modifyDateStr];
    NSString * title = @"页面分享";
    NSString * titlesub = @"采点分享";
    if (!titlesub) {
        titlesub = @"分享";
    }
    NSArray* imageArray = @[[UIImage imageNamed:@"ios-template-180"]];
    
    //    if (imageArray) {
    if (PlatformType == SSDKPlatformTypeSinaWeibo) {
        NSString * wei = [NSString stringWithFormat:@"%@ %@",title,url];
        
        
        [shareParams SSDKSetupShareParamsByText:wei
                                         images:imageArray
                                            url:[NSURL URLWithString:url]
                                          title:titlesub
                                           type:SSDKContentTypeText];
    }else
    {
        [shareParams SSDKSetupShareParamsByText:title
                                         images:imageArray
                                            url:[NSURL URLWithString:url]
                                          title:titlesub
                                           type:SSDKContentTypeWebPage];
    }
    
    //进行分享
    [ShareSDK share:PlatformType
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         
         [theController stopshowLoading];
         // [theController.tableView reloadData];
         
         switch (state) {
             case SSDKResponseStateSuccess:
             {
                     [self StateSuccess];
                 
                 
                 break;
             }
             case SSDKResponseStateFail:
             {
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                     message:[NSString stringWithFormat:@"%@", error]
                                                                    delegate:theController
                                                           cancelButtonTitle:@"确定"
                                                           otherButtonTitles:nil];
                 [alertView show];
                 break;
             }
             case SSDKResponseStateCancel:
             {
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                     message:nil
                                                                    delegate:theController
                                                           cancelButtonTitle:@"确定"
                                                           otherButtonTitles:nil];
                 //[alertView show];
                 break;
             }
             default:
                 break;
         }
     }];
    // }
    
    
}
-(void)StateSuccess{
    
    [self showLoading];
    NSDictionary * dic = @{
                           
                           };
    [self.requestManager postWithUrl:@"api/task/share.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
        [ self showAllTextDialog:@"分享成功"];
        [self loadata];
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
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
