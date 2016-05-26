//
//  WNImagePicker.m
//  WNImagePicker
//
//  Created by wuning on 16/5/10.
//  Copyright © 2016年 alen. All rights reserved.
//

#import "WNImagePicker.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import "MutiCollectionLayout.h"
#import "AlbumPhotoCell.h"
#import "UIView+Additions.h"
#import "UIImage+Additions.h"
#import "MCxiangceTableViewCell.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "MakeshaidanViewController.h"
#define SCALEMAX 2.0 //放缩的最大值
#define WIDTHHEIGHTLIMETSCALE 3.0/4.0 //限制得到图片的 长宽比例

//获取设备物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//获取设备物理宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface WNImagePicker ()<UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    CGSize orginSize;
    
    UIScrollView *_scrollView;
    UIScrollView * subscrollView;
    
    
    
    
    UIButton *_titleBtn;
    
    UITableView *_tableView;
    BOOL _isshowTableView;
    
    
}
@property (nonatomic, strong) NSMutableArray *assets;
@property (nonatomic, strong) ALAssetsGroup *assetsGroup;
@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong) NSMutableArray *groups;

@property (weak, nonatomic) IBOutlet UIView *photoBgView;
@property (weak, nonatomic) IBOutlet MutiCollectionLayout *collectionLayout;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionPhotos;
@property (strong, nonatomic)  UIImageView *imageSelected;
@end

@implementation WNImagePicker

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _photoBgView.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Width);
    //创建imageView
    _imageSelected = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Width)];
    [_photoBgView addSubview:_imageSelected];
    
    _assetsLibrary = [[ALAssetsLibrary alloc] init];
    _groups = [NSMutableArray array];
    
    _titleBtn = [[UIButton alloc]initWithFrame:CGRectMake(64, 0, Main_Screen_Width - 2*64, 44)];
    _titleBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_titleBtn setTitleColor:RGBCOLOR(127, 125, 147) forState:0];
    
    [_titleBtn setTitle:@"选择照片或拍照" forState:0];
    [_titleBtn addTarget:self action:@selector(actionTitleBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView =_titleBtn;
    
//    self.navigationItem.title = @"选择照片或拍照";
    [self loadLibrary];
    
    _assets = [[NSMutableArray alloc] init];
    [self addGestureRecognizerToView:self.imageSelected];
    
    
    
    CGFloat x = (Main_Screen_Width - 2) / 3;
    CGFloat y = 0;
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(x, y, 1, Main_Screen_Width)];
    lineView.backgroundColor = [UIColor whiteColor];
    [_photoBgView addSubview:lineView];
    
    x +=1 +x;
    lineView = [[UIView alloc]initWithFrame:CGRectMake(x, y, 1, Main_Screen_Width)];
    lineView.backgroundColor = [UIColor whiteColor];
    [_photoBgView addSubview:lineView];

    y =(Main_Screen_Width - 2) / 3;
    x = 0;
    
    lineView = [[UIView alloc]initWithFrame:CGRectMake(x, y, Main_Screen_Width, 1)];
    lineView.backgroundColor = [UIColor whiteColor];
    [_photoBgView addSubview:lineView];

    y += 1 + y;
    
    lineView = [[UIView alloc]initWithFrame:CGRectMake(x, y, Main_Screen_Width, 1)];
    lineView.backgroundColor = [UIColor whiteColor];
    [_photoBgView addSubview:lineView];

    
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - 64)];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.hidden = !_isshowTableView;
    [self.view addSubview:_tableView];
    
