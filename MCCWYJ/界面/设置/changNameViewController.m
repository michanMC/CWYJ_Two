//
//  changNameViewController.m
//  MCCWYJ
//
//  Created by MC on 16/5/3.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "changNameViewController.h"

@interface changNameViewController ()<UITextFieldDelegate>
{
    
    UITextField *_textField;
    
    
}

@end

@implementation changNameViewController
//-(void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//    
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改昵称";
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64)];
    view.backgroundColor =AppMCBgCOLOR;//[UIColor groupTableViewBackgroundColor];
    [self.view addSubview:view];
    
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 64, Main_Screen_Width - 20, 40)];
    lbl.text = @"昵称最长为8个汉字，或16个数字、字母";
    lbl.textColor = AppTextCOLOR;
    lbl.font = AppFont;
    [self.view addSubview:lbl];
    view = [[UIView alloc]initWithFrame:CGRectMake(0, 64 + 40, Main_Screen_Width, 44)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, Main_Screen_Width - 20, 44)];
    
    [view addSubview:_textField];
    _textField.text = [MCUserDefaults objectForKey:@"nickname"];
   _textField.placeholder = @"设置昵称";
    [_textField addTarget:self action:@selector(actionText:) forControlEvents:UIControlEventEditingChanged];
    _textField.delegate = self;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(actionBtn)];
    
    
    
    // Do any additional setup after loading the view.
}
-(void)actionBtn{
    
    [_textField resignFirstResponder];
    
    if (_textField.text.length) {
        NSString * nameStr =_textField.text;
        //发送通知
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"dischangenameObjNotification" object:nameStr];
        
        
        
        
        NSString *str=nameStr;//Notification.object;
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
            
            str=nameStr;
        }
        
        
        NSDictionary * Parameterdic = @{
                                        @"nickname":str
                                        };
        
        
        
        [self showLoading];
        [self.requestManager postWithUrl:@"api/user/profiles/updateNickname.json" refreshCache:NO params:Parameterdic IsNeedlogin:YES success:^(id resultDic) {
            [self stopshowLoading];
            NSLog(@"修改成功%@",resultDic);
            /*保存数据－－－－－－－－－－－－－－－－－begin*/
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            [defaults setObject :str forKey:@"nickname"];
            
            //强制让数据立刻保存
            [defaults synchronize];
            [self showHint:@"保存成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
                
            });

            
        } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
            [self stopshowLoading];
            [self showAllTextDialog:description];
            
        }];

        
        
        
        
    }
 
    
}
-(void)actionText:(UITextField*)text{
    
    //获取文本框内容的字节数
    NSString * aString = text.text;//[text.text stringByReplacingCharactersInRange:range withString:string];
    int bytes = [self stringConvertToInt:aString];
    
    if (bytes >8)
    {
        text.text=[text.text substringToIndex:8];
        
        
    }

    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]){
        return NO;
    }

    //获取文本框内容的字节数
    NSString * aString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    int bytes = [self stringConvertToInt:aString];

    //设置不能超过32个字节，因为不能有半个汉字，所以以字符串长度为单位。
    return YES;
    
}
//得到字节数函数
- (int)stringConvertToInt:(NSString*)strtemp
{
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++)
    {
        if (*p) { 
            p++; 
            strlength++; 
        } 
        else { 
            p++; 
        }
    }
    return (strlength+1)/2;
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
