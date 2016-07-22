//
//  LeftViewController.m
//  ThreeViewsText
//
//

#import "LeftViewController.h"
#import "homeYJModel.h"
#import "me1TableViewCell.h"
#import "me2TableViewCell.h"
#import "LoginController.h"
#import "AXPopoverView.h"
#import "AXPopoverLabel.h"
@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    CGFloat _selfViewW ;
    UITableView *_tableView;
    UIButton * _headBtn;
    BOOL _isshang;
    BOOL _isloaddata;

    YJUserModel * _usermodel;
    UILabel *_nameLbl;
    UIImageView * _biaozhiLbl;
    UILabel * _IdLbl;
    NSArray * _titelImgArray;

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
    
    sideMenuViewController.panGestureEnabled = NO;
    [self stopshowLoading];
    _isloaddata = NO;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    _isloaddata = NO;
    _selfViewW = Main_Screen_Width - 50;
    _titelImgArray = @[
                       @[@"--我的游",@"我的晒",@"我的采",@"我的售",@"我的足迹-"],
                       @[@"通讯录",@"我的任务"]
                       ];
    self.view.alpha = 1;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, _selfViewW, Main_Screen_Height) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = AppMCBgCOLOR;

    [self prepareheadView];
    // Do any additional setup after loading the view.
}
-(void)prepareheadView{
    UIImageView * view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _selfViewW, 260*MCHeightScale)];
//    view.backgroundColor = [UIColor redColor];
    view.image = [UIImage imageNamed:@"mine_Background"];
    view.userInteractionEnabled = YES;
    _tableView.tableHeaderView = view;
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(_selfViewW - 40, 30, 30, 30)];
//    btn.backgroundColor = [UIColor yellowColor];
    [btn setImage:[UIImage imageNamed:@"icon_message"] forState:0];
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
    
    [_headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[MCUserDefaults objectForKey:@"thumbnail"]] forState:0 placeholderImage:[UIImage imageNamed:@"home_Avatar_146"]];
//

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

    _biaozhiLbl = [[UIImageView alloc]init];
//    _biaozhiLbl.image = [UIImage imageNamed:@"Lv1"];
    if (_usermodel.grade == 1) {
        _biaozhiLbl.image = [UIImage imageNamed:@"Lv1"];
        
    }
    if (_usermodel.grade == 2) {
        _biaozhiLbl.image = [UIImage imageNamed:@"Lv2"];
        
    }
    if (_usermodel.grade == 3) {
        _biaozhiLbl.image = [UIImage imageNamed:@"Lv3"];
        
    }
    if (_usermodel.grade == 4) {
        _biaozhiLbl.image = [UIImage imageNamed:@"Lv4"];
        
    }
    if (_usermodel.grade == 5) {
        _biaozhiLbl.image = [UIImage imageNamed:@"Lv5"];
        
    }
    
    
    [self updateBiaozhiLbl];

    
    
    [view addSubview:_biaozhiLbl];

    
    y +=h + 10;
    _IdLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, y, _selfViewW, 20)];
    _IdLbl.textColor = [UIColor whiteColor];
    _IdLbl.font = [UIFont systemFontOfSize:13];
    _IdLbl.textAlignment = NSTextAlignmentCenter;
    _IdLbl.text = [NSString stringWithFormat:@"ID:%@",_usermodel.userno];

    [view addSubview:_IdLbl];
    
    
    
    x = 10;
    y += 20 + 8;
    w = (_selfViewW - 50)/4;
    h = 30;
    NSString *travelStr = @"游记";
    if (_usermodel.travelOfGrade.length) {
        travelStr = _usermodel.travelOfGrade;
    }
    NSString *recommendStr = @"态度";
    if (_usermodel.recommendOfGrade.length) {
        recommendStr = _usermodel.recommendOfGrade;
    }
    NSString *askForBuyStr = @"发单";
    if (_usermodel.askForBuyOfGrade.length) {
        askForBuyStr = _usermodel.askForBuyOfGrade;
    }
    NSString *pickOfStr = @"代购";
    if (_usermodel.pickOfGrade.length) {
        pickOfStr = _usermodel.pickOfGrade;
    }

    


    
    
    NSArray * arr = @[travelStr,recommendStr,pickOfStr,askForBuyStr];
    for (NSInteger  i = 0; i < 4; i ++) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
        btn.layer.borderColor = [UIColor whiteColor].CGColor;
        btn.layer.borderWidth = 1;
        ViewRadius(btn, 2);
        [btn setTitle:arr[i] forState:0];
        [btn setTitleColor:[UIColor whiteColor] forState:0];
        btn.titleLabel.font  = AppFont;
        btn.tag =  333+i;
        [btn addTarget:self action:@selector(action_Btn:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        x += 10 + w;
    }
    
    
}
-(void)action_Btn:(UIButton*)btn{
    
    NSInteger i = btn.tag - 333;
    NSString * detail = @"";
    if (i == 0) {
        detail = _usermodel.travelIntro.length ?  _usermodel.travelIntro:@"暂时没评论，快去发表作品吧！";
    }
    if (i == 1) {
        detail = _usermodel.recommendIntro.length ?  _usermodel.recommendIntro:@"暂时没评论，快去发表作品吧！";
    }
    if (i == 2) {
        detail = _usermodel.pickIntro.length ?  _usermodel.pickIntro:@"暂时没评论，快去发表作品吧！";
    }
    if (i == 3) {
        detail = _usermodel.askForBuyIntro.length ?  _usermodel.askForBuyIntro:@"暂时没评论，快去发表作品吧！";
    }
    
    
    
    [AXPopoverLabel showFromView:btn animated:YES duration:10.0 title:@"" detail:detail configuration:^(AXPopoverLabel *popoverLabel) {
        popoverLabel.showsOnPopoverWindow = NO;
        popoverLabel.translucent = NO;
        //        popoverLabel.titleTextColor = [UIColor blackColor];
        //        popoverLabel.detailTextColor = [[UIColor blackColor] colorWithAlphaComponent:0.9];
        popoverLabel.preferredArrowDirection = AXPopoverArrowDirectionTop;
        popoverLabel.translucentStyle = AXPopoverTranslucentLight;
        
    }];
    
    
    
}