//    _tableView.hidde
    
    
}
-(void)actionTitleBtn{
    
    if (_isshowTableView) {
        _isshowTableView = NO;
        _tableView.hidden = YES;
    }
    else
    {
        _isshowTableView = YES;
        _tableView.hidden = NO;


    }
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _groups.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellid = @"MCxiangceTableViewCell";
    MCxiangceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[MCxiangceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (_groups.count > indexPath.row) {
        ALAssetsGroup *groupmodle = _groups[indexPath.row];
        NSString* groupname = [groupmodle valueForProperty:ALAssetsGroupPropertyName];
        CGImageRef poster = [groupmodle posterImage];
        
        cell.imgView.image =[UIImage imageWithCGImage:poster];
        cell.titleLbl.text =groupname;
        

        
        
        return cell;
    }
    
    return [[UITableViewCell alloc]init];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_groups.count > indexPath.row) {
        ALAssetsGroup *groupmodle = _groups[indexPath.row];
        NSString* groupname = [groupmodle valueForProperty:ALAssetsGroupPropertyName];
        CGImageRef poster = [groupmodle posterImage];
        
        [_titleBtn setTitle:groupname forState:0];
        [self loadAssetGroup:groupmodle];

        
        
//        cell.imgView.image =[UIImage imageWithCGImage:poster];
//        cell.titleLbl.text =groupname;
        
        
        _isshowTableView = NO;
        _tableView.hidden = YES;

        
    }

    
    
}

//手势的响应方法
-(void)tapAction:(UITapGestureRecognizer *)tap
{
    
        //如果取得的滚动视图的缩放比例是大于等于2,那说明是放大过的,需要还原
        if (subscrollView.zoomScale >= 2) {
            //将滚动视图还原成原图大小
            [subscrollView setZoomScale:1 animated:YES];
        }
        else
        {
            //将指定的一个区域放大到全屏
            //先获取事件触发的点,在滚动视图的什么位置上,获取这个点
            CGPoint locationPoint = [tap locationInView:subscrollView];
            CGRect rect = CGRectMake(locationPoint.x - 20, locationPoint.y - 20, 40, 40);
            [subscrollView zoomToRect:rect animated:YES];
        }
    
        
        
 
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initNavi];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initNavi
{
    [self.collectionPhotos registerNib:[UINib nibWithNibName:@"AlbumPhotoCell" bundle:nil] forCellWithReuseIdentifier:@"AlbumPhotoCell"];
    self.collectionLayout.widthHeightScale = 1;
    self.collectionLayout.lineSpacing = 0;
    self.collectionLayout.interitemSpacing = 0;
    self.collectionLayout.numberOfItemForLine = 4;
    self.collectionLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark -- 加载资源库
- (void)loadLibrary
{
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
        //        headerView.hidden = YES;
        
        NSString *errorMessage = nil;
        switch ([error code]) {
            case ALAssetsLibraryAccessUserDeniedError:
            case ALAssetsLibraryAccessGloballyDeniedError:
            {
                errorMessage = @"The user has declined access to it.";
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"当前不能查看照片，请进入IPAD设置->隐私->照片->在XXX应用后面打开开关" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
            }
                break;
            default:
                errorMessage = @"Reason unknown.";
                break;
        }
    };
    
    // emumerate through our groups and only add groups that contain photos
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop) {
        
        ALAssetsFilter *assetsFilter = nil;
        assetsFilter = [ALAssetsFilter allAssets];
        [group setAssetsFilter:assetsFilter];
        if ([group numberOfAssets] > 0)
        {
            [self.groups addObject:group];
            //            [_collectionView reloadData];
            
            //            [NSObject cancelPreviousPerformRequestsWithTarget:_collectionView selector:@selector(reloadData) object:nil];
            [self performSelectorOnMainThread:@selector(loadLibraryComplete) withObject:nil waitUntilDone:NO];
        }
        else
        {
            
        }
    };
    
    // enumerate only photos
    NSUInteger groupTypes = ALAssetsGroupAlbum | ALAssetsGroupEvent | ALAssetsGroupFaces | ALAssetsGroupSavedPhotos;
    groupTypes = ALAssetsGroupAll; // 遍历全部相册
    [self.assetsLibrary enumerateGroupsWithTypes:groupTypes usingBlock:listGroupBlock failureBlock:failureBlock];
}

- (void)loadLibraryComplete
{
    [_tableView reloadData];
    // 结束以后,如果没有选中的相册，加载第一个相册的照片并显示
    if (_groups.count > 0 && !_assetsGroup) {
        ALAssetsGroup * aa =[_groups lastObject];
        NSString *ss = [aa valueForProperty:@"ALAssetsGroupPropertyName"];
        [_titleBtn setTitle:ss forState:0];//count
//        int count = [group numberOfAssets];

        [self loadAssetGroup:[_groups lastObject]];
    }
}

