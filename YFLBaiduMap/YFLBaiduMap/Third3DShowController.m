//
//  Third3DShowController.m
//  YFLBaiduMap
//
//  Created by 杨丰林 on 2017/11/7.
//  Copyright © 2017年 杨丰林. All rights reserved.
//

#import "Third3DShowController.h"
#import <BaiduPanoSDK/BaiduPanoramaView.h>
#import <BaiduPanoSDK/BaiduPanoramaView.h>
@interface Third3DShowController ()<BaiduPanoramaViewDelegate>
@property (nonatomic, strong) BaiduPanoramaView *panoramaView;
@property (nonatomic, strong) UIButton *third3DBtn;
@end

@implementation Third3DShowController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
    [self BD3DshowView];
}

-(void)initView{
    self.navigationItem.title = @"3D地图";
}



-(void)BD3DshowView{
    CGRect frame = CGRectMake(0, 0, screenW, screenH);

    // key 为在百度LBS平台上统一申请的接入密钥ak 字符串
    self.panoramaView = [[BaiduPanoramaView alloc] initWithFrame:frame key:@"wybZnM7pHjkdNDP3pfExeqe8iA03TkCu"];
    // 为全景设定一个代理
    self.panoramaView.delegate = self;
    [self.view addSubview:self.panoramaView];
    // 设定全景的清晰度， 默认为middle
    [self.panoramaView setPanoramaImageLevel:ImageDefinitionHigh];
    // 设定全景的pid， 这是指定显示某地的全景，/Work/Code/app/panosdk2/ios/demo/BaiduPanoDemo/BaiduPanoDemo也可以通过百度坐标进行显示全景
    // [self.panoramaView setPanoramaWithPid:@"01002200001309101607372275K"];
    // 西单大悦城坐标
    [self.panoramaView setPanoramaWithLon:self.coorDinate2D.longitude lat:self.coorDinate2D.latitude];
    //[self.panoramaView setPanoramaWithLon:116.379918 lat:39.916634];

}

#pragma mark - panorama view delegate

- (void)panoramaWillLoad:(BaiduPanoramaView *)panoramaView {
    
}

- (void)panoramaDidLoad:(BaiduPanoramaView *)panoramaView descreption:(NSString *)jsonStr {
    
}


- (void)panoramaLoadFailed:(BaiduPanoramaView *)panoramaView error:(NSError *)error {
    
}

- (void)panoramaView:(BaiduPanoramaView *)panoramaView overlayClicked:(NSString *)overlayId {
    
}

- (void)panoramaView:(BaiduPanoramaView *)panoramaView didReceivedMessage:(NSDictionary *)dict {
    
}

- (void)dealloc {
    [self.panoramaView removeFromSuperview];
    self.panoramaView.delegate = nil;
    self.panoramaView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
