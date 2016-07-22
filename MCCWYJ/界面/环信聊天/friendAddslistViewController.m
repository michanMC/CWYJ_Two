//
//  friendAddslistViewController.m
//  MCCWYJ
//
//  Created by MC on 16/6/7.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "friendAddslistViewController.h"
#import "friendslistModel.h"
#import "ContactListTableViewCell.h"
#import "CarteViewController.h"
#import "YJNoDataTableViewCell.h"
@interface friendAddslistViewController ()<UITableViewDelegate,UITableViewDataSource,ContactListTableViewCellDelegate>
{
    
    
    UITableView*_tableView;
    NSMutableArray *_dataArray;
    NSMutableArray *_nameKeyArray;
    BOOL _isNoData;

}

@end

@implementation friendAddslistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新的朋友";
    //加好友
    NSString * home = @"addfriend";
    [MCUserDefaults setObject:@"0" forKey:home];
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didHomeRemindObjNotification" object:@""];
    
    _dataArray = [NSMutableArray array];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = AppMCBgCOLOR;
    _tableView.sectionIndexBackgroundColor=[UIColor clearColor];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:@selector(actionrightBar)];
    [self friendslistData];

    // Do any additional setup after loading the view.
}
-(void)friendslistData{
    [self showLoading];
    NSDictionary * dic = @{
                           
                           };
    [self.requestManager postWithUrl:@"api/friends/newFriends.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
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
            if(![arrayKey containsObject:nameKey])
                [arrayKey addObject:nameKey];
            
            [array addObject:model];
        }
        
        
        _dataArray = [self grouping:array NamekeyArray:arrayKey];
        if (_dataArray.count) {
            _isNoData = NO;
        }
        else
        {
            _isNoData = YES;
            
        }

        [_tableView reloadData];
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        if (_dataArray.count) {
            _isNoData = NO;
        }
        else
        {
            _isNoData = YES;
            
        }
        [_tableView reloadData];

        [self stopshowLoading];
        [self showAllTextDialog:description];
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
    
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if (_isNoData) {
        return 1;
    }

    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isNoData) {
        return 1;
    }

    // Return the number of rows in the section.
    if (_dataArray.count > section) {
        NSArray * arr = _dataArray[section];
        return arr.count;
    }
    return 0;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isNoData) {
        return self.view.mj_h;
    }

    return 60;

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_isNoData) {
        return 0.001;
    }

    return 30;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_isNoData) {
        return [[UIView alloc]init];;
    }
    

    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 30)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 40, 30)];
    lbl.text = _nameKeyArray[section];
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
    BOOL isA = [self pipeizimu:_nameKeyArray[section]];
    if (isA) {
        return _nameKeyArray[section];
        
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
    if (_isNoData) {
        YJNoDataTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mc2"];
        if (!cell) {
            cell = [[YJNoDataTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mc2"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell prepareNoDataUI:self.view.mj_h TitleStr:@"暂时没有你要查询的数据"];
        //        [cell.tapBtn addTarget:self action:@selector(actionTapBtn) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
        
        
    }
    

    ContactListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[ContactListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (_dataArray.count > indexPath.section) {
        
            friendslistModel * model = _dataArray[indexPath.section][indexPath.row];
        [cell prepareUI3:model];

            [cell.imgview sd_setImageWithURL:[NSURL URLWithString:model.userModel.thumbnail] placeholderImage:[UIImage imageNamed:@"home_Avatar_44"]];
            
            cell.titleLbl.text = model.userModel.nickname;
        if ([model.status isEqualToString:@"1"]) {
            cell.receiveBtn.backgroundColor = [UIColor whiteColor];
            [cell.receiveBtn setTitleColor:[UIColor lightGrayColor] forState:0];
            [cell.receiveBtn setTitle:@"已接受" forState:0];
            
            
        }
        else if ([model.status isEqualToString:@"0"])
        {
          
            cell.receiveBtn.backgroundColor = AppCOLOR;//[UIColor whiteColor];
            [cell.receiveBtn setTitleColor:[UIColor whiteColor] forState:0];
            [cell.receiveBtn setTitle:@"接受" forState:0];

            
        }
        cell.delegate = self;
            return cell;
            
    }
    
    
    
    return [[UITableViewCell alloc]init];
}
-(void)selectModle:(friendslistModel *)molde
{
    if ([molde.status isEqualToString:@"0"])
    {
        if (!molde.friendUid.length) {
            [self showHint:@"无效id"];
            return;
        }
        
    [self showLoading];
    NSDictionary * dic = @{
                         @"friendId":molde.friendUid,
                         @"status":@(1)
                           };
    [self.requestManager postWithUrl:@"api/friends/update.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
        [self friendslistData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"didfriendslistDataObjNotification" object:@""];

            
        });

        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
    }];

        
    }
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_dataArray.count > indexPath.section) {
        
        friendslistModel * model = _dataArray[indexPath.section][indexPath.row];
        
        CarteViewController *ctl = [[CarteViewController alloc]init];
        ctl.userModel = model.userModel;
        
        [self pushNewViewController:ctl];
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
