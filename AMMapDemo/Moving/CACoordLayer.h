//
//  CACoordLayer.h
//  AMMapDemo
//
//  Created by Alan on 2016/12/22.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <MAMapKit/MAMapKit.h>

@interface CACoordLayer : CALayer

@property (nonatomic, assign) MAMapView *mapView;

@property (nonatomic) double mapx;

@property (nonatomic) double mapy;

@property (nonatomic) CGPoint centerOffset;

@end

@interface MAMapView (Additional)

- (CGPoint)pointForMapPoint:(MAMapPoint)mapPoint;

@end
