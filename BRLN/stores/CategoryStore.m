//
//  CategoryStore.m
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 8/5/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import "CategoryStore.h"
#import "Category.h"
#import "Place.h"
#import "PlaceLocation.h"

@implementation CategoryStore

@synthesize managedObjectContext;

+ (CategoryStore *)defaultStore
{
    static CategoryStore *defaultStore = nil;
    if (!defaultStore) {
        defaultStore = [[super allocWithZone:nil] init];
    }
    
    return defaultStore;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self defaultStore];
}

- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"managedObject: %@", managedObjectContext);        
//        NSEntityDescription *categoryEntity = [NSEntityDescription entityForName:@"Category" inManagedObjectContext:managedObjectContext];
//        NSFetchRequest *request = [[NSFetchRequest alloc] init];
//        [request setEntity:categoryEntity];
//        
//        NSError *error;
//        NSArray *results = [managedObjectContext executeFetchRequest:request error:&error];
//        
//        if (!results || error) {
//            NSLog(@"ERROR: Fetch request raised an error - %@", [error description]);
//        }
//        
//        if ([results count] == 0) {
//            [self importData];
//        } else {
//            allCategories = [[NSMutableArray alloc] initWithArray:results];
//        }
    }
    
    return self;
}

- (NSArray *)allCategories
{
    return allCategories;
}

- (void)importData
{
    allCategories = [[NSMutableArray alloc] init];
    
    NSError *jsonError;
    NSString *jsonDataPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSDictionary *jsonResults = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:jsonDataPath] options:kNilOptions error:&jsonError];
    
    NSEnumerator *enumeratorCategories = [[jsonResults objectForKey:@"data"] objectEnumerator];
    id enumeratorCategory;
    
    while (enumeratorCategory = [enumeratorCategories nextObject]) {
        Category *c = [NSEntityDescription insertNewObjectForEntityForName:@"Category" inManagedObjectContext:managedObjectContext];
        [c setCategoryName:[enumeratorCategory valueForKey:@"categoryName"]];
        
        NSEnumerator *enumeratorPlaces = [[enumeratorCategory objectForKey:@"places"] objectEnumerator];
        id enumeratorPlace;
        
        while (enumeratorPlace = [enumeratorPlaces nextObject]) {
            Place *place = [NSEntityDescription insertNewObjectForEntityForName:@"Place" inManagedObjectContext:managedObjectContext];
            [place setPlaceName:[enumeratorPlace valueForKey:@"placeName"]];
            [place setPlaceDescription:[enumeratorPlace valueForKey:@"placeDescription"]];
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
        
        [allCategories addObject:c];
        NSLog(@"IMPORT: added category");
    }
//    [[self tableView ] reloadData];
}

@end
