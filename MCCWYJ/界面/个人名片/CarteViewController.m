//
//  CarteViewController.m
//  MCCWYJ
//
//  Created by MC on 16/5/23.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "CarteViewController.h"
#import "ItemView.h"
#import "CarteTableViewCell.h"
#import "AddFriendViewController.h"
#import "MCCapacityView.h"
#import "FriendYJViewController.h"
#import "SellViewController.h"
#import "BuyOnViewController.h"
#import "ChatViewController.h"
#import "ContactListViewController.h"
#import "FenxianViewController.h"
#import "AXPopoverView.h"
#import "AXPopoverLabel.h"


@interface CarteViewController ()<UITableViewDataSource,UITableViewDelegate,ItemViewDelegate,MCCapacityViewDelegate>
{
    UITableView *_tableView;
    UIButton * _headBtn;
    UILabel *_nameLbl;
    UILabel * _IdLbl;
    UIImageView * _biaozhiimg;
    UIImageView * _headerView;
    ItemView*_itemView;

    BOOL _isShowCapacity;
    MCCapacityView * _CapacityView;
    
    
    
    
    NSMutableArray *_travelsArray;
    NSMutableArray *_buyOfPickArray;
    NSMutableArray *_buyOfSellArray;

    
}
@property(strong, nonatomic) AXPopoverView *popoverView;
@property(strong, nonatomic) AXPopoverLabel *popoverLabel;

@end

@implementation CarteViewController


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self MCCapacityViewhidden];
}


