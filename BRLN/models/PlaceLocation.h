//
//  PlaceLocation.h
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 8/20/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Place;

@interface PlaceLocation : NSManagedObject

@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic, retain) Place *place;

@end
