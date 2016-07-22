//
//  ContactListViewController.m
//  MCCWYJ
//
//  Created by MC on 16/6/7.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "ContactListViewController.h"
#import "ContactListTableViewCell.h"
#import "friendslistModel.h"
#import "friendAddslistViewController.h"
#import "CarteViewController.h"
#import "AddressBookViewController.h"
#import "ChatViewController.h"
#import "RecomFriendViewController.h"
@interface ContactListViewController ()<EaseUserCellDelegate,UIActionSheetDelegate,UITableViewDelegate,UITableViewDataSource,ContactListTableViewCellDelegate,UIAlertViewDelegate>
{
    
    UITableView*_tableView;
    NSMutableArray *_dataArray;
    NSMutableArray *_nameKeyArray;
    friendslistModel *_delemodel;
    NSString *_sessionId;
    NSMutableArray *_UnreadMessageArray;

}
@property (nonatomic) NSInteger unapplyCount;

@end

@implementation ContactListViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [self reloadApplyView];
    [self setupUnreadMessageCount];
    [_tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"好友列表";
    //监听数据的刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(friendslistData) name:@"didfriendslistDataObjNotification" object:nil];
     _sessionId = [MCUserDefaults objectForKey:@"sessionId"];

    _dataArray = [NSMutableArray array];
//    _seleFirIDArray = [NSMutableArray array];
     _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.sectionIndexBackgroundColor=[UIColor clearColor];
    _tableView.backgroundColor = AppMCBgCOLOR;

    [self.view addSubview:_tableView];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"wqe" style:UIBarButtonItemStylePlain target:self action:@selector(actionrightBar)];
    //timeline_relationship_icon_addattention
   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_icon_add"] style:UIBarButtonItemStylePlain target:self action:@selector(actionrightBar)];
    
    [self friendslistData];
//    [self setupUnreadMessageCount];
    // Do any additional setup after loading the view.
}

// 统计未读消息数
-(void)setupUnreadMessageCount
{
    _UnreadMessageArray = [NSMutableArray array];
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    NSInteger unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
        NSLog(@"conversationId == %@",conversation.conversationId);
       if(!conversation.latestMessage.isRead)
       {
           [_UnreadMessageArray addObject:conversation.conversationId];
 
       }
    }
    if (unreadCount == 0) {
        [_UnreadMessageArray removeAllObjects];
    }
    NSLog(@"unreadCount  === %zd",unreadCount);
    NSLog(@"_UnreadMessageArray == %@",_UnreadMessageArray);
}