#pragma mark 加载相册
- (void)loadAssetGroup:(ALAssetsGroup *)group
{
    _assetsGroup = group;
    
    [self.assets removeAllObjects];
    
    //    NSString *title = [group valueForProperty:ALAssetsGroupPropertyName];
    //    [self configTitleViewWithTitle:title];
    
    ALAssetsGroupEnumerationResultsBlock assetsEnumerationBlock = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            [self.assets addObject:result];
        }
    };
    
    ALAssetsFilter *onlyPhotosFilter = nil;
    onlyPhotosFilter = [ALAssetsFilter allPhotos];
    [self.assetsGroup setAssetsFilter:onlyPhotosFilter];
    [self.assetsGroup enumerateAssetsUsingBlock:assetsEnumerationBlock];
    
    self.assets = [NSMutableArray arrayWithArray:[[self.assets reverseObjectEnumerator] allObjects]];
    [self implement:self.assets];
    
}

- (void)implement:(NSMutableArray *)array
{
    
    [_collectionPhotos reloadData];
    if (array.count > 1) {
        [_collectionPhotos selectItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    }
    if (array.count > 0) {
        ALAsset *asset = [_assets objectAtIndex:0];
        
        ALAssetRepresentation *assetRepresentation = [asset defaultRepresentation];
        UIImage *fullScreenImage = [UIImage imageWithCGImage:[assetRepresentation fullResolutionImage]
                                                       scale:[assetRepresentation scale]
                                                 orientation:(int)[assetRepresentation orientation]];
        [self setCoverImage:fullScreenImage];
    }
}

#pragma mark -- 添加手势
- (void) addGestureRecognizerToView:(UIView *)view
{
    // 旋转手势
    [view setUserInteractionEnabled:YES];
    [view setMultipleTouchEnabled:YES];
    //    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateView:)];
    //    [view addGestureRecognizer:rotationGestureRecognizer];
    
    // 缩放手势
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
//    view.maximumZoomScale=5.0;//图片的放大倍数
//    scrollView.minimumZoomScale=1.0;//图片的最小倍率
//    [panRecognizer setMinimumNumberOfTouches:2];
//    [panRecognizer setMaximumNumberOfTouches:2];
    [view addGestureRecognizer:pinchGestureRecognizer];
    
    // 移动手势
    //UITapGestureRecognizer
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    panGestureRecognizer.maximumNumberOfTouches = 1;
    [view addGestureRecognizer:panGestureRecognizer];
}

- (void)setCoverImage:(UIImage *)theImage
{

    CGFloat WHScale = theImage.size.width / theImage.size.height;
    
    CGFloat rule = ScreenWidth * WIDTHHEIGHTLIMETSCALE;
    CGSize imageViewSize;
    if (WHScale > 1) {
        CGFloat height = ScreenWidth/WHScale;
        if (height < rule) {
            height = rule;
            imageViewSize = CGSizeMake(height*WHScale, height);
        }else{
            imageViewSize = CGSizeMake(ScreenWidth, height);
        }
    }else{
        CGFloat width = ScreenWidth*WHScale;
        if (width < rule) {
            width = rule;
            imageViewSize = CGSizeMake(width, width/WHScale);
        }else{
            imageViewSize = CGSizeMake(width, ScreenWidth);
        }
    }
    self.imageSelected.contentMode = UIViewContentModeScaleToFill;
    [self.imageSelected setImage:theImage];
    //[self.imageSelected setTranslatesAutoresizingMaskIntoConstraints:YES];
    self.imageSelected.frame = CGRectMake(0, 0, imageViewSize.width, imageViewSize.height);
    self.imageSelected.center = CGPointMake(self.imageSelected.superview.width / 2.0f, self.imageSelected.superview.height / 2.0f);
    
    orginSize = self.imageSelected.frame.size;
}

#pragma mark -- 手势代码实现
// 处理缩放手势
- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    UIView *view = pinchGestureRecognizer.view;
    
    
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        pinchGestureRecognizer.scale = 1;
        
    }
    
    
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        _photoBgView.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Width);

        
        CGFloat rule = view.width > view.height?view.width:view.height;
        
        
        
        CGFloat min = ScreenWidth * WIDTHHEIGHTLIMETSCALE;
       
        if (rule < ScreenWidth) {
            CGFloat width;
            CGFloat height;
            if (view.width > view.height) {
                width = ScreenWidth;
                height = ScreenWidth * view.height / view.width;
            }else{
                height = ScreenWidth;
                width = ScreenWidth * view.width / view.height;
            }
            
            if (width < min || height < min) {
                width = orginSize.width;
                height = orginSize.height;
            }
            
            [UIView animateWithDuration:0.2 animations:^{
                view.width = width;
                view.height = height;
                view.center = CGPointMake(view.superview.width / 2.0, view.superview.height / 2.0);
                
            }];
        }else{
            CGFloat width = view.width;
            CGFloat height = view.height;
            if (width > SCALEMAX * orginSize.width || height > SCALEMAX * orginSize.height) {
                height = SCALEMAX * orginSize.height;
                width = SCALEMAX * orginSize.width;
            }
            if (width < min || height < min) {
                width = orginSize.width;
                height = orginSize.height;
            }
            CGPoint center = view.center;
            if (width < ScreenWidth) {
                center.x = view.superview.width / 2.0;
            }
            if (height < ScreenWidth) {
                center.y = view.superview.height / 2.0;
            }
            
            [UIView animateWithDuration:0.2 animations:^{
                view.width = width;
                view.height = height;
                view.center = center;
            }];
        }
        
    }
}
//-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
//{
//    
//    NSLog(@"ssss%@",scrollView);
//    //取出小滚动视图中的图片视图进行放大
//    //接收手势的这个视图是里面的小滚动视图
//    return subscrollView;
//}