-(void)actionnav_popup{
    
    
    if (_isShowCapacity) {
        _isShowCapacity = NO;
        [_CapacityView removeFromSuperview];
        
    }
    else
    {
        _isShowCapacity = YES;
        NSArray * array = [NSArray array];

        if ([_userModel.id integerValue] ==[[MCUserDefaults objectForKey:@"id"] integerValue]) {
            array = @[@"发送该名片"];

            
        }
        else
        {
            if (_isfriend) {
                array = @[@"分享该名片",@"举报",@"删除"];
            }
            else
                array = @[@"发送该名片",@"举报"];

        }

        
        _CapacityView = [[MCCapacityView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) TitleArray:array];
        _CapacityView.delegate = self;

        [_CapacityView showInWindow];
        
        
    }

    
    
}
-(void)MCCapacityViewselsctTitle:(NSString *)titleDic
{
    [self MCCapacityViewhidden];
    if ([titleDic isEqualToString:@"分享该名片"]||[titleDic isEqualToString:@"发送该名片"]) {
        
        ContactListViewController * ctl = [[ContactListViewController alloc]init];
        ctl.isSelect = YES;
        _userModel.raw = _userModel.thumbnail;
        ctl.userDatamodle = _userModel;
        [self pushNewViewController:ctl];
    }
    else if ([titleDic isEqualToString:@"举报"]){
        
        jubaoViewController * ctl = [[jubaoViewController alloc]init];
        ctl._typeindex = @"4";
        ctl._youjiId = _userModel.id;
        
        [self pushNewViewController:ctl];
 
        
        
        
    }
    else if ([titleDic isEqualToString:@"删除"]){
        [self showLoading];
        NSDictionary * dic = @{
                               @"friendId":_userModel.id,
                               @"status":@(2)
                               };
        
        [self.requestManager postWithUrl:@"api/friends/update.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
            [self stopshowLoading];
            NSLog(@"resultDic ===%@",resultDic);
            [self showHint:@"删除成功"];
            [self loadData];
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"didfriendslistDataObjNotification" object:@""];
            
        } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
            [self stopshowLoading];
            [self showHint:description];
        }];
        
  
    }

    NSLog(titleDic);
}
-(void)MCCapacityViewhidden
{
    _isShowCapacity = NO;
    [_CapacityView removeFromSuperview];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _travelsArray = [NSMutableArray array];
    _buyOfPickArray = [NSMutableArray array];
    _buyOfSellArray = [NSMutableArray array];

    self.title = @"好友名片";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_popup"] style:UIBarButtonItemStylePlain target:self action:@selector(actionnav_popup)];

//    _popoverLabel.titleFont = [UIFont systemFontOfSize:16];

    [self prepareUI];
    
    
    // Do any additional setup after loading the view.
}
-(void)prepareUI{
    
     _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = AppMCBgCOLOR;

    [self prepareheadView];
    [self loadData];
}
-(void)loadData{
//    _userModel.id = @"977";
        [self showLoading];
    NSDictionary * dic = @{
                           @"destUid":@([_userModel.id integerValue])
                           };
    
    NSLog(@">>>>>>%@",dic);
    
    [self.requestManager postWithUrl:@"api/user/hasUserCard.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
        
        _userModel = [YJUserModel mj_objectWithKeyValues:resultDic[@"object"]];
        
        
        _tableView.tableHeaderView = nil;
        [self prepareheadView];
        
        if ([resultDic[@"object"][@"buyOfPick"] isKindOfClass:[NSArray class]]) {
            NSArray *buyOfPick = resultDic[@"object"][@"buyOfPick"];
            for (NSDictionary * dic in buyOfPick) {
                MCBuyModlel *model = [MCBuyModlel mj_objectWithKeyValues:dic];
                NSString * imageUrl = dic[@"imageUrl"];
                id result = [self analysis:imageUrl];
                if ([result isKindOfClass:[NSArray class]]) {
                    model.imageUrl = result;
                }
                id json = [self analysis:model.json];
                model.Buyjson = [MCBuyjson mj_objectWithKeyValues:json];
                for (NSString * url in model.imageUrl) {
                    YJphotoModel*   photoModel =[[YJphotoModel alloc]init];
                    photoModel.raw = url;
                    [model.YJphotos addObject:photoModel];
                    
                }
                for (NSDictionary * operateOpdic in model.operateOps) {
                    YJoptsModel*   photoModel =[YJoptsModel mj_objectWithKeyValues:operateOpdic];
                    [model.YJoptsArray addObject:photoModel];
                    
                }
                
                
                
                model.MCdescription = dic[@"description"];
                model.userModel = [YJUserModel mj_objectWithKeyValues:model.user];
                [_buyOfPickArray addObject:model];
            }
            

            
        }
        
        if ([resultDic[@"object"][@"buyOfSell"] isKindOfClass:[NSArray class]]) {
            NSArray *buyOfSell = resultDic[@"object"][@"buyOfSell"];
            for (NSDictionary * dic in buyOfSell) {
                MCBuyModlel *model = [MCBuyModlel mj_objectWithKeyValues:dic];
                NSString * imageUrl = dic[@"imageUrl"];
                id result = [self analysis:imageUrl];
                if ([result isKindOfClass:[NSArray class]]) {
                    model.imageUrl = result;
                }
                id json = [self analysis:model.json];
                model.Buyjson = [MCBuyjson mj_objectWithKeyValues:json];
                for (NSString * url in model.imageUrl) {
                    YJphotoModel*   photoModel =[[YJphotoModel alloc]init];
                    photoModel.raw = url;
                    [model.YJphotos addObject:photoModel];
                    
                }
                for (NSDictionary * operateOpdic in model.operateOps) {
                    YJoptsModel*   photoModel =[YJoptsModel mj_objectWithKeyValues:operateOpdic];
                    [model.YJoptsArray addObject:photoModel];
                    
                }
                
                
                
                model.MCdescription = dic[@"description"];
                model.userModel = [YJUserModel mj_objectWithKeyValues:model.user];
               [_buyOfSellArray addObject:model];
            }

            
        }
        
        
        
        if ([resultDic[@"object"][@"travels"] isKindOfClass:[NSArray class]]) {
            
            
            NSArray *travels = resultDic[@"object"][@"travels"];
            for (NSDictionary* dic in travels) {
                homeYJModel * model = [homeYJModel mj_objectWithKeyValues:dic];
                model.userModel = [YJUserModel mj_objectWithKeyValues:dic[@"user"]];
                NSLog(@"%@",model.userModel.isNew);
                
                if (model.photos) {
                    for (NSDictionary * photodic in model.photos) {
                        YJphotoModel * photomodel = [YJphotoModel mj_objectWithKeyValues:photodic];
                        [model.YJphotos addObject:photomodel];
                    }
                }
                
                
                [_travelsArray addObject:model];
            }

            
        }


        
        
        
        if ([_userModel.friends isEqualToString:@"1"]) {
            _isfriend = YES;
        }
        else
        {
            _isfriend = NO;

        }

        
        if ([_userModel.id integerValue] ==[[MCUserDefaults objectForKey:@"id"] integerValue]) {
            
            _tableView.tableFooterView = nil;
            NSLog(@"=====%@",[MCUserDefaults objectForKey:@"id"]);
            NSLog(@"=====%@",_userModel.uid);

        }
        else
        {
            [self prepareFooerView];
        }
        [_tableView reloadData];


    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showHint:description];
        
    }];

    
    
}
-(void)prepareheadView{
    
    _headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 260*MCHeightScale)];
    //    view.backgroundColor = [UIColor redColor];
    _headerView.image = [UIImage imageNamed:@"mine_Background"];
    
    _headerView.userInteractionEnabled = YES;
    _tableView.tableHeaderView = _headerView;
    
    
    
    CGFloat w = 80*MCWidthScale;
    
    CGFloat x = (Main_Screen_Width- w)/2;
    
    CGFloat h = w;
    CGFloat y = 60;
    
    _headBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    ViewRadius(_headBtn, w/2);
    _headBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    _headBtn.layer.borderWidth = 2;
