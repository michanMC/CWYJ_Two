//
//  MakeViewController.m
//  MCCWYJ
//
//  Created by MC on 16/5/5.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MakeViewController.h"

@interface MakeViewController ()<UIScrollViewDelegate>
{
    UIScrollView * _ScrollView;
    
    
    
}

@end

@implementation MakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"制作游记";
    _ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64)];
    
    _ScrollView.delegate =self;
    [self.view addSubview:_ScrollView];
       
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