-(void)friendslistData{
    [self showLoading];
    NSDictionary * dic = @{
                         
                           };
    [self setupUnreadMessageCount];
    [self.requestManager postWithUrl:@"api/friends/list.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
        NSArray * arra = resultDic[@"object"];
        NSMutableArray * arrayKey = [NSMutableArray array];
        NSMutableArray * array = [NSMutableArray array];

        for (NSDictionary *dic in arra) {
            friendslistModel * model = [friendslistModel mj_objectWithKeyValues:dic];
            
            model.userModel = [YJUserModel mj_objectWithKeyValues:dic[@"friend"]];
            if (!model.userModel.nickname.length) {
                model.userModel.nickname = [CommonUtil phonenumbel:model.userModel.mobile];
            }
            NSString * nameKey = [self firstCharactor:model.userModel.nickname?model.userModel.nickname:@"未知"];
            model.nameKey = nameKey;
            model.hid = model.userModel.hid;
            if(![arrayKey containsObject:nameKey])
                [arrayKey addObject:nameKey];

            [array addObject:model];
        }
        
        
        _dataArray = [self grouping:array NamekeyArray:arrayKey];

        [_tableView reloadData];
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showHint:description];
           }];
    
    
    
}
-(NSMutableArray*)grouping:(NSMutableArray*)array NamekeyArray:(NSMutableArray*)nameKeyArray{
    NSMutableArray *groupingArray =[NSMutableArray array];
    //字母排序
    _nameKeyArray = (NSMutableArray*)[nameKeyArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    NSInteger count = _nameKeyArray.count;
    NSMutableArray * mcarray = [[NSMutableArray alloc]initWithArray:_nameKeyArray];
    BOOL ishas = NO;
    for (int i = 0; i < mcarray.count; i++) {
        NSString * keys = mcarray[i];
        BOOL is_A = [self pipeizimu:keys];
        if (!is_A) {
            [mcarray removeObject:keys];
            ishas = YES;
            i --;
            if (i < 0) {
                i  = -1;
            }
            count--;
        }
        if (i == mcarray.count - 1) {
            if (ishas)
                [mcarray addObject:@"#"];
            break;
        }
    }
    NSLog(@"%@",mcarray);
    _nameKeyArray= [[NSMutableArray alloc]initWithArray:mcarray];
    
    NSMutableDictionary * dicArray = [NSMutableDictionary dictionary];
    for (NSString * keyStr in _nameKeyArray) {//根据字母创建各个数组
        NSMutableArray * arrayData = [NSMutableArray array];
        //判断是不是字母开头的
        BOOL isA = [self pipeizimu:keyStr];
        
        if (isA)
            [dicArray setObject:arrayData forKey:keyStr];
        else
            [dicArray setObject:arrayData forKey:@"#"];
        
        
    }
    
    for (friendslistModel*model in array) {//为各个数组加载对应的对象
        NSLog(@">>>%@",model.nameKey);
        //判断是不是字母开头的
        BOOL isA = [self pipeizimu:model.nameKey];
        if (isA)
            [[dicArray objectForKey:model.nameKey] addObject:model];
        else
            [[dicArray objectForKey:@"#"] addObject:model];
        
        
    }
    BOOL isjia = NO;
    for (NSString * keyStr in _nameKeyArray) {//从字典里分离出
        
        BOOL isA = [self pipeizimu:keyStr];
        NSArray * arr = [NSArray array];
        if (isA)
            arr =[dicArray objectForKey:keyStr];
        else{
            
            arr =[dicArray objectForKey:@"#"];
            if (!isjia){
                [groupingArray addObject:arr];
                // [_nameKeyArray addObject:@"#"];
                
            }
            isjia = YES;
            continue;
        }
        //        if (isjia) {
        //            continue;
        //        }
        
        [groupingArray addObject:arr];
    }
    NSLog(@">>>>%@",groupingArray);
    
    
    
    return groupingArray;
}
#pragma mark 正则表达式
-(BOOL)pipeizimu:(NSString *)str
{
    
    NSCharacterSet *disallowedCharacters = [[NSCharacterSet
                                             characterSetWithCharactersInString:@"QWERTYUIOPLKJHGFDSAZXCVBNMqwertyuioplkjhgfdsazxcvbnm "] invertedSet];
    NSRange foundRange = [str rangeOfCharacterFromSet:disallowedCharacters];
    if (foundRange.location != NSNotFound) {
        return NO;
    }
    return YES;
    
    //判断是否以字母开头
    // NSString *ZIMU = @"/^[a-zA-z]/";
    NSString *ZIMU = @"/^[a-z][A-Z]/";
    
    NSPredicate *regextestA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ZIMU];
    // NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ZIMU];
    
    if ([regextestA evaluateWithObject:str] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
- (NSString *)firstCharactor:(NSString *)aString
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    if (!pinYin.length) {
        pinYin = @"#";
    }
    //获取并返回首字母
    return [pinYin substringToIndex:1];
}

-(void)actionrightBar{
    AddressBookViewController * ctl = [[AddressBookViewController alloc]init];
    [self pushNewViewController:ctl];
}
- (void)reloadApplyView
{
    NSInteger count = [[[ApplyViewController shareController] dataSource] count];
    self.unapplyCount = count;
    
    [_tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if (_isSelect) {
        return _dataArray.count;
    }
    return _dataArray.count+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (_isSelect) {

        NSArray * arr = _dataArray[section];
        
        return arr.count;

    
    }
    if (section == 0) {
        return 2;
    }
    else
    {
        NSArray * arr = _dataArray[section-1];
        
        return arr.count;
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isSelect) {
        return 50;

    }
    if (indexPath.section == 0) {
        return 60;
    }
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_isSelect) {
        return 30;

    }
    if(section == 0)
    return 10;
    return 30;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 30)];
    view.backgroundColor = AppMCBgCOLOR;//[UIColor groupTableViewBackgroundColor];
    if (!_isSelect)
    if (section == 0) {
        view.frame = CGRectMake(0, 0, Main_Screen_Width, 10);
        return view;
    }

    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 40, 30)];
    if (_isSelect) {
        lbl.text = _nameKeyArray[section];

    }else
    lbl.text = _nameKeyArray[section-1];
    //判断是不是字母开头的
    BOOL isA = [self pipeizimu:lbl.text];
    if (!isA) {
        lbl.text = @"#";
    }
    
    lbl.font = [UIFont systemFontOfSize:14];
    [view addSubview:lbl];
    // lbl.backgroundColor = [UIColor blackColor];
    return view;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (!_isSelect)
    {
    if (section==0) {
        return @"";
    }
}
    BOOL isA = [self pipeizimu:_nameKeyArray[section-1]];
    if (isA) {
        return _nameKeyArray[section-1];
        
    }
    
    return @"#";
}
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
     return _nameKeyArray;
