//
//  SettViewViewController.m
//  MCCWYJ
//
//  Created by MC on 16/5/3.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "SettViewController.h"
#import "changNameViewController.h"
#import "AddressViewController.h"
#import "SafetyViewController.h"
#import "AboutViewController.h"
#import "SystemSettViewController.h"
#import "GengxinViewController.h"
#import "MyIntegralViewController.h"
#import "ApplyViewController.h"
#import "MyIntegralModel.h"
#import "MCDimensionViewController.h"
@interface SettViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UITableView * _tableView;
    UIButton * _headBtn;
    BOOL _isshang;
    NSArray * _titleArray;
    NSArray *_detailArray;
    YJUserModel * _usermodel;
    MyIntegralModel *  _IntegralModel;

}

@end

@implementation SettViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_tableView) {
        [_tableView reloadData];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    //监听修改昵称
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dischangenameObj:) name:@"dischangenameObjNotification" object:nil];
    _titleArray = @[
                    @[@"昵称",@"二维码",@"我的积分",@"地址管理"],
                    @[@"安全中心",@"关于我们",@"系统消息",@"系统设置"]
                    ];
    _detailArray = @[
                     @[@"修改昵称",@"",@"积分",@"修改收货地址"],
                     @[@"修改密码",@"意见反馈放在这了",@"消息提醒",@"清理缓存"]
                     
                     ];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = AppMCBgCOLOR;

    [self prepareHeadView];
    [self prepareFooer];
    [self loadData];
//    [self Datadetail];
    // Do any additional setup after loading the view.
}
-(void)loadData{
    
    //      [self showLoading];
    NSDictionary * dic = @{
                           
                           };
    [self.requestManager postWithUrl:@"api/purse/getPurse.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        NSLog(@"resultDic ===%@",resultDic);
        _IntegralModel = [MyIntegralModel mj_objectWithKeyValues:resultDic[@"object"]];
        NSLog(@"%@",   _IntegralModel.systemIntegral);
        [_tableView reloadData];
        
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
    }];
    
}

-(void)prepareFooer{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 100)];
    view.backgroundColor = AppMCBgCOLOR;//[UIColor groupTableViewBackgroundColor];
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(40, 100 - 40 -20,Main_Screen_Width - 2* 40, 40)];
    [btn setTitle:@"退出登录" forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    btn.titleLabel.font = AppFont;
    btn.backgroundColor = AppRegTextCOLOR;//[UIColor redColor];
    [view addSubview:btn];
    ViewRadius(btn, 5);
    [btn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    _tableView.tableFooterView = view;
}
-(void)Datadetail{
    [self showLoading];
    [self.requestManager postWithUrl:@"api/user/detail.json" refreshCache:NO params:nil IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        
        NSLog(@"查询资料resultDic == %@",resultDic);
        _usermodel  = [YJUserModel mj_objectWithKeyValues:resultDic[@"object"]];
        
        
        
        [_tableView reloadData];
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        NSLog(@"失败");
        
    }];
    
}

