//
//  LocationViewController.m
//  YFLBaiduMap
//
//  Created by 杨丰林 on 2017/11/3.
//  Copyright © 2017年 杨丰林. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()<BMKGeoCodeSearchDelegate>
@property (nonatomic, strong)BMKGeoCodeSearch *geocodesearch;               //检索对象
@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title= @"编码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self geoCodeWithAddress:@""];
}


#pragma mark ----地理编码
- (void)geoCodeWithAddress:(NSString *)address
{
    BMKGeoCodeSearchOption *geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    geoCodeSearchOption.city= @"北京";
    geoCodeSearchOption.address = @"北京大学";
    BOOL flag = [self.geocodesearch geoCode:geoCodeSearchOption];
    if(flag)
    {
        NSLog(@"geo检索发送成功");
    }
    else
    {
        NSLog(@"geo检索发送失败");
    }
}

//检索对象
- (BMKGeoCodeSearch *)geocodesearch
{
    if (!_geocodesearch)
    {
        _geocodesearch = [[BMKGeoCodeSearch alloc] init];
        _geocodesearch.delegate = self;
    }
    return _geocodesearch;
}

//实现Deleage处理回调结果
//接收正向编码结果
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR)
    {
        //在此处理正常结果
        NSLog(@"经纬度是 === %.2f  %.2f",result.location.latitude, result.location.longitude);
        //[self walkSearchFrom:self.fromCoor to:result.location];
    }
    else
    {
        NSLog(@"抱歉，未找到结果");
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
