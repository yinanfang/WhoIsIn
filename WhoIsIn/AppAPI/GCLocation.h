//
//  GCLocation.h
//  WhoIsIn
//
//  Created by Golden Compass on 11/27/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface GCLocation : NSObject

+ (MKCoordinateRegion)getRegionWithDefaultValue;
+ (MKCoordinateRegion)getRegionWithLatitude:(double)latitude longitude:(double)longitude;
+ (MKCoordinateRegion)getRegionWithLatitude:(double)latitude longitude:(double)longitude spanLat:(double)spanLat spanLong:(double)spanLong;


@end
