//
//  PlaceAnnotation.m
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 8/3/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import "PlaceAnnotation.h"
#import "Place.h"
#import "PlaceLocation.h"
#import "Category.h"

@implementation PlaceAnnotation

@synthesize place;
@synthesize coordinate;

- (id)initWithPlace:(Place *)currentPlace
{
    self = [super init];
    if (self) {
        [self setPlace:currentPlace];
    }
    
    return self;
}

- (CLLocationCoordinate2D)coordinate
{
    coordinate.latitude = [[[self place] placeLocation] latitude];
    coordinate.longitude = [[[self place] placeLocation] longitude];
    return coordinate;
}

- (NSString *)title
{
    return [place placeName];
}


- (NSString *)subtitle
{
    return [[place category] categoryName];
}

@end
