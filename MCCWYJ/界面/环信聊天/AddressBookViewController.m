//
//  AddressBookViewController.m
//  MCCWYJ
//
//  Created by MC on 16/6/13.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "AddressBookViewController.h"
#import <AddressBookUI/AddressBookUI.h>
#import <AddressBook/AddressBook.h>
#import "MHContactModel.h"
#import "pinyin.h"
#import "AddressBookModel.h"
#import "AddressBookTableViewCell.h"
@interface AddressBookViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView * _tableView;
    
    NSMutableArray * _dataArray;
    
    NSMutableArray *_userDataArray;
    NSMutableArray * _nameKeyArray;
    
    
}
/** 所有联系人 */
@property (strong, nonatomic) NSMutableArray *dataSource;
/** 排序后所有联系人 */
@property (strong, nonatomic) NSMutableArray *userSource;
@property (strong, nonatomic) NSMutableArray *numArray;
@property (strong, nonatomic) NSMutableDictionary *dict;

@end

@implementation AddressBookViewController
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

- (NSMutableArray *)userSource
{
    if (!_userSource) {
        _userSource = [NSMutableArray new];
    }
    return _userSource;
}
- (NSMutableArray *)numArray
{
    if (!_numArray) {
        _numArray = [NSMutableArray new];
    }
    return _numArray;
}

- (NSMutableDictionary *)dict
{
    if (!_dict) {
        _dict = [NSMutableDictionary new];
    }
    return _dict;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通讯录导入";
    _dataArray = [NSMutableArray array];
    _userDataArray = [NSMutableArray array];
    _nameKeyArray = [NSMutableArray array];
    [self prepareUI];
    
    __weak AddressBookViewController *weakSelf = self;
    __weak UITableView *weaktableView = _tableView;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [weakSelf showLoading];
        [self address];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [weakSelf stopshowLoading];
            
            [weaktableView reloadData];
            [weakSelf loadData];
        });
    });

    
    // Do any additional setup after loading the view.
}
-(void)refresData{
    [_dataArray removeAllObjects];
    [_userDataArray removeAllObjects];
    [self loadData];

}
-(void)prepareUI{
     _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = AppMCBgCOLOR;
    _tableView.sectionIndexBackgroundColor=[UIColor clearColor];

}
-(void)loadData{
    NSMutableArray * Allphonearray = [NSMutableArray array];

    
    for (MHContactModel *addressBook  in self.dataSource) {
        
        for (NSString * phoneStr in addressBook.telArray) {
            
            if ([CommonUtil isMobile:phoneStr]) {
                [Allphonearray addObject:phoneStr];

            }
            
        }

    }
    NSLog(@"Allphonearray ==%@",Allphonearray);
    
    
    if (!Allphonearray.count) {
        return;
    }
    
    
    NSString * phonearrayStr = [Allphonearray componentsJoinedByString:@","];
    
    
    
    [self showLoading];
    NSDictionary * dic = @{
                         @"mobiles":phonearrayStr
                           };
    [self.requestManager postWithUrl:@"api/friends/importContacts.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        NSLog(@"resultDic ===%@",resultDic);
        
        NSArray * objectArray =resultDic [@"object"];
        for (NSDictionary * mcdic in objectArray) {
            AddressBookModel * modle = [AddressBookModel mj_objectWithKeyValues:mcdic];
            [_dataArray addObject:modle];
            
            NSString * mobile = mcdic[@"mobile"];
            
            
            
            for (MHContactModel *addressBook  in self.dataSource) {
                NSString * name =addressBook.name;
                
                
                if ([addressBook.telArray containsObject:mobile]) {
                    
                    NSString*  nickname;
                    
                    if ([mcdic[@"nickname"] length]) {
                        
                        nickname = mcdic[@"nickname"];
                    }
                    else
                    {
                        nickname =name;
                        
                    }
                    modle.nickname =nickname;

                    
                    

                }

            }
            
        }

        
        //整理数据
        [self sortDatas];
        NSLog(@"=====%@",_userDataArray);
        
        if (_userDataArray.count) {
            [_nameKeyArray removeAllObjects];
            for (NSDictionary *dic in _userDataArray) {
                NSNumber *num = [[dic allKeys] lastObject];
                char *a = (char *)malloc(2);
                sprintf(a, "%c", [num charValue]);
                NSString *str = [[NSString alloc] initWithUTF8String:a];
                
                [_nameKeyArray addObject:str];

            }
            
        }
        [self stopshowLoading];

        [_tableView reloadData];
        
        
        
        
        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
    }];
}
//UITableView数据源和代理方法
#pragma mark - 设置section的行数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _userDataArray.count;
}
#pragma mark - 设置section的头部高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
#pragma mark - 设置cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35 + 20;
}
#pragma mark - 设置section显示的内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSDictionary *dic = [_userDataArray objectAtIndex:section];
    
    NSNumber *num = [[dic allKeys] lastObject];
    char *a = (char *)malloc(2);
    sprintf(a, "%c", [num charValue]);
    NSString *str = [[NSString alloc] initWithUTF8String:a];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 30)];
    label.text = [@"    " stringByAppendingString:str];
    label.textAlignment = NSTextAlignmentLeft;
    label.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    return label;
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