//    return @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"#"];
}
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSLog(@"%d--%@",index,title);
    return  [_nameKeyArray indexOfObject:title];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
      static NSString * cellid = @"ContactListTableViewCell";
        ContactListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[ContactListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    if (_isSelect) {
        if (_dataArray.count > indexPath.section) {
            
            friendslistModel * model = _dataArray[indexPath.section][indexPath.row];
            cell.issele = _isSelect;
            cell.issfabu = _issfabu;
            [cell prepareUI2:model];
            cell.delegate = self;
            [cell.imgview sd_setImageWithURL:[NSURL URLWithString:model.userModel.thumbnail] placeholderImage:[UIImage imageNamed:@"home_Avatar_44"]];
            
            cell.titleLbl.text = model.userModel.nickname;
            cell.hongview.hidden = YES;
            return cell;
            
        }
        
    }
    if (indexPath.section == 0) {

            [cell prepareUI1];
        if (indexPath.row == 0) {
            
            cell.imgview.image = [UIImage imageNamed:@"icon_new-friend"];
            cell.titleLbl.text = @"新的朋友";
            cell.titlesubLbl.text = @"xxx申请加你为好友";
            //加好友
            NSString * home = @"addfriend";
            NSInteger index = [[MCUserDefaults objectForKey:home] integerValue];
            
            if (index) {
                cell.hongview.hidden = NO;

            }
            else
            {
                cell.hongview.hidden = YES;

            }

        }
        else
        {
            cell.imgview.image = [UIImage imageNamed:@"icon_-recommend"];
            cell.titleLbl.text = @"推荐好友";
            cell.titlesubLbl.text = @"你有3个推荐好友";
            cell.hongview.hidden = YES;
  
        }
        
        return cell;
    }
    else
    {
        if (_dataArray.count > indexPath.section-1) {

            friendslistModel * model = _dataArray[indexPath.section-1][indexPath.row];
            [cell prepareUI2:model];
            cell.delegate = self;
            [cell.imgview sd_setImageWithURL:[NSURL URLWithString:model.userModel.thumbnail] placeholderImage:[UIImage imageNamed:@"home_Avatar_44"]];
            //3918bb2078ab0bbc3b23b1b10b8f9618,
            //b64ff98138ddb22ab8ab4178504eb502,
            cell.titleLbl.text = model.userModel.nickname;
            
            if ([_UnreadMessageArray containsObject:model.hid]) {
                
                cell.hongview.hidden = NO;
                return cell;

            }
            else
            {
                cell.hongview.hidden = YES;
                return cell;

  
            }
            
        
        }
    }
    
    return [[UITableViewCell alloc]init];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_issfabu) {
        return;
    }
    if (_isSelect&&!_issfabu) {
        if (_dataArray.count > indexPath.section) {
            
            friendslistModel * model = _dataArray[indexPath.section][indexPath.row];
            NSString * ss=  [_userDatamodle mj_JSONString];

            EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:ss];
            
            NSString *from = [[EMClient sharedClient] currentUsername];
            
            
            //生成Message
            EMMessage *message = [[EMMessage alloc] initWithConversationID:model.userModel.hid from:from to:model.userModel.hid body:body ext:@{}];
            message.ext = @{@"is_card_call":@(1)}; // 扩展消息部分
//            [message seta]
//            [message ]
//            [message setattr]
            message.chatType = EMChatTypeChat;// 设置为单聊消息
            __weak typeof(self) weakself = self;
            [[EMClient sharedClient].chatManager asyncSendMessage:message progress:nil completion:^(EMMessage *aMessage, EMError *aError) {
                NSLog(@"aMessage == %@",aMessage);
                
                if (!aError) {
                    [self showHint:@"分享成功"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                       
    ChatViewController *chatController = [[ChatViewController alloc]initWithConversationChatter:model.userModel.hid conversationType:EMConversationTypeChat];
                        
                        NSString * nickname = @"";
                        if (model.userModel.nickname.length) {
                            nickname = model.userModel.nickname;
                        }
                        else if(model.userModel.mobile.length){
                            nickname =  [CommonUtil phonenumbel:model.userModel.mobile];
                            
                        }
                        else
                        {
                            nickname = @"";
                        }
                        NSString * str = [NSString stringWithFormat:@"与%@聊天中",nickname];
                        chatController.title = str;
                        chatController.useModel = model.userModel;
                        [self.navigationController pushViewController:chatController animated:YES];
                        
                        

                        
//                        [self.navigationController popViewControllerAnimated:YES];
                        
                    });

                }
                
                
                
                
                
            }];

            
            
            
            return;
            ChatViewController *chatController = [[ChatViewController alloc]initWithConversationChatter:model.friendUid conversationType:EMConversationTypeChat];
            
            NSString * str = [NSString stringWithFormat:@"与%@聊天中",model.userModel.nickname.length > 0 ? model.userModel.nickname : model.userModel.hid];
            chatController.title = str;
            chatController.useModel = model.userModel;
            [self.navigationController pushViewController:chatController animated:YES];
            

        }
        return;
    }
    if (indexPath.section == 0&& indexPath.row == 0) {
        friendAddslistViewController * ctl = [[friendAddslistViewController alloc]init];
        [self pushNewViewController:ctl];
    }
    if (indexPath.section == 0&& indexPath.row == 1) {
        RecomFriendViewController * ctl = [[RecomFriendViewController alloc]init];
        [self pushNewViewController:ctl];
    }
    if (indexPath.section !=0) {
        
        if (_dataArray.count > indexPath.section-1) {
            
            friendslistModel * model = _dataArray[indexPath.section-1][indexPath.row];
            CarteViewController *ctl = [[CarteViewController alloc]init];
            ctl.userModel = model.userModel;
            
            if ([model.status isEqualToString:@"1"]) {
                ctl.isfriend = YES;
            }
            [self pushNewViewController:ctl];
        
        }
  
        
    }
    

}
-(void)selectModle2:(friendslistModel *)molde IsAdd:(BOOL)isadd{
    
    if ([molde.status isEqualToString:@"1"]) {
        if (!molde.id.length) {
            [self showHint:@"无效id"];
            return;
        }
    }
    if (isadd) {
        [_seleFirIDArray addObject:molde.id];
    }
    else
    {
        if ([_seleFirIDArray containsObject:molde.id]) {
            [_seleFirIDArray removeObject:molde.id];
        }
    }

    
}
-(void)selectModle:(friendslistModel *)molde
{
    
    
    if ([molde.status isEqualToString:@"1"]) {
        if (!molde.id.length) {
            _delemodel = nil;
            [self showHint:@"无效id"];
            return;
        }
        _delemodel = molde;
        
        UIAlertView * al = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"是否删除该好友" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [al show];

    }
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        [self showLoading];
        if (!_delemodel.friendUid) {
            [self showHint:@"无效id"];
            return;
        }
        NSDictionary * dic = @{
                               @"friendId":_delemodel.friendUid,
                               @"status":@(2)
                               };
        [self.requestManager postWithUrl:@"api/friends/update.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
            [self stopshowLoading];
            NSLog(@"resultDic ===%@",resultDic);
            [self friendslistData];
            _delemodel = nil;
            
        } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
            [self stopshowLoading];
            [self showAllTextDialog:description];
        }];
        

        
        
    }
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