//    [_headBtn addTarget:self action:@selector(actionHeadbtn) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:_headBtn];
    
    [_headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:_userModel.thumbnail] forState:0 placeholderImage:[UIImage imageNamed:@"home_Avatar_146"]];

    //
    
    y +=h + 20;
    w = Main_Screen_Width;
    h = 20;
    w =  [MCIucencyView heightforString:_userModel.nickname?_userModel.nickname :@"" andHeight:20 fontSize:16];
    
    x = (Main_Screen_Width-w)/2;
    _nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _nameLbl.text = _userModel.nickname;
    _nameLbl.textColor = [UIColor whiteColor];
    _nameLbl.font = [UIFont systemFontOfSize:16];
    [_headerView addSubview:_nameLbl];
    
    _biaozhiimg = [[UIImageView alloc]init];
    _biaozhiimg.image = [UIImage imageNamed:@"Lv1"];
    if (_userModel.grade == 1) {
        _biaozhiimg.image = [UIImage imageNamed:@"Lv1"];

    }
    if (_userModel.grade == 2) {
        _biaozhiimg.image = [UIImage imageNamed:@"Lv2"];
        
    }
    if (_userModel.grade == 3) {
        _biaozhiimg.image = [UIImage imageNamed:@"Lv3"];
        
    }
    if (_userModel.grade == 4) {
        _biaozhiimg.image = [UIImage imageNamed:@"Lv4"];
        
    }
    if (_userModel.grade == 5) {
        _biaozhiimg.image = [UIImage imageNamed:@"Lv5"];
        
    }
    
   
    [self updateBiaozhiLbl];
    [_headerView addSubview:_biaozhiimg];
    
    
    y +=h + 10;
    _IdLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, y, Main_Screen_Width, 20)];
    _IdLbl.textColor = [UIColor whiteColor];
    _IdLbl.font = [UIFont systemFontOfSize:13];
    _IdLbl.textAlignment = NSTextAlignmentCenter;
    _IdLbl.text = [NSString stringWithFormat:@"ID：%@",_userModel.userno?_userModel.userno:@""];//@"ID:12345532";
    [_headerView addSubview:_IdLbl];
    
    
    x = 10;
    y += 20 + 10;
    w = (Main_Screen_Width - 50)/4;
    h = 30;
    NSString *travelStr = @"游记";
    if (_userModel.travelOfGrade.length) {
        travelStr = _userModel.travelOfGrade;
    }
    NSString *recommendStr = @"态度";
    if (_userModel.recommendOfGrade.length) {
        recommendStr = _userModel.recommendOfGrade;
    }
    NSString *askForBuyStr = @"发单";
    if (_userModel.askForBuyOfGrade.length) {
        askForBuyStr = _userModel.askForBuyOfGrade;
    }
    NSString *pickOfStr = @"代购";
    if (_userModel.pickOfGrade.length) {
        pickOfStr = _userModel.pickOfGrade;
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
        [_headerView addSubview:btn];
        x += 10 + w;
    }
    
