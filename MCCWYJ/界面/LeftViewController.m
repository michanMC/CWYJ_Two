//
//  LeftViewController.m
//  ThreeViewsText
//
//  Created by lanouhn on 16/2/29.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import "LeftViewController.h"


@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    CGFloat _selfViewW ;
    UITableView *_tableView;
    UIButton * _headBtn;
    BOOL _isshang;


}

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation LeftViewController

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
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
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
    [self.requestManager postWithUrl:@"api/user/profiles/updateAvatar.json" refreshCache:NO params:Parameterdic success:^(id resultDic) {
        [self stopshowLoading];
        //头像
        [_headBtn setImage:img forState:0];
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [defaults setObject:resultDic[@"object"] forKey:@"thumbnail"];
        //强制让数据立刻保存
        [defaults synchronize];

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
    return [[UITableViewCell alloc]init];
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
