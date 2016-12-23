//
//  MyCustomAnnotationView.h
//  AMMapDemo
//
//  Created by Alan on 2016/12/21.
//  Copyright © 2016年 Alan. All rights reserved.
//

///注意 移动的时候地图不支持旋转

// 可设置起泡  add..到paopaoView上面    paopaoView可根据需要设置frame
//可以做移动动画

#import <MAMapKit/MAMapKit.h>
#import "TracingPoint.h"


@interface MyCustomAnnotationView : MAAnnotationView

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic,strong) UIView *paopaoView;

/**
 @brief 添加动画
 @param points 轨迹点串，每个轨迹点为TracingPoint类型
 @param duration 动画时长，包括从上一个动画的终止点过度到新增动画起始点的时间
 */
- (void)addPaoPaoTrackingAnimationForPoints:(NSArray *)points duration:(CFTimeInterval)duration;

/// 初始化使用此方法
- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier  bounds:(CGRect)bounds;




@end