#pragma mark-注销
-(void)logout{
    
    [self showLoading];
    [self.requestManager postWithUrl:@"api/user/logout.json" refreshCache:NO params:nil IsNeedlogin:YES success:^(id resultDic) {
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        /*保存数据－－－－－－－－－－－－－－－－－begin*/
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [defaults setObject :@"" forKey:@"Pwd"];
        [defaults setObject :@"" forKey:@"uid"];
        
        [defaults setObject :@"" forKey:@"thumbnail"];
        
        [defaults setObject :@"" forKey:@"sessionId"];
        [defaults setObject :@"" forKey:@"nickname"];
        [defaults setObject :@"" forKey:@"mobile"];
        [defaults setObject :@"" forKey:@"id"];
        [defaults setObject :@"" forKey:@"password"];
        [defaults setObject:@"" forKey:@"isLogOut"];
        [MCIucencyView remRemind];

        [self.requestManager.httpClient.requestSerializer setValue:@"" forHTTPHeaderField:@"user_session"];
        
        if ([[defaults objectForKey:@"type"]  isEqual: @(3)]) {
            
            [ShareSDK cancelAuthorize:SSDKPlatformTypeSinaWeibo];
            
        }
        if ([[defaults objectForKey:@"type"]  isEqual: @(1)]) {
            
           [ShareSDK cancelAuthorize:SSDKPlatformTypeWechat];
            
        }
        if ([[defaults objectForKey:@"type"]  isEqual: @(2)]) {
            
            [ShareSDK cancelAuthorize:SSDKPlatformTypeQQ];
            
        }
        
        //强制让数据立刻保存
        [defaults synchronize];
        
        
        [JPUSHService setAlias:@""
              callbackSelector:nil
                        object:self];

        __weak SettViewController *weakSelf = self;

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            
            EMError *error = [[EMClient sharedClient] logout:YES];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf stopshowLoading];
//                if (error != nil) {
//                    
//                    [weakSelf showHint:error.errorDescription];
//                }
//                else{
                    [self showAllTextDialog:@"账号已退出"];

                    
                    [[ApplyViewController shareController] clear];
                    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
                    //发送通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"didNewObjNotification" object:@""];
                    //发送通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"didMCMyshoppingObjNotification" object:@""];
                    //发送通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"disquery2ObjNotification" object:@""];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.navigationController popViewControllerAnimated:YES];
                        
                        
                    });

                //}
            });
        });
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
//        [self showAllTextDialog:description];
        NSLog(@"失败");
        /*保存数据－－－－－－－－－－－－－－－－－begin*/
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [defaults setObject :@"" forKey:@"Pwd"];
        [defaults setObject :@"" forKey:@"uid"];
        
        [defaults setObject :@"" forKey:@"thumbnail"];
        
        [defaults setObject :@"" forKey:@"sessionId"];
        [defaults setObject :@"" forKey:@"nickname"];
        [defaults setObject :@"" forKey:@"mobile"];
        [defaults setObject :@"" forKey:@"id"];
        [defaults setObject :@"" forKey:@"password"];
        [defaults setObject:@"" forKey:@"isLogOut"];
        
        [self.requestManager.httpClient.requestSerializer setValue:@"" forHTTPHeaderField:@"user_session"];
        
        if ([[defaults objectForKey:@"type"]  isEqual: @(3)]) {
            
            [ShareSDK cancelAuthorize:SSDKPlatformTypeSinaWeibo];
            
        }
        if ([[defaults objectForKey:@"type"]  isEqual: @(1)]) {
            
            [ShareSDK cancelAuthorize:SSDKPlatformTypeWechat];
            
        }
        if ([[defaults objectForKey:@"type"]  isEqual: @(2)]) {
            
            [ShareSDK cancelAuthorize:SSDKPlatformTypeQQ];
            
        }
        //强制让数据立刻保存
        [defaults synchronize];
        __weak SettViewController *weakSelf = self;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            
            EMError *error = [[EMClient sharedClient] logout:YES];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf stopshowLoading];
//                if (error != nil) {
//                    
//                    //[weakSelf showHint:error.errorDescription];
//                }
//                else{
                    [self showAllTextDialog:@"账号已退出"];
                    
                    
                    [[ApplyViewController shareController] clear];
                    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
                    //发送通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"didNewObjNotification" object:@""];
                    //发送通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"didMCMyshoppingObjNotification" object:@""];
                    //发送通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"disquery2ObjNotification" object:@""];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.navigationController popViewControllerAnimated:YES];
                        
                        
                    });
                    
               // }
            });
        });


    }];
    
    
    
    
}

