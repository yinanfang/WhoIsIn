//
//  GCLocation.m
//  WhoIsIn
//
//  Created by Golden Compass on 11/27/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCLocation.h"

@implementation GCLocation

+ (MKCoordinateRegion)getRegionWithDefaultValue
{
    CLLocationCoordinate2D coord = (CLLocationCoordinate2D){.latitude = 40, .longitude = -100};
    MKCoordinateSpan span = {.latitudeDelta =  30, .longitudeDelta =  30};
    MKCoordinateRegion region = {coord, span};
    return region;
}

+ (MKCoordinateRegion)getRegionWithLatitude:(double)latitude longitude:(double)longitude
{
    return [GCLocation getRegionWithLatitude:latitude longitude:longitude spanLat:0.2 spanLong:0.2];
}

+ (MKCoordinateRegion)getRegionWithLatitude:(double)latitude longitude:(double)longitude spanLat:(double)spanLat spanLong:(double)spanLong
{
    CLLocationCoordinate2D coord = (CLLocationCoordinate2D){.latitude = latitude, .longitude = longitude};
    MKCoordinateSpan span = {.latitudeDelta =  spanLat, .longitudeDelta =  spanLong};
    MKCoordinateRegion region = {coord, span};
    return region;
}
@end
