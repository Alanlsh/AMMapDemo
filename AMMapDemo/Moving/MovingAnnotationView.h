//
//  MovingAnnotationView.h
//  AMMapDemo
//
//  Created by Alan on 2016/12/22.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "TracingPoint.h"


@interface MovingAnnotationView : MAPinAnnotationView

/**
 @brief 添加动画
 @param points 轨迹点串，每个轨迹点为TracingPoint类型
 @param duration 动画时长，包括从上一个动画的终止点过度到新增动画起始点的时间
 */
- (void)addTrackingAnimationForPoints:(NSArray *)points duration:(CFTimeInterval)duration;

@end
