//
//  VTSelectionPickerView.m
//  huiyang
//
//  Created by Mac on 14-2-21.
//  Copyright (c) 2014年 wwj. All rights reserved.
//
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#import "GKHpickerAddressView.h"
@interface GKHpickerAddressView ()
{
   

}

@property (weak,nonatomic) UITextField *textfield;

//data
//@property (strong, nonatomic) NSDictionary *pickerDic;
@property (nonatomic,copy)NSString *provinceStr;
@property (nonatomic,copy)NSString *cityStr;
@property (nonatomic,copy)NSString *regionStr;
@property (nonatomic,assign)NSInteger component1;

@property (strong, nonatomic) NSMutableArray *provinceArray;
@property (strong, nonatomic) NSMutableArray *cityArray;
@property (strong, nonatomic) NSMutableArray *townArray;
@property (strong, nonatomic) NSMutableArray *selectedArray;
@end
@implementation GKHpickerAddressView
GKHpickerAddressView * instance;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _component1 = 0;
    }
    return self;
}

+ (GKHpickerAddressView *)shareInstancePickerAddressByctrl:(UIViewController *)ctrl DataArray:(NSMutableArray*)arr block:(passStrValueBlock)block;{
//    static dispatch_once_t   p;
//    dispatch_once(&p,^{
        instance=[[GKHpickerAddressView alloc] init];
        [instance setBackgroundColor:[UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.0]];
        [instance setUserInteractionEnabled:YES];
        [instance createPickerView];
        [ctrl.view endEditing:YES];
        [ctrl.view addSubview:instance];
        [instance.textfield becomeFirstResponder];
   //});
    
    
    //
    instance.dataArray = arr;
    instance.provinceStr = @"";
    instance.cityStr = @"";
    instance.regionStr = @"";
    instance.component1 = 0;
    [instance.pickerView selectRow:0 inComponent:0 animated:YES];
    [instance.pickerView selectRow:0 inComponent:1 animated:YES];
    [instance.pickerView selectRow:0 inComponent:2 animated:YES];
    
    
    [instance getPickerData];
    [instance.textfield becomeFirstResponder];
    instance.valueBlock=block;
    instance.ctrl=ctrl;
    [instance.pickerView reloadAllComponents];
    return instance;
}
- (void)getPickerData {
    
    _provinceArray = [NSMutableArray array];
    _cityArray = [NSMutableArray array];
    _selectedArray = [NSMutableArray array];
    _townArray = [NSMutableArray array];

    if (_dataArray.count) {
        
    for (LocationsModel * model1 in _dataArray) {
        [_provinceArray addObject:model1.Name];
    }
        if (_provinceArray.count) {
            _provinceStr = _provinceArray[0];
        }
        
        
        
        LocationsModel * model  = _dataArray[0];
        
        for (CityModel * cmodel in model.CityArray) {
            [_cityArray addObject:cmodel.Name];
            
            for (RegionModel * rmodel in cmodel.RegionArray) {
                [_townArray addObject:rmodel.Name];
                
            }
            
        }
        if (_cityArray.count) {
            _cityStr = _cityArray[0];
        }
        if (_townArray.count) {
            _regionStr = _townArray[0];
        }

    }

}
-(void)createPickerView
{
    if (self.pickerView==nil) {
        UITextField *TextField=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        TextField.hidden=YES;
        [self addSubview:TextField];
        self.textfield=TextField;
        self.pickerView= [[UIPickerView alloc] init];
        self.pickerView.delegate=self;
        self.pickerView.dataSource=self;
        UIToolbar *keyboardToolbar;
        if (keyboardToolbar == nil) {
            keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 38.0f)];
            keyboardToolbar.barStyle = UIBarStyleBlackTranslucent;
        }
        UIBarButtonItem *doneBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"完成",@"") style:UIBarButtonItemStylePlain target:self   action:@selector(dismiss)];
        [doneBarItem setTintColor:[UIColor whiteColor]];
        keyboardToolbar.backgroundColor=[UIColor blackColor];
        keyboardToolbar.superview.backgroundColor=[UIColor clearColor];
        [keyboardToolbar setItems:[NSArray arrayWithObjects:doneBarItem,nil]];
        //    NSLog(@"%lu",(unsigned long)self.keyboardToolbar.subviews.count);
        self.textfield.inputAccessoryView =keyboardToolbar;
        self.textfield.inputView=self.pickerView;
    }
}
#pragma  mark -UIPickViewDelegate-

#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return _provinceArray.count;
        
    } else if (component == 1) {
        return _cityArray.count;
    } else {
        return _townArray.count;
    }
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *lable=[[UILabel alloc]init];
    lable.textAlignment=NSTextAlignmentCenter;
    lable.font=[UIFont systemFontOfSize:13];
    if (component == 0) {
        lable.text=[self.provinceArray objectAtIndex:row];
    } else if (component == 1) {
        
        
        lable.text=[self.cityArray objectAtIndex:row];
    } else {
        lable.text=[self.townArray objectAtIndex:row];
    }
    return lable;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        return Main_Screen_Width/3-10;
    } else if (component == 1) {
        return Main_Screen_Width/3;
    } else {
        return Main_Screen_Width/3;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _provinceStr = @"";
    _cityStr = @"";
    _regionStr = @"";
    
    if (component == 0) {
        
        LocationsModel * model  = _dataArray[row];
        _provinceStr = model.Name;
        _component1 = row;
        [_cityArray removeAllObjects];
        [_townArray removeAllObjects];

        for (CityModel * cmodel in model.CityArray) {
            [_cityArray addObject:cmodel.Name];
            
            for (RegionModel * rmodel in cmodel.RegionArray) {
                [_townArray addObject:rmodel.Name];
                
            }
            
        }
        if (_cityArray.count) {
            _cityStr = _cityArray[0];
        }
        if (_townArray.count) {
            _regionStr = _townArray[0];
        }

        [pickerView selectedRowInComponent:1];
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];

        [pickerView reloadComponent:2];

    }
    
    
    
    if (component == 1) {
        LocationsModel * model  = _dataArray[_component1];
        _provinceStr = model.Name;

        
        [_townArray removeAllObjects];

        CityModel * cmodel = model.CityArray[row];
        _cityStr = cmodel.Name;

        for (RegionModel * rmodel in cmodel.RegionArray) {
            [_townArray addObject:rmodel.Name];
            
        }
        if (_townArray.count) {
            _regionStr = _townArray[0];
        }

        [pickerView selectRow:0 inComponent:2 animated:YES];
        [pickerView reloadComponent:2];

    }
}
-(void)dismiss{
    [self.textfield resignFirstResponder];
    
    if (_provinceArray.count) {

    _provinceStr =self.provinceArray[[self.pickerView selectedRowInComponent:0]];
    
    }
    else
    {
       _provinceStr = @"";
    }
    if (_cityArray.count) {
        _cityStr=self.cityArray[[self.pickerView selectedRowInComponent:1]];

    }
    else
    {
        _cityStr = @"";
 
    }
    if (_townArray.count) {
        _regionStr=self.townArray[[self.pickerView selectedRowInComponent:2]];
    }
    else
        _regionStr= @"";
    NSString *string=[NSString stringWithFormat:@"%@%@%@",_provinceStr,_cityStr,_regionStr];
//    
//
    
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:_provinceStr forKey:@"province"];
    [dic setObject:_cityStr forKey:@"city"];
    [dic setObject:_regionStr forKey:@"region"];

    self.valueBlock(self.ctrl,string,dic);
}



@end