#pragma mark - 设置每个section里的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dic = [_userDataArray objectAtIndex:section];
    NSArray *array = [[dic allValues] firstObject];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mc"];
    if (cell == nil) {
        cell = [[AddressBookTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mc"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic = [_userDataArray objectAtIndex:indexPath.section];
    
    NSArray *array = [[dic allValues] lastObject];
    [cell prepareUI];
    AddressBookModel *model = [array objectAtIndex:indexPath.row];
    cell.model =model;
    cell.delegate = self;
    NSString *name = model.nickname;
    NSString *tel = model.mobile;
    [cell.imgview sd_setImageWithURL:[NSURL URLWithString:model.thumbnail] placeholderImage:[UIImage imageNamed:@"home_Avatar_60"]];
    cell.nameLbl.text =name.length == 0 ?@"无":name;
    
    cell.phoneLbl.text = [NSString stringWithFormat:@"手机号:%@",tel];
    if ([model.isFriend boolValue]) {
        
        cell.Registbtn.backgroundColor = [UIColor whiteColor];
        [cell.Registbtn setTitleColor:[UIColor grayColor] forState:0];
        [cell.Registbtn setTitle:@"已添加" forState:0];
    }
    else
    {
        if ([model.isRegist boolValue]) {
            if ([model.isSendInvite boolValue]) {
                cell.Registbtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
                [cell.Registbtn setTitleColor:[UIColor whiteColor] forState:0];
                [cell.Registbtn setTitle:@"已发送" forState:0];

            }
            else
            {
                cell.Registbtn.backgroundColor = AppCOLOR;
                [cell.Registbtn setTitleColor:[UIColor whiteColor] forState:0];
                [cell.Registbtn setTitle:@"邀请" forState:0];
            }
            
        }
        else
        {
            cell.Registbtn.backgroundColor = AppCOLOR;
            [cell.Registbtn setTitleColor:[UIColor whiteColor] forState:0];
            [cell.Registbtn setTitle:@"邀请" forState:0];
        }
    }
    return cell;
}

#pragma mark - 获取通讯录里联系人姓名和手机号
- (void)address
{
    //新建一个通讯录类
    ABAddressBookRef addressBooks = nil;
    
    addressBooks =  ABAddressBookCreateWithOptions(NULL, NULL);
    //获取通讯录权限
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    
    ABAddressBookRequestAccessWithCompletion(addressBooks, ^(bool granted, CFErrorRef error){
        dispatch_semaphore_signal(sema);
    });
    
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
    if (ABAddressBookGetAuthorizationStatus() != kABAuthorizationStatusAuthorized) {
        NSLog(@"权限失败");
        return;
    }
    
    //获取通讯录中的所有人
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBooks);
    //通讯录中人数
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBooks);
    
    //循环，获取每个人的个人信息
    for (NSInteger i = 0; i < nPeople; i++) {
        
        //新建一个addressBook model类
        MHContactModel *addressBook = [[MHContactModel alloc] init];
        addressBook.telArray = [NSMutableArray new];
        //获取个人
        ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
        //获取个人名字
        CFTypeRef abName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
        CFTypeRef abLastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
        CFStringRef abFullName = ABRecordCopyCompositeName(person);
        NSString *nameString = (__bridge NSString *)abName;
        NSString *lastNameString = (__bridge NSString *)abLastName;
        
        if ((__bridge id)abFullName != nil) {
            nameString = (__bridge NSString *)abFullName;
        }
        else {
            if ((__bridge id)abLastName != nil) {
                nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastNameString];
            }
        }
        addressBook.name = nameString;
        
        ABPropertyID multiProperties[] = {
            kABPersonPhoneProperty,
            kABPersonEmailProperty
        };
        NSInteger multiPropertiesTotal = sizeof(multiProperties) / sizeof(ABPropertyID);
        for (NSInteger j = 0; j < multiPropertiesTotal; j++) {
            ABPropertyID property = multiProperties[j];
            ABMultiValueRef valuesRef = ABRecordCopyValue(person, property);
            NSInteger valuesCount = 0;
            if (valuesRef != nil) valuesCount = ABMultiValueGetCount(valuesRef);
            
            if (valuesCount == 0) {
                CFRelease(valuesRef);
                continue;
            }
            //获取电话号码和email
            for (NSInteger k = 0; k < valuesCount; k++) {
                CFTypeRef value = ABMultiValueCopyValueAtIndex(valuesRef, k);
                switch (j) {
                    case 0: {// Phone number
                        NSString *tel = (__bridge NSString*)value;
                        
                        //以下5行请勿删除,请勿修改,隐形代码,删改后果自负
                        tel = [tel stringByReplacingOccurrencesOfString:@"(" withString:@""];
                        tel = [tel stringByReplacingOccurrencesOfString:@")" withString:@""];
                        tel = [tel stringByReplacingOccurrencesOfString:@"-" withString:@""];
                        tel = [tel stringByReplacingOccurrencesOfString:@" " withString:@""];
                        tel = [tel stringByReplacingOccurrencesOfString:@" " withString:@""];
                        
                        [addressBook.telArray addObject:tel];
                        break;
                    }
                }
                CFRelease(value);
            }
            CFRelease(valuesRef);
        }
        //将个人信息添加到数组中，循环完成后addressBookTemp中包含所有联系人的信息
        [self.dataSource addObject:addressBook];
        
        if (abName) CFRelease(abName);
        if (abLastName) CFRelease(abLastName);
        if (abFullName) CFRelease(abFullName);
    }
    
    //整理数据
    //[self sortDatas];
}