//    
//    
//    _itemView = [[ItemView alloc] initWithFrame:CGRectMake(x, y, Main_Screen_Width , 100)];
//    _itemView.delegate = self;
//    _itemView.itemHeith = 25;
//    
//    _itemView.itemArray = @[@"优秀",@"喷雾剂",@"旷代",@"买了"];
//
//    [_headerView addSubview:_itemView];

    
    
    
}
-(void)action_Btn:(UIButton*)btn{
    
    NSInteger i = btn.tag - 333;
    NSString * detail = @"";
    if (i == 0) {
        detail = _userModel.travelIntro.length ?  _userModel.travelIntro:@"暂时没评论，快去发表作品吧！";
    }
    if (i == 1) {
        detail = _userModel.recommendIntro.length ?  _userModel.recommendIntro:@"暂时没评论，快去发表作品吧！";
    }
    if (i == 2) {
        detail = _userModel.pickIntro.length ?  _userModel.pickIntro:@"暂时没评论，快去发表作品吧！";
    }
    if (i == 3) {
        detail = _userModel.askForBuyIntro.length ?  _userModel.askForBuyIntro:@"暂时没评论，快去发表作品吧！";
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
-(void)prepareFooerView{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 100)];
    _tableView.tableFooterView = view;
    
    
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(40, 30, Main_Screen_Width - 80, 40)];
    btn.backgroundColor = AppCOLOR;
    if (_isfriend) {
        [btn setTitle:@"发送消息" forState:0];

    }
    else
        [btn setTitle:@"加好友" forState:0];

    ViewRadius(btn, 3);
    btn.titleLabel.font  = AppFont;
    [btn addTarget:self action:@selector(actionBtn) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    [view addSubview:btn];
    
    
    
}
- (BOOL)didBuddyExist:(NSString *)buddyName
{
    NSArray *userlist = [[EMClient sharedClient].contactManager getContactsFromDB];
    
    
    for (NSString *username in userlist) {
        if ([username isEqualToString:buddyName]){
            return YES;
        }
    }
    return NO;
}
- (BOOL)hasSendBuddyRequest:(NSString *)buddyName
{
    NSArray *userlist = [[EMClient sharedClient].contactManager getContactsFromDB];
    for (NSString *username in userlist) {
        if ([username isEqualToString:buddyName]) {
            return YES;
        }
    }
    return NO;
}
#pragma mark-点击发消息
-(void)actionBtn{
    if (_isfriend) {
        
        ChatViewController *chatController = [[ChatViewController alloc]initWithConversationChatter:_userModel.hid conversationType:EMConversationTypeChat];
        NSString * nickname = @"";
        if (_userModel.nickname.length) {
            nickname = _userModel.nickname;
        }
        else if(_userModel.mobile.length){
           nickname =  [CommonUtil phonenumbel:_userModel.mobile];
            
        }
        else
        {
            nickname = @"";
        }
        NSString * str = [NSString stringWithFormat:@"与%@聊天中",nickname];
        chatController.title = str;
        chatController.useModel = _userModel;
        [self.navigationController pushViewController:chatController animated:YES];
        
        
        
    }
    else
    {
        
        NSString *buddyName = _userModel.hid;//[self.dataSource objectAtIndex:indexPath.row];
        AddFriendViewController * ctl = [[AddFriendViewController alloc]init];
        
        ctl.addHid = buddyName;
        ctl.uid = _userModel.id;
        [self pushNewViewController:ctl];

        
//        if ([self didBuddyExist:buddyName]) {
//            
//            
//            NSString *message = [NSString stringWithFormat:NSLocalizedString(@"friend.repeat", @"'%@'has been your friend!"), buddyName];
//            
//            [EMAlertView showAlertWithTitle:message
//                                    message:nil
//                            completionBlock:nil
//                          cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
//                          otherButtonTitles:nil];
//            
//        }
//        else if([self hasSendBuddyRequest:buddyName])
//        {
//            NSString *message = [NSString stringWithFormat:NSLocalizedString(@"friend.repeatApply", @"you have send fridend request to '%@'!"), buddyName];
//            [EMAlertView showAlertWithTitle:message
//                                    message:nil
//                            completionBlock:nil
//                          cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
//                          otherButtonTitles:nil];
//            
//        }else{
//        }

        
        
        
        
    }
    
    
    
    
}

#pragma mark-_itemView代理
-(void)itemH:(CGFloat)itemh
{
    _itemView.frame = CGRectMake(CGRectGetMinX(_itemView.frame), CGRectGetMinY(_itemView.frame), CGRectGetWidth(_itemView.frame), itemh + 10);
   CGFloat  h = 250*MCHeightScale - _itemView.mj_y;
    
    if (itemh + 10 > h) {
        
        CGFloat h2 = itemh + 10 - h;
        
        _headerView.frame = CGRectMake(_headerView.mj_x, _headerView.mj_y, _headerView.mj_w, _headerView.mj_h + h2);
        
        _tableView.tableHeaderView = _headerView;

    }
}

