//
//  zuopinViewController.m
//  CWYouJi
//
//  Created by MC on 15/11/1.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "zuopinViewController.h"
#import "HMSegmentedControl.h"
#import "MyshouchangViewController.h"
#import "MyzuopinViewController.h"
#import "zuopinXQViewController.h"
#import "homeYJModel.h"
@interface zuopinViewController ()<UIScrollViewDelegate>
{
    
    HMSegmentedControl *titleSegment;
    MyshouchangViewController *_myshouchangCtl;
    
    MyzuopinViewController * _myzuopinCtl;
    
    NSInteger _isBianji;
    NSInteger _isBianji2;
    UIImageView * _imgViewMessage;
    NSMutableArray *dateMutablearray;
    
}

@end

@implementation zuopinViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //[self.navigationController setToolbarHidden:YES animated:NO];
    self.navigationController.navigationBarHidden = YES;
    
}

-(void)ActionBack{

    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectObjzuopin:) name:@"didSelectzuopinNotification" object:nil];
    
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_icon_back_pressed"] style:UIBarButtonItemStylePlain target:self action:@selector(ActionBack)];
    
    
    self.title = @"作品";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _isBianji = 3;
    _isBianji2 = 3;

    [self prepareUI];
    // Do any additional setup after loading the view.
}
#pragma mark-监听
- (void)didSelectObjzuopin:(NSNotification *)notication
{
    NSLog(@">>>%@",notication);
    if ([notication.object isKindOfClass:[NSDictionary class]]) {
        NSDictionary * dic = notication.object;
        
        zuopinXQViewController * ctl = [[zuopinXQViewController alloc]init];
        homeYJModel * model = dic[@"model"];
        
        
        
        
        
        if ([[MCUser sharedInstance].messageContents containsObject:model.id]) {
            [[MCUser sharedInstance].messageContents removeObject:model.id];
        }
        dateMutablearray =[MCUser sharedInstance].messageContents;
        _myzuopinCtl.dateMutablearray = dateMutablearray;
        
        if (dateMutablearray.count) {
            _imgViewMessage.hidden = NO;
        }
        else
        {
            _imgViewMessage.hidden = YES;
            
        }

        [_myzuopinCtl.tableView reloadData];
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"pinglunCounNotification" object:nil];
        ctl.home_model = dic[@"model"];
        ctl.dataArray = dic[@"dataarray"];
        ctl.index = [dic[@"index"] integerValue];
        
        [self pushNewViewController:ctl];
 
        
        
/*
        dispatch_queue_t _globalQueue;
        dispatch_queue_t _mainQueue;
        _mainQueue = dispatch_get_main_queue();
        _globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(_globalQueue, ^{
            
            
            if ([[MCUser sharedInstance].messageContents containsObject:model.id]) {
                [[MCUser sharedInstance].messageContents removeObject:model.id];
            }
            dateMutablearray =[MCUser sharedInstance].messageContents;
            _myzuopinCtl.dateMutablearray = dateMutablearray;
           
            if (dateMutablearray.count) {
                _imgViewMessage.hidden = NO;
            }
            else
            {
                _imgViewMessage.hidden = YES;
                
            }
            

            dispatch_async(_mainQueue, ^{
                [_myzuopinCtl.tableView reloadData];
                //发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"pinglunCounNotification" object:nil];
                ctl.home_model = dic[@"model"];
                ctl.dataArray = dic[@"dataarray"];
                ctl.index = [dic[@"index"] integerValue];
                
                [self pushNewViewController:ctl];

            });
            
        });
        

    */
        

    }
   
    
}

-(void)prepareUI{
    [self addAllSelect];
    //    添加滚动
    [self addScrollView];
    [self addMyzuopin];
    [self addMyshouchang];
    
    
    
    
}
-(void)addMyshouchang{
    _myshouchangCtl = [[MyshouchangViewController alloc]init];
     [self.mainScroll addSubview:_myshouchangCtl.view];
}
-(void)addMyzuopin{
    _myzuopinCtl = [[MyzuopinViewController alloc]init];
    _myzuopinCtl.dateMutablearray =dateMutablearray;
    [self.mainScroll addSubview:_myzuopinCtl.view];
    
}
-(void)addAllSelect{

    //选择框
    titleSegment = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 44)];
    titleSegment.sectionTitles = @[@"已制作的作品", @"我收藏的作品"];
    titleSegment.selectedSegmentIndex = _SegmentIndex;
  //  if (_SegmentIndex> 0) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(bianjiBtn)];
