//
//  LeftViewController.m
//  ThreeViewsText
//
//  Created by lanouhn on 16/2/29.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import "LeftViewController.h"
#import "homeYJModel.h"
#import "me1TableViewCell.h"
#import "me2TableViewCell.h"
#import "LoginController.h"
@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    CGFloat _selfViewW ;
    UITableView *_tableView;
    UIButton * _headBtn;
    BOOL _isshang;
    BOOL _isloaddata;

    YJUserModel * _usermodel;
    UILabel *_nameLbl;
    UILabel * _biaozhiLbl;
    UILabel * _IdLbl;


}

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation LeftViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil

{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        //监听查询资料
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disDatadetailObj:) name:@"disDatadetailObjNotification" object:nil];
    }
    return self;
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    RESideMenu *sideMenuViewController  =(RESideMenu*)  appDelegate.window.rootViewController;
    
    sideMenuViewController.panGestureEnabled = NO;
    
        
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    RESideMenu *sideMenuViewController  =(RESideMenu*)  appDelegate.window.rootViewController;
    
    sideMenuViewController.panGestureEnabled = YES;
    [self stopshowLoading];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    _isloaddata = NO;
    _selfViewW = Main_Screen_Width - 50;
    
    self.view.alpha = 1;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, _selfViewW, Main_Screen_Height) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self prepareheadView];
    // Do any additional setup after loading the view.
}
-(void)prepareheadView{
    UIImageView * view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _selfViewW, 250*MCHeightScale)];
    view.backgroundColor = [UIColor redColor];
    view.userInteractionEnabled = YES;
    _tableView.tableHeaderView = view;
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(_selfViewW - 60, 30, 30, 30)];
    btn.backgroundColor = [UIColor yellowColor];
    [btn addTarget:self action:@selector(SettBtn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    CGFloat w = 80*MCWidthScale;

    CGFloat x = (_selfViewW- w)/2;
    
    CGFloat h = w;
    CGFloat y = 60;
    _headBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    ViewRadius(_headBtn, w/2);
    _headBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    _headBtn.layer.borderWidth = 2;
    [_headBtn addTarget:self action:@selector(actionHeadbtn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_headBtn];
    
    [_headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[MCUserDefaults objectForKey:@"thumbnail"]] forState:0 placeholderImage:[UIImage imageNamed:@"home_mine_avatar2"]];


    y +=h + 20;
    w = _selfViewW;
    h = 20;
   w =  [MCIucencyView heightforString:[MCUserDefaults objectForKey:@"nickname"] andHeight:20 fontSize:16];
    
    x = (_selfViewW-w)/2;
    _nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _nameLbl.text = [MCUserDefaults objectForKey:@"nickname"];
    _nameLbl.textColor = [UIColor whiteColor];
    _nameLbl.font = [UIFont systemFontOfSize:16];
    [view addSubview:_nameLbl];

    _biaozhiLbl = [[UILabel alloc]init];
    _biaozhiLbl.text = @"Lv1";
    _biaozhiLbl.textColor = [UIColor whiteColor];
    _biaozhiLbl.font = AppFont;
    _biaozhiLbl.layer.borderColor = [UIColor whiteColor].CGColor;
    _biaozhiLbl.textAlignment = NSTextAlignmentCenter;
    _biaozhiLbl.layer.borderWidth = 1;
    ViewRadius(_biaozhiLbl, 10);
    [self updateBiaozhiLbl];
    [view addSubview:_biaozhiLbl];

    
    y +=h + 10;
    _IdLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, y, _selfViewW, 20)];
    _IdLbl.textColor = [UIColor whiteColor];
    _IdLbl.font = [UIFont systemFontOfSize:13];
    _IdLbl.textAlignment = NSTextAlignmentCenter;

    [view addSubview:_IdLbl];

    
}
-(void)updateBiaozhiLbl{
    _biaozhiLbl.frame  =CGRectMake(_nameLbl.mj_x -35 , _nameLbl.mj_y, 30, 20);
    
    
}

#pragma mark-查询资料
-(void)disDatadetailObj:(NSNotification*)notication{
    
    [self Datadetail];

}
-(void)Datadetail{
    if (_isloaddata) {
        return;
    }
    
    _isloaddata = YES;
    [self showLoading];
    [self.requestManager postWithUrl:@"api/user/detail.json" refreshCache:NO params:nil IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        _isloaddata = NO;

        NSLog(@"查询资料resultDic == %@",resultDic);
        _usermodel  = [YJUserModel mj_objectWithKeyValues:resultDic[@"object"]];
        //头像
        [_headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_usermodel.raw]] forState:0 placeholderImage:[UIImage imageNamed:@"mine_default-avatar"]];
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [defaults setObject:_usermodel.raw forKey:@"thumbnail"];

        
        
        
      CGFloat  w =  [MCIucencyView heightforString:_usermodel.nickname andHeight:20 fontSize:16];
        
      CGFloat  x = (_selfViewW-w)/2;
        
        _nameLbl.frame = CGRectMake(x, _nameLbl.mj_y, w, 20);
        _nameLbl.text =_usermodel.nickname;
        [defaults setObject :_usermodel.nickname forKey:@"nickname"];
        [self updateBiaozhiLbl];
        _IdLbl.text = [NSString stringWithFormat:@"ID:%@",_usermodel.id];
        
        //强制让数据立刻保存
        [defaults synchronize];

        
        //发送通知刷新头像
        [[NSNotificationCenter defaultCenter] postNotificationName:@"disTouXiangObjNotification" object:nil];

        
        [_tableView reloadData];
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
        NSLog(@"失败");
        _isloaddata = NO;

    }];
 
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
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    RESideMenu *sideMenuViewController  =(RESideMenu*)  appDelegate.window.rootViewController;
    
    sideMenuViewController.panGestureEnabled = NO;
    

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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            CGFloat h = 0;
            CGFloat y = 20;
            
            if ([_usermodel.introduction length]) {
                h  = [MCIucencyView heightforString:_usermodel.introduction andWidth:_selfViewW - 20 fontSize:14];
                
            }
            y +=h + 10;
            h = 20;
          return  y +=h + 10;

        }
    }
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .01;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 5;
    }
    return 2;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid1 = @"me1TableViewCell";
    static NSString * cellid2 = @"me2TableViewCell";

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            me1TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
            if (!cell) {
                cell = [[me1TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid1];
            }
           [cell prepareStr:_usermodel.introduction TitleStr:@"我的游(77)" Ishong:YES];
            return cell;
        }
        me2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid2];
        if (!cell) {
            cell = [[me2TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid2];
        }
        [cell preapreTitleStr:@"我的购(66)" Ishong:YES];
        return cell;

    }
    if (indexPath.section == 1) {
        me2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid2];
        if (!cell) {
            cell = [[me2TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid2];
        }
        [cell preapreTitleStr:@"通讯录" Ishong:NO];
        return cell;
 
    }
    return [[UITableViewCell alloc]init];
}
#pragma mark-设置
-(void)SettBtn{
    
    [self.sideMenuViewController hideMenuViewController];
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"disCtlViewObjNotification" object:@"设置"];
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
