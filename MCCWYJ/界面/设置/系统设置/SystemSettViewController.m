//
//  SystemSettViewController.m
//  MCCWYJ
//
//  Created by MC on 16/5/5.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "SystemSettViewController.h"
#import "SettgTableViewCell.h"
@interface SystemSettViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

{
    UITableView *_tableView;
    NSArray *_array;
    CGFloat cacheCount;

}

@end

@implementation SystemSettViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"系统设置";
    _array = @[@[@"系统通知",@"评论通知"],
               @[@"清除缓存"]
               ];
    cacheCount = 0;

 _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.backgroundColor = AppMCBgCOLOR;

    [self.view addSubview:_tableView];
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   , ^{
                       
                       NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
                       cacheCount = [self folderSizeAtPath:cachPath];
                       [self performSelectorOnMainThread:@selector(tableReloadData) withObject:nil waitUntilDone:YES];
                   });

    // Do any additional setup after loading the view.
}
-(void)tableReloadData
{
    [_tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    SettgTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SettgTableViewCell"];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SettgTableViewCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.tileLbl.text = _array[indexPath.section][indexPath.row];
    cell.tileLbl.textColor = AppTextCOLOR;


    if (indexPath.section == 0) {
 
    cell.SWBtn.tag = indexPath.row + 600;
    
    [cell.SWBtn setImage:[UIImage imageNamed:@"toggle-off"] forState:UIControlStateNormal];
    [cell.SWBtn setImage:[UIImage imageNamed:@"toggle-on"] forState:UIControlStateSelected];
    cell.SWBtn.selected = YES;
    [cell.SWBtn addTarget:self action:@selector(actionSwBtn:) forControlEvents:UIControlEventTouchUpInside];
 
    }
    else
    {
//        cell.SWBtn.hidden = YES;
        [cell.SWBtn setImage:nil forState:UIControlStateNormal];
        cell.SWBtn.enabled = NO;
        
        [cell.SWBtn setTitle:[NSString stringWithFormat:@"%.2fM",cacheCount] forState:0];
        [cell.SWBtn setTitleColor:RGBCOLOR(127, 125, 147) forState:0];
        cell.SWBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
    }
    return cell;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否清除本地缓存数据 ?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag = 100;
        [alertView show];

    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 100)
    {
        if (buttonIndex == 1)
        {

            //新建一个项目做测试
            dispatch_async(
                           dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                           , ^{
                               NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
                               NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                               NSLog(@"Path : %@\n files : %@",cachPath,files);
                               for (NSString *p in files) {
                                   NSError *error;
                                   NSString *path = [cachPath stringByAppendingPathComponent:p];
                                   if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                                       [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                                   }
                               }
                               [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];});
            
            
        }
    }
}
-(void)clearCacheSuccess
{
    cacheCount = 0;
    [self showHint:@"清理成功"];
    [_tableView reloadData];
}

-(void)actionSwBtn:(UIButton*)btn{
    
    
    if (btn.selected ) {
        btn.selected = NO;
        
    }
    else
    {
        btn.selected = YES;
    }
    

}
//遍历文件夹获得文件夹大小，返回多少M
- (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

//单个文件的大小
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
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
