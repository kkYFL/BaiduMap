//
//  LocationViewController.m
//  YFLBaiduMap
//
//  Created by 杨丰林 on 2017/11/3.
//  Copyright © 2017年 杨丰林. All rights reserved.
//

#import "LocationViewController.h"
#import "Third3DShowController.h"

@interface LocationViewController ()<BMKPoiSearchDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BMKPoiSearch *searcher;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *poiInfoList;
@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    [self initView];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self POISearch];
}

-(void)initView{
    self.title= @"编码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
}

-(void)POISearch{
    //初始化搜索对象 ，并设置代理
    _searcher =[[BMKPoiSearch alloc]init];
    _searcher.delegate = self;
    //请求参数类BMKCitySearchOption
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageIndex = 0;
    citySearchOption.pageCapacity = 10;
    citySearchOption.city= @"全国";
    citySearchOption.keyword = @"清华大学";
    //发起城市内POI检索
    BOOL flag = [_searcher poiSearchInCity:citySearchOption];
    if(flag) {
        NSLog(@"城市内检索发送成功");
    }
    else {
        NSLog(@"城市内检索发送失败");
    }
}

//实现PoiSearchDeleage处理回调结果
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        
        ///<POI列表，成员是BMKPoiInfo
        self.poiInfoList = poiResultList.poiInfoList;
        NSMutableArray *tempDataArr = [NSMutableArray array];
        for (BMKPoiInfo *poi in self.poiInfoList) {
            CLLocationCoordinate2D pt = poi.pt;
        }
         ///<城市列表，成员是BMKCityListInfo
        NSArray *cityList = poiResultList.cityList;

        [self.tableView reloadData];
        
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}
//不使用时将delegate设置为 nil
-(void)viewWillDisappear:(BOOL)animated
{
    _searcher.delegate = nil;
}

#pragma mark - TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.poiInfoList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dataCell"];
    if (self.poiInfoList.count > indexPath.row) {
        BMKPoiInfo *poi = self.poiInfoList[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",poi.name];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.poiInfoList.count > indexPath.row) {
        BMKPoiInfo *poi = self.poiInfoList[indexPath.row];
        CLLocationCoordinate2D pt = poi.pt;
        
        Third3DShowController *thir3DVC = [[Third3DShowController alloc]init];
        thir3DVC.coorDinate2D = pt;
        [self.navigationController pushViewController:thir3DVC animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0f;
}

#pragma mark - 懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        //UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(screenW/2.0, 0, screenW/2.0,[[UIScreen mainScreen]bounds].size.height-64) style:UITableViewStylePlain];
        UITableView *tableView = [[UITableView alloc]init];
        [tableView setFrame:CGRectMake(screenW/2.0, 0, screenW/2.0, screenH)];
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"dataCell"];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:tableView];
        self.tableView = tableView;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
