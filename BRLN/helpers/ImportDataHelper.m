//
//  ImportDataHelper.m
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 8/7/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import "DatabaseHelper.h"
#import "ImportDataHelper.h"

#import "Category.h"
#import "Place.h"
#import "PlaceLocation.h"

@implementation ImportDataHelper

@synthesize managedObjectContext;

static ImportDataHelper *sharedInstance = nil;

+ (ImportDataHelper *)sharedInstance
{
    if (nil != sharedInstance) {
        return sharedInstance;
    }
    
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedInstance = [[ImportDataHelper alloc] init];
    });
    
    return sharedInstance;
}

- (void)importData
{
    NSLog(@"IMPORT: begining import...");
    
    [self setManagedObjectContext:[[DatabaseHelper sharedInstance] managedObjectContext]];
    
    NSError *jsonError;
    NSString *jsonDataPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSDictionary *jsonResults = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:jsonDataPath] options:kNilOptions error:&jsonError];
    
    NSEnumerator *enumeratorCategories = [[jsonResults objectForKey:@"data"] objectEnumerator];
    id enumeratorCategory;
    
    while (enumeratorCategory = [enumeratorCategories nextObject]) {
        Category *c = [NSEntityDescription insertNewObjectForEntityForName:@"Category" inManagedObjectContext:managedObjectContext];
        [c setCategoryName:[enumeratorCategory valueForKey:@"categoryName"]];
        [c setCategoryDescription:[enumeratorCategory valueForKey:@"categoryDescription"]];
        
        NSEnumerator *enumeratorPlaces = [[enumeratorCategory objectForKey:@"places"] objectEnumerator];
        id enumeratorPlace;
        
        while (enumeratorPlace = [enumeratorPlaces nextObject]) {
            Place *place = [NSEntityDescription insertNewObjectForEntityForName:@"Place" inManagedObjectContext:managedObjectContext];
            [place setPlaceName:[enumeratorPlace valueForKey:@"placeName"]];
            [place setPlaceDescription:[enumeratorPlace valueForKey:@"placeDescription"]];
            [place setPlaceAddress:[enumeratorPlace valueForKey:@"placeAddress"]];
            [place setPlaceUrl:[enumeratorPlace valueForKey:@"placeUrl"]];            
            
            PlaceLocation *placeLocation = [NSEntityDescription insertNewObjectForEntityForName:@"PlaceLocation" inManagedObjectContext:managedObjectContext];
            [placeLocation setLatitude:[[[enumeratorPlace objectForKey:@"placeLocation"] valueForKey:@"lat"] doubleValue]];
            [placeLocation setLongitude:[[[enumeratorPlace objectForKey:@"placeLocation"] valueForKey:@"long"] doubleValue]];
            
            [place setPlaceLocation:placeLocation];
            NSLog(@"IMPORT: added place location");
            
            [c addPlacesObject:place];
            NSLog(@"IMPORT: added place");
        }
        
        NSError *error;
        [managedObjectContext save:&error];
        
        if (error) {
            NSLog(@"ERROR: Save raised an error - %@", [error description]);
        }
        
        NSLog(@"IMPORT: added category");
    }
    
    NSLog(@"IMPORT: completed!");
}

@end
