//
//  TracingPoint.h
//  AMMapDemo
//
//  Created by Alan on 2016/12/22.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface TracingPoint : NSObject

/**
 @brief 轨迹经纬度
 */
@property (nonatomic) CLLocationCoordinate2D coordinate;


/**
 @brief 方向，有效范围0~359.9度
 */
@property (nonatomic) CLLocationDirection course;



@end
