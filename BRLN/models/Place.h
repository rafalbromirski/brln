//
//  Place.h
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 8/3/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Category, PlaceLocation;

@interface Place : NSManagedObject

@property (nonatomic) BOOL favorited;
@property (nonatomic, retain) NSString * placeDescription;
@property (nonatomic, retain) NSString * placeName;
@property (nonatomic, retain) NSString * placeUrl;
@property (nonatomic, retain) Category *category;
@property (nonatomic, retain) PlaceLocation *placeLocation;

@end
