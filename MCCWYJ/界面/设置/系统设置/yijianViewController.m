//
//  yijianViewController.m
//  CWYouJi
//
//  Created by MC on 15/11/19.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "yijianViewController.h"
#import "UIPlaceHolderTextView.h"
@interface yijianViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
{
    
      UITableView *_tableView;
    UIPlaceHolderTextView * _textView;
    
}

@end

@implementation yijianViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    [self.view addSubview:_tableView];
    self.navigationItem.rightBarButtonItem =  [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(actionSend)];

    // Do any additional setup after loading the view.
}
-(void)actionSend{
    NSLog(@"%@",_textView.text);
    [_textView resignFirstResponder];
    if (!_textView.text.length) {
        kAlertMessage(@"请写下你宝贵的意见");
        return;
    }
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
   NSString * mobile =  [defaults objectForKey:@"UserName"];
    
    if(!mobile || !mobile.length){
        [self showAllTextDialog:@"亲，你还没登录"];
        return;
    }
    NSDictionary * Parameterdic = @{
                                    @"content":_textView.text,
                                    @"mobile":mobile,
                                    @"imei":IMEI,
                                    @"device":@(2)
                                    };
    
    
    [self showLoading];
    [self.requestManager postWithUrl:@"api/global/feedback.json" refreshCache:NO params:Parameterdic IsNeedlogin:YES success:^(id resultDic) {
        [self stopshowLoading];
        NSLog(@"成功");
        NSLog(@"返回==%@",resultDic);
        [self showAllTextDialog:@"发送成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.navigationController popViewControllerAnimated:YES];
        });


    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [self stopshowLoading];
        [self showAllTextDialog:description];
        
        NSLog(@"失败");

    }];
    
    
    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }
    UILabel * lbl = (UILabel*)[self.view viewWithTag:600];
    
    NSString * aString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    if ([aString length] > 250) {
        //[_tableview reloadData];
     
        
        return NO;
    }
    return YES;
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
       return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 200;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mc4"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mc4"];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    _textView = [[UIPlaceHolderTextView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 200)];
    _textView.placeholder =@"写下你的宝贵意见";
    _textView.textColor = AppTextCOLOR;
    _textView.font = AppFont;
    [cell.contentView addSubview:_textView];
    _textView.delegate =self;
    
    
    
    return cell;

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