#pragma mark - 把联系人按字母排序整理
- (void)sortDatas
{
    //处理(中文姓名 或 字母开头姓名)的联系人
    for (char i = 'A'; i<='Z'; i++) {
        
        NSMutableArray *numArray = [[NSMutableArray alloc] init];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        
        for (int j = 0; j < _dataArray.count; j++) {
            AddressBookModel *model = [_dataArray objectAtIndex:j];
            
            //获取姓名首位
            NSString *string = [model.nickname substringWithRange:NSMakeRange(0, 1)];
            //将姓名首位转换成NSData类型
            NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
            //data的长度大于等于3说明姓名首位是汉字
            if (data.length >= 3)
            {
                //将汉字首字母拿出
                char a = pinyinFirstLetter([model.nickname characterAtIndex:0]);
                
                //将小写字母转成大写字母
                char b = a - 32;
                
                if (b == i) {
                    [numArray addObject:model];
                    [dict setObject:numArray forKey:[NSNumber numberWithChar:i]];
                }
            }
            else {
                //data的长度等于1说明姓名首位是字母或者数字
                if (data.length == 1) {
                    //判断姓名首位是否位小写字母
                    NSString * regex = @"^[a-z]$";
                    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
                    BOOL isMatch = [pred evaluateWithObject:string];
                    if (isMatch == YES) {
                        //NSLog(@"这是小写字母");
                        
                        //把大写字母转换成小写字母
                        char j = i+32;
                        //数据封装成NSNumber类型
                        NSNumber *num = [NSNumber numberWithChar:j];
                        //给a开空间，并且强转成char类型
                        char *a = (char *)malloc(2);
                        //将num里面的数据取出放进a里面
                        sprintf(a, "%c", [num charValue]);
                        //把c的字符串转换成oc字符串类型
                        NSString *str = [[NSString alloc]initWithUTF8String:a];
                        
                        if ([string isEqualToString:str]) {
                            [numArray addObject:model];
                            [dict setObject:numArray forKey:[NSNumber numberWithChar:i]];
                        }
                        
                    }
                    else {
                        //判断姓名首位是否为大写字母
                        NSString * regexA = @"^[A-Z]$";
                        NSPredicate *predA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexA];
                        BOOL isMatchA = [predA evaluateWithObject:string];
                        
                        if (isMatchA == YES) {
                            //NSLog(@"这是大写字母");
                            
                            NSNumber *num = [NSNumber numberWithChar:i];
                            //给a开空间，并且强转成char类型
                            char *a = (char *)malloc(2);
                            //将num里面的数据取出放进a里面
                            sprintf(a, "%c", [num charValue]);
                            //把c的字符串转换成oc字符串类型
                            NSString *str = [[NSString alloc]initWithUTF8String:a];
                            
                            if ([string isEqualToString:str]) {
                                [numArray addObject:model];
                                [dict setObject:numArray forKey:[NSNumber numberWithChar:i]];
                            }
                        }
                    }
                }
            }
        }
        
        if (dict.count != 0) {
            [_userDataArray addObject:dict];
        }
    }
    
    //处理(无姓名 或 数字开头姓名)的联系人
    char n = '#';
    int cont = 0;
    for (int j = 0; j< _dataArray.count; j++) {
        
        AddressBookModel *model = [_dataArray objectAtIndex:j];
        //获取姓名的首位
        NSString *string = [model.nickname substringWithRange:NSMakeRange(0, 1)];
        //将姓名首位转化成NSData类型
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
        
        //判断data的长度是否小于3
        if (data.length < 3) {
            if (cont == 0) {
                cont++;
            }
            if (data.length == 1) {
                //判断首位是否为数字
                NSString * regexs = @"^[0-9]$";
                NSPredicate *preds = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexs];
                BOOL isMatch = [preds evaluateWithObject:string];
                if (isMatch == YES) {
                    //如果姓名为数字
                    [self.numArray addObject:model];
                    [self.dict setObject:self.numArray forKey:[NSNumber numberWithChar:n]];
                }
            }
            else {
                //如果姓名为空
                model.nickname = @"无";
                if (model.mobile.length != 0) {
                    [self.numArray addObject:model];
                    [self.dict setObject:self.numArray forKey:[NSNumber numberWithChar:n]];
                }
            }
        }
    }
    if (self.dict.count != 0) {
        [_userDataArray addObject:self.dict];
    }
    
    
    
    
    
//    //主线程刷新UI
//    [self performSelectorOnMainThread:@selector(updateUI) withObject:nil waitUntilDone:NO];
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
