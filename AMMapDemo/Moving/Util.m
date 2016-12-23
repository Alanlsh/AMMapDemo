//
//  Util.m
//  AMMapDemo
//
//  Created by Alan on 2016/12/22.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "Util.h"

@implementation Util

+ (CLLocationDirection)calculateCourseFromMapPoint:(MAMapPoint)point1 to:(MAMapPoint)point2
{
    
    //20级坐标y轴向下，需要反过来
    MAMapPoint dp = MAMapPointMake(point2.x - point1.x, point1.y - point2.y);

    if (dp.y == 0) {
        return dp.x < 0?270.f:0.f;
    }
    
    double dir = atan(dp.x/dp.y) * 180.f/M_PI;
    
    if (dp.y > 0)
    {
        if (dp.x < 0)
        {
            dir = dir + 360.f;
        }
    }else
    {
        dir = dir + 180.f;
    }
    return dir;
}

+ (CLLocationDirection)calculateCourseFromCoordinate:(CLLocationCoordinate2D)coordinate1 to:(CLLocationCoordinate2D)coordinate2
{
    MAMapPoint p1 = MAMapPointForCoordinate(coordinate1);
    MAMapPoint p2 = MAMapPointForCoordinate(coordinate2);
    
    return [self calculateCourseFromMapPoint:p1 to:p2];
}

+ (CLLocationDirection)fixNewDirection:(CLLocationDirection)newDir basedOnOldDirection:(CLLocationDirection)oldDir
{
  // the gap between newDir and oldDir would not exceed 180.f degree
    CLLocationDirection turn = newDir - oldDir;
    if (turn > 180.f)
    {
        return newDir - 360.f;
    }else if (turn < -180.f)
    {
        return newDir +360.f;
    }else{
        return newDir;
    }
}



@end
