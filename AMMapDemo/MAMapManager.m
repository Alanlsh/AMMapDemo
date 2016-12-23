//
//  MAMapManager.m
//  AMMapDemo
//
//  Created by Alan on 2016/12/20.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "MAMapManager.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

#import "MyCustomAnnotationView.h"
#import "Util.h"

#import "MovingAnnotationView.h"

@interface MAMapManager ()<MAMapViewDelegate>
{
    BOOL _isFirstLocation;

}
@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) MAPointAnnotation *pointAnnotation;

@property (nonatomic, strong) NSMutableArray *trackings;


@end

@implementation MAMapManager

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mapView];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    button.backgroundColor =[UIColor redColor];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

}

- (void)buttonClicked:(id)sender
{
    [self reloadAnonotationCoordinates:nil];
}

- (void)reloadAnonotationCoordinates:(NSArray *)coordinates
{
    CLLocationCoordinate2D coordinate1 = CLLocationCoordinate2DMake(_pointAnnotation.coordinate.latitude + 0.01, _pointAnnotation.coordinate.longitude + 0.01);
    
    CLLocationCoordinate2D coordinate2 = CLLocationCoordinate2DMake(_pointAnnotation.coordinate.latitude - 0.01, _pointAnnotation.coordinate.longitude + 0.02);
    
    
    CLLocationCoordinate2D coordinate3 = CLLocationCoordinate2DMake(_pointAnnotation.coordinate.latitude + 0.01, _pointAnnotation.coordinate.longitude + 0.01);
    
    CLLocationCoordinate2D coordinate4 = CLLocationCoordinate2DMake(_pointAnnotation.coordinate.latitude + 0.01, _pointAnnotation.coordinate.longitude - 0.04);
    
    
    CLLocationCoordinate2D *acoordinates = (CLLocationCoordinate2D *)malloc(4*sizeof(CLLocationCoordinate2D));
    
    acoordinates[0] = coordinate1;
    acoordinates[1] = coordinate2;
    acoordinates[2] = coordinate3;
    acoordinates[3] = coordinate4;
    
    
    NSArray * points = [self getTrackingWithCoords:acoordinates count:4];
    MyCustomAnnotationView *annotationView = (MyCustomAnnotationView *)[_mapView viewForAnnotation:self.pointAnnotation];
    [annotationView addPaoPaoTrackingAnimationForPoints:points duration:5];
}

// 转换成包含TracingPoint类型对象的数组
-(NSArray *)getTrackingWithCoords:(CLLocationCoordinate2D *)coords count:(NSUInteger)count
{
    _trackings = [NSMutableArray array];
    for (int i = 0; i<count-1; i++)
    {
        TracingPoint * tp = [[TracingPoint alloc] init];
        tp.coordinate = coords[i];
        tp.course = [Util calculateCourseFromCoordinate:coords[i] to:coords[i+1]];
        [_trackings addObject:tp];
    }
    
    TracingPoint * tp = [[TracingPoint alloc] init];
    tp.coordinate = coords[count - 1];
    tp.course = ((TracingPoint *)[_trackings lastObject]).course;
    [_trackings addObject:tp];
    
    return _trackings;
}



#pragma mark - MAMapViewDelegate
/**
 * @brief 根据anntation生成对应的View
 * @param mapView 地图View
 * @param annotation 指定的标注
 * @return 生成的标注View
 */
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{

    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        
        
        MyCustomAnnotationView *annotationView = [[MyCustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier: @"pointReuseIndetifier" bounds:CGRectMake(0, 0, 40, 40)];
//        annotationView.bounds = CGRectMake(0, 0, 40, 40);
        
        
//        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
//        animation.values = @[@0,@(M_PI_2),@(M_PI),@(M_PI + M_PI_2),@(2 * M_PI)];
//        animation.duration = 2.0;
//        animation.repeatCount = CGFLOAT_MAX;
        
        
        annotationView.imageView.image = [UIImage imageNamed:@"userPosition"];

        annotationView.selected = YES;
        

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
        label.backgroundColor = [UIColor blackColor];
        label.text = @"1342411234344431";
        label.textColor = [UIColor blackColor];
        [annotationView.paopaoView addSubview:label];
//        [label.layer addAnimation:animation forKey:@"transform.rotation"];

        return annotationView;
    }

    return nil;
}



/**
 * @brief 位置或者设备方向更新后，会调用此函数
 * @param mapView 地图View
 * @param userLocation 用户定位信息(包括位置与设备方向等数据)
 * @param updatingLocation 标示是否是location数据更新, YES:location数据更新 NO:heading数据更新
 */
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if (!_isFirstLocation) {
        _isFirstLocation = YES;
        
        
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        
        pointAnnotation.coordinate = self.mapView.userLocation.coordinate;
        
        pointAnnotation.title = @"大标题";
        pointAnnotation.subtitle = @"子标题";
        
        
        [self.mapView selectAnnotation:pointAnnotation animated:YES];
        self.pointAnnotation = pointAnnotation;
         
        
        [self.mapView addAnnotation:pointAnnotation];
        
        
        
        self.mapView.centerCoordinate = self.mapView.userLocation.coordinate;
        
    }
    

}

/**
 * @brief 定位失败后，会调用此函数
 * @param mapView 地图View
 * @param error 错误号，参考CLError.h中定义的错误号
 */
- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{


}


#pragma mark - AMapLocationManagerDelegate
/**
 *  当定位发生错误时，会调用代理的此方法。
 *
 *  @param manager 定位 AMapLocationManager 类。
 *  @param error 返回的错误，参考 CLError 。
 */
- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{

}

/**
 *  连续定位回调函数
 *
 *  @param manager 定位 AMapLocationManager 类。
 *  @param location 定位结果。
 */
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{

}


- (MAMapView *)mapView
{
    if (!_mapView) {
        _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
        _mapView.delegate = self;
        _mapView.zoomLevel = 7;
        _mapView.rotateEnabled = NO;
        
        _mapView.showsUserLocation = NO;
        _mapView.userTrackingMode = MAUserTrackingModeNone;
        _mapView.showsUserLocation = YES;
        
        NSLog(@"__________%5f_______%5f_________________",_mapView.userLocation.location.coordinate.latitude,_mapView.userLocation.location.coordinate.longitude);

        
        
    
    }
    return _mapView;
}




@end
