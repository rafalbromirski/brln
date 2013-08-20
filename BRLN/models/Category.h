//
//  Category.h
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 8/20/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Place;

@interface Category : NSManagedObject

@property (nonatomic, retain) NSString * categoryDescription;
@property (nonatomic, retain) NSString * categoryName;
@property (nonatomic, retain) NSSet *places;
@end

@interface Category (CoreDataGeneratedAccessors)

- (void)addPlacesObject:(Place *)value;
- (void)removePlacesObject:(Place *)value;
- (void)addPlaces:(NSSet *)values;
- (void)removePlaces:(NSSet *)values;

@end
