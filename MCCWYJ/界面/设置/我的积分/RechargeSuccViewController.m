//
//  RechargeSuccViewController.m
//  MCCWYJ
//
//  Created by MC on 16/5/27.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "RechargeSuccViewController.h"

@interface RechargeSuccViewController ()
{
    
    UIImageView * _imgView;
    
    
}

@end

@implementation RechargeSuccViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.title = @""
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake((Main_Screen_Width - 64)/2, 64 + 70, 64, 64)];
    _imgView.image = [UIImage imageNamed:@"success-prompt"];
    [self.view addSubview:_imgView];
    
    
    UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 64 + 70 + 64 + 20, Main_Screen_Width, 20)];
    lbl.textColor = [UIColor darkTextColor];
    lbl.text = _titleStr;
    lbl.font = [UIFont systemFontOfSize:16];
    lbl.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:lbl];

    lbl = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width/2-Main_Screen_Width/4, 64 + 70 + 64 + 30 + 20 + 5, Main_Screen_Width/2, 40)];
    lbl.textColor = [UIColor darkTextColor];
    lbl.text = _subtitleStr;
    lbl.font = [UIFont systemFontOfSize:14];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.numberOfLines = 0;
    [self.view addSubview:lbl];

    
    
    
    
    // Do any additional setup after loading the view.
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