-(void)updateBiaozhiLbl{
    _biaozhiimg.frame  =CGRectMake(_nameLbl.mj_x -35 , _nameLbl.mj_y + 1.5, 30, 17);
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isfriend) {
        return 4;
    }
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_isfriend) {
        if (indexPath.row == 3) {
            return 44;
        }
    }
    else
    {
        if (indexPath.row == 1) {
            return 44;
        }

        
    }
    
    CGFloat h = 50;
    
    return h + 20;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_isfriend) {
        if (indexPath.row == 3) {
            static  NSString * cellid1 = @"CarteTableViewCell";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid1];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.textColor = AppTextCOLOR;
            cell.textLabel.text = @"足迹地图";
            return cell;

        
        
        }
    }
    else
    {
        if (indexPath.row == 1) {

            static  NSString * cellid2 = @"CarteTableViewCell";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid2];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid2];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.textColor = AppTextCOLOR;
            cell.textLabel.text = @"足迹地图";
            return cell;

        }
        
        
    }

    
    static  NSString * cellid = @"CarteTableViewCell1";
    CarteTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[CarteTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0) {
        
        [cell prepareUI:@"游记" DataArray:_travelsArray];
        
        return cell;

    }
    if (indexPath.row == 1) {
        [cell prepareUI:@"代购单" DataArray:_buyOfPickArray];
        return cell;
        
    }
    if (indexPath.row == 2) {
        [cell prepareUI:@"售卖单" DataArray:_buyOfSellArray];
        return cell;
        
    }

    return [[UITableViewCell alloc]init];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_isfriend) {
        if (indexPath.row == 3) {
            FenxianViewController * ctl = [[FenxianViewController alloc]init];
            
            
            ctl.uidStr = _userModel.id;
            
                ctl.adlinkurl = [NSString stringWithFormat:@"%@api/travel/chinaMap.jhtml?uid=%ld",AppURL,[_userModel.id integerValue]];
                ctl.adlin2kurl = [NSString stringWithFormat:@"%@api/travel/worldMap.jhtml?uid=%ld",AppURL,[_userModel.id integerValue] ];
                
                [self pushNewViewController:ctl];
            
            

            
            return;
        }
    }
    else
    {
        if (indexPath.row == 1) {
            FenxianViewController * ctl = [[FenxianViewController alloc]init];
            ctl.uidStr = _userModel.id;

                ctl.adlinkurl = [NSString stringWithFormat:@"%@api/travel/chinaMap.jhtml?uid=%ld",AppURL,[_userModel.id integerValue]];
                ctl.adlin2kurl = [NSString stringWithFormat:@"%@api/travel/worldMap.jhtml?uid=%ld",AppURL,[_userModel.id integerValue] ];
                
                [self pushNewViewController:ctl];

            return;
        }
        
        
    }
    
    if (indexPath.row == 0) {
        FriendYJViewController * ctl = [[FriendYJViewController alloc]init];
        ctl.uid = _userModel.id;
        [self pushNewViewController:ctl];
    }
    else if (indexPath.row == 1){
        BuyOnViewController *ctl = [[BuyOnViewController alloc]init];
        ctl.uid = _userModel.id;

        [self pushNewViewController:ctl];
    }
    else if (indexPath.row == 2){
        SellViewController * ctl = [[SellViewController alloc]init];
        
        ctl.uid = _userModel.id;

        [self pushNewViewController:ctl];

        
    }
//    else if (indexPath.row == 3){
//        FenxianViewController * ctl = [[FenxianViewController alloc]init];
//        
//        if ([[MCUserDefaults objectForKey:@"id"] integerValue] ) {
//            ctl.adlinkurl = [NSString stringWithFormat:@"%@api/travel/chinaMap.jhtml?uid=%ld",AppURL,[_userModel.id integerValue]];
//            ctl.adlin2kurl = [NSString stringWithFormat:@"%@api/travel/worldMap.jhtml?uid=%ld",AppURL,[_userModel.id integerValue] ];
//            
//            [self pushNewViewController:ctl];
//        }
//        
//        
//    }

    
    
    

    
    
    
    
    
    
    
    
    
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
