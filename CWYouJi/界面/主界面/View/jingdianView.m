//
//  jingdianView.m
//  CWYouJi
//
//  Created by MC on 15/11/15.
//  Copyright © 2015年 MC. All rights reserved.
//

#import "jingdianView.h"
#import "jingdianModel.h"
#import "jingdianlieTableViewCell.h"
@interface jingdianView ()<UITableViewDataSource,UITableViewDelegate>{
    
    
    
}

@end

@implementation jingdianView
-(instancetype)initWithFrame:(CGRect)frame

{
    self = [super initWithFrame:frame];
    if (self) {
      
    }
    return self;
    
    
}
-(void)prepareUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, self.frame.size.height) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
    

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return _jingdianArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static  NSString * cellid = @"jingdianlieTableViewCell";
    
    
    jingdianlieTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"jingdianlieTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"jingdianlieTableViewCell" owner:self options:nil]lastObject];
    }
    
    if (_jingdianArray.count > indexPath.row) {
        jingdianModel *model = _jingdianArray[indexPath.row];
    cell.titleLbl.text = model.nameCH;
    cell.titleLbl.font = [UIFont systemFontOfSize:14];
    cell.titleLbl.textColor = AppTextCOLOR;
        
        
        
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    jingdianModel *model = _jingdianArray[indexPath.row];

    [_delegate jingdianStr:model.nameCH SpotId:model.id];
    
    
}
-(void)setJingdianArray:(NSMutableArray *)jingdianArray
{
    
    _jingdianArray = jingdianArray;
    [_tableView reloadData];
    
    
}
#pragma mark-分割线没有显示全，左边有一段缺失：
-(void)viewDidLayoutSubviews {
    [super layoutSubviews];
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
