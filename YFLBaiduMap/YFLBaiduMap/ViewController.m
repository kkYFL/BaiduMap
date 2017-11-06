//
//  ViewController.m
//  YFLBaiduMap
//
//  Created by 杨丰林 on 16/11/9.
//  Copyright © 2016年 杨丰林. All rights reserved.
//

#import "ViewController.h"
#import "LocationViewController.h"


@interface ViewController ()<BMKMapViewDelegate,BMKBusLineSearchDelegate>

@property (nonatomic ,strong) BMKMapView *mapView;
@property (nonatomic ,assign) BOOL status;

@property (nonatomic, strong) UIButton *locationBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

// SDK  di
-(void)initView{
    //nav 地图切换
    UIButton *rightItemBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightItemBtn setTitle:@"切换" forState:UIControlStateNormal];
    [rightItemBtn setTitleColor:[UIColor colorWithRed:0/255.0 green:245/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
    [rightItemBtn setFrame:CGRectMake(0, 0,60, 40)];
    [rightItemBtn addTarget:self action:@selector(changeMap:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:rightItemBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    //map
    BMKMapView* mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, screenW, screenH)];
    mapView.mapType=BMKMapTypeStandard;
    mapView.delegate=self;
    self.mapView = mapView;
    [self.view addSubview:self.mapView];
    
    UIButton *button = [[UIButton alloc] init];
    button.backgroundColor = [UIColor greenColor];
    [button setFrame:CGRectMake(80, 100, 80, 40)];
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    [button setTitle:@"location" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(locationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    self.locationBtn = button;
  
}



-(void)createMap{

}

-(void)changeMap:(UIButton *)sender{
    _status=!_status;
    if (!_status) {
        //标准
        [_mapView setMapType:BMKMapTypeStandard];
    }else{
        //切换为卫星图
        [_mapView setMapType:BMKMapTypeSatellite];
    }

}

-(void)locationAction:(UIButton *)sender{
    LocationViewController *locationVC = [[LocationViewController alloc] init];
    [self.navigationController pushViewController:locationVC animated:YES];
}







-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.mapView viewWillDisappear];
    
    [self.mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
