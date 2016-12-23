//
//  Util.h
//  AMMapDemo
//
//  Created by Alan on 2016/12/22.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>

#define RadToDeg 57.2957795130823228646477218717336654663086 //180.f / M_PI
#define DegToRad 0.0174532925199432954743716805978692718782 // M_PI / 180.f

@interface Util : NSObject

+ (CLLocationDirection)calculateCourseFromMapPoint:(MAMapPoint)point1 to:(MAMapPoint)point2;

+ (CLLocationDirection)calculateCourseFromCoordinate:(CLLocationCoordinate2D)coordinate1 to:(CLLocationCoordinate2D)coordinate2;

+ (CLLocationDirection)fixNewDirection:(CLLocationDirection)newDir basedOnOldDirection:(CLLocationDirection)oldDir;

@end