//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    //判断,如果传进来的参数视图是外层的滚动视图才去计算页码
//    if (scrollView == _scrollView) {
//        NSInteger index = scrollView.contentOffset.x /320;
//        _pageCtl.currentPage = index;
//        
//        //遍历一遍大滚动视图里的所有的小滚动视图,将小滚动视图的缩放还原为1
//        for (UIScrollView * scroll in _scrollView.subviews) {
//            [scroll setZoomScale:1 animated:YES];
//        }
//    }
//    
//}

// 处理拖拉手势
- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
//    _photoBgView.frame = CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Width);

//    //如果取得的滚动视图的缩放比例是大于等于2,那说明是放大过的,需要还原
//    if (subscrollView.zoomScale >= 2) {
//        //将滚动视图还原成原图大小
//        [subscrollView setZoomScale:1 animated:YES];
//    }
//    else
//    {
//        //将指定的一个区域放大到全屏
//        //先获取事件触发的点,在滚动视图的什么位置上,获取这个点
//        CGPoint locationPoint = [panGestureRecognizer locationInView:subscrollView];
//        CGRect rect = CGRectMake(locationPoint.x - 20, locationPoint.y - 20, 40, 40);
//        [subscrollView zoomToRect:rect animated:YES];
//    }
//
//    
//    
//    return;
    UIView *view = panGestureRecognizer.view;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:view.superview];
        [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
        [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
    }
    if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint center = view.center;
        
        if (view.width <= ScreenWidth)
        {
            center.x = ScreenWidth / 2.0f;
        }else{
            if (view.originX > 0) {
                center.x -= view.originX;
            }else{
                if ((ScreenWidth - center.x) > view.width / 2.0f) {
                    center.x += (ScreenWidth - center.x) - view.width / 2.0f;
                }
            }
        }
        
        if (view.height <= ScreenWidth) {
            center.y = ScreenWidth / 2.0f;
        }else{
            if (view.originY > 0) {
                center.y -= view.originY;
            }else{
                if((ScreenWidth - center.y) > view.height / 2.0f){
                    CGFloat offSet =(ScreenWidth - center.y)-view.height / 2.0f;
                    center.y += offSet;
                }
            }
        }
        [UIView animateWithDuration:0.2 animations:^{
            view.center = center;
        }];
        
    }
}

