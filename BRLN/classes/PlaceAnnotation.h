//
//  PlaceAnnotation.h
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 8/3/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class Place;

@interface PlaceAnnotation : NSObject <MKAnnotation>
{
    CLLocationCoordinate2D coordinate;
    Place *place;
}

@property (nonatomic, strong) Place *place;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinates;

- (id)initWithPlace:(id)place;

@end