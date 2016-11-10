//
//  ViewController.m
//  YFLBaiduMap
//
//  Created by 杨丰林 on 16/11/9.
//  Copyright © 2016年 杨丰林. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()<BMKMapViewDelegate>

@property (nonatomic ,strong) BMKMapView *mapView;
@property (nonatomic ,assign) BOOL status;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    

}

-(void)initView{
    //nav
    UIButton *rightItemBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightItemBtn setTitle:@"切换" forState:UIControlStateNormal];
    [rightItemBtn setTitleColor:[UIColor colorWithRed:0/255.0 green:245/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
    [rightItemBtn setFrame:CGRectMake(0, 0,60, 40)];
    [rightItemBtn addTarget:self action:@selector(changeMap:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:rightItemBtn];
    self.navigationItem.rightBarButtonItem=rightItem;
    
    //map
    BMKMapView* mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, screenW, screenH)];
    mapView.mapType=BMKMapTypeStandard;
    mapView.delegate=self;
    self.mapView = mapView;
    [self.view addSubview:self.mapView];
    
    //
    
    
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
