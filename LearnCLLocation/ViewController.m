//
//  ViewController.m
//  LearnCLLocation
//
//  Created by zhifu360 on 2018/6/6.
//  Copyright © 2018年 智富金融. All rights reserved.
//

#import "ViewController.h"
#import "ZZJLocation.h"

@interface ViewController ()<ZZJLocationDelagate>

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) ZZJLocation *location;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setPage];
}

- (void)setPage {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.label.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 20);
    [self.view addSubview:self.label];
    
    //开始更新定位
    [self.location beginUpdatingLocation];
}

///获取定位得到的城市
- (void)getLocationCity:(NSString *)city {
    
    self.label.text = [NSString stringWithFormat:@"当前城市为：%@", city];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ZZJLocationDelagate

- (void)locationDidEndUpdatingLocation:(Location *)location {
    
    //在此对需要的数据进行处理使用
    NSLog(@"国家：%@",location.country);
    NSLog(@"省/直辖市：%@",location.administrativeArea);
    NSLog(@"地级市/直辖市区：%@",location.locality);
    NSLog(@"县/区：%@",location.subLocality);
    NSLog(@"街道：%@",location.thoroughfare);
    NSLog(@"子街道：%@",location.subThoroughfare);
    
    NSLog(@"经度：%lf",location.longitude);
    NSLog(@"纬度：%lf",location.latitude);
}

#pragma mark - lazy

- (UILabel *)label {
    
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:18];
        _label.textColor = [UIColor purpleColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.text = @"正在定位。。。";
    }
    return _label;
}

- (ZZJLocation *)location {
    
    if (!_location) {
        _location = [[ZZJLocation alloc] init];
        _location.delegate = self;
    }
    return _location;
}

@end