-(void)prepareHeadView{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 100*MCHeightScale)];
    view.backgroundColor = AppMCBgCOLOR;//[UIColor groupTableViewBackgroundColor];
    _tableView.tableHeaderView = view;
    
    CGFloat w = 60*MCWidthScale;
    
    CGFloat x = (Main_Screen_Width- w)/2;
    
    CGFloat h = w;
    CGFloat y = (100*MCHeightScale - w) / 2;
    _headBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    ViewRadius(_headBtn, w/2);
    
    _headBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    _headBtn.layer.borderWidth = 2;
    [_headBtn addTarget:self action:@selector(actionHeadbtn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_headBtn];
    [_headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[MCUserDefaults objectForKey:@"thumbnail"]] forState:0 placeholderImage:[UIImage imageNamed:@"home_Avatar_60"]];
    
    
    
}
#pragma mark-点击头像
-(void)actionHeadbtn{
    _isshang = YES;
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
    }
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing=YES;
    picker.sourceType=sourceType;
    picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:picker animated:YES completion:nil];
    
}
//图像选取器的委托方法，选完图片后回调该方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image=[info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    //当图片不为空时显示图片并保存图片
    if (image != nil && _isshang) {
        
        _isshang = NO;
        [self updateAvatar:image];
    }
}
#pragma mark-上传头像
-(void)updateAvatar:(UIImage*)img{
    
    // [self showHudInView:self.view hint:nil];
    NSData *imageData = UIImageJPEGRepresentation(img, 0.2);
    NSString *base64Image=[imageData base64Encoding];
    
    
    NSDictionary * Parameterdic = @{
                                    @"image":base64Image
                                    
                                    };
    [self showLoading];
    
    
    [self.requestManager postWithUrl:@"api/user/profiles/updateAvatar.json" refreshCache:NO params:Parameterdic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        //头像
        [_headBtn setImage:img forState:0];
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [defaults setObject:resultDic[@"object"] forKey:@"thumbnail"];
        [defaults setObject:resultDic[@"object"] forKey:@"raw"];

        //强制让数据立刻保存
        [defaults synchronize];
        
        
        
        //发送通知刷新头像
        [[NSNotificationCenter defaultCenter] postNotificationName:@"disTouXiangObjNotification" object:nil];
        [self showAllTextDialog:@"更换成功"];
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
        NSLog(@"失败");
        
    }];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0)
    return 10;
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    return 4;
    return 4;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellid = @"mccell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
        
    }
    for (UIView * view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        UIImageView * imgview = [[UIImageView alloc]initWithFrame:CGRectMake(Main_Screen_Width - 25 - 30, 7, 30, 30)];
        imgview.image = [UIImage imageNamed:@"nav_code"];
        [cell.contentView addSubview:imgview];
    }
    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _titleArray[indexPath.section][indexPath.row];
    cell.textLabel.textColor = AppTextCOLOR;
    
    cell.detailTextLabel.text = _detailArray[indexPath.section][indexPath.row];
    cell.detailTextLabel.font = AppFont;
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.detailTextLabel.textColor = [UIColor darkTextColor];
           
            cell.detailTextLabel.text = [MCUserDefaults objectForKey:@"nickname"];
        }
        if (indexPath.row == 2) {
            cell.detailTextLabel.textColor = [UIColor darkTextColor];
        CGFloat ff= [_IntegralModel.systemIntegral floatValue]+[_IntegralModel.rechargeIntegral floatValue];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f",ff];
        }
        
    }
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            changNameViewController * ctl = [[changNameViewController alloc]init];
            [self pushNewViewController:ctl];
        }
        if (indexPath.row == 1) {
            MCDimensionViewController * ctl = [[MCDimensionViewController alloc]init];
            
            [self pushNewViewController:ctl];
        }

        if (indexPath.row == 2) {
            MyIntegralViewController * ctl = [[MyIntegralViewController alloc]init];
            [self pushNewViewController:ctl];
        }

        if (indexPath.row == 3) {
            AddressViewController * ctl = [[AddressViewController alloc]init];
            [self pushNewViewController:ctl];

        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            SafetyViewController * ctl = [[SafetyViewController alloc]init];
            [self pushNewViewController:ctl];

            
        }
        if (indexPath.row == 1) {
            AboutViewController * ctl = [[AboutViewController alloc]init];
            [self pushNewViewController:ctl];
            
            
        }
        if (indexPath.row == 2) {
            GengxinViewController * ctl = [[GengxinViewController alloc]init];
            [self pushNewViewController:ctl];
            
            
        }
        if (indexPath.row == 3) {
            SystemSettViewController * ctl = [[SystemSettViewController alloc]init];
            [self pushNewViewController:ctl];
            
            
        }

    }
    
}
- (BOOL)isContainsEmoji:(NSString *)string {
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    isEomji = YES;
                }
            }
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                isEomji = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                isEomji = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                isEomji = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                isEomji = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                isEomji = YES;
            }
            if (!isEomji && substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    isEomji = YES;
                }
            }
        }
    }];
    return isEomji;
}

-(BOOL)isIncludeSpecialCharact: (NSString *)str {
    NSLog(@"str == %@",str);
    NSLog(@"str == %zd",str);

    
    //***需要过滤的特殊字符：~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€。
    NSRange urgentRange = [str rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€ ~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€ "]];
    if (urgentRange.location == NSNotFound)
    {
        
        
        return NO;
    }
    
    return YES;
}

#pragma mark-修改昵称
-(void)dischangenameObj:(NSNotification*)Notification{
    
    
    
    NSString *str=Notification.object;
    //***调用关键方法，获得bool值，yes或者no：
    if (str.length>1) {
        str = [str substringToIndex:2];
        
    }
    BOOL ok= [self isContainsEmoji:str];
    if (ok==YES) {
        [self showHint:@"亲，昵称不能特殊字符开头哦"];
        NSLog(@"包含有特殊字符");
        
        
        return;
    }else{
        NSLog(@"不包含特殊字符");
    }
    
    
    NSDictionary * Parameterdic = @{
                                    @"nickname":Notification.object
                                    };
    [self showLoading];
    [self.requestManager postWithUrl:@"api/user/profiles/updateNickname.json" refreshCache:NO params:Parameterdic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"修改成功%@",resultDic);
        /*保存数据－－－－－－－－－－－－－－－－－begin*/
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [defaults setObject :Notification.object forKey:@"nickname"];

        //强制让数据立刻保存
        [defaults synchronize];

        [_tableView reloadData];
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