-(void)updateBiaozhiLbl{
    _biaozhiLbl.frame  =CGRectMake(_nameLbl.mj_x -35 , _nameLbl.mj_y + 1.5, 30, 17);
    
    
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
        [_headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_usermodel.raw]] forState:0 placeholderImage:[UIImage imageNamed:@"home_Avatar_146"]];
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [defaults setObject:_usermodel.raw forKey:@"thumbnail"];

        
        
        
      CGFloat  w =  [MCIucencyView heightforString:_usermodel.nickname andHeight:20 fontSize:16];
        
      CGFloat  x = (_selfViewW-w)/2;
        
        _nameLbl.frame = CGRectMake(x, _nameLbl.mj_y, w, 20);
        _nameLbl.text =_usermodel.nickname;
        [defaults setObject :_usermodel.nickname forKey:@"nickname"];
        [self updateBiaozhiLbl];
        _IdLbl.text = [NSString stringWithFormat:@"ID:%@",_usermodel.userno];
        
        //强制让数据立刻保存
        [defaults synchronize];

        
        //发送通知刷新头像
        [[NSNotificationCenter defaultCenter] postNotificationName:@"disTouXiangObjNotification" object:nil];
        _tableView.tableHeaderView = nil;
        [self prepareheadView];

        
        [_tableView reloadData];
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
       NSLog(@"%@",description);
//        [self showAllTextDialog:description];
        _isloaddata = NO;
        if ([description isEqualToString:@"请重新登录"]||[description isEqualToString:@"30006"]) {
            
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.sideMenuViewController hideMenuViewController];

            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"disCtlViewObjNotification" object:@"登录"];

            
        });
        }
        NSLog(@"失败");

    }];
 
}
#pragma mark-点击头像
-(void)actionHeadbtn{
    [self.sideMenuViewController hideMenuViewController];
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"disCtlViewObjNotification" object:@"设置"];
    
    return;
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
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell prepareStr:_usermodel.introduction TitleStr:[NSString stringWithFormat:@"我的游(%@)",_usermodel.travelCount] Ishong:            ![MCIucencyView travelRemind]];
            cell.imgview.image =[UIImage imageNamed:_titelImgArray[indexPath.section][indexPath.row]] ;
            return cell;
        }
        me2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid2];
        if (!cell) {
            cell = [[me2TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid2];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

//        if (indexPath.row == 1) {
//            [cell preapreTitleStr:@"我的购(66)" Ishong:YES];
// 
//        }
        if (indexPath.row == 1)
            [cell preapreTitleStr:[NSString stringWithFormat:@"我的晒(%@)",_usermodel.buyOfShowCount] Ishong:![MCIucencyView showRemind]];
        else if (indexPath.row == 2)
            [cell preapreTitleStr:[NSString stringWithFormat:@"我的求(%@)",_usermodel.buyOfPickCount] Ishong:![MCIucencyView pickRemind]];
        else if (indexPath.row == 3)
            [cell preapreTitleStr:[NSString stringWithFormat:@"我的售(%@)",_usermodel.buyOfSellCount] Ishong:![MCIucencyView sellRemind]];
        else if (indexPath.row == 4)
            [cell preapreTitleStr:@"我的足迹" Ishong:NO];


        cell.imgview.image =[UIImage imageNamed:_titelImgArray[indexPath.section][indexPath.row]] ;

        return cell;

    }
    if (indexPath.section == 1) {
        me2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid2];
        if (!cell) {
            cell = [[me2TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid2];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        if (indexPath.row == 0) {
            
            [cell preapreTitleStr:@"通讯录" Ishong:![MCIucencyView addressBookRemind]];

        }
        else if (indexPath.row == 1)
            [cell preapreTitleStr:@"我的任务" Ishong:NO];

        cell.imgview.image =[UIImage imageNamed:_titelImgArray[indexPath.section][indexPath.row]] ;

        return cell;
 
    }
    return [[UITableViewCell alloc]init];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    [self.sideMenuViewController hideMenuViewController];
    
    if (indexPath.section == 0&&indexPath.row == 0) {
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"disCtlViewObjNotification" object:@"我的游"];
    }
    if (indexPath.section == 0&&indexPath.row == 1) {
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"disCtlViewObjNotification" object:@"我的晒"];
    }
    if (indexPath.section == 0&&indexPath.row == 2) {
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"disCtlViewObjNotification" object:@"我的求"];
    }
    if (indexPath.section == 0&&indexPath.row == 3) {
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"disCtlViewObjNotification" object:@"我的售"];
    }
    if (indexPath.section == 1&&indexPath.row == 1) {
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"disCtlViewObjNotification" object:@"我的任务"];
    }
    
    if (indexPath.section == 1&&indexPath.row == 0) {
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"disCtlViewObjNotification" object:@"通讯录"];
    }
    if (indexPath.section == 0&&indexPath.row == 4) {
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"disCtlViewObjNotification" object:@"我的足迹"];
    }


    



    
}
#pragma mark-im
-(void)SettBtn{
    [self.sideMenuViewController hideMenuViewController];
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"disCtlViewObjNotification" object:@"系统消息"];

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
