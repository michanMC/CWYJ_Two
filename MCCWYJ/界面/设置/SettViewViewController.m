//
//  SettViewViewController.m
//  MCCWYJ
//
//  Created by MC on 16/5/3.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "SettViewViewController.h"
#import "changNameViewController.h"
#import "AddressViewController.h"
#import "SafetyViewController.h"
#import "AboutViewController.h"
#import "SystemSettViewController.h"
#import "GengxinViewController.h"
@interface SettViewViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UITableView * _tableView;
    UIButton * _headBtn;
    BOOL _isshang;
    NSArray * _titleArray;
    NSArray *_detailArray;

}

@end

@implementation SettViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    //监听修改昵称
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dischangenameObj:) name:@"dischangenameObjNotification" object:nil];
    _titleArray = @[
                    @[@"昵称",@"我的积分",@"地址管理"],
                    @[@"安全中心",@"关于我们",@"系统消息",@"系统设置"]
                    ];
    _detailArray = @[
                     @[@"修改昵称",@"积分",@"修改收货地址"],
                     @[@"修改密码",@"意见反馈放在这了",@"消息提醒",@"清理缓存"]
                     
                     ];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self prepareHeadView];
    [self prepareFooer];
    // Do any additional setup after loading the view.
}
-(void)prepareFooer{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 100)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
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
#pragma mark-注销
-(void)logout{
    
    [self showLoading];
    [self.requestManager postWithUrl:@"api/user/logout.json" refreshCache:NO params:nil IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
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

        
        [self showAllTextDialog:@"账号已退出"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
            
                      
        });
        

        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
        NSLog(@"失败");

    }];
    
    
    
    
}

-(void)prepareHeadView{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 100*MCHeightScale)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
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
    [_headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[MCUserDefaults objectForKey:@"thumbnail"]] forState:0 placeholderImage:[UIImage imageNamed:@"home_mine_avatar2"]];
    
    
    
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
    return 3;
    return 4;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellid = @"mccell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
        
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
        if (indexPath.row == 1) {
            cell.detailTextLabel.textColor = [UIColor darkTextColor];
            
            cell.detailTextLabel.text = @"123";
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
        if (indexPath.row == 2) {
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
#pragma mark-修改昵称
-(void)dischangenameObj:(NSNotification*)Notification{
    
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
