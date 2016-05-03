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
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_textField resignFirstResponder];

    if (_textField.text.length) {
        NSString * nameStr =_textField.text;
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dischangenameObjNotification" object:nameStr];
    
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改昵称";
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
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
    
    _textField.delegate = self;
    
    // Do any additional setup after loading the view.
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
    if (bytes >8)
    {
        //超出字节数，还是原来的内容
        return NO;
    }
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