//    }
//    else
//    {
//        self.navigationItem.rightBarButtonItem = nil;
//    }

    titleSegment.backgroundColor = [UIColor whiteColor];
    titleSegment.textColor = [UIColor grayColor];
    titleSegment.selectedTextColor = AppCOLOR;
    titleSegment.font = [UIFont systemFontOfSize:16];
    titleSegment.selectionIndicatorColor = AppCOLOR;//[UIColor colorWithPatternImage:[UIImage imageNamed:@"red_line_tap"]];
    //titleSegment.selectionIndicatorHeight = 3;
    titleSegment.selectionStyle = HMSegmentedControlSelectionStyleArrow;
    titleSegment.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone;
    [self.view addSubview:titleSegment];
    __weak typeof(self) weakSelf = self;
    __block typeof(NSInteger) weakisBianji = _isBianji;

    [titleSegment setIndexChangeBlock:^(NSInteger index) {
        
        weakSelf.mainScroll.contentOffset =CGPointMake(index * Main_Screen_Width, 0);
        if (index== 1) {
            weakSelf.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:weakSelf action:@selector(bianjiBtn)];
            if (_isBianji == 1) {
                //weakisBianji = 0;
                
                weakSelf.navigationItem.rightBarButtonItem.title =  @"完成";}
            
            else if(_isBianji == 0 )
            {
                //weakisBianji = 1;
                
                weakSelf.navigationItem.rightBarButtonItem.title =  @"编辑";
                
            }
            
           // NSLog(@"%ld",_isBianji);
        }
        else
        {
           // weakSelf.navigationItem.rightBarButtonItem = nil;
            weakSelf.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:weakSelf action:@selector(bianjiBtn)];
            if (_isBianji2 == 1) {
                //weakisBianji = 0;
                
                weakSelf.navigationItem.rightBarButtonItem.title =  @"完成";}
            
            else if(_isBianji2 == 0 )
            {
                //weakisBianji = 1;
                
                weakSelf.navigationItem.rightBarButtonItem.title =  @"编辑";
                
            }
            

        }
        
        
    }];
    _imgViewMessage = [[UIImageView alloc]initWithFrame:CGRectMake(titleSegment.frame.size.width / 2 - 20, (44 - 15 )/2, 15, 15)];
    _imgViewMessage.image =[UIImage imageNamed:@"mine_dot"];
    
    
    
    NSArray * array2 = [MCUser sharedInstance].messageContents;

    
    if (array2.count) {
          _imgViewMessage.hidden = NO;
        
        
        
        dateMutablearray  = [array2 mutableCopy];
//        
//        
//        NSMutableArray *array = [NSMutableArray arrayWithArray:array2];
//        
//        for (int i = 0; i < array.count; i ++) {
//            
//            NSString *string = array[i];
//            
//            NSMutableArray *tempArray = [@[] mutableCopy];
//            
//            [tempArray addObject:string];
//            
//            for (int j = i+1; j < array.count; j ++) {
//                
//                NSString *jstring = array[j];
//                
//                NSLog(@"jstring:%@",jstring);
//                
//                if([string isEqualToString:jstring]){
//                    
//                    NSLog(@"jvalue = kvalue");
//                    
//                    [tempArray addObject:jstring];
//                    
//                    [array removeObjectAtIndex:j];
//                    
//                }
//                
//            }
//            
//            [dateMutablearray addObject:tempArray];
//            
//        }
//        NSLog(@">>>>%@",dateMutablearray);
        
        
    }
    else
    {
        _imgViewMessage.hidden = YES;
    }

    
    [titleSegment addSubview:_imgViewMessage];
    //
}
- (void)addScrollView
{
    //中间View
    self.mainScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44 + 64, Main_Screen_Width, Main_Screen_Height - 44 - 64)];
    self.mainScroll.contentSize = CGSizeMake(Main_Screen_Width * 2, 0);
    //self.mainScroll.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
    _mainScroll.contentOffset = CGPointMake(Main_Screen_Width * _SegmentIndex, 0);
    self.mainScroll.delegate = self;
    self.mainScroll.pagingEnabled = YES;
    self.mainScroll.showsHorizontalScrollIndicator = NO;
    self.mainScroll.bounces = NO;
    [self.view addSubview:self.mainScroll];
    
    
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([scrollView isKindOfClass:[UITableView class]]) {
        return;
    }
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    [titleSegment setSelectedSegmentIndex:page animated:YES];
    if (page> 0) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(bianjiBtn)];
        if (_isBianji == 1) {
           // _isBianji = 0;
            self.navigationItem.rightBarButtonItem.title =  @"完成";}
        else if(_isBianji == 0)
        {
            //_isBianji = 1;
            self.navigationItem.rightBarButtonItem.title =  @"编辑";
            
        }

    }
    else
    {
       // self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(bianjiBtn)];
        if (_isBianji2 == 1) {
            // _isBianji = 0;
            self.navigationItem.rightBarButtonItem.title =  @"完成";}
        else if(_isBianji2 == 0)
        {
            //_isBianji = 1;
            self.navigationItem.rightBarButtonItem.title =  @"编辑";
            
        }

        
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-编辑
-(void)bianjiBtn{
    CGFloat pageWidth = _mainScroll.frame.size.width;
    NSInteger page = _mainScroll.contentOffset.x / pageWidth;
    if (page == 1) {
        
    
    if (_isBianji== 1) {
        _isBianji = 0;
        self.navigationItem.rightBarButtonItem.title =  @"编辑";//[[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(bianjiBtn)];
        _myshouchangCtl.isquanxuan = NO;
        _myshouchangCtl.deleteBtn.selected = NO;
        _myshouchangCtl.deleArray = [NSMutableArray array];
        [_myshouchangCtl actionBianji];
        
    }
    else
    {
        _isBianji = 1;
       self.navigationItem.rightBarButtonItem.title =  @"完成";
        [_myshouchangCtl actionBianji];

    }
    }
    else
    {
        if (_isBianji2== 1) {
            _isBianji2 = 0;
            self.navigationItem.rightBarButtonItem.title =  @"编辑";//[[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(bianjiBtn)];

            [_myzuopinCtl actionBianji];
        }
        else
        {
            _isBianji2 = 1;
            self.navigationItem.rightBarButtonItem.title =  @"完成";
            _myzuopinCtl.isquanxuan = NO;
            _myzuopinCtl.deleteBtn.selected = NO;
            _myzuopinCtl.deleArray = [NSMutableArray array];
            NSLog(@"%@",_myzuopinCtl.deleArray);
            [_myzuopinCtl actionBianji];
            
        }

    }
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