#pragma mark -- UICollectionViewDelegate and DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assets.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
//    return [[UICollectionViewCell alloc]init];
    
    
    AlbumPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AlbumPhotoCell" forIndexPath:indexPath];

    
    
    if (indexPath.row == 0) {
        cell.imageCover.image = [UIImage imageNamed:@"icon_camera1"];
        
    }else{
        ALAsset *asset = [_assets objectAtIndex:indexPath.row - 1];
        
        CGImageRef thumbnailImageRef = [asset thumbnail];
        UIImage *thumbnail = [UIImage imageWithCGImage:thumbnailImageRef];
        
        // apply the image to the cell
       cell.imageCover.image = thumbnail;
    }
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusDenied) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"当前不能拍摄，请进入IPAD设置->隐私->相机->在衣橱大爆炸应用后面打开开关" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            return;
        }
        [self useCamera];
    }else{
        ALAsset *asset = [_assets objectAtIndex:indexPath.row - 1];
        
        ALAssetRepresentation *assetRepresentation = [asset defaultRepresentation];
        UIImage *fullScreenImage = [UIImage imageWithCGImage:[assetRepresentation fullResolutionImage]
                                                       scale:[assetRepresentation scale]
                                                 orientation:(int)[assetRepresentation orientation]];
        
        [self setCoverImage:fullScreenImage];
        
        
        [UIView animateWithDuration:0.25 animations:^{
            self.collectionPhotos.frame = CGRectMake(0, self.photoBgView.height, self.view.width, self.view.height - self.photoBgView.height);
            self.photoBgView.originY = 0;
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView.tag == 8000 ||scrollView.tag == 9000 ) {
        return;
    }
    
    
    if (scrollView == self.collectionPhotos) {
        if (scrollView.contentOffset.y > 10 && self.photoBgView.originY == 0) {
            [UIView animateWithDuration:0.25 animations:^{
                self.collectionPhotos.frame = self.view.bounds;
                self.photoBgView.originY = self.photoBgView.height * -1;
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                
            }];
        }
        
        if (scrollView.contentOffset.y < -20 && self.photoBgView.originY == -self.photoBgView.height) {
            [UIView animateWithDuration:0.25 animations:^{
                self.collectionPhotos.frame = CGRectMake(0, self.photoBgView.height, self.view.width, self.view.height - self.photoBgView.height);
                self.photoBgView.originY = 0;
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}
#pragma mark -- UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [self setCoverImage:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image == nil){
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    [self setCoverImage:image];
    // 刷新当前相册
//    if (isCameraAutoSavePhoto) {
        if([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
            NSLog(@"MLSelectPhoto : 保存成功");
        }else{
            NSLog(@"MLSelectPhoto : 没有用户权限,保存失败");
        }
//    }

    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self implement:self.assets];
}

#pragma mark -- ActionMethod
- (void)leftBarAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
//    if ([self.delegate respondsToSelector:@selector(onCancel:)]) {
//        [self.delegate onCancel:self];
//    }
}

- (void)rightBarAction
{
    CGFloat scraled = self.imageSelected.image.size.width / self.imageSelected.frame.size.width;
    
    CGFloat imgX;
    CGFloat imgY;
    CGFloat imgW;
    CGFloat imgH;
    
    if (self.imageSelected.width <= ScreenWidth)
    {
        imgX = 0;
        imgW = self.imageSelected.width;
    }else{
        imgX = -(self.imageSelected.originX);
        imgW = ScreenWidth;
    }
    
    if (self.imageSelected.height <= ScreenWidth) {
        imgY = 0;
        imgH = self.imageSelected.height;
    }else{
        imgY = - (self.imageSelected.originY);
        imgH = ScreenWidth;
    }
    
    CGRect rect = CGRectMake(imgX*scraled, imgY*scraled, imgW*scraled, imgH*scraled);
    
    
    
    UIImage *imageCut = [self.imageSelected.image getSubImage:rect];

    MakeshaidanViewController * ctl = [[MakeshaidanViewController alloc]init];
    ctl.img =imageCut;
    [self.navigationController pushViewController:ctl animated:YES];
                                
}

-(void)useCamera
{
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    pickerController.delegate = self;
    pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    pickerController.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
    [self presentViewController:pickerController animated:YES completion:nil];
}
@end
