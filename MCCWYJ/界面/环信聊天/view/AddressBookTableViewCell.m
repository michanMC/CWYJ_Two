//
//  AddressBookTableViewCell.m
//  MCCWYJ
//
//  Created by MC on 16/6/14.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "AddressBookTableViewCell.h"

@implementation AddressBookTableViewCell
-(void)prepareUI{
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat x = 10;
    CGFloat w = 35;
    CGFloat y = 10;
    CGFloat h = 35;
    _imgview = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _imgview.image = [UIImage imageNamed:@"home_Avatar_60"];
    [self.contentView addSubview:_imgview];
    ViewRadius(_imgview, w/2);
    
    x += w + 10;
    w = Main_Screen_Width - x - 100;
    h = 20;
    _nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _nameLbl.textColor = [UIColor darkTextColor];
    [self.contentView addSubview:_nameLbl];

    
    y += h;
    _phoneLbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _phoneLbl.textColor = AppTextCOLOR;
    _phoneLbl.font = AppFont;
    [self.contentView addSubview:_phoneLbl];

    
    x = Main_Screen_Width - 10 - 64;
    y = (35+20-30)/2;
    w = 64;
    h = 30;
    _Registbtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [_Registbtn setTitleColor:[UIColor whiteColor] forState:0];
    [_Registbtn setTitle:@"邀请" forState:0];
    _Registbtn.titleLabel.font = AppFont;
    _Registbtn.backgroundColor = AppCOLOR;
    ViewRadius(_Registbtn, 3);
    [self.contentView addSubview:_Registbtn];

    [_Registbtn addTarget:self action:@selector(actionRegistbtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
}
-(void)actionRegistbtn:(UIButton*)btn{
    
    if (_delegate&&_model&&![_model.isFriend boolValue]&&![_model.isSendInvite boolValue]) {
        
        
            [_delegate showLoading];
        NSDictionary * dic = @{
                         @"mobile":_model.mobile
                           };
    [_delegate.requestManager postWithUrl:@"api/friends/invite.json" refreshCache:NO params:dic IsNeedlogin:YES success:^(id resultDic) {
        [_delegate stopshowLoading];
        NSLog(@"resultDic ===%@",resultDic);
        [_delegate refresData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_delegate showHint:@"发送成功"];
            
        });

        
    } fail:^(NSURLSessionDataTask *operation, NSError *error, NSString *description) {
        [_delegate stopshowLoading];
        [_delegate showAllTextDialog:description];
    }];

        
    }
       
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
